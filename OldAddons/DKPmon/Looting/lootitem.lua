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

local _G = getfenv(0)

local L = AceLibrary("AceLocale-2.2"):new("DKPmon")
local dewdrop = AceLibrary("Dewdrop-2.0")
local dewOptions = {} -- table for the dewdrop menu

local LootItem = {}
DKPmon.LootItem = LootItem

--[[
New
Description:
  Create a new loot item button frame.
Input:
  parent -- frame to use as the parent of the button
  id     -- number; loot id of the button (integer, and > 0)
Returns:
]]
function LootItem:New(parent, id)
   -- Written with guidance from XLoot:AddLootFrame
   local item = {}
   item.id = id
   
   local frame = CreateFrame("Frame", "DKPmonLootItem"..id, parent)
   item.frame = frame 
   local button = CreateFrame(LootButton1:GetObjectType(), "DKPmonLootItem"..id.."Button", frame, "LootButtonTemplate")
   item.button = button
   button.lootitem = item
   
   item.itemname = _G["DKPmonLootItem"..id.."ButtonText"]
   item.statusline = button:CreateFontString("DKPmonLootItem"..id.."ButtonDescription", "ARTWORK", "GameFontNormalSmall")
   
   local font = {item.itemname:GetFont()}
   font[2] = 10
   
   item.itemname:SetDrawLayer("OVERLAY")
   item.itemname:SetJustifyH("LEFT")
   item.itemname:SetHeight(10)
   item.itemname:SetWidth(200)
   item.itemname:ClearAllPoints()
   item.itemname:SetPoint("TOPLEFT", button, "TOPLEFT", 42, -8)
   
   item.statusline:SetDrawLayer("OVERLAY")
   item.statusline:SetFont(unpack(font))
   item.statusline:SetJustifyH("LEFT")
   item.statusline:SetHeight(10)    
   item.statusline:SetWidth(200)
   item.statusline:ClearAllPoints()
   item.statusline:SetPoint("TOPLEFT", button, "TOPLEFT", 45, -19)
   
   button:SetHitRectInsets(0, -210, 0, -1)
   
   local border = DKPmon.FrameSkinner:QualityBorder(button)
   local fborder = DKPmon.FrameSkinner:QualityBorder(frame)
   button.wrapper = DKPmon.FrameSkinner:ItemButtonWrapper(button, 6, 6)
   fborder:SetHeight(fborder:GetHeight() -3)
   fborder:SetPoint("CENTER", frame, "CENTER", 4, 0.5)
   fborder:SetAlpha(0.3)
   frame:SetWidth(250)
   frame:SetHeight(button:GetHeight()+1)
   button:ClearAllPoints()
   frame:ClearAllPoints()
   frame:SetPoint("TOPLEFT", parent, "TOPLEFT", 10, -45 - (id-1)*(frame:GetHeight()+5))
   
   button:SetPoint("LEFT", frame, "LEFT")
   button:SetScript("OnClick", function(s, bclicked) s.lootitem:OnClick(bclicked) end)
   button:SetScript("PostClick", function(s, bclicked) if bclicked == "LeftButton" and IsControlKeyDown() then DressUpItemLink(item.iteminfo.link) end end) 
   button:SetScript("OnEnter", function(s) s.lootitem:ShowTooltip() end)
   
   --Skin
   DKPmon.FrameSkinner:Skin(frame)
   
   button:DisableDrawLayer("ARTWORK")
   button:Hide()
   frame:Hide()
   
   setmetatable(item, { __index = LootItem })
   return item
end


--[[
Show
Description:
  Show the button
Input:
Returns:
]]
function LootItem:Show()
   self.frame:Show()
   self.button:Show()
end


--[[
Hide
Description:
  Hide the button
Input:
Returns:
]]
function LootItem:Hide()
   self.frame:Hide()
   self.button:Hide()
end


--[[
GetHeight, GetWidth
Description:
  Return the height & width of the button, respectively
Input:
Returns:
]]
function LootItem:GetHeight()
   return self.button.wrapper:GetHeight()
end
function LootItem:GetWidth()
   return self.frame:GetWidth()
end

function LootItem:GetWinner()
   return self.bidinfo.winner
end
function LootItem:GetWinnerDKP()
   local i
   for i = 1, self.bidinfo.nbidders do
      if self.bidinfo.winner == self.bidinfo.bidders[i].name then
	 return self.bidinfo.bidders[i].dkp
      end
   end
   return nil
end
function LootItem:GetDKPInfo()
   return self.iteminfo.dkpinfo
end
function LootItem:GetItemInfo()
   return self.iteminfo
end

--[[
SetItem
Description:
  Set the item information for this button
Input:
  iteminfo -- table; ItemInfo struct
Returns:
  None
]]
function LootItem:SetItem(iteminfo)
   if self.iteminfo ~= nil then self.iteminfo = {} end --DKPmon:TableDelete(self.iteminfo) end
   if self.bidinfo ~= nil then self.bidinfo = {} end --DKPmon:TableDelete(self.bidinfo) end
   self.iteminfo = iteminfo
   self.bidinfo = { winner = L["Disenchant"], nbidders = 0, bidders = { }, distributed = false }
   SetItemButtonTexture(self.button, iteminfo.texture)
   self.itemname:SetTextColor(iteminfo.colourrgb.r, iteminfo.colourrgb.g, iteminfo.colourrgb.b)
   self.itemname:SetText(iteminfo.name)
   self:UpdateStatusText()
end

--[[
SetItem
Description:
  Set the item information for this button by copying the item information from the given LootItem
Input:
  item -- LootItem table
Returns:
  None
]]
function LootItem:CopyLootItem(item)
   self.iteminfo = item.iteminfo
   self.bidinfo = item.bidinfo
   SetItemButtonTexture(self.button, self.iteminfo.texture)
   self.itemname:SetTextColor(self.iteminfo.colourrgb.r, self.iteminfo.colourrgb.g, self.iteminfo.colourrgb.b)
   self.itemname:SetText(self.iteminfo.name)
   self:UpdateStatusText()
end

--[[
UpdateStatusText
Description:
  Update the statusline text to reflect the current winner and # of bidders.
Input:
Returns:
]]
function LootItem:UpdateStatusText()
   local winnerName = self.bidinfo.winner
   local tab = DKPmon.PointsDB:GetTable(winnerName)
   local hex
   if tab then
      hex = DKPmon:getClassHex(tab.info.class)
   end   
   local coloredName = hex and string.format("|cff%s%s|r",hex,winnerName) or winnerName
   self.statusline:SetText(string.format(L["%d Bids  -- Winner = %s"], self.bidinfo.nbidders, coloredName))
end

--[[
ShowTooltip
Description:
  Display the tooltip for the item associated with this button
Input:
Returns:
]]
function LootItem:ShowTooltip()
-- Reports that this SetOwner is causing issues with some addons
   GameTooltip:SetOwner(self.frame, "ANCHOR_RIGHT")
   GameTooltip:SetHyperlink(self.iteminfo.link)
   DKPmon.DKP:Get():FillTooltip(self.iteminfo.dkpinfo)
   if self.iteminfo.allowed ~= true then
      GameTooltip:AddLine(L["Blocking for more info"], 1.0, 0.819, 0.0)
   end
   --DKPmon:Print("test")
   GameTooltip:Show()
   CursorUpdate()
end


--[[
OnClick
Description:
  OnClick event handler for this button
Input:
  buttonclicked -- string; which button was clicked.
Returns:
]]
function LootItem:OnClick(buttonclicked)
   --pprint(self.iteminfo)
   --pprint(self.bidinfo)
   --DKPmon:TableDelete(dewOptions)
   dewOptions = {}
   if buttonclicked == "LeftButton" then
      if IsControlKeyDown() then return end -- dressing room function
      	
      dewOptions.type = "group"
      dewOptions.args = {}
      -- Bring up the list of bidders to select a winner from.
      dewOptions.args.header = { type = 'header', name = self.iteminfo.link , order = 1 }
      -- Add the selectors for "Disenchant" and "Bank"
      dewOptions.args.disenchantit = { type = 'execute', name = L['Disenchant'], order = 2, desc = 'Disenchant the item',
	 func = function() self.bidinfo.winner = L["Disenchant"]; self:UpdateStatusText(); end }
      dewOptions.args.guildbankit = { type = 'execute', name = L['Bank'], order = 3, desc = L['Pass the item to the guild bank'],
	 func = function() self.bidinfo.winner = L["Bank"]; self:UpdateStatusText(); end }
      DKPmon.DKP:Get():BuildWinnerSelectList(self, dewOptions, self.iteminfo.dkpinfo, self.bidinfo.bidders)
      
      if (DKPmon.Looting:GetBidState() == 2 or DKPmon.Looting:GetBidState() == 3) then
        local item_override_value = ""
        item_override_value = LootItem:GetCurrentItemValue(self)
        if (item_override_value ~= "" and item_override_value ~= nil) then
            item_override_value = ": (" .. item_override_value .. ")"
        else
            item_override_value = ""
        end
        dewOptions.args.bidoverrride = {
              type = 'group',
              name = 'Bid Override'..item_override_value,
              desc = 'Options for temporarily overriding bids and item prices',
              order = 40000,
              args = {
                      adjustbid = { 
                      type = 'text',
                      name = L['Override Bid'],
                      desc = L['Enter a value to override the bid on this item this time only. This value will not be saved.'],
                      usage = 'Enter a value to override the bid/cost of the item.',
                      get = function() return LootItem:GetCurrentItemValue(self) end,
                      set = function(v) LootItem:SetItemValueOverride(self, v) end,
                      order = 40001},
                    removeoverrride = { type = 'execute', name = L['Clear Bid Override'], order = 40002, desc = L['Clears the current override value'],
                      func = function() return LootItem:ClearItemValueOverride(self); end } 
              } 
          }        
      end      
      
      dewdrop:Open(self.button, 'children', dewOptions, 'point', "TOPLEFT", 'relativePoint', "TOPRIGHT")
      return
   end
   if buttonclicked == "RightButton" then
      dewOptions.type = "group"
      dewOptions.args = {}
      local showmenu = false
      if DKPmon.Looting:GetBidState() == 0 then
	 -- Add an menu choice for removing this item from the list
	 dewOptions.args.removeitem = {
	    type = 'execute', name = L['Remove item'], desc = L['Remove this item from the list'],
	    func = function()
		      dewdrop:Close()
		      StaticPopupDialogs["DKPMON_CONFIRM_REMOVEITEM"].OnAccept = 
			 function()
			    DKPmon.Looting:RemoveItem(self.id)
			 end
		      StaticPopup_Show("DKPMON_CONFIRM_REMOVEITEM", self.iteminfo.link)
		   end,
	    order = 1
	 }
	 showmenu = true
      end
      local lootmethod, mlID = GetLootMethod()
      if DKPmon.Looting:GetBidState() == 3 and (not self.bidinfo.distributed) and lootmethod == "master" and mlID == 0 then -- ML's enabled, and I'm the ML
	 -- Add a menu item to distribute via masterlooter
	 dewOptions.args.masterloot = {
	    type = 'execute', name = L['Distribute via masterlooter'], desc = L['Give this item to its winner via masterlooter'],
	    func = function()
		      dewdrop:Close()
		      StaticPopupDialogs["DKPMON_CONFIRM_DISTRIBUTEML"].OnAccept =
			 function()
			    self:MasterLootItem()
			 end
          
          local winnerName = self.bidinfo.winner
          local tab = DKPmon.PointsDB:GetTable(winnerName)
          local hex
          if tab then
             hex = DKPmon:getClassHex(tab.info.class)
          end   
          local coloredName = hex and string.format("|cff%s%s|r",hex,winnerName) or winnerName          
          
		      StaticPopup_Show("DKPMON_CONFIRM_DISTRIBUTEML", self.iteminfo.link, coloredName)
		   end,
	    order = 2
	 }
	 showmenu = true
      end
      -- Bring up the command menu for this button.
      local gotDKP = DKPmon.DKP:Get():BuildItemActionMenu(self, dewOptions, self.iteminfo)
      if gotDKP or showmenu then 
	 dewdrop:Open(self.button, 'children', dewOptions, 'point', "TOPLEFT", 'relativePoint', "TOPRIGHT")
      end
      return
   end
end

function LootItem:GetCurrentItemValue(self_info)
	--pprint(self_info.bidinfo.bidders);
	return self_info.iteminfo.dkpinfo.override
end

function LootItem:ClearItemValueOverride(self_info)
    self_info.iteminfo.dkpinfo.override = nil
    return true;
end

function LootItem:SetItemValueOverride(self_info, v)
    if (v == "") then
        v = nil
    end
	self_info.iteminfo.dkpinfo.override = v
	return true;
end

--[[
MasterLootItem()
Description:
  Called when the user clicks on button to distribute an item via masterlooter
Input:
  item: The item number of the item to be distributed
Output:
  None
]]
function LootItem:MasterLootItem()
   local iTab = self.iteminfo
   -- 1) Determine the slot number of the item 
   local nItems = GetNumLootItems()
   local i = 0
   local link
   while not (i > nItems) and (link ~= iTab.link) do
      i = i + 1
      link = GetLootSlotLink(i)
   end
   if (link ~= iTab.link) then
      -- Couldn't find the item, for some reason
      DKPmon:Print(string.format(L["ERROR: Could not find %s in loot window."], iTab.link))
      return
   end
   local slot = i
   -- 2) Determine the candidate index of the winner.
   LootFrame_OnEvent("UPDATE_MASTER_LOOT_LIST")
   local nRaiders = GetNumGroupMembers()
   local name
   local winnername
   if self.bidinfo.winner == L["Bank"] then
      winnername = DKPmon.db.realm.bankname
   else
      if self.bidinfo.winner == L["Disenchant"] then
	 winnername = DKPmon.db.realm.disenchanter
      else
	 winnername = self.bidinfo.winner
      end
   end
   -- Make sure the winner's in the raid
   if not DKPmon.RaidRoster:IsPlayerInRaid(winnername) then
      DKPmon:Print(string.format(L["Selected winner for %s is not in the raid. Cannot distribute"], iTab.link))
      return
   end
   i = 0
   while not (i > nRaiders) and (name ~= winnername) do
      i = i + 1
      name = GetMasterLootCandidate(i)
   end
   if (name ~= winnername) then
      -- Couldn't find the winner in the list of raid members eligable to receive loot
      DKPmon:Print(string.format(L["ERROR: %s could not be found in the MasterLooter list for %s"], winnername, iTab.link))
      return
   end
   local candidate = i
   GiveMasterLoot(slot, candidate)
end

--[[
PlaceBid
Description:
  Place, or remove, a bid for the given person on this item.
Input:
  bidder -- String; in-game name of the person bidding (i.e. not their bidname)
  dkpinfo -- information sent along for the DKP system to update this bid.
Returns:
  boolean -- nil = bid rejected
    false = bid removed
    true = bid accepted
]]
function LootItem:PlaceBid(bidder, dkpinfo)
   local retval = DKPmon.DKP:Get():PlaceBid(self, bidder, dkpinfo, self.bidinfo.bidders, self.bidinfo.nbidders)
   if retval ~= nil then   
      self.bidinfo.nbidders = table.maxn(self.bidinfo.bidders)
      self:UpdateStatusText()
   end
   return retval
end
