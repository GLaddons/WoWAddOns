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

local L = AceLibrary("AceLocale-2.2"):new("DKPmon")
local dewdrop = AceLibrary("Dewdrop-2.0")
    
local dewOptions = {} -- table for the dewdrop menu

local AwardFrame = { 
   standbylist = {},  -- list of people on standby. Indexed by player name. [<name>] = { bidname, bidclass, bidclasshex, class, classhex, onlist }
   dblist = {}, -- list of people in the database. Indexed by player name. [<name>] = { classhex, onlist }
   pointstoaward = {} -- list of { pool=#, amount=#, source=string } tables
}
DKPmon.Awarding = AwardFrame

DKPmon.DBDefaults.AwardFrame = {}
DKPmon.DBDefaults.AwardFrame.pos = { x = (UIParent:GetWidth() / 2), y = (UIParent:GetHeight() / 2) }

--[[
AwardFrame:Create()
Description:
  Build the frame for handling looting/bidding/auctioning/etc via DKPmon
Input:
Returns:
]]
function AwardFrame:Create() 
   if self.frame then return end
   
   self.frame = CreateFrame("Frame", "DKPmonAwardFrame", UIParent)
   self.frame:SetFrameStrata("DIALOG")
   self.frame:SetFrameLevel(5)
   self.frame:SetWidth(225)
   self.frame:SetHeight(50)
   
   self.frame:SetMovable(1)
   self.frame:EnableMouse(1)
   self.frame:RegisterForDrag("LeftButton")
   self.frame:SetScript("OnDragStart", function() AwardFrame:DragStart() end)
   self.frame:SetScript("OnDragStop", function() AwardFrame:DragStop() end)
   
   DKPmon.FrameSkinner:BackdropFrame(self.frame, {0, 0, 0, 0.7}, {0.7, 0.7, 0.7, 0.9} )
   
   self.frame:ClearAllPoints()
   self.frame:SetPoint("TOPLEFT", UIParent, "BOTTOMLEFT", DKPmon.db.realm.AwardFrame.pos.x, DKPmon.db.realm.AwardFrame.pos.y)
   
   DKPmon.FrameSkinner:Skin(self.frame)
   
   -- Title for the frame
   local t = self.frame:CreateFontString()
   t:SetPoint("CENTER", self.frame, "TOP", 0, -10)
   t:SetTextColor(1.0, 0.819, 0.0)
   t:SetWidth(200)
   t:SetFontObject(GameFontNormal)
   t:SetText(L["DKPmon: Points Awarding"])
   
   -- Create the close-window button
   local b = CreateFrame("Button", "DKPmonAwardFrameCloseButton", self.frame)
   self.closebutton = b
   b:SetScript("OnClick", function() AwardFrame:Hide() end)
   --    b:SetFrameLevel(8)
   b:SetWidth(32); b:SetHeight(32)
   b:SetNormalTexture("Interface\\Buttons\\UI-Panel-MinimizeButton-Up")
   b:SetPushedTexture("Interface\\Buttons\\UI-Panel-MinimizeButton-Down")
   b:SetHighlightTexture("Interface\\Buttons\\UI-Panel-MinimizeButton-Highlight")
   b:ClearAllPoints()
   b:SetPoint("TOPRIGHT", self.frame, "TOPRIGHT", 3, 3)
   b:SetHitRectInsets(5, 5, 5, 5)
   b:Show()
   
   self.topframe = self:CreateTopFrame(self.frame)
   self.topframe:ClearAllPoints()
   self.topframe:SetPoint("TOP", self.frame, "TOP", 0, -20)
   self.topframe:Show()
   
   self.bottomframe = self:CreateBottomFrame(self.frame)
   self.bottomframe:ClearAllPoints()
   self.bottomframe:SetPoint("BOTTOM", self.frame, "BOTTOM", 0, 10)
   self.bottomframe:Show()
   
   self:BuildDBList()
end

function AwardFrame:CreateTopFrame(parent)
   -- Create the miniframe for choosing whom to award points to.
   local f = CreateFrame("Frame", "DKPmonAwardTopframe", parent)
   f:SetWidth(280)
   f:SetHeight(80)
   
   DKPmon.FrameSkinner:BackdropFrame(f, {0, 0, 0, 0.7}, {0.7, 0.7, 0.7, 0.9} )
   DKPmon.FrameSkinner:Skin(f)
   
   local b = CreateFrame("Button", "DKPmonAwardFrameActionButton", f, "UIPanelButtonTemplate")
   f.selectbutton = b
   b:SetWidth(120); b:SetHeight(22)
   b:SetText(L["Select players"])
   b:ClearAllPoints()
   b:SetPoint("TOP", f, "TOP", 0, -10)
   b:SetScript("OnClick", function() AwardFrame:OnSelectButtonClick() end)
   b:Show()
   
   -- Text lines for displaying how many people are selected
   local t = f:CreateFontString()
   t:SetPoint("TOP", f, "TOP", 0, -30)
   t:SetTextColor(1.0, 0.819, 0.0)
   t:SetWidth(260)
   t:SetFontObject(GameFontNormal)
   t:SetJustifyH("CENTER")
   f.raidstr = t
   
   t = f:CreateFontString()
   t:SetPoint("TOP", f, "TOP", 0, -42)
   t:SetTextColor(1.0, 0.819, 0.0)
   t:SetWidth(260)
   t:SetFontObject(GameFontNormal)
   t:SetJustifyH("CENTER")
   f.standbystr = t
   
   t = f:CreateFontString()
   t:SetPoint("TOP", f, "TOP", 0, -54)
   t:SetTextColor(1.0, 0.819, 0.0)
   t:SetWidth(260)
   t:SetFontObject(GameFontNormal)
   t:SetJustifyH("CENTER")
   f.dbstr = t
   
   return f
end

function AwardFrame:CreateBottomFrame(parent)
   -- Create the frame for viewing the list of points to be awarded, and for awarding the current list of points
   local f = CreateFrame("Frame", "DKPmonAwardBottomframe", parent)
   f:SetWidth(280)
   f:SetHeight(42+10+12+12)
   
   DKPmon.FrameSkinner:BackdropFrame(f, {0, 0, 0, 0.7}, {0.7, 0.7, 0.7, 0.9} )
   DKPmon.FrameSkinner:Skin(f)

   local t = f:CreateFontString()
   t:SetPoint("TOP", f, "TOP", 0, -10)
   t:SetTextColor(1.0, 0.819, 0.0)
   t:SetWidth(260)
   t:SetFontObject(GameFontNormal)
   t:SetJustifyH("LEFT")
   t:SetText(L["Points to award:"])

   t = f:CreateFontString()
   t:SetPoint("TOP", f, "TOP", 0, -25)
   t:SetTextColor(1.0, 0.819, 0.0)
   t:SetWidth(260)
   t:SetFontObject(GameFontNormal)
   t:SetJustifyH("LEFT")
   t:SetText(L["None"])
   f.pointslist = t

   local b = CreateFrame("Button", "DKPmonPurgePointsListButton", f, "UIPanelButtonTemplate")
   f.purgepointsbutton = b
   b:SetWidth(120); b:SetHeight(22)
   b:SetText(L["Purge List"])
   b:ClearAllPoints()
   b:SetPoint("BOTTOM", f, "BOTTOM", -65, 10)
   b:SetScript("OnClick", function() 
			     AwardFrame.pointstoaward = {}
			     DKPmon.DKP:Get():OnPurgePointsList()
			     AwardFrame:UpdatePointsListText()
			  end)
   b:Show()
   b:Disable()

   b = CreateFrame("Button", "DKPmonAwardAwardPointsButton", f, "UIPanelButtonTemplate")
   f.awardpointsbutton = b
   b:SetWidth(120); b:SetHeight(22)
   b:SetText(L["Award points"])
   b:ClearAllPoints()
   b:SetPoint("BOTTOM", f, "BOTTOM", 65, 10)
   b:SetScript("OnClick", function() StaticPopup_Show("DKPMON_CONFIRM_AWARDPOINTS") end)
   b:Show()
   
   return f
end

--[[
BuildDBList
Description:
  Go through the points database, and build our list of names in the database
Input:
Returns:
]]
function AwardFrame:BuildDBList()
   local DKPtab = DKPmon.PointsDB:GetTable() -- the points database
   local name, tab
   for name, tab in pairs(DKPtab) do
      self.dblist[name] = { classhex = DKPmon:getClassHex(tab.info.class), onlist = false }
   end
end

--[[
UpdateDBList
Description:
  Called when player with the given name has been added to the database
Input:
  name -- string; name of the player added
Returns:
]]
function AwardFrame:UpdateDBList(name)
   if self.frame == nil then return end -- we don't care, no award frame is built yet
   local tab = DKPmon.PointsDB:GetTable(name)
   self.dblist[name] = { classhex = DKPmon:getClassHex(tab.info.class), onlist = false }
   self:UpdateDBText()
end

--[[
AwardFrame:Show()
Description:
  Display the DKPmon points awarding window
Input:
Returns:
]]
function AwardFrame:Show()
   self:Create()
   self:Hide()
   
   DKPmon.Logging:LogToRaidTrackerReportValidity()
   
   local width = math.max(self.topframe:GetWidth(), self.bottomframe:GetWidth())
   local height = 30 + self.topframe:GetHeight() + self.bottomframe:GetHeight()
   
   -- Get the subframe for the DKP system
   if self.dkpframe then self.dkpframe:Hide() end
   self.dkpframe = DKPmon.DKP:Get():GetAwardFrame()
   self.dkpframe:SetParent(self.frame)
   self.dkpframe:ClearAllPoints()
   self.dkpframe:SetPoint("TOP", self.topframe, "BOTTOM", 0, 0)
   self.dkpframe:Show()
   
   width = math.max(width, self.dkpframe:GetWidth())
   height = height + self.dkpframe:GetHeight()
   
   self.frame:SetHeight(height)
   self.frame:SetWidth(width+20)
   
   self:UpdateRaidText()
   self:UpdateStandbyText()
   self:UpdateDBText()
   self.frame:Show()
end

--[[
AwardFrame:Hide()
Description:
  Hide the DKPmon points awarding window
Input:
Returns:
]]
function AwardFrame:Hide()
   if self.frame then self.frame:Hide() end
end

--[[
Functions for updating the status strings in the miniframe
]]
function AwardFrame:UpdateRaidText()
   if self.frame == nil then return end
   local nonlist, ninraid = 0, 0
   if GetNumGroupMembers() ~= 0 then
      -- Go through the raid roster and calculate:
      --  1) The number of people on the roster.
      --  2) The number of people on the roster with onlist=true
      local roster = DKPmon.RaidRoster:GetRoster()
      local name, tab
      for name, tab in pairs(roster) do
	       ninraid = ninraid + 1
	       if tab.onlist then nonlist = nonlist + 1 end
      end
   end
   self.topframe.raidstr:SetText(string.format(L["%d/%d raid members selected"], nonlist, ninraid))
end
function AwardFrame:UpdateStandbyText()
   if self.frame == nil then return end
   local nonlist, ninlist = 0, 0
   -- Go through the standby list and calculate
   --  1) The number of people in the list
   --  2) The number of people in the list with onlist=true
   local name, tab
   for name, tab in pairs(self.standbylist) do
      ninlist = ninlist + 1
      if tab.onlist then nonlist = nonlist + 1 end
   end
   self.topframe.standbystr:SetText(string.format(L["%d/%d standby members selected"], nonlist, ninlist))
end
function AwardFrame:UpdateDBText()
   if self.frame == nil then return end
   local nonlist, ninlist = 0, 0
   -- Go through the database list and calculate
   --  1) The number of people in the list
   --  2) The number of people in the list with onlist=true
   local name, tab
   for name, tab in pairs(self.dblist) do
      ninlist = ninlist + 1
      if tab.onlist then nonlist = nonlist + 1 end
   end
   self.topframe.dbstr:SetText(string.format(L["%d/%d members selected from the database"], nonlist, ninlist))
end

--[[
UpdatePointsListText
Description:
  Called to update the list of points that will be awarded when the award points button is clicked
]]
function AwardFrame:UpdatePointsListText()
   local i, ptab
   local dkpsys = DKPmon.DKP:Get()
   local str
   local nLines = 0
   for i, ptab in ipairs(self.pointstoaward) do
      if nLines == 0 then
	 str = string.format("%s: %g %s", ptab.source, ptab.amount, dkpsys:GetPoolName(ptab.pool))
      else
	 str = string.format("%s\n%s: %g %s", str, ptab.source, ptab.amount, dkpsys:GetPoolName(ptab.pool))
      end
      nLines = nLines + 1
   end
   if nLines == 0 then
      self.bottomframe.pointslist:SetText(L["None"])
      self.bottomframe.purgepointsbutton:Disable()
      nLines = 1
   else
      self.bottomframe.pointslist:SetText(str)
      self.bottomframe.purgepointsbutton:Enable()
   end
   self.bottomframe:SetHeight(42+10+12*(nLines+1))
   self:Show()
end

--[[    
AwardFrame:DragStart()
Description:
  Called when the user clicks on the DKPmon points awarding window to begin moving it around
Input:
Returns:
]]
function AwardFrame:DragStart()
   self.frame:StartMoving()
end


--[[
AwardFrame:DragStop()
Description:
  Called when the user stops dragging the window around. Saves the position of the window to the AceDB
Input:
Returns:
]]
function AwardFrame:DragStop()
   self.frame:StopMovingOrSizing()
   DKPmon.db.realm.AwardFrame.pos.x = self.frame:GetLeft()
   DKPmon.db.realm.AwardFrame.pos.y = self.frame:GetTop()
end


--[[
GetNumSelected
Description:
  Return the total number of players selected to be awarded points
Input:
Returns:
]]
function AwardFrame:GetNumSelected()
   local nsel = 0
   -- a) Go through the raid roster
   local roster = DKPmon.RaidRoster:GetRoster()
   local name, rtab
   for name, rtab in pairs(roster) do
      if rtab.onlist then
	 nsel = nsel + 1
      end
   end
   -- b) Go through the standby list
   for name, rtab in pairs(self.standbylist) do
      if rtab.onlist then --and playerlist[name] == nil then
	 nsel = nsel + 1
      end
   end
   -- c) Go through the list from the database
   for name, rtab in pairs(self.dblist) do
      if rtab.onlist then --and playerlist[name] == nil then
	 nsel = nsel + 1
      end
   end
   return nsel
end

--[[
OnSelectButtonClick
Description:
  Called when the "Select players" button in the miniframe is clicked
Input:
Returns:
]]
function AwardFrame:OnSelectButtonClick()
   -- Build up the dewdrop menu that we're going to display
   --DKPmon:TableDelete(dewOptions)
   dewOptions = { type = 'group', args = {} }
   dewOptions.args.header = { type = 'header', name = L['Select the players to award points to'], order = 1 }
   
   -- Build the raid selection options
   local raid = { 
      type = 'group', name = L["Raid members"], desc = L["Select members from the raid to award points to"], 
      args = {}, order = 2 
   }
   -- Add the query raid, select all, and unselect all buttons
   raid.args.performqueryraid = {
      type = 'execute', name = L["Query raid"], desc = L["Query the raid to determine everyone's bidding name, and whether they're online."],
      func = function()
		DKPmon.Comm:SendToBidder("QR")
		--dewdrop:Close()
	     end,
      order = 1
   }
   raid.args.selectallraidmembers = {
      type = 'execute', name = L["Select all"], desc = L["Select all members of the raid."],
      func = function()
		local T = DKPmon.RaidRoster:GetRoster()
		local t
		for _, t in pairs(T) do
		   t.onlist = true
		end
		AwardFrame:UpdateRaidText()
	     end,
      order = 2
   }
   raid.args.unselectallraidmembers = {
      type = 'execute', name = L["Unselect all"], desc = L["Unselect all members of the raid."],
      func = function()
                local T = DKPmon.RaidRoster:GetRoster()
                local t
                for _, t in pairs(T) do
		   t.onlist = false
                end
                AwardFrame:UpdateRaidText()
	     end,
      order = 3
   }
   raid.args.blanklineheader = {
      type = "header", name = " ", order = 4
   }
   -- Add all members in the raid to the list
   local tab = DKPmon.RaidRoster:GetRoster()
   local name, value 
   for name, value in pairs(tab) do
      local n = name
      local namestr
      if name == value.bidchar.name then
	 namestr = string.format("|cff%s%s|r", value.char.classhex, name)
      else
	 namestr = string.format("|cff%s%s|r[|cff%s%s|r]", value.char.classhex, name, value.bidchar.classhex, value.bidchar.name)
      end
      raid.args[name] = { 
	 type = 'toggle', name = namestr, order = 100+string.byte(name),
	 desc = L["Add/remove this player"], 
	 get = function()
		  local tab = DKPmon.RaidRoster:GetPlayerInfo(n)
		  if tab then
		     return tab.onlist
		  end
		  return false
	       end,
	 set = function(v)
		  local tab = DKPmon.RaidRoster:GetPlayerInfo(n)
		  if tab then 
		     tab.onlist = v
		     AwardFrame:UpdateRaidText()
		  end
	       end
      }
   end
   dewOptions.args.raidlist = raid
   
   
   -- Build the standby selection options
   local standby = { 
      type = 'group', name = L["Standby members"], desc = L["Select members from standby to award points to"], 
      args = {}, order = 3
   }
   -- Add the query standby, select all, and unselect all buttons
   standby.args.performquerystandby = {
      type = 'execute', name = L["Query standby"], desc = L["Query the standby to determine everyone's bidding name, and whether they're online."],
      func = function()
		DKPmon.Comm:SendToBidder("QS", nil, nil, "GUILD")
		--DKPmon:TableDelete(AwardFrame.standbylist) -- empty the list
        AwardFrame.standbylist = {}
		dewdrop:Close() -- We'll close the window 'cause receiving replies to this query will invalidate this dewdrop menu
             end,
      order = 1
   }
   standby.args.selectallstandbymembers = {
      type = 'execute', name = L["Select all"], desc = L["Select all members of the standby."],
      func = function()
                local T = AwardFrame.standbylist
                local t
                for _, t in pairs(T) do
		   t.onlist = true
                end
                AwardFrame:UpdateStandbyText()
             end,
      order = 2
   }
   standby.args.unselectallstandbymembers = {
      type = 'execute', name = L["Unselect all"], desc = L["Unselect all members of the standby."],
      func = function()
                local T = AwardFrame.standbylist
                local t
                for _, t in pairs(T) do
                   t.onlist = false
                end
                AwardFrame:UpdateStandbyText()
             end,
      order = 3
   }
   standby.args.blanklineheader = {
      type = "header", name = " ", order = 4
   }
   -- Add all members in the standby to the list
   tab = AwardFrame.standbylist
   for name, value in pairs(tab) do
      local n = name
      local namestr
      if name == value.bidchar.name then
	 namestr = string.format("|cff%s%s|r", value.char.classhex, name)
      else
	 namestr = string.format("|cff%s%s|r[|cff%s%s|r]", value.char.classhex, name, value.bidchar.classhex, value.bidchar.name)
      end
      standby.args[name] = { 
	 type = 'toggle', name = namestr, order = 100+string.byte(name),
	 desc = L["Add/remove this player"], 
	 get = function()
		  local tab = AwardFrame.standbylist[n]
		  if tab then
		     return tab.onlist
		  end
		  return false
	       end,
	 set = function(v)
		  local tab = AwardFrame.standbylist[n]
		  if tab then 
		     tab.onlist = v
		     AwardFrame:UpdateStandbyText()
		  end
	       end
      }
   end
   dewOptions.args.standbylist = standby
   
   -- Last, but not least, the list of members in the database needs to be built
   local db = { 
      type = 'group', name = L["Database members"], desc = L["Select members from the points database to award points to"], 
      args = {}, order = 4
   }
   -- Add the select all, and unselect all buttons
   db.args.selectalldbmembers = {
      type = 'execute', name = L["Select all"], desc = L["Select all members of the database."],
      func = function()
                local T = AwardFrame.dblist
                local t
                for _, t in pairs(T) do
		   t.onlist = true
                end
                AwardFrame:UpdateDBText()
             end,
      order = 2
   }
   db.args.unselectalldbmembers = {
      type = 'execute', name = L["Unselect all"], desc = L["Unselect all members of the database."],
      func = function()
                local T = AwardFrame.dblist
                local t
                for _, t in pairs(T) do
                   t.onlist = false
                end
                AwardFrame:UpdateDBText()
             end,
      order = 3
   }
   db.args.blanklineheader = {
      type = "header", name = " ", order = 4
   }
   -- Add the people in the database to the list
   tab = self.dblist
   for name, value in pairs(tab) do
      -- [<name>] = { classhex, onlist }
      local n, v = name, value
      local firstletter = string.sub(name, 1, 1)
      if db.args[firstletter] == nil then
	 db.args[firstletter] = { 
            type = "group", name = firstletter, order = string.byte(firstletter),
            desc = string.format(L["Players starting with the letter %s"], firstletter),
            args = {}
	 }
      end
      local dTab = db.args[firstletter].args
      dTab[name] = {
	 type = 'toggle', name = string.format("|cff%s%s|r", value.classhex, name),
	 desc = L["Add/remove this player"],
	 get = function()
		  return v.onlist
	       end,
	 set = function(val)
		  v.onlist = val
		  AwardFrame:UpdateDBText()
	       end,
	 order = string.byte(name, 2)
      }
   end
   dewOptions.args.dblist = db
   dewdrop:Open(self.topframe.selectbutton, 'children', dewOptions, 'point', "TOP", 'relativepoint', "TOP")
end

--[[
AwardOutstandingPoints
Description:
  Called to award the points in the pointstoaward table to the selected players.
Input:
Returns:
]]
function AwardFrame:AwardOutstandingPoints()
   local announceraid, announceguild = false, false
   -- 1) Build the list of players to award points to.
   --   this is a list of CharInfo structs, indexed by bidding name
   local playerlist = {}
   -- a) Go through the raid roster, and pick out the selected players
   local roster = DKPmon.RaidRoster:GetRoster()
   local name, rtab
   for name, rtab in pairs(roster) do
      if rtab.onlist then
	 announceraid = true
	 playerlist[name] = rtab.bidchar
      end
   end
   -- b) Go through the standby list
   for name, rtab in pairs(self.standbylist) do
      if rtab.onlist and playerlist[name] == nil then
	 announceguild = true
	 playerlist[name] = rtab.bidchar
      end
   end
   -- c) Go through the list from the database
   for name, rtab in pairs(self.dblist) do
      if rtab.onlist and playerlist[name] == nil then
         playerlist[name] = DKPmon.PointsDB:GetTable(name).info
      end
   end
   
   -- 2) Award the points
   DKPmon.PointsDB:AwardFromList(playerlist, self.pointstoaward)
   
   -- 2a) Log The Points
   DKPmon.Logging:AwardPoints(playerlist, self.pointstoaward) -- log the awarding
   if (DKPmon.Logging:LogToRaidTrackerReportValidity() == true and DKPmon.Logging:LogToRaidTrackerActive() == true) then
      DKPmon.Logging:RaidTrackerAwardPoints(playerlist, self.pointstoaward) -- log the awarding to ct_raid_tracker
   end

   -- 3) Announce the awarded points
   local dkpsys = DKPmon.DKP:Get()
   if announceraid then
      SendChatMessage(L["Points awarded:"], "RAID") 
   end
   if announceguild then
      SendChatMessage(L["Points awarded:"], "GUILD")
   end
   for _, rtab in ipairs(self.pointstoaward) do
      local msg = string.format("   %s: %g %s", rtab.source, rtab.amount, dkpsys:GetPoolName(rtab.pool))
      if announceraid then SendChatMessage(msg, "RAID") end
      if announceguild then SendChatMessage(msg, "GUILD") end
   end
   
   dkpsys:PointsAwarded()
   --DKPmon:DeleteTable(self.pointstoaward)
   self.pointstoaward = {}
   self:UpdatePointsListText()
end

--[[
ReceiveRaidQueryReply
Description:
  Called when we receive a reply to our raid query from a player
Input:
  sender -- name of the player that sent the reply
  params -- string; serialization of the player's bidding CharInfo struct
Returns:
  true
]]

function table_dump(t,indent)
    local names = {}
    if not indent then indent = "" end
    for n,g in pairs(t) do
        table.insert(names,n)
    end
    table.sort(names)
    for i,n in pairs(names) do
        local v = t[n]
        if type(v) == "table" then
            if(v==t) then -- prevent endless loop if table contains reference to itself
                print(indent..tostring(n)..": <-")
            else
                print(indent..tostring(n)..":")
                table_dump(v,indent.."   ")
            end
        else
            if type(v) == "function" then
                print(indent..tostring(n).."()")
            else
                print(indent..tostring(n)..": "..tostring(v))
            end
        end
    end
end

function AwardFrame:ReceiveRaidQueryReply(sender, params)
   local charInfo = DKPmon:StringToCharInfo(params)
   --DKPmon.Print('In ReceiveRaidQueryReply',sender)
   DKPmon.RaidRoster:SetBidname(sender, charInfo)
   --if DKPmon.RaidRoster:GetPlayerInfo(sender) ~= nil then
   local T = DKPmon.RaidRoster:GetPlayerInfo(sender)
   if T == nil then
	DKPmon.Print('DKPmon','You are not in a raid')
	return true
   end
   T.onlist = true
   if dewdrop:IsOpen(self.topframe.selectbutton) then
      dewdrop:Refresh(2)
   end
   self:UpdateRaidText()
   return true
end
--end
DKPmon.Comm:RegisterCommand("RQR", AwardFrame.ReceiveRaidQueryReply, AwardFrame)

--[[
ReceiveStandbyQueryReply
Description:
  Called when we receive a reply to our standby query from a player
Input:
  sender -- name of the player that sent the reply
  params -- table; { str = <string; serialization of the player's bidding CharInfo struct>, c = <string; class of the sender> }
Returns:
  true
]]
function AwardFrame:ReceiveStandbyQueryReply(sender, params)
   -- First! Check that the person isn't already in the raid.
   if DKPmon.RaidRoster:IsPlayerInRaid(sender) then
      DKPmon.Comm:SendToBidder("M", L["You're already in the raid, turn off your standby flag."], sender, "GUILD")
      return true
   end
   local charInfo = DKPmon:StringToCharInfo(params.str)
   local T = self.standbylist[sender]
   if T == nil then
      self.standbylist[sender] = { 
	 char = { name = sender, class = params.c, classhex = DKPmon:getClassHex(params.c) },
	 bidchar = charInfo,
	 onlist = true
      }
   else
      T.bidchar = charInfo -- Just in case it changed since the last query
      T.onlist = true
   end
   self:UpdateStandbyText()
   return true
end
DKPmon.Comm:RegisterCommand("RQS", AwardFrame.ReceiveStandbyQueryReply, AwardFrame)

--[[
SetPointAward
Description:
  Set the pointstoaward table to contain only the given table
Input:
  tab -- table; { pool=#, amount=#, source=string }
Returns:
  None
]]
function AwardFrame:SetPointAward(tab)
   if type(tab) ~= "table" or type(tab.pool) ~= "number" or type(tab.amount) ~= "number" or type(tab.source) ~= "string" then
      error(L["Invalid input. Expected table with pool number, amount number, and source string."])
      return
   end
   DKPmon.DKP:Get():OnPurgePointsList()
   self.pointstoaward = { tab }
   --DKPmon:Print(string.format("Set award points to: pool=%d, amount=%g, source=%s.", tab.pool, tab.amount, tab.source))
   self:UpdatePointsListText()
end

--[[
AppendPointAward
Description:
  Append the given table to the pointstoaward table
Input:
  tab -- table; { pool=#, amount=#, source=string }
Returns:
  None
]]
function AwardFrame:AppendPointAward(tab)
   if type(tab) ~= "table" or type(tab.pool) ~= "number" or type(tab.amount) ~= "number" or type(tab.source) ~= "string" then
      error(L["Invalid input. Expected table with pool number, amount number, and source string."])
      return
   end
   table.insert(self.pointstoaward, tab)
   --DKPmon:Print(string.format("Appended award points: pool=%d, amount=%g, source=%s.", tab.pool, tab.amount, tab.source))
   self:UpdatePointsListText()
end
