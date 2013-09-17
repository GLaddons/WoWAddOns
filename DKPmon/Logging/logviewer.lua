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

local LogViewer = { 
   cache = {}, -- cached text version of the currently selected log
   currentlog = nil, -- which log ID is currently being viewed
   togglemenu = nil, -- dewdrop table for toggling which parts of the log to view
   selectlog = nil -- dewdrop table for chosing which log to display
}
DKPmon.Logging.LogViewer = LogViewer

DKPmon.DBDefaults.LogViewer = {
   pinfos = false, -- Toggle for whether to view player info when viewing log
   pjoins = false, -- Toggle for whether to view player join time information
   pleaves = false, -- Toggle for whether to view player leave time information
   itemdrops = true, -- Toggle for whether to view item drop information
   pointsawarded = true, -- Toggle for whether to view point award information
   
   -- Position of the log viewing window
   pos = { x = (UIParent:GetWidth() / 2), y = (UIParent:GetHeight() / 2) }
}

local dewdrop = AceLibrary("Dewdrop-2.0")

--[[
Create
Description:
  Build the frame for log viewing
Input:
Returns:
]]
function LogViewer:Create()
   if self.frame then return end
   local fwidth = 360
   local fheight = 250
   self.frame = CreateFrame("Frame", "DKPmonLogViewerFrame", UIParent)
   self.frame:SetFrameStrata("DIALOG")
   self.frame:SetFrameLevel(5)
   self.frame:SetWidth(fwidth)
   self.frame:SetHeight(fheight)

   self.frame:SetMovable(1)
   self.frame:EnableMouse(1)
   self.frame:RegisterForDrag("LeftButton")
   self.frame:SetScript("OnDragStart", function() LogViewer:DragStart() end)
   self.frame:SetScript("OnDragStop", function() LogViewer:DragStop() end)

   DKPmon.FrameSkinner:BackdropFrame(self.frame, {0, 0, 0, 0.7}, {0.7, 0.7, 0.7, 0.9} )

   self.frame:ClearAllPoints()
   self.frame:SetPoint("TOPLEFT", UIParent, "BOTTOMLEFT", DKPmon.db.realm.LogViewer.pos.x, DKPmon.db.realm.LogViewer.pos.y)

   DKPmon.FrameSkinner:Skin(self.frame)

   -- Title for the frame
   local t = self.frame:CreateFontString()
   t:SetPoint("CENTER", self.frame, "TOP", 0, -10)
   t:SetTextColor(1.0, 0.819, 0.0)
   t:SetWidth(200)
   t:SetFontObject(GameFontNormal)
   t:SetText(L["DKPmon: View Logs"])

   -- Create the close-window button
   local b = CreateFrame("Button", "DKPmonLogViewerFrameCloseButton", self.frame, "UIPanelCloseButton")
   self.closebutton = b
   b:SetScript("OnClick", function() LogViewer:Hide() end)
   b:ClearAllPoints()
   b:SetPoint("TOPRIGHT", self.frame, "TOPRIGHT", 3, 3)
   b:Show()

   -- Button for selecting what parts of the log to view
   b = CreateFrame("Button", "DKPmonLogViewerPartButton", self.frame, "UIPanelButtonTemplate")
   self.partsbutton = b
   b:SetWidth((fwidth-30)/2); b:SetHeight(22)
   b:SetText(L["View log parts"])
   b:ClearAllPoints()
   b:SetPoint("TOP", self.frame, "TOP", -((fwidth-20)/4), -25)
   b:SetScript("OnClick", function() LogViewer:ToggleViewOptions() end)
   b:Show()

   -- Button for selecting which log to view
   b = CreateFrame("Button", "DKPmonLogViewerLogSelectButton", self.frame, "UIPanelButtonTemplate")
   self.logselectbutton = b
   b:SetWidth((fwidth-30)/2); b:SetHeight(22)
   b:SetText(L["Select Log"])
   b:ClearAllPoints()
   b:SetPoint("TOP", self.frame, "TOP", ((fwidth-20)/4), -25)
   b:SetScript("OnClick", function() LogViewer:SelectLog() end)
   b:Show()

   -- Create the scrolling text window
   local f = CreateFrame("ScrollingMessageFrame", "DKPmonLogViewerScrollFrame", self.frame)--"ChatFrameTemplate") --"UIPanelScrollFrameTemplate")
   self.scrollframe = f
   f:SetWidth(fwidth-20-26)
   f:SetHeight(fheight-60)
   f:SetFading(false) -- disable text fading
   f:SetMaxLines(100)
   f:SetFontObject(GameFontNormalSmall)
   f:SetJustifyH("LEFT")
   f:ClearAllPoints()
   f:SetPoint("TOP", self.frame, "TOP", 0, -50)
   f:Show()

   b = CreateFrame("Button", "DKPmonLogViewerPageUpButton", self.frame, "UIPanelButtonTemplate")
   self.pageupbutton = b
   b:SetWidth(16); b:SetHeight(16)
   b:SetText("U")
   b:ClearAllPoints()
   b:SetPoint("TOPLEFT", self.scrollframe, "TOPRIGHT", 1, 0)
   b:SetScript("OnClick", function() self.scrollframe:PageUp() end)
   b:Show()

   b = CreateFrame("Button", "DKPmonLogViewerScrollUpButton", self.frame, "UIPanelScrollUpButtonTemplate")
   self.scrollupbutton = b
   b:SetWidth(16); b:SetHeight(16)
   b:ClearAllPoints()
   b:SetPoint("TOP", self.pageupbutton, "BOTTOM", 0, -5)
   b:SetScript("OnClick", function() self.scrollframe:ScrollUp() end)
   b:Show()

   b = CreateFrame("Button", "DKPmonLogViewerScrollUpButton", self.frame, "UIPanelScrollDownButtonTemplate")
   self.scrolldownbutton = b
   b:SetWidth(16); b:SetHeight(16)
   b:ClearAllPoints()
   b:SetPoint("TOP", self.scrollupbutton, "BOTTOM", 0, -5)
   b:SetScript("OnClick", function() self.scrollframe:ScrollDown() end)
   b:Show()

   b = CreateFrame("Button", "DKPmonLogViewerPageDownButton", self.frame, "UIPanelButtonTemplate")
   self.pagedownbutton = b
   b:SetWidth(16); b:SetHeight(16)
   b:SetText("D")
   b:ClearAllPoints()
   b:SetPoint("TOP", self.scrolldownbutton, "BOTTOM", 0, -5)
   b:SetScript("OnClick", function() self.scrollframe:PageDown() end)
   b:Show()
end

--[[
Show
Description:
  Display the DKPmon log viewing window
]]
function LogViewer:Show()
   self:Create()
   self:Hide()
   if self.currentlog ~= nil then
      self:BuildCache(self.currentlog) -- update the cache if we're viewing an active log
      -- Display the log
      self:DisplayLog()
   end
   self.frame:Show()
end

--[[
Hide
Description:
  Hide the DKPmon log viewing window
]]
function LogViewer:Hide()
   if self.frame then self.frame:Hide() end
end

--[[
DragStart
Description:
  Called when the user clicks on the DKPmon log viewing window to begin moving it around
]]
function LogViewer:DragStart()
   self.frame:StartMoving()
end

--[[
DragStop
Description:
  Called when the user stops dragging the window around. Saves the position of the window to the AceDB
]]
function LogViewer:DragStop()
   self.frame:StopMovingOrSizing()
   DKPmon.db.realm.LogViewer.pos.x = self.frame:GetLeft()
   DKPmon.db.realm.LogViewer.pos.y = self.frame:GetTop()
end

--[[
ToggleViewOptions
Description:
  Called when the user clicks on the button to toggle display of various parts of the currently selected log.
  Will bring up a dewdrop menu with which the user can toggle the displays
]]
function LogViewer:ToggleViewOptions()
   -- Log items to toggle:
    -- Player Info
    -- Player Joins
    -- Player Leaves
    -- Item Drops
    -- Points Awarded
   if self.togglemenu == nil then
      -- build the menu Ace Options table
      self.togglemenu = {
	 type = 'group',
	 args = {
	    playerinfos = {
	       type = 'toggle', name = L['Player Information'], desc = L['Toggle display of player information'],
	       get = function()
			return DKPmon.db.realm.LogViewer.pinfos
		     end,
	       set = function(v)
			DKPmon.db.realm.LogViewer.pinfos = v
			self:DisplayLog()
		     end,
	       order = 1
	    },
	    playerjoins = {
	       type = 'toggle', name = L['Player Joins'], desc = L['Toggle display of player join time information.'],
	       get = function()
			return DKPmon.db.realm.LogViewer.pjoins
		     end,
	       set = function(v)
			DKPmon.db.realm.LogViewer.pjoins = v
			self:DisplayLog()
		     end,
	       order = 2
	    },
	    playerleaves = {
	       type = 'toggle', name = L['Player Leaves'], desc = L['Toggle display of player leave time information.'],
	       get = function()
			return DKPmon.db.realm.LogViewer.pleaves
		     end,
	       set = function(v)
			DKPmon.db.realm.LogViewer.pleaves = v
			self:DisplayLog()
		     end,
	       order = 3
	    },
	    itemdrops = {
	       type = 'toggle', name = L['Item drops'], 
	       desc = L['Toggle display of item drops, who they went to, and how many points they cost.'],
	       get = function()
			return DKPmon.db.realm.LogViewer.itemdrops
		     end,
	       set = function(v)
			DKPmon.db.realm.LogViewer.itemdrops = v
			self:DisplayLog()
		     end,
	       order = 4
	    },
	    pointsawarded = {
	       type = 'toggle', name = L['Point awards'], 
	       desc = L['Toggle display of points awarded and to whom.'],
	       get = function()
			return DKPmon.db.realm.LogViewer.pointsawarded
		     end,
	       set = function(v)
			DKPmon.db.realm.LogViewer.pointsawarded = v
			self:DisplayLog()
		     end,
	       order = 5
	    },
	 }
      }
   end
   dewdrop:Open(self.partsbutton, 'children', self.togglemenu, 'point', 'TOP', 'relativePoint', 'TOP')
end

--[[
SelectLog
Description:
  Called when the user clicks on the "Select Log" button.
  Will present a menu from which the user can select which log to view
]]
function LogViewer:SelectLog()
   if self.selectlog == nil then
      self.selectlog = {
	 type = 'text', name = L['Select Log'], desc = L['Select which log to view'],
	 set = function(v)
		  self.logtoview = tonumber(string.sub(v, 2))
		  self:BuildCache(self.logtoview)
		  self:DisplayLog()
	       end,
	 get = function()
		  if self.logtoview == nil then return nil end
		  return "l"..self.logtoview
	       end,
	 validate = {}
      }
   end
   -- Fill in the validate field of the selectlog table
   DKPmon:TableDelete(self.selectlog.validate)
   local logID, logTab
   local vTab = self.selectlog.validate
   for logID, logTab in pairs(DKPmon.db.realm.Log.logs) do
      vTab["l"..logID] = string.format("%s (%s)", logTab.raidkey, logTab.raidstart)
   end
   dewdrop:Open(self.logselectbutton, 'children', self.selectlog, 'point', 'TOP', 'relativePoint', 'TOP')
end

--[[
BuildCache
Description:
  Set the cache to store data for the given logID. If that logID is already in the cache, then this function does nothing;
  though, if the logID is the currently active log then the cache is rebuilt.
Input:
  logID -- number; index in the SavedVariables Log.log table for the log to cache
]]
function LogViewer:BuildCache(logID)
   if self.currentlog == logID then 
      if not (DKPmon.db.realm.Log.active and logID == DKPmon.db.realm.Log.currentLog) then
	 return 
      end
   end
   local Log = DKPmon.db.realm.Log.logs[logID]

   -- Wipe out the cache
   DKPmon:TableDelete(self.cache)
   if Log == nil then
      self.currentlog = nil
      return
   end
   self.currentlog = logID
   
   -- Player information strings.
   self.cache.pinfos = {}
   local name, charInfo
   if Log.playerinfos then
      for name, charInfo in pairs(Log.playerinfos) do
	 table.insert(self.cache.pinfos, 
		      string.format("> %s -- %d, %s, %s", charInfo.name, charInfo.level, charInfo.class, charInfo.race))
      end
   end
   
   -- Player Joins strings
   self.cache.pjoins = {}
   local tab
   if Log.playerjoins then
      for name, tab in pairs(Log.playerjoins) do
	 local str = string.format("> %s -- %s", name, tab[1])
	 local len, i = #tab
	 for i = 2, len do
	    str = string.format(", %s", tab[i])
	 end
	 table.insert(self.cache.pjoins, str)
      end
   end
   
   -- Player Leaves strings
   self.cache.pleaves = {}
   local tab
   if Log.playerleaves then
      for name, tab in pairs(Log.playerleaves) do
	 local str = string.format("> %s -- %s", name, tab[1])
	 local len, i = #tab
	 for i = 2, len do
	    str = string.format(", %s", tab[i])
	 end
	 table.insert(self.cache.pleaves, str)
      end
   end
   
   -- Loot list
   self.cache.lootlist = {}
   local dkpsys = DKPmon.DKP:Get()
   if Log.lootlist then
      for _, tab in ipairs(Log.lootlist) do
	 table.insert(self.cache.lootlist, string.format("> |cff%s%s|r -- %s", tab.colour, tab.name, tab.received))
	 local pool, cost
	 for pool, cost in pairs(tab.value) do
	    table.insert(self.cache.lootlist, string.format("   %g %s", cost, dkpsys:GetPoolName(tonumber(pool))))
	 end
      end
   end
   
   -- Points awarded
   self.cache.pointsawarded = {}
   if Log.pointsawarded then
      local MaxStrLen = 60
      for _, tab in ipairs(Log.pointsawarded) do
	 table.insert(self.cache.pointsawarded, string.format("> %s", tab.source))
	 local pool, cost
	 for pool, cost in pairs(tab.values) do
	    table.insert(self.cache.pointsawarded, string.format("  %g %s", cost, dkpsys:GetPoolName(tonumber(pool))))
	 end
	 table.insert(self.cache.pointsawarded, L["  Awarded to:"])
	 local pname
	 local str = "  -"
	 local first = true
	 for _, pname in ipairs(tab.players) do
	    if string.len(str) + string.len(pname) + 2 > MaxStrLen then
	       table.insert(self.cache.pointsawarded, str)
	       str = "  -"
	       first = true
	    end
	    if first then
	       str = string.format("%s %s", str, pname)
	    else
	       str = string.format("%s, %s", str, pname)
	    end
	    first = false
	 end
	 if not first then
	    table.insert(self.cache.pointsawarded, str)
	 end
      end
   end
end

--[[
DisplayLog
Description:
  Display the currently selected log
]]
function LogViewer:DisplayLog()
   local sf = self.scrollframe

   sf:Clear()
   if self.currentlog == nil then return end
   local Log = DKPmon.db.realm.Log.logs[self.currentlog]
   if Log == nil then return end

   sf:SetMaxLines(#self.cache.pinfos + #self.cache.pjoins + #self.cache.pleaves + #self.cache.lootlist + #self.cache.pointsawarded + 20)

   -- Header
   sf:AddMessage(string.format(L["Viewing Log: %s"], Log.raidkey))
   sf:AddMessage(string.format(L["Started: %s"], Log.raidstart))
   if Log.raidend then
      sf:AddMessage(string.format(L["Ended: %s"], Log.raidend))
   end
   sf:AddMessage(" ")
   sf:AddMessage(" ")

   -- Display the player list
   if DKPmon.db.realm.LogViewer.pinfos then
      sf:AddMessage(L["Player Information:"])
      local str
      for _, str in ipairs(self.cache.pinfos) do
	 sf:AddMessage(str)
      end
      sf:AddMessage(" ")
      sf:AddMessage(" ")
   end
   
   -- Display the player join times
   if DKPmon.db.realm.LogViewer.pjoins then
      sf:AddMessage(L["Player Join Times:"])
      local str
      for _, str in ipairs(self.cache.pjoins) do
	 sf:AddMessage(str)
      end
      sf:AddMessage(" ")
      sf:AddMessage(" ")
   end

   -- Display the player leave times
   if DKPmon.db.realm.LogViewer.pleaves then
      sf:AddMessage(L["Player Leave Times:"])
      local str
      for _, str in ipairs(self.cache.pleaves) do
	 sf:AddMessage(str)
      end
      sf:AddMessage(" ")
      sf:AddMessage(" ")
   end
   
   -- Display the loot list
   if DKPmon.db.realm.LogViewer.itemdrops then
      sf:AddMessage(L["Loot List:"])
      local str
      for _, str in ipairs(self.cache.lootlist) do
	 sf:AddMessage(str)
      end
      sf:AddMessage(" ")
      sf:AddMessage(" ")
   end
   
   -- Display the list of awarded points
   if DKPmon.db.realm.LogViewer.pointsawarded then
      sf:AddMessage(L["List of Awarded Points:"])
      local str
      for _, str in ipairs(self.cache.pointsawarded) do
	 sf:AddMessage(str)
      end
      sf:AddMessage(" ")
      sf:AddMessage(" ")
   end

   sf:ScrollToTop()
   local i
   for i = 1, 17 do sf:ScrollDown() end
end