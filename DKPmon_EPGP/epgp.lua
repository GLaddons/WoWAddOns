--[[
    Lack of Copyright Karl Schmidt, 2007

    This file is part of DKPmon_EPGP.

    DKPmon_EPGP is free software; you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published by
    the Free Software Foundation; either version 2 of the License, or
    (at your option) any later version.

    DKPmon_EPGP is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.

    You should have received a copy of the GNU General Public License
    along with DKPmon_EPGP; if not, write to the Free Software
    Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA

    Many thanks to Daniel D. Neilson for DKPmon_FCZS and Arlo White for
    DKPmon_BossAuction, whose coding work I am shamelessly ripping off and
    without whom DKPmon_EPGP would not be here
]]

--[[
      -- Every item is a fixed point cost ("GP"), as dictated by a database of items.
      -- Points ("EP") are awarded arbitrarily
      -- Priority is determined as EP/GP, highest priority wins
      -- Supports an arbitrary number of "point pools"
]]

--[[
dkpinfo table contents for this DKP system:
]]

-- Check if DKPmon is installed before doing anything.
--if DKPmon == nil then return end

local AceOO = AceLibrary("AceOO-2.0")
local L = AceLibrary("AceLocale-2.2"):new("DKPmon_EPGP")

local EPGP = AceOO.Class(DKPmon_DKP_BaseClass,"AceEvent-2.0")
local Debug = LibStub("LibDebug-1.0")
local GPLib = LibStub("LibGearPoints-1.2")
local dewdrop = AceLibrary("Dewdrop-2.0")

local use_pre_wotlk_formula = 0 -- set to 0 for the WoTLK (new) EPGP formula. Set to 1 to use the TBC (pre-WoTLK or old) formula

--[[
Initialize
Description:
  Initialize the DKP system. Effectively called from within the OnEnable() function of DKPmon
Input:
  None
Returns:
  None
]]
function EPGP.prototype:Initialize()
   local mydb = DKPmon.DKP:GetDB("EPGP")
   if mydb.qualthreshold == nil then
      mydb.qualthreshold = 4
   end
   if mydb.allowitemadding == nil then
      mydb.allowitemadding = true
   end
	if mydb.autoMasterLoot == nil then
		mydb.autoMasterLoot = true
	end
	if mydb.selectedPool == nil then
        mydb.selectedPool = 1
	end

    if mydb.greedFactor == nil then
        mydb.greedFactor = 1
    end
    
    if mydb.allowautocosts == nil then
        mydb.allowautocosts = false
    end

	self.periodicDkpIndex = 0
end

--[[
GetPlayerPoints(name,pool)
Description:
Redefines the inherited GetPlayerPoints in a way that makes sense for EPGP
Input:
  name -- The name of the bidding player.
  pool -- The number of the bidding pool we're checking points for
Returns:
  The value of EP/GP, rounded to two decimals
]]
function EPGP.prototype:GetPlayerPoints(name, pool)
   return floor( 100 * DKPmon.PointsDB:GetEarned(name, pool) / max(1,DKPmon.PointsDB:GetSpent(name, pool)) + 0.5 ) / 100
end

--[[
GetItemInfo()
Description:
  Given information on an item, check if the item is allowed to be bid on (meets quality requirements, is in a database, etc)
  and get the DKP information for the item.
Input:
  iteminfo -- ItemInfo table minus allowed & dkpinfo fields
Returns:
  allowed, dkpinfo
    allowed -- boolean or nil;
      nil (item shouldn't be bid on),
      false (item is okay, but more info is needed for it. So, the item can be added to the list, but bidding cannot be opened until the info is filled in)
      true (item's good to go)
    dkpinfo -- table; information on this item's cost, etc. (whatever's needed by the DKP system to know how many points to charge for the item). nil if allowed = nil
]]
function EPGP.prototype:GetItemInfo(iteminfo)
   local mydb = DKPmon.DKP:GetDB("EPGP")
   if iteminfo.quality < mydb.qualthreshold then return nil,nil end -- TODO: Quality threshold through the AceDB

   local cInfo = DKPmon.CustomInfo:Get("EPGP")
   local dkpinfo, allowed = {}, true
   -- Look up the item in the itemvalues table
   local tab = cInfo.itemvalues[iteminfo.name]
   if tab == nil then
      -- Wasn't in the pre-defined list, check if it's in the SavedVariables list.
      if mydb.itemlist ~= nil then
	 tab = mydb.itemlist[iteminfo.name]
      end
   end
   if tab ~= nil then
      dkpinfo.cost = tab.value
      dkpinfo.poolIndex = tab.pool
      -- Quick sanity check.
      if cInfo.poolnames[tab.pool] == nil then
         error(string.format(L["Item %s is assigned to an undefined pool."], iteminfo.name))
         return nil, nil
      end
      dkpinfo.poolName = cInfo.poolnames[tab.pool]
   else
      if not mydb.allowitemadding then return nil, nil end
      allowed = false
      dkpinfo.cost = 0
      dkpinfo.poolIndex = 0
      dkpinfo.poolName = L["Unknown"]
   end
   return allowed, dkpinfo
end


--[[
FillTooltip()
Description:
  Called when an item in the Looting Window is moused over to add the DKP-system specific information to the GameTooltip for the moused over item
Input:
  dkpinfo -- table; same table returned from self:GetItemInfo()
Returns:
  Nothing
]]
function EPGP.prototype:FillTooltip(dkpinfo)
   GameTooltip:AddLine(" ")
   GameTooltip:AddDoubleLine(string.format(L["GP = %g"], dkpinfo.cost), string.format("%s(#%d)",  dkpinfo.poolName, dkpinfo.poolIndex),
                             1.0, 0.819, 0.0,  1.0, 0.819, 0.0)
end

--[[
AddDistributionActionOptions
Description:
  Called when the "Actions" button in the loot distribution window is pressed.
  This call allowed the DKP system to add any DKP-system specific options it might like to the action menu.
Input:
  dewOptions -- the AceOptions table to add to
  bidstate -- the current bidstate.
Returns:
  None
]]
function EPGP.prototype:AddDistributionActionOptions(dewOptions, bidstate)
end

--[[
BuildWinnerSelectList(itembutton, dewOptions, iteminfo)
Description:
  Build the list of item bidders to select a winner from.
  Note: the "Disenchant" and "Guild bank" options will already be in the list.
Input:
  itembutton -- LootItem; lootitem class/table that's associated with the item passed.
  dewOptions -- table; dewOptions table to add the list to
  dkpinfo -- table; information about the item for the DKP system
  bidders -- table; indexed by number, starting at 1. Each entry is a table of the form: { name = string, dkpinfo = table }
    where "name" is the name of the player that placed the bid, and dkpinfo is the information about their bid
Returns:
  None
]]
function EPGP.prototype:BuildWinnerSelectList(itembutton, dewOptions, dkpinfo, bidders)
   local i, nametab
   for i, nametab in ipairs(bidders) do
      local bidderinfo = DKPmon.RaidRoster:GetPlayerInfo(nametab.name) -- information about the player who placed this bid
      if bidderinfo == nil then
	 DKPmon:Print(string.format(L["Error -- player %s has bid on this item but has never been in the raid! Not listing them."], nametab.name))
      else
	 local playerep = DKPmon.PointsDB:GetEarned(bidderinfo.bidchar.name, dkpinfo.poolIndex)
	 local playerprio = DKPmon.PointsDB:GetEarned(bidderinfo.bidchar.name, dkpinfo.poolIndex)/max(1,DKPmon.PointsDB:GetSpent(bidderinfo.bidchar.name, dkpinfo.poolIndex))
	 local namestr
	 if nametab.name == bidderinfo.bidchar.name then
	    if nametab.dkp.bidtype == 1 then namestr = string.format("%s - |cff%s%s|r(%g) (%g EP)", L["Need"], bidderinfo.char.classhex, nametab.name, playerprio, playerep)
        elseif nametab.dkp.bidtype == 2 then namestr = string.format("%s - |cff%s%s|r(%g) (%g EP)", L["Greed"], bidderinfo.char.classhex, nametab.name, playerprio, playerep)
        end
	 else
	    if nametab.dkp.bidtype == 1 then namestr = string.format("%s - ||cff%s%s|r[|cff%s%s|r](%g) (%g EP)", L["Need"], bidderinfo.char.classhex,
                                                                 nametab.name, bidderinfo.bidchar.classhex, bidderinfo.bidchar.name, playerprio, playerep)
        elseif nametab.dkp.bidtype == 2 then namestr = string.format("%s - ||cff%s%s|r[|cff%s%s|r](%g) (%g EP)", L["Greed"], bidderinfo.char.classhex,
                                                                     nametab.name, bidderinfo.bidchar.classhex, bidderinfo.bidchar.name, playerprio, playerep)
        end
	 end
	 dewOptions.args[string.format("%d", i)] = {
	    type = 'execute', name = namestr, order = 25000 - playerprio + nametab.dkp.bidtype*20000,
	    desc = string.format(L["Select %s to win the item"], nametab.name),
	    func = function() itembutton.bidinfo.winner = nametab.name; itembutton:UpdateStatusText(); end
	 }
      end
   end
end


StaticPopupDialogs["DKPMON_EPGP_CONFIRM_SETITEMVALUE"] = {
   text = "", -- will be assigned by creater
   button1 = L["Yes"],
   button2 = L["No"],
   OnAccept = nil, -- will be assigned by creater
   OnCancel = function() end,
   sound = "levelup2",
   timeout = 10,
   whiledead = 1,
   hideOnEscape = 1
}

--[[
BuildItemActionMenu(itembutton, dewOptions, iteminfo)
Description:
  Called when the user right-clicks on an item in the "Loot distribution" window.
  This is the DKP system's opportunity to do things like assign a point value to the item, if desired.
Input:
  itembutton -- LootItem; lootitem class/table that's associated with the item passed.
  dewOptions -- table; dewOptions table to add the list to
  iteminfo -- ItemInfo table
Returns:
  boolean; true -- items were added to the list
           false -- no items were added to the list.
]]
function EPGP.prototype:BuildItemActionMenu(itembutton, dewOptions, iteminfo)
   if DKPmon.Looting:GetBidState() == 0 then -- Building item list
      --if iteminfo.allowed then return false end     
      if self.potentialitemvalues == nil then self.potentialitemvalues = {} end
      if self.potentialitemvalues[iteminfo.name] == nil then
	    self.potentialitemvalues[iteminfo.name] = {value = 0, pool = 1, formula_value = 0}
      end
      
      --Begin code edits by David Pate
      local mydb1 = DKPmon.DKP:GetDB("EPGP")   
      local recommended_item_gp_value = "";
      --if mydb1.allowautocosts == true then
        --This will call the GPLib function for calculating the GP Cost and place it in the table as the value for the item
        --This will only occur if the check button for allowing costs to be automatically inserted in the EPGP System menu is checked.
        --This was done this way to ensure that if for some reason the main looter wanted to change the cost they still would be able to.
        --DKPmon:Print(iteminfo)
        --DKPmon:Print(iteminfo.link)
        local _, _, Color, Ltype, ItemId, Enchant, Gem1, Gem2, Gem3, Gem4, Suffix, Unique, LinkLvl, Name = string.find(iteminfo.link, "|?c?f?f?(%x*)|?H?([^:]*):?(%d+):?(%d*):?(%d*):?(%d*):?(%d*):?(%d*):?(%-?%d*):?(%-?%d*):?(%d*)|?h?%[?([^%[%]]*)%]?|?h?|?r?")
        recommended_item_gp_value = GPLib:GetValue(ItemId)
     	
        if not (recommended_item_gp_value == nil) then
     		self.potentialitemvalues[iteminfo.name].formula_value = recommended_item_gp_value
        else 
     		self.potentialitemvalues[iteminfo.name].formula_value = 0
        end
        --DKPmon:Print(self.potentialitemvalues[iteminfo.name].formula_value .. "!!!!") 
      --end
      local cInfo = DKPmon.CustomInfo:Get("EPGP")
      local mydb = DKPmon.DKP:GetDB("EPGP")
      dewOptions.args.epgp = {
	 type = 'group',
	 name = L['Specify item value'],
	 desc = L['Specify the value of this item'],
	 args = {
	    assign = {
	       type = 'execute', name = L['Assign value'], desc = L['Assign this value to this item'],
	       func = function()
			 if self.potentialitemvalues[iteminfo.name] == 0 then DKPmon:Print(L["Cannot assign a value of zero"]); return end
			 StaticPopupDialogs["DKPMON_EPGP_CONFIRM_SETITEMVALUE"].text =
			    string.format(L["Make %s worth %g points from pool %s?"],
					  iteminfo.link, self.potentialitemvalues[iteminfo.name].value, cInfo.poolnames[self.potentialitemvalues[iteminfo.name].pool])
			 StaticPopupDialogs["DKPMON_EPGP_CONFIRM_SETITEMVALUE"].OnAccept =
			    function()
			       iteminfo.allowed = true
			       if mydb.itemlist == nil then mydb.itemlist = {} end
			       mydb.itemlist[iteminfo.name] = { value = self.potentialitemvalues[iteminfo.name].value, pool = self.potentialitemvalues[iteminfo.name].pool }
			       self.potentialitemvalues[iteminfo.name] = nil
			       iteminfo.dkpinfo = {
				  cost = mydb.itemlist[iteminfo.name].value,
				  poolIndex = mydb.itemlist[iteminfo.name].pool,
				  poolName = cInfo.poolnames[mydb.itemlist[iteminfo.name].pool]
			       }
			    end
			 StaticPopup_Show("DKPMON_EPGP_CONFIRM_SETITEMVALUE")
			 dewdrop:Close()
		      end,
	       order = 1
	    },
	    poolchoice = {
	       type = 'text', name = L['Choose pool'], desc = L['Choose which point pool this item is in'],
	       usage = '<pool>',
	       get = function() return string.format("p%d", self.potentialitemvalues[iteminfo.name].pool) end,
	       set = function(v) self.potentialitemvalues[iteminfo.name].pool = tonumber(string.sub(v, 2)); end,
	       validate = {},
	       order = 2
	    },
	    setvalue = {
	       type = 'text', name = L['Set Custom value'], desc = L['Set the number of points this item is worth - Use Assign Value to store the value'],
	       usage = '<value>',
	       get = function() return self.potentialitemvalues[iteminfo.name].value end,
	       set = function(v) self.potentialitemvalues[iteminfo.name].value = v end,
	       validate = function(v) local val = tonumber(v); if val == nil then return false end; return not (val < 0); end,
	       order = 3
	    },
	    setformulavalue = {
	       type = 'text', name = L['Set Formula Value'], desc = L['Set the number of points this item is worth to the EPGP formula value - Use Assign Value to store the value'],
	       usage = '<value>',
	       get = function() return self.potentialitemvalues[iteminfo.name].formula_value end,
	       set = function(v) self.potentialitemvalues[iteminfo.name].value = v end,
	       validate = function(v) local val = tonumber(v); if val == nil then return false end; return not (val < 0); end,
	       order = 4
	    }	    
	 }
      }
      -- Fill in the validate field of dewOptions.args.epgp.args.poolchoice
      local i, name
      for i, name in ipairs(cInfo.poolnames) do
	 dewOptions.args.epgp.args.poolchoice.validate["p"..i] = name
      end
      return true
   end

   if DKPmon.Looting:GetBidState() == 1 then -- If bidding's open
      dewOptions.args.epgp = {
	 type = 'text', name = L['Add/remove a bidder'], desc = L['Add, or remove, a player from the list of bidders for this item.'],
	 usage = '<name>', get = false,
	 validate = function(v)
		       -- Make sure the name's in the raid
		       local name = string.upper(string.sub(v,1,1))..string.lower(string.sub(v, 2))
		       return DKPmon.RaidRoster:IsPlayerInRaid(name)
		    end,
	 set = function(v)
		  local name = string.upper(string.sub(v,1,1))..string.lower(string.sub(v, 2))
		  DKPmon.Looting:ReceiveBid(name, { item = itembutton.id, dkp = { bidtype = 1 } })
	       end
      }
      return true
   end
   return false
end

--[[
ProcessQueryConsole(bidname, bidclass)
Description:
  Build, and return, a message string to send regarding the point totals of the given bidname
Input:
  bidname -- name to look up the points for
Returns:
  String -- message to be displayed to the person who did the query
]]
function EPGP.prototype:ProcessQueryConsole(bidname)
   local cInfo = DKPmon.CustomInfo:Get("EPGP")
   local tab = DKPmon.PointsDB:GetTable(bidname)
   if tab == nil then
      return L["You have no points."]
   end
   local reply = L["Your EP, GP and priority are:"]
   for p, _ in pairs(tab.points) do
      local pool = tonumber(p)
      local ep = DKPmon.PointsDB:GetEarned(bidname, pool)
      local gp = max(1,DKPmon.PointsDB:GetSpent(bidname, pool))
      reply = string.format("%s %s = %g EP, %g GP & %g EP/GP;", reply, cInfo.poolnames[pool], ep, gp, floor( 100*ep/gp + 0.5 ) / 100)
   end
   return reply
end

--[[
GetNPools
Description:
  Return the number of point pools being used by the DKP system
Input:
  None
Returns:
  Number.
]]
function EPGP.prototype:GetNPools()
   return DKPmon.CustomInfo:Get("EPGP").numpools
end

--[[
GetPoolName
Description:
  Find out what the given pool number is called
Input:
  pool -- number in the range [1, GetNPools()]
Returns:
  string -- name by which to refer to the pool
]]
function EPGP.prototype:GetPoolName(pool)
   return DKPmon.CustomInfo:Get("EPGP").poolnames[pool]
end

--[[
PlaceBid
Description:
  Place, or remove, a need or greed bid for the given person on this item.
Input:
  bidder -- String; in-game name of the person bidding (i.e. not their bidname)
  dkpinfo -- information sent along for the DKP system to update this bid. Table { bidtype -- Integer; 1 is need, 2 greed, 3 remove }
  bidderlist -- table; the list of bidders for this item. Each entry = { name = <name of person bidding>, dkp = <information about the bid> }
  nbidders -- number; number of elements in the bidderlist table
Returns:
  Boolean
    nil = bid rejected
    true = bid accepted
    false = bid removed
]]

function EPGP.prototype:PlaceBid(itembutton, bidder, dkpinfo, bidderlist, nbidders)
   -- In EPGP bid placement can be need or greed, which is carried in dkpinfo.bidtype

   -- Search the biddinglist to see if this person's already bid on this item
   local i
   for i = 1, nbidders do
      if bidderlist[i].name == bidder then
        if not bidderlist[i].dkp then
          -- Check if bidder has made a type-specific bid before (required for backwards compatability)
          bidderlist[i].dkp = { bidtype = dkpinfo.bidtype }
          -- DKPmon:Print("DEBUG: Created bidderlist.dkpinfo, bidtype: " .. dkpinfo.bidtype)
          return true
        elseif dkpinfo.bidtype == 3 then
          -- Remove request, remove this element from the list
          table.remove(bidderlist, i)
          -- DKPmon:Print("DEBUG: Removed user from bidderlist")
          return false
        elseif ( dkpinfo.bidtype == 1 or dkpinfo.bidtype == 2 ) then
          -- Need or greed bid, set as appropriate
          bidderlist[i].dkp.bidtype = dkpinfo.bidtype
          -- DKPmon:Print("DEBUG: Accepted bid, bidtype: " .. dkpinfo.bidtype)
          return true
        end
      end
   end

   -- Sanity check to see if dkpinfo is in fact included
   if dkpinfo == nil then
     return nil
   end

   -- Person wasn't in the list, so add them
   table.insert(bidderlist, { name = bidder, dkp = { bidtype = dkpinfo.bidtype } })
   -- DKPmon:Print("DEBUG: Created bidderlist entry, type: " .. dkpinfo.bidtype)
   return true
end


--[[
GetCost(winner, itemdkp, winnerdkp)
Description:
  Given the dkpinfo about an item, and the winner return a table containing the costs to charge the winner.
Input:
  winner -- string; name of the winner
  itemdkp -- table; same table returned from self:GetItemInfo()
  winnerdkp -- table; same table used in self:PlaceBid()
Returns:
  table  -- {  [<pool#>] = <number -- the cost to the pool>, ... }
]]
function EPGP.prototype:GetCost(winner, itemdkp, winnerdkp)
    local mydb = DKPmon.DKP:GetDB("EPGP")
    if winnerdkp == nil then  --This happens for items heading for bank or disenchant
        return { [itemdkp.poolIndex] = itemdkp.cost }
    elseif winnerdkp.bidtype == 1 then
        if (itemdkp.override ~= nil) then
            return { [itemdkp.poolIndex] = itemdkp.override }
        else
            return { [itemdkp.poolIndex] = itemdkp.cost }
        end
    else
        if (itemdkp.override ~= nil) then
            return { [itemdkp.poolIndex] = itemdkp.override }
        else
            return { [itemdkp.poolIndex] = itemdkp.cost * mydb.greedFactor }
        end
    end
end

--[[
DeductPoints(itemwinners)
Description:
  Deduct the points for won items.
Input:
  itemwinners -- table; { [i] = { winner = <string; raid name of the winner>,
  item = <table; ItemInfo struct>,
  dkp = <table; return value of self:GetCost() for the won item> } } for i = 1.. num winners
Returns:
  None
]]
function EPGP.prototype:DeductPoints(itemwinners)
   local i, tab
   local cInfo = DKPmon.CustomInfo:Get("EPGP")
   local mydb = DKPmon.DKP:GetDB("EPGP")
   for i, tab in ipairs(itemwinners) do
      -- Deduct the points from the winner
      if tab.winner ~= L["Disenchant"] and tab.winner ~= L["Bank"] then -- We don't deduct points for disenchanting or banking
        local wininfo = DKPmon.RaidRoster:GetPlayerInfo(tab.winner)
        if wininfo == nil then
	      local msg = string.format(L["Error -- %s has never been in the raid! I cannot deduct points because I don't know enough about them. Please make note of the following deductions and do them manually:"], tab.winner)
	      local p, c
	      for p, c in pairs(tab.dkp) do
	        msg = string.format(L["%s\n%g from pool %d"], msg, c, p)
          end
	    DKPmon:Print(msg)
	    else
	      local p, c
	      for p, c in pairs(tab.dkp) do
	       DKPmon.PointsDB:SpendPoints(wininfo.bidchar, tonumber(p), c)
	       DKPmon.Comm:SendToBidder("M", string.format(L["You have been charged %g %s GP for %s."], c, cInfo.poolnames[p], tab.item.link), tab.winner)
	      end
	    end
      end
   end
end

--[[
GetAwardFrame()
Description:
  Build, if required,  and return the subframe that will be attached to the points awarding frame to handle
  points awarding for this DKP system
Input:
  None
Returns:
  A frame
]]
function EPGP.prototype:GetAwardFrame()
   if self.awardframe then return self.awardframe end
   local f = CreateFrame("Frame", "DKPmonEPGPAwardFrame", nil)
   --   f:SetFrameLevel(6)
   f:SetWidth(200)
   f:SetHeight(100)
   self.awardframe = f

   DKPmon.FrameSkinner:BackdropFrame(f, {0, 0, 0, 0.7}, {0.7, 0.7, 0.7, 0.9} )

   DKPmon.FrameSkinner:Skin(f)

   local b = CreateFrame("Button", "DKPmonEPGPAwardFrameActionButton", f, "UIPanelButtonTemplate")
   f.selectbutton = b
   b:SetWidth(175); b:SetHeight(22)
   b:SetFrameLevel(6)
   b:SetText(L["Set points to award"])
   b:ClearAllPoints()
   b:SetPoint("TOP", f, "TOP", 0, -10)
   local epgp = self
   b:SetScript("OnClick", function() epgp:OnAwardButtonClick() end)
   b:Show()

   b = CreateFrame("Button", "DKPmonFDKPAwardFrameActionButton", f, "UIPanelButtonTemplate")
   f.selectPeriodicDkpButton = b
   b:SetWidth(175); b:SetHeight(22)
   b:SetFrameLevel(6)
   b:SetText(L["Select periodic EP"])
   b:ClearAllPoints()
   b:SetPoint("TOPLEFT", f.selectbutton, "BOTTOMLEFT", 0, 0)
   b:SetScript("OnClick", function() self:OnSelectPeriodicDkpButtonClick() end)
   b:Show()

   local str = f:CreateFontString("DKPMon_AwardFrame_PeriodicDkpString","OVERLAY","GameFontNormal")
   str:SetText(L['Periodic EP Inactive.'])
   f.nextPeriodicDkpString = str
   str:SetPoint("TOP", f.selectPeriodicDkpButton, "BOTTOM", 0, -4)
   str:Show()
   f:SetScript("OnShow",function() self:OnAwardFrameShow() end)
   f:SetScript("OnHide",function() self:OnAwardFrameHide() end)

   b = CreateFrame("Button", "DKPmonEPGPAwardFrameDecayButton", f, "UIPanelButtonTemplate")
   f.decaybutton = b
   b:SetWidth(175); b:SetHeight(22)
   b:SetFrameLevel(6)
   b:SetText(L["Decay the EPGP database"])
   b:ClearAllPoints()
   b:SetPoint("TOP", f.nextPeriodicDkpString, "BOTTOM", 0, 0)
   local epgp = self
   b:SetScript("OnClick", function() epgp:OnDecayButtonClick() end)
   b:Show()

   self.customaward = { pool = 1, amount = 0 }
   self.customdecay = { pool = 1, percent = 0 }
   return self.awardframe
end


--[[
OnAwardButtonClick
Description:
  Called when the user clicks on the button on our frame in the awarding points window
Input:
  None
Returns:
  None
]]
function EPGP.prototype:OnAwardButtonClick()
   if self.awardactionmenu == nil then
      local cInfo = DKPmon.CustomInfo:Get("EPGP")
      local epgp = self
      local dewtab = { type = 'group', args = {} }
      -- Add in the menu for specifying a custom number of points to award
      local custab = { type = 'group', name = L['Specify custom amount'], desc = L['Specify a custom number of points to award to everyone'], args = {}, order = 3 }
      custab.args.appendcurr = {
	 type = 'execute', name = L['Append custom'], desc = L['Append the currently specified custom amount to the list of points to be awarded.'],
	 func = function()
		   if epgp.customaward.amount == 0 then return end
		   DKPmon.Awarding:AppendPointAward({ pool = epgp.customaward.pool, amount = epgp.customaward.amount, source = "Custom" })
        end,
	 order = 2
      }
      custab.args.pool = {
	 type = 'text', name = L['Select pool'], desc = L['Select the pool to award EP to'],
	 get = function()
		  return "p"..epgp.customaward.pool
	       end,
	 set = function(v)
		  epgp.customaward.pool = tonumber(string.sub(v, 2))
	       end,
	 validate = {},
	 order = 3
      }
      local i, pname
      for i, pname in pairs(cInfo.poolnames) do
	 custab.args.pool.validate["p"..i] = pname
      end
      custab.args.amount = {
	 type = 'text', name = L['Specify points'], usage = "<number>", desc = L["Specify the number of EP to award. This can be negative."],
	 get = function()
		  return string.format("%g", epgp.customaward.amount)
	       end,
	 set = function(v)
		  epgp.customaward.amount = tonumber(v)
	       end,
	 validate = function(v)
		       return tonumber(v) ~= nil
		    end,
	 input = false,
	 order = 4
      }
      dewtab.args.custom = custab

      self.awardactionmenu = dewtab
   end
   dewdrop:Open(self.awardframe.selectbutton, 'children', self.awardactionmenu, 'point', "TOP", 'relativepoint', "TOP")
end

StaticPopupDialogs["DKPMON_EPGP_CONFIRM_DECAY"] = {
   text = "", -- will be assigned by creater
   button1 = L["Yes"],
   button2 = L["No"],
   OnAccept = nil, -- will be assigned by creater
   OnCancel = function() end,
   sound = "levelup2",
   timeout = 10,
   whiledead = 1,
   hideOnEscape = 1
}

--[[
OnDecayButtonClick
Description:
  Called when the user clicks on the Decay EP & GP Button in the award window.
Input:
  None
Returns:
  None
]]
function EPGP.prototype:OnDecayButtonClick()
   if self.decayactionmenu == nil then

      local mydb  = DKPmon.DKP:GetDB("EPGP")
      local cInfo = DKPmon.CustomInfo:Get("EPGP")
      local epgp = self
      local dewtab = { type = 'group', args = {} }

    -- Add in a menu to handle decay
      local decaytab = { type = 'group', name = L['Decay EPGP'], desc = L['Remove a specified percentage of both EP & GP'], args = {}, order = 3 }

    decaytab.args.appendcurr = {
	 type = 'execute', name = L['Execute Decay'], desc = L['Confirm EPGP Decay for specified players and pools'],
	 func = function()
     	StaticPopupDialogs["DKPMON_EPGP_CONFIRM_DECAY"].text =
		    string.format(L["Do you really want to decay the database?"])
		StaticPopupDialogs["DKPMON_EPGP_CONFIRM_DECAY"].OnAccept =
		    function()
		       local roster = DKPmon.PointsDB:GetTable()
                if epgp.customdecay.percent == 0 or roster == nil then return end
                for name,dbtab in pairs(roster) do
                    local ep = DKPmon.PointsDB:GetEarned(name, epgp.customdecay.pool)
                    local gp = max(1,DKPmon.PointsDB:GetSpent(name, epgp.customdecay.pool))
                    -- DKPmon:Print("DEBUG: " .. name .. " has " .. ep .. " EP and " .. gp .. " GP")
                    ep = ep * (1 - epgp.customdecay.percent/100)
                    gp = gp * (1 - epgp.customdecay.percent/100)
                    -- DKPmon:Print("Attempting to set " .. name .. " to " .. ep .. " EP and " .. gp .. " GP")
                    DKPmon.PointsDB:SetPoints( dbtab.info , epgp.customdecay.pool, ep, gp)
                end
		    end
		StaticPopup_Show("DKPMON_EPGP_CONFIRM_DECAY")
        end,
	 order = 2
      }

    decaytab.args.pool = {
	 type = 'text', name = L['Select pool'], desc = L['Select the pool to decay'],
	 get = function()
		  return "p"..epgp.customdecay.pool
	    end,
	 set = function(v)
		  epgp.customdecay.pool = tonumber(string.sub(v, 2))
	    end,
	 validate = {},
	 order = 3
      }

      local i, pname
      for i, pname in pairs(cInfo.poolnames) do
	 decaytab.args.pool.validate["p"..i] = pname
      end
      decaytab.args.amount = {
	 type = 'text', name = L['Specify percent'], usage = "<number>", desc = L["Specify the percent of EP & GP to remove."],
	 get = function()
		  return string.format("%g", epgp.customdecay.percent)
	       end,
	 set = function(v)
		  epgp.customdecay.percent = tonumber(v)
	       end,
	 validate = function(v)
		       return tonumber(v) ~= nil
		    end,
	 input = false,
	 order = 4
      }
      dewtab.args.custom2 = decaytab

      self.decayactionmenu = dewtab
   end
   dewdrop:Open(self.awardframe.decaybutton, 'children', self.decayactionmenu, 'point', "TOP", 'relativepoint', "TOP")
end

--[[
OnSelectPeriodicDkpButtonClick
Description:
  Called when "Select Periodic EP" button is clicked
Input:
  None
Returns:
  None
]]
function EPGP.prototype:OnSelectPeriodicDkpButtonClick()
	if self.selectPeriodicDkpActionMenu == nil then
		local cInfo = DKPmon.CustomInfo:Get("EPGP")
		--Construct Validate table

		local validateTab = {}
		validateTab["p0"] = L["No periodic EP"]
		local i = 1

		for i,pdTab in ipairs(cInfo.periodicDkp) do
			validateTab["p"..i] = string.format(L["%d EP every %d minutes"], pdTab.amount, pdTab.interval)
			i = i + 1
		end

		local dewtab = {type = 'text', name=L['Periodic EP'], desc=L['Select the periodic EP to use'],
			usage = '<number>',
			get = function() return "p"..self.periodicDkpIndex end,
			set = function(v) self:SelectPeriodicDkp(tonumber(string.sub(v,2))) end,
			validate = validateTab,
			order = 1
			}

		self.selectPeriodicDkpActionMenu = dewtab

	end

   dewdrop:Open(self.awardframe.selectPeriodicDkpButton, 'children', self.selectPeriodicDkpActionMenu, 'point', "TOP", 'relativepoint', "TOP")
end

--[[
SelectPeriodDkp
Description:
    Switch to a particular index's periodic EP schedule, registers events to award points when the timer expires
Input:
  Index -- Integer; a valid periodic EP award index from custom.lua/example.lua
Returns:
  None
   ]]
function EPGP.prototype:SelectPeriodicDkp(index)
	self.periodicDkpIndex = index
	--Unregister event
	if self.periodicEventId ~= nil and self:IsEventScheduled(self.periodicEventId) then
			self:CancelScheduledEvent(self.periodicEventId)
			DKPmon:Print(L["Current Periodic EP event cancelled."])
			self.periodicEventId = nil
	end

	if index == 0 then
		return
	else
		local cInfo = DKPmon.CustomInfo:Get("EPGP")
		local pdkp = cInfo.periodicDkp[index]
		if pdkp == nil then
			DKPmon:Print("ERROR: Invalid periodicDKP index!: "..index)
			return
		end
		--Register event
		self.periodicEventId = "DKPmon_EPGP-" .. math.random()
        self:ScheduleRepeatingEvent(self.periodicEventId,self.OnPeriodicInterval,pdkp.interval*60,self)
		DKPmon:Print(string.format(L["%s: %d EP will be awarded every %.2f minutes."],pdkp.name,pdkp.amount, pdkp.interval))
		--Starts the timer
		if self.awardframe:IsVisible() then self:OnAwardFrameShow() end

	end
end


--[[
OnPeriodicInterval
Description:
  Called every period to add predefined EP to be awarded.
Input:
  None
Returns:
  None
]]
function EPGP.prototype:OnPeriodicInterval()
	local cInfo = DKPmon.CustomInfo:Get("EPGP")
	local pdkp = cInfo.periodicDkp[self.periodicDkpIndex]
	if pdkp == nil then
		DKPmon:Print("ERROR:  Couldn't get periodic dkp table, this should never happen!")
		self:SelectPeriodicDkp(0)
		return
	end

	local mydb = DKPmon.DKP:GetDB("EPGP")
	DKPmon.Awarding:AppendPointAward({pool=mydb.selectedPool, amount=pdkp.amount,source=pdkp.name})
end

--[[
OnAwardFrameShow
Description:
  Run when award frame is shown to update timer text and schedule continued updating
Input:
  None
Returns:
  None
]]
function EPGP.prototype:OnAwardFrameShow()
	self:UpdateTimerText()
	--Already updating text
	if self.textUpdateEventId ~= nil then
		if self.periodicEventId == nil then
			self:CancelScheduledEvent(self.textUpdateEventId)
		end
		return
	end

	if self.periodicEventId ~= nil then
		self.textUpdateEventId = self:ScheduleRepeatingEvent(self.UpdateTimerText,1,self)
	end
end

--[[
OnAwardFrameHide
Description:
  Run when award frame is hidden to cancel timer text updates
Input:
  None
Returns:
  None
]]
function EPGP.prototype:OnAwardFrameHide()
	--Remind if pending points
	if self.textUpdateEventId ~= nil then
		self:CancelScheduledEvent(self.textUpdateEventId)
		self.textUpdateEventId = nil
	end
end


--[[
UpdateTimerText
Description:
  Update the timer text, scheduled when Award Frame is showing
Input:
  None
Returns:
  None
]]
function EPGP.prototype:UpdateTimerText()
	local isScheduled, timeLeft
	if self.periodicEventId ~= nil then
		isScheduled, timeLeft = self:IsEventScheduled(self.periodicEventId)
	end
	if not isScheduled then
		self.awardframe.nextPeriodicDkpString:SetText(L['Periodic EP Inactive.'])
		--Will unregister for us
		self:OnAwardFrameHide()
		return
	end
	self.awardframe.nextPeriodicDkpString:SetText(string.format(L['Next Periodic EP: %s'],self:SecondsToClock(timeLeft)))
end

--[[
SecondsToClock
Description:
  Convert nSeconds to HH:MM:SS format
Input:
  nSeconds -- float; a number of elapsed seconds
Returns:
  String -- nSeconds converted to "HH:MM:SS"
]]
function EPGP.prototype:SecondsToClock(nSeconds)
	nHours = string.format("%02.f", math.floor(nSeconds/3600));
	nMins = string.format("%02.f", math.floor(nSeconds/60 - (nHours*60)));
	nSecs = string.format("%02.f", math.floor(nSeconds - nHours*3600 - nMins *60));
	return nHours..":"..nMins..":"..nSecs
end

--[[
OnPurgePointsList
Description:
  Called from the points awarding routines when the user purges the points list. No special action needed for EPGP.
Input:
  None
Returns:
  None
]]
function EPGP.prototype:OnPurgePointsList()
--[[  ]]
end

--[[
PointsAwarded
Description:
  Called from the points awarding routines _after_ all the points in its list have been awarded. No special action needed for EPGP.
Input:
  None
Returns:
  None
]]
function EPGP.prototype:PointsAwarded()
--[[  ]]
end

--[[
GetFubarOptionsMenu
Description:
  Return the options menu for this DKP system to be added to the fubar. This must be a valid Ace Options table, or nil
Input:
  None
Returns:
  nil or an Ace Options table
]]
function EPGP.prototype:GetFubarOptionsMenu()
   if self.fubarmenu then return self.fubarmenu end
   local mydb = DKPmon.DKP:GetDB("EPGP")
   local tab = {
      type = 'group',
      name = L['EPGP options'],
      desc = L['Options for the Effort Points/Gear Points DKP system'],
      args = {
	 qualitythreshold = {
	    type = 'text',
	    name = L['Item quality threshold'],
	    desc = L['Set the threshold on item quality to automatically include in the item list for bidding on.'],
	    usage = '<number>',
	    get = function() return "p"..mydb.qualthreshold end,
	    set = function(v) mydb.qualthreshold = tonumber(string.sub(v,2)) end,
	    validate = {
	       ["p0"] = string.format(L["|cff%sPoor|r"], DKPmon:rgbToHex(ITEM_QUALITY_COLORS[0])),
	       ["p1"] = string.format(L["|cff%sCommon|r"], DKPmon:rgbToHex(ITEM_QUALITY_COLORS[1])),
	       ["p2"] = string.format(L["|cff%sUncommon|r"], DKPmon:rgbToHex(ITEM_QUALITY_COLORS[2])),
	       ["p3"] = string.format(L["|cff%sRare|r"], DKPmon:rgbToHex(ITEM_QUALITY_COLORS[3])),
	       ["p4"] = string.format(L["|cff%sEpic|r"], DKPmon:rgbToHex(ITEM_QUALITY_COLORS[4])),
	       ["p5"] = string.format(L["|cff%sLegendary|r"], DKPmon:rgbToHex(ITEM_QUALITY_COLORS[5])),
	       ["p6"] = string.format(L["|cff%sArtifact|r"], DKPmon:rgbToHex(ITEM_QUALITY_COLORS[6])),
	    },
	    order = 2
	 },
	 allowitemadding = {
	    type = 'toggle',
	    name = L['Item adding'],
	    desc = L['Enable adding of items to SavedVariables database.'],
	    get = function()
		     return mydb.allowitemadding
		  end,
	    set = function(v)
		     mydb.allowitemadding = v
		  end,
	    order = 1
	 },
     -- Begin code edits by David Pate 
     allowautocosts = {
     type = 'toggle',
     name = "Automatic Item Cost",
     desc = "Automatically present the EPGP calculated value of an item when assigning the costs",
     get = function()
            return mydb.allowautocosts
            end,
    set = function(v)
            mydb.allowautocosts = v
            end,
    order = 4
    --End code edits by David Pate
     },     
	limit = {
		type = "range",
		name = L["Greed factor"],
		desc = L["The GP cost for an item won on Need is multiplied by this factor to determine the cost of the same item on a Greed bid"],
		get = function()
                return mydb.greedFactor
            end,
		set = function(v)
                mydb.greedFactor = v
            end,
		min = 0,
		max = 1,
		step = .01,
        isPercent = true,
		order = 3,
	}
      }
   }
   self.fubarmenu = tab
   return tab
end

-- Last, but not least, create a EPGP object and register it to DKPmon as a DKP system
local EPGPObj = EPGP:new()
DKPmon.DKP:Register(EPGPObj, "EPGP", L["Effort Points/Gear Points"])