--[[
    Copyright Daniel D. Neilson, 2006

    This file is part of DKPmon.

    DKPmon is free software; you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published by
    the Free Software Foundation; either version 2 of the License, or
    (at your option) any later version.

    DKPmon is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.

    You should have received a copy of the GNU General Public License
    along with DKPmon; if not, write to the Free Software
    Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
]]

DKPmon = AceLibrary("AceAddon-2.0"):new("AceConsole-2.0", "AceDB-2.0", "AceComm-2.0", "Metrognome-2.0", "AceEvent-2.0", "FuBarPlugin-2.0")
local L = AceLibrary("AceLocale-2.2"):new("DKPmon")
local tablet = AceLibrary("Tablet-2.0")

local DKPmonDBver = 2.0

DKPmon.DBDefaults = {
   dbversion = DKPmonDBver, -- Structure version of the SavedVariables DB
   password = "default", -- Password for points database broadcasting
   disenchanter = "", -- Player name of the person to give items to be disenchanted to
   bankname = "", -- Player name of the person to give items to for the guild bank
   amLeader = false, -- true iff we're running DKPmon for this raid
   alwayssync = true, -- true -> always send our points database on a sync request
   DKP = {
      dbversion = 1.0, -- What structure version of the points database
      system = "FDKP", -- The sysID of the DKP system to use
      checksum = nil, -- The checksum for the database data
      db = {} -- The points database
   },
   Log = {
      dbversion = 1.1, -- What structure version of the points database
      active = false, -- whether logging's active
      currentLog = nil, -- string; what log name we're logging to
      autologging = false, -- boolean; whether to automatically start a log when entering a raid instance
      logs = {} -- table of the logs
   },
   RaidRoster = {
      list = {}, -- list of RaidRoster structs for all players in your current raid
      left = {} -- list of RaidRoster structs for all players who have left your current raid.
   },
   PluginData = { -- Data that import/export modules wanted to save.
   }
}


DKPmon.hasIcon = "Interface\\Addons\\DKPmon\\DKPmon_icon.tga"
DKPmon.cannotDetachTooltip = true
DKPmon.cannotHideText = false

function DKPmon:OnInitialize()
   self.OnMenuRequest = self.Options.fubar
   
   -- Set the console commands
   self:RegisterChatCommand({L["/dkp"], L["/dkpmon"]}, self.Options.console)
   
   -- Called when the addon is loaded
   self:RegisterDB("DKPmonDB")
   self:RegisterDefaults('realm', self.DBDefaults)
   
   -- Ensure the database is up to date.
   if self.db.realm.dbversion < DKPmonDBver then
      -- Database is from a previous version of DKPmon
      -- Need to migrate it over.
      self:Print(L["Database version changed. Migrating to new format."])
      -- Just wipe out the old database.
      --self:TableDelete(self.db.realm)
      self.db.realm = DBDefaults
   end

   -- Log format changed. Migrate old data to new data.
   if self.db.realm.Log.dbversion < 1.1 then
      self:Print(L["Log version changed. Migrating to new format."])
      self.Logging:MigrateLog()
   end

   -- Calculate the checksum for the DKP database if there isn't one
   if self.db.realm.DKP.checksum == nil then
      self.PointsDB:CalculateChecksum()
   end
   
   -- Claim our message prefix from the Bidder stub hack
   if BidderDKPStub ~= nil then
      BidderDKPStub:DeregisterComm()
   end
   self:SetCommPrefix(self.Comm.DKPmonCommPrefix)
   
   self:RegisterMetro("DKPmonCommDispatch", function() DKPmon.Comm:DispatchMessages() end)
   self:ChangeMetroRate("DKPmonCommDispatch", 1.0/20) -- Call it 20 times per second
   
   self:RegisterMetro("DKPmonClose", function() DKPmon.Looting:StartCloseBiddingTimer() end)
   
   self:RegisterMetro("DKPmonUpdateLevelZeros", function() DKPmon.RaidRoster:UpdateLevelZeros() end)
   self:ChangeMetroRate("DKPmonUpdateLevelZeros", 1.0)
   
   self.Comm:RegisterCommand("L", self.ReceiveLeaderClaim, self)
   self:RegisterMetro("DKPmonLeader", function() DKPmon:CheckLeader() end)
   self.leadername = ""
   
   --DKPmon:Print("Initialize System: "..DKPmon.db.realm.DKP.system)
   
   --[[    
   -- Register the metronome
   
   self:RegisterMetro("DKPmonBidderCheck", function() DKPmon:PrintNoBidderInstalledList() end)
]]
end

function DKPmon:OnEnable()
   self.Comm:Enable() -- enable communications
   --DKPmon:Print("Initializing DKP Types")
   self.DKP:Initialize()
   --DKPmon:Print("Initializing DKP Types Finished")
   self.Logging:Initialize()
   self.ImpExpModules:InitializeModules()
   
   self.lastLeaderClaim = GetTime()
   self:SetLeader(false)
   
   self:ChangeMetroRate("DKPmonLeader", 17) -- Call every 17 seconds
   self:StartMetro("DKPmonLeader")
   self:RegisterEvent("LOOT_OPENED", function() DKPmon.Looting:OnLootEvent() end)
   self:RegisterEvent("RAID_ROSTER_UPDATE", 
       function() 
          if IsInRaid() == false or GetNumGroupMembers() == 0 then 
             -- Turn off the log if one's going
             local logtab = DKPmon.Logging:GetTable()
             if logtab.active then DKPmon.Logging:StopLog() end
          end
          DKPmon.RaidRoster:UpdateRoster() 
       end)
   -- Fires when entering an instance that saves when a boss is killed (ie: raid instance or heroic) 
   self:RegisterEvent("RAID_INSTANCE_WELCOME", 
	function()
          local logtab = DKPmon.Logging:GetTable()
          if IsInRaid == false or GetNumGroupMembers() == 0 then -- Heroic instance
             return 
          end 
          if logtab.active then return end -- Logging already turned on.
          if not logtab.autologging then return end
          logtab.logname = arg1
          StaticPopup_Show("DKPMON_CONFIRM_STARTLOG", logtab.logname)
	end )		
   self.RaidRoster:BuildRoster()
end

function DKPmon:OnDisable()
   -- Called when the addon is disabled.
   --self:Print("Disabled")
end

--[[ AceDB-2.0 Methods ]]
function DKPmon:OnProfileDisable()
   -- Called when the user changes profiles (before change)
end

function DKPmon:OnProfileEnable()
   -- Called when the user changes profiles (after change)
end

--[[ Function for checking the whether the raid has a DKPmon leader set ]]
function DKPmon:SetLeader(val)
   -- Never allowed to be leader if you're not in a raid
   if IsInRaid() == false then self.db.realm.amLeader = false; return end
   if (val and not self.db.realm.amLeader) then
      DKPmon:Print(L["I'm now the DKP lead."])
   end
   self.db.realm.amLeader = val
   if val then
      self.Comm:SendToDKPmon("L")
      self:SetIcon("Interface\\AddOns\\DKPmon\\DKPmon_leader.tga")
      self:UpdateDisplay()
   else
      self:SetIcon("Interface\\AddOns\\DKPmon\\DKPmon_icon.tga")
      self:UpdateDisplay()
   end
end
function DKPmon:GetLeaderState()
   return self.db.realm.amLeader
end
function DKPmon:CheckLeader()
   if IsInRaid() == false then
      -- Not in a raid, ignore.
      return
   end
   if self:GetLeaderState() then
      -- We're the leader, send a message that we're the leader to the raid.
      self.Comm:SendToDKPmon("L")
   else
      -- We're not the leader. If it's been more than 45 seconds since we last had a DKPmon
      -- claim leader, then claim leader for ourself.
      local currTime = GetTime()
      if (currTime - self.lastLeaderClaim) > 45.0 then
         self:SetLeader(true)
      end
   end
end
function DKPmon:ReceiveLeaderClaim(sender)
    --DKPmon:Print("Debug "..sender)
   local name_split = strsplit("%-", sender )
   sender = name_split
   self.lastLeaderClaim = GetTime()
   --DKPmon:Print("Debug LeadNA"..self.leadername)
   if sender ~= self.leadername then
      self.leadername = sender
      DKPmon:Print(L["DKP leader changed to "]..sender)
   end   
   --DKPmon:Print("Debug Sender"..sender)
   --DKPmon:Print("Debug Player"..UnitName("player"))
   if sender ~= UnitName("player") then
      self:SetLeader(false)
   end
   return true
end

--[[ FuBarPlugin-2.0 Methods ]]

--[[
	Called when FuBar icon is left-clicked
	Show Looting window if it's hidden, otherwise show points award window
]]
function DKPmon:OnClick()
	if self.Looting:GetBidState() > 0 and not self.Looting.frame:IsVisible() then
		self.Looting:Show()
	else
		self.Awarding:Show()
	end
end

--[[
	Called when FuBar icon is moused over and tooltip needs updating
   ]]
function DKPmon:OnTooltipUpdate()
	local cat = tablet:AddCategory('columns',2)
	cat:AddLine('text',L["DKP Leader:"],'text2',self.leadername)
	local log = DKPmon.Logging:GetCurrentLog()
	local text
	if log then
		text = log.raidkey
	else
		text = L["Disabled"]
	end
	
	cat:AddLine('text',L["Logging:"],'text2',text)
	
	tablet:SetTitle(L["DKPmon"])
	tablet:SetHint(L["Click to open Points Awarding window."])
end  