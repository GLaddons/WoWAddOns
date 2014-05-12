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

local LootFrame = { bidstate = 0, itembuttons = {}, nbuttons = 0, nitems = 0, closetimeremaining = 0, closetime = 30 }
DKPmon.Looting = LootFrame

DKPmon.DBDefaults.LootFrame = {}
DKPmon.DBDefaults.LootFrame.pos = { x = (UIParent:GetWidth() / 2), y = (UIParent:GetHeight() / 2) }
DKPmon.DBDefaults.LootFrame.closetime = 30


--[[
Create
Description:
  Build the frame for handling looting/bidding/auctioning/etc via DKPmon
Input:
Returns:
]]
function LootFrame:Create() 
   if self.frame then return end
   
   self.frame = CreateFrame("Frame", "DKPmonLootFrame", UIParent)
   self.frame:SetFrameStrata("DIALOG")
   self.frame:SetFrameLevel(5)
   self.frame:SetWidth(225)
   self.frame:SetHeight(50)
   
   self.frame:SetMovable(1)
   self.frame:EnableMouse(1)
   self.frame:RegisterForDrag("LeftButton")
   self.frame:SetScript("OnDragStart", function() LootFrame:DragStart() end)
   self.frame:SetScript("OnDragStop", function() LootFrame:DragStop() end)
   
   DKPmon.FrameSkinner:BackdropFrame(self.frame, {0, 0, 0, 0.7}, {0.7, 0.7, 0.7, 0.9} )
   
   self.frame:ClearAllPoints()
   self.frame:SetPoint("TOPLEFT", UIParent, "BOTTOMLEFT", DKPmon.db.realm.LootFrame.pos.x, DKPmon.db.realm.LootFrame.pos.y)
   
   DKPmon.FrameSkinner:Skin(self.frame)
   
   -- Title for the frame
   local t = self.frame:CreateFontString()
   t:SetPoint("CENTER", self.frame, "TOP", 0, -10)
   t:SetTextColor(1.0, 0.819, 0.0)
   t:SetWidth(175)
   t:SetFontObject(GameFontNormal)
   t:SetText(L["DKPmon: Loot Distribution"])
   
   -- Create the close-window button
   local b = CreateFrame("Button", "DKPmonLootFrameCloseButton", self.frame)
   self.closebutton = b
   b:SetScript("OnClick", function() LootFrame.frame:Hide() end)
   b:SetWidth(32); b:SetHeight(32)
   b:SetNormalTexture("Interface\\Buttons\\UI-Panel-MinimizeButton-Up")
   b:SetPushedTexture("Interface\\Buttons\\UI-Panel-MinimizeButton-Down")
   b:SetHighlightTexture("Interface\\Buttons\\UI-Panel-MinimizeButton-Highlight")
   b:ClearAllPoints()
   b:SetPoint("TOPRIGHT", self.frame, "TOPRIGHT", 3, 3)
   b:SetHitRectInsets(5, 5, 5, 5)
   b:Show()
   
   -- Actions button
   b = CreateFrame("Button", "DKPmonLootFrameActionButton", self.frame, "UIPanelButtonTemplate")
   self.actionbutton = b
   b:SetWidth(100); b:SetHeight(22)
   b:SetText(L["Actions"])
   b:SetPoint("TOP", self.frame, "TOP", 0, -20)
   b:SetScript("OnClick", function() LootFrame:ShowActionMenu() end)
   b:Show()

   -- Text string for reporting DKP system used
   t = self.frame:CreateFontString()
   t:SetPoint("TOP", self.frame, "BOTTOM", 0, 30)
   t:SetWidth(205)
   t:SetFontObject(GameFontNormalSmall)
   t:SetText(L["DKP System: "])
   t:SetNonSpaceWrap(false)
   t:SetJustifyH("LEFT")
   self.dkpsystext = t
   
   -- Text string for reporting logging status
   t = self.frame:CreateFontString()
   t:SetPoint("TOP", self.frame, "BOTTOM", 0, 19)
   t:SetWidth(205)
   t:SetFontObject(GameFontNormalSmall)
   t:SetText(L["Logging: "])
   t:SetNonSpaceWrap(false)
   t:SetJustifyH("LEFT")
   self.logtext = t

   -- Set the close time to the saved value
   self.closetime = DKPmon.db.realm.LootFrame.closetime or 30
end


--[[
Show
Description:
  Display the DKPmon looting window
Input:
Returns:
]]
function LootFrame:Show()
   self:Create()
   self.frame:Hide()
   local buttonheight = 0
   local width = 225
   local i
   for i = 1, self.nbuttons do
      self.itembuttons[i]:Hide()
   end
   for i = 1, self.nitems do
      width = math.max(width, self.itembuttons[i]:GetWidth()+20)
      self.itembuttons[i]:Show()
   end
   
   if self.nbuttons > 0 then
      buttonheight = self.itembuttons[1]:GetHeight()
   end
   self.frame:SetHeight(20+50 + buttonheight * self.nitems)
   self.frame:SetWidth(width)
   self:SetTextStrings()
   self.frame:Show()
end

function LootFrame:SetTextStrings()
   if self.frame == nil then return end
   -- Set the name of the DKP system
   self.dkpsystext:SetText(string.format(L["DKP System: %s"], DKPmon.DKP:GetDKPSystemName()))
   -- Set the logging string based on whether logging is currently enabled.
   local log = DKPmon.Logging:GetCurrentLog()
   if log == nil then
      -- Logging disabled.
      self.logtext:SetText(L["Logging: Disabled"])
   else
      -- Logging enabled
      self.logtext:SetText(string.format(L["Log: %s started %s"], log.raidkey, log.raidstart))
   end
end

--[[
GetBidState()
Description:
  Return the current bidding state.
Input:
  None
Returns:
  bidstate -- number;
    0 -- Building the list of bidable items
    1 -- Bidding is open, and we're accepting bids
    2 -- Bidding is closed and we're deciding winners
    3 -- Winners have been announced, waiting for point deduction
]]
function LootFrame:GetBidState()
   return self.bidstate
end

--[[
SetBidState()
Description:
  Set the current bid state to the given number. Doesn't perform any sanity checking, so be sure you know what you're doing
  when changing the bidstate.
Input:
  bidstate -- number;
    0 -- Building the list of bidable items
    1 -- Bidding is open, and we're accepting bids
    2 -- Bidding is closed and we're deciding winners
    3 -- Winners have been announced, waiting for point deduction
Returns:
  None
]]
function LootFrame:SetBidState(bidstate)
   self.bidstate = bidstate
end

--[[
Hide()
Description:
  Hide the DKPmon looting window
Input:
Returns:
]]
function LootFrame:Hide()
   if self.frame then self.frame:Hide() end
end


--[[    
DragStart()
Description:
  Called when the user clicks on the DKPmon looting window to begin moving it around
Input:
Returns:
]]
function LootFrame:DragStart()
   self.frame:StartMoving()
end


--[[
LootFrame:DragStop()
Description:
  Called when the user stops dragging the window around. Saves the position of the window to the AceDB
Input:
Returns:
]]
function LootFrame:DragStop()
   self.frame:StopMovingOrSizing()
   DKPmon.db.realm.LootFrame.pos.x = self.frame:GetLeft()
   DKPmon.db.realm.LootFrame.pos.y = self.frame:GetTop()
end


--[[
LootFrame:AddItem()
Description:
  Given the information for an item, add the item to the list of bidable items. Creates the button and all that jazz.
Input:
  iteminfo -- table; ItemInfo struct
Returns:
]]
function LootFrame:AddItem(iteminfo)
   if self.frame == nil then self:Create() end
   if (self.nbuttons == self.nitems) then
      self.nbuttons = self.nbuttons + 1
      self.itembuttons[self.nbuttons] = DKPmon.LootItem:New(self.frame, self.nbuttons)
   end
   self.nitems = self.nitems + 1
   self.itembuttons[self.nitems]:SetItem(iteminfo)
   self:Show()
end

--[[
LootFrame:RemoveItem(id)
Description:
  Given the information for an item, add the item to the list of bidable items. Creates the button and all that jazz.
Input:
  id -- number; id of the item to be removed
Returns:
]]
function LootFrame:RemoveItem(id)
   local i
   for i = id, self.nitems-1 do
      self.itembuttons[i]:CopyLootItem(self.itembuttons[i+1])
   end
   self.nitems = self.nitems - 1
   self:Show()
end

--[[    
LootFrame:Clear()
Description:
  Remove all bidable items from the list.
Input:
Returns:
]]
function LootFrame:Clear()
   if self.frame == nil then return end -- nothing to do
   if self.bidstate > 0 then
      -- Bidding's active, have to confirm that the clear should go through
      StaticPopup_Show("DKPMON_CONFIRM_LOOTCLEAR")
      return
   end
   if self.bidstate < 0 then -- we were called from the popup dialog
      -- Bidding's active, have to close it down
      DKPmon:StopMetro("DKPmonClose") -- Stop the timer if one's going
      DKPmon.Comm:SendToBidder("C")
      SendChatMessage("Sorry, bidding was cancelled.", "RAID")
   end
   self.nitems = 0
   self.closetimeremaining = 0
   self.bidstate = 0
   if self.frame:IsVisible() ~= nil then
      self:Show()
   end
end

--[[
ShowActionMenu
Description:
  Called when the "Actions" button is clicked. Brings up a list of available actions to perform (open bidding, close bidding, announce, etc)
Input:
Returns:
]]
function LootFrame:ShowActionMenu() 
   --DKPmon:TableDelete(dewOptions)
   dewOptions = { type = "group", args = {} }
   dewOptions.args.header = { type = 'header', name = L['Actions'], order = 1 } 
   
   dewOptions.args.clearall = { type = 'execute', name = L['Clear all'], 
      desc = L['Clear all items from the distribution window'], func = function() LootFrame:Clear() end, order = 100 }
   
   if self.bidstate == 0 then
      -- Add the "Open bidding" option
      dewOptions.args.openbids = { type = 'execute', name = L['Open bidding'], desc = L['Open bidding on all items'],
	 func = function() DKPmon.Looting:OpenBidding(); dewdrop:Close() end, order = 2 }
   end
   if self.bidstate == 1 then
      -- Add  "Close bidding" timer selection, "Close bidding" option, and "cancel" option
      dewOptions.args.closetimer = { type = 'range', name = L['Close timer'], desc = L['Select time in which to close bidding'],
	 min = 5, max = 60, step = 1,
	 get = function() return LootFrame.closetime end, set = function(v) LootFrame.closetime = v; DKPmon.db.realm.LootFrame.closetime = v end,
	 order = 3 }
      dewOptions.args.closebidding = { type = 'execute', name = L['Close bidding'], desc = L['Start the timer to close bidding on all items'],
	 func = function()  local Lt = DKPmon.Looting; Lt.closetimeremaining = Lt.closetime; Lt:StartCloseBiddingTimer(); dewdrop:Close() end,
	 order = 4 }
      dewOptions.args.canceltimer  = { type = 'execute', name = L['Cancel closing timer'], desc = L['Cancel the countdown timer for close of bidding'],
	 func = function() 
		   DKPmon:StopMetro("DKPmonClose"); 
		   --if IsRaidOfficer() then 
		   --   SendChatMessage(L["Bid closing countdown cancelled."], "RAID_WARNING")
		   --else
		      SendChatMessage(L["Bid closing countdown cancelled."], "RAID")
		   --end 
		   dewdrop:Close()
		end, 
	 order = 5 }
      dewOptions.args.cancelbidding = { type = 'execute', name = L['Cancel'], desc = L['Cancel the open bidding and allow more items to be added'],
	 func = function() DKPmon.Looting:CancelCloseTimer(); dewdrop:Close() end, order = 6 }
   end
   if self.bidstate == 2 or self.bidstate == 3 then
      -- Add the "Open bidding" option
      dewOptions.args.openbids = { type = 'execute', name = L['Open bidding'], desc = L['Open bidding on all items'],
	 func = function() DKPmon.Looting:OpenBidding(); dewdrop:Close() end, order = 2 }
      -- Add "Announce winners" option
      dewOptions.args.announce = { type = 'execute', name = L['Announce'], desc = L['Announce all item winners'],
	 func = function() DKPmon.Looting:AnnounceWinners(); dewdrop:Close() end, order = 7 }
   end
   if self.bidstate == 3 then
      -- Add "Deduct points" option
      dewOptions.args.deduct = { type = 'execute', name = L["Deduct winners' points"], desc = L['Open bidding on all items'],
	 func = function() DKPmon.Looting:DeductPoints(); dewdrop:Close() end, order = 8 }
   end
   
   DKPmon.DKP:Get():AddDistributionActionOptions(dewOptions, self.bidstate)
   
   dewdrop:Open(self.actionbutton, 'children', dewOptions, 'point', "TOP", 'relativePoint', "TOP")
end

--[[
OpenBidding
Description:
  Called when the user selects "Open Bidding" from the actions menu.
Input:
Returns:
]]
function LootFrame:OpenBidding()
   -- Make sure we're in a raid
   if IsInRaid() == false then
      DKPmon:Print(L["You're not in a raid group."])
      return
   end
   -- Go through the list of items to make sure that none are blocking the openning of bidding.
   local i
   local blocked = false
   for i = 1, self.nitems do
      if self.itembuttons[i].iteminfo.allowed == false then
	 blocked = true
	 DKPmon:Print(string.format(L["Item %d needs information filled in before bidding can begin."], i))
      end
   end
   if blocked then return end
   -- Okay, there are no blocks so build up the table to send and send the open bidding command.
   local tab = { sysID = DKPmon.DKP:GetDKPSystemID(), iteminfo = {} }
   for i = 1, self.nitems do
      -- *************************************************
      -- HACK to get around AceComm bug with not receiving itemlinks that aren't in the local cache
--      table.insert(tab.iteminfo, { link = string.gsub(self.itembuttons[i].iteminfo.link, "|", "@@@@"), dkp = self.itembuttons[i].iteminfo.dkpinfo } )
      -- *************************************************

      -- This is the non-hack version of this loop's internals
      table.insert(tab.iteminfo, { link = self.itembuttons[i].iteminfo.link, dkp = self.itembuttons[i].iteminfo.dkpinfo } )
   end
   DKPmon:Print('Leader OpenBidding',val)
   DKPmon:SetLeader(true)
   DKPmon.Comm:SendToBidder("OB", tab)
   self:SetBidState(1) -- move to open bidding

   -- And announce to the raid that bidding is open, and which items are available.
   SendChatMessage(L["Bidding is now open on:"], "RAID")
   for i = 1, self.nitems do
      SendChatMessage(string.format("   %s", self.itembuttons[i].iteminfo.link), "RAID")
   end
end


--[[
ReceiveBid
Description:
   Called when a "PB" (place bid) message is received from a bidder.
Input:
  sender -- the player who sent the bid
  params -- parameter table for the bid; see design doc for details.
Returns:
  None; but does send a bidding acknowledged ("M") message to the sender
]]
function LootFrame:ReceiveBid(sender, params)
   if params.item > self.nitems then
      DKPmon.Comm:SendToBidder("M", L["Error -- sent bid on non-existant item."], sender)
      DKPmon:Print(string.format(L["Error -- Received bid from %s on item that does not exist."], sender))
      return
   end
   local retval = self.itembuttons[params.item]:PlaceBid(sender, params.dkp)
   local msg
   if retval == nil then
      msg = string.format(L["Your bid on item %s was rejected."], params.item)
   else 
      if retval then
	 msg = string.format(L["Your bid on item %s was accepted."], params.item)
      else
	 msg = string.format(L["Your bid on item %s was removed."], params.item)
      end
   end
   DKPmon.Comm:SendToBidder("M", msg, sender)
   return true
end
DKPmon.Comm:RegisterCommand("PB", LootFrame.ReceiveBid, LootFrame)

--[[
StartCloseBiddingTimer()
Description:
  Starts the timer to close bidding, also called when the metronome ticks for the close of bidding
Input:
  None
Output:
  Just to raid chat
]]
function LootFrame:StartCloseBiddingTimer()
   local ctime = self.closetimeremaining
   local timerDur
   --self:Print("Close bidding in "..time.." seconds")
   DKPmon:StopMetro("DKPmonClose")
   if ctime == 0 then
      -- Time's up, close the bidding.
     --if IsRaidOfficer() then
  	 --  SendChatMessage(L["Bidding is now closed."], "RAID_WARNING")
     --else
  	   SendChatMessage(L["Bidding is now closed."], "RAID")
     --end
      self:SetBidState(2) -- Move to winner picking
      DKPmon.Comm:SendToBidder("C") -- Send the close of bidding command
      DKPmon.DKP:Get():OnCloseBidding()
      return
   end
   --if IsRaidOfficer() then
   --   SendChatMessage(string.format(L["Bidding closing in %g seconds."], ctime), "RAID_WARNING")
   --else
      SendChatMessage(string.format(L["Bidding closing in %g seconds."], ctime), "RAID")
   --end
   if ctime > 10 then
      timerDur = ctime - 10
   else
      if ctime > 5 then
	 timerDur = ctime - 5
      else
	 timerDur = 1
      end
   end
   self.closetimeremaining = ctime - timerDur
   DKPmon:ChangeMetroRate("DKPmonClose", timerDur)
   DKPmon:StartMetro("DKPmonClose")
end

--[[
CancelCloseTimer()
Description:
  Called when the "Cancel Close" option is selected
Input:
  None
Output:
  Just to raid chat
]]
function LootFrame:CancelCloseTimer()
   DKPmon:StopMetro("DKPmonClose")
   SendChatMessage(L["Bidding temporarily cancelled."], "RAID")
   self.closetimeremaining = 0
   -- Send the close bidding message.
   DKPmon.Comm:SendToBidder("C")
   self:SetBidState(0) -- move back to item placement
end


--[[
AnnounceWinners()
Description:
  Announces all selected item winners to raid chat
Input:
  None
Output:
  None
]]
function LootFrame:AnnounceWinners()
   SendChatMessage(L["And the winners are:"], "RAID")
   local i
   local DKP = DKPmon.DKP:Get()
   for i = 1, self.nitems do
      local ilink, winner = self.itembuttons[i].iteminfo.link, self.itembuttons[i].bidinfo.winner
      SendChatMessage(string.format("%s -- %s", ilink, winner), "RAID")
      DKP:OnWinnerAnnounce(i, ilink, winner)
   end
   self:SetBidState(3) -- Move to allowing items to be distributed & points to be deducted.
end

--[[
DeductPoints()
Description:
  Deducts points from all the winners then clears the looting window
Input:
  None
Output:
  None
]]
function LootFrame:DeductPoints()
   if self.bidstate == 3 then
      StaticPopup_Show("DKPMON_CONFIRM_DEDUCTPOINTS", DKPmon.DKP:GetDKPSystemName())
      return
   end
   -- First, build the list of DKP costs for each item
   local itemwinners = {}
   local i
   local DKP = DKPmon.DKP:Get()
   for i = 1, self.nitems do
      local button = self.itembuttons[i]
      local iinfo, winner, winnerdkp = button:GetItemInfo(), button:GetWinner(), button:GetWinnerDKP()
      --pprint(iinfo)
      --pprint(winner)
      --pprint(winnerdkp)
      table.insert(itemwinners, { winner = winner, item = iinfo, dkp = DKP:GetCost(winner, iinfo.dkpinfo, winnerdkp) })
   end
   DKP:DeductPoints(itemwinners)
   DKPmon.Logging:LootWins(itemwinners)
   if (DKPmon.Logging:LogToRaidTrackerReportValidity() == true and DKPmon.Logging:LogToRaidTrackerActive() == true) then
      DKPmon.Logging:RaidTrackerLogItems(itemwinners) -- log the item awards
   end   
   --DKPmon:TableDelete(itemwinners)
   self.nitems = 0
   self:Hide()
   self:SetBidState(0) -- Back to adding items
   DKPmon.Awarding:Show()
end
