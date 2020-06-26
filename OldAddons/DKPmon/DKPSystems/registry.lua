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

--[[
   Class for registering DKP systems to DKPmon
]]

local L = AceLibrary("AceLocale-2.2"):new("DKPmon")

local Registry = { CurrentDKP = { obj = nil, id = nil} , db = {} }
DKPmon.DKP = Registry

local AceOO = AceLibrary("AceOO-2.0")

function Registry:Initialize()
   --DKPmon:Print("Initializing DKP System Menu Options")
   --DKPmon:Print("Current System: "..DKPmon.db.realm.DKP.system)
   -- Build the Fubar options menu for the DKP systems
   local regtab = DKPmon.Options.fubar.dkpsystem
   if regtab == nil then -- If our table isn't in the fubar menu yet, add it
      regtab = {
	 type = 'group',
	 name = L['DKP System Options'],
	 desc = L['Options related to the choice of DKP System.'],
	 args = { 
	    choice = {
	       type = 'text',
	       name = L['DKP System.'],
	       desc = L['Choose which DKP system to use.'],
	       usage = '<name>',
	       get = function() return Registry.CurrentDKP.id end,
	       set = function(v) Registry:SetDKPSystem(v) end,
	       validate = {},
	       order = 1
	    },
	 },
	 order = 50
      }
      DKPmon.Options.fubar.args.dkpsystem = regtab
   end
   
   local defaultID = DKPmon.db.realm.DKP.system
   --DKPmon:Print("Default ID:"..defaultID)
   -- Initialize every registered object
   local sysID, tab
   for sysID, tab in pairs(self.db) do
    --DKPmon:Print("Initializing Addon: " .. sysID)  
      tab.obj:Initialize()
      --DKPmon:Print("Initializing Addon Finished: " .. sysID)  
      -- Add this system to the validate field of the choice option.
      -- This will allow the user to pick it as an option
      regtab.args.choice.validate[sysID] = tab.name
      -- Add the DKP system's fubar options menu, if there is one, to the fubar menu
      regtab.args[sysID] = tab.obj:GetFubarOptionsMenu()
   end
   
   if self.db[defaultID] ~= nil then
    --DKPmon:Print("Default Not Nil")  
    self:SetDKPSystem(defaultID)
   else
        --DKPmon:Print("Default Nil")  
     self:SetDKPSystem("FDKP")
   end
end

--[[
Register
Description:
  Register a DKP system object with DKPmon
Input:
  sysObj -- Class derived from DKPmon_DKP_BaseClass
  sysID -- internal identifier to use to identify this system
  name -- name of the system
Returns:
  None
]]
function Registry:Register(sysObj, sysID, name)
  --DKPmon:Print("DKP System Activated: "..sysID)
   -- Sanity checking
   if not AceOO.inherits(sysObj, DKPmon_DKP_Interface) then
      error(string.format(L["Register DKP system -- DKP system with sysID %s does not inherit from the DKPmon_DKP_BaseClass object"], tostring(sysID)))
      return
   end
   if type(sysID) ~= "number" and type(sysID) ~= "string" then
      error(L["Register DKP system -- second arg must be a string or number"])
      return
   end
   if self.db[sysID] ~= nil then
      error(string.format(L["Register DKP system -- %s already registered."], tostring(sysID)))
      return
   end
   self.db[sysID] = { obj = sysObj, name = name }
end


--[[
Get
Description:
  Return the object for the current DKP system
Input:
Returns:
  A child class of DKPmon_DKP_BaseClass
]]
function Registry:Get()
   return self.CurrentDKP.obj
end


--[[
GetDKPSystemID
Description:
  Find out the sysID of the currently selected DKP system
Input:
Returns:
  sysID -- The sysID used to register the current DKP system
]]
function Registry:GetDKPSystemID()
   return self.CurrentDKP.id
end

--[[
GetDKPSystemName
Description:
  Find out the name that the current DKP system goes by
Input:
Returns:
  string -- the name of the DKP system
]]
function Registry:GetDKPSystemName()
   return self.db[self.CurrentDKP.id].name
end


--[[
SetDKPSystem
Description:
  Set the current DKP system to the one registered under the given sysID
Input:
  sysID -- The sysID used to register the desired DKP system
Returns:
]]
function Registry:SetDKPSystem(sysID)
    --DKPmon:Print("DKP System Set: "..sysID)
    DKPmon.db.realm.DKP.system = sysID
   if self.db[sysID] == nil then
      error(string.format(L["DKP System %s not registered."], tostring(sysID)))
      return
   end
   -- 
   if DKPmon.Looting:GetBidState() ~= 0 then
      StaticPopupDialogs["DKPMON_CONFIRM_DKPSYSTEMCHANGE"].OnAccept = 
	 function()
	    DKPmon.Looting:SetBidState(0)
	    DKPmon.Looting:Clear()
	    DKPmon.DKP:SetDKPSystem(sysID)
	 end
      if StaticPopup_Show("DKPMON_CONFIRM_DKPSYSTEMCHANGE") == nil then
	 DKPmon:Print(L["Cannot change systems right now. Bidding is open, and I can't open a dialog box."])
	 return
      end
      return
   end
   -- Make sure to clear the looting window, just in case.
   DKPmon.Looting:Clear()
   DKPmon.Looting:SetTextStrings() -- update the system text line
   
   -- Hide the looting & award windows
   DKPmon.Looting:Hide()
   DKPmon.Awarding:Hide()
   
   self.CurrentDKP.id = sysID
   self.CurrentDKP.obj = self.db[sysID].obj
   --DKPmon:Print("DKP System Stored: "..sysID)
   DKPmon.db.realm.DKP.system = sysID
end


--[[
GetDB()
Description:
  Return the savedvariables database table in which to save all information for the DKP system with the given sysID
Input:
  sysID -- The sysID used to register the desired DKP system
Returns:
  database -- table; the place to store information for DKP system "sysID"
]]
function Registry:GetDB(sysID)
   if self.db[sysID] == nil then
      error(string.format(L["DKP System %s not registered."], tostring(sysID)))
      return nil
   end
   if DKPmon.db.realm.DKP[sysID] == nil then
      DKPmon.db.realm.DKP[sysID] = {}
   end
   return DKPmon.db.realm.DKP[sysID]
end

--[[
ProcessQueryConsole
Description:
  Process a "QC" command received from Bidder
Input:
  sender -- string; the person who sent the command
  params -- string; name to lookup the points for
Returns:
  None. But, sends a message to the Bidder that sent the command
]]
function Registry:ProcessQueryConsole(sender, params)
   if not DKPmon:GetLeaderState() then return true end
   
   local str = self.CurrentDKP.obj:ProcessQueryConsole(params)
   DKPmon.Comm:SendToBidder("M", str, sender)
   return true
end
DKPmon.Comm:RegisterCommand("QC", Registry.ProcessQueryConsole, Registry)

--[[
ProcessPointsQuery
Description:
  Process a "QP" command received from Bidder
Input:
  sender -- string; the person who sent the command
  params -- string; serialization of the CharInfo struct for the player's bidname
Returns:
  None. But, sends a message to the Bidder that sent the command
]]
function Registry:ProcessPointsQuery(sender, params)
   if DKPmon.db.realm.amLeader ~= true then return true end
   local charInfo = DKPmon:StringToCharInfo(params)
   DKPmon.Print('In ProcessPoints')
   DKPmon.RaidRoster:SetBidname(sender, charInfo)
   local tab = {}
   local dkpsys = self.CurrentDKP.obj
   local npools = dkpsys:GetNPools()
   local p
   for p = 1, npools do
      tab[p] = dkpsys:GetPlayerPoints(charInfo.name, p) -- DKPmon.PointsDB:GetPlayerPoints(charInfo.name, p)
   end
   DKPmon.Comm:SendToBidder("RQP", tab, sender)
   return true
end
DKPmon.Comm:RegisterCommand("QP", Registry.ProcessPointsQuery, Registry)
