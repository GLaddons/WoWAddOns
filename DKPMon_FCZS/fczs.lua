--[[
    Copyright Daniel D. Neilson, 2006

    This file is part of DKPmon_FCZS.

    DKPmon_FCZS is free software; you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published by
    the Free Software Foundation; either version 2 of the License, or
    (at your option) any later version.

    DKPmon_FCZS is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.

    You should have received a copy of the GNU General Public License
    along with DKPmon_FCZS; if not, write to the Free Software
    Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
]]

--[[
      -- Every item is a fixed point cost, as dictated by a database of items.
      -- Points are awarded using zero-sum
      -- Supports an arbitrary number of "point pools"
]]

--[[
dkpinfo table contents for this DKP system:
]]

-- Check if DKPmon is installed before doing anything.
--if DKPmon == nil then return end

local AceOO = AceLibrary("AceOO-2.0")
local L = AceLibrary("AceLocale-2.2"):new("DKPmon_FCZS")

local FCZS = AceOO.Class(DKPmon_DKP_BaseClass)

local dewdrop = AceLibrary("Dewdrop-2.0")

--[[
Initialize
Description:
  Initialize the DKP system. Effectively called from within the OnEnable() function of DKPmon
Input:
  None
Returns:
  None
]]
function FCZS.prototype:Initialize()
   local mydb = DKPmon.DKP:GetDB("FCZS")
   if mydb.qualthreshold == nil then
      mydb.qualthreshold = 4
   end
   if mydb.allowitemadding == nil then
      mydb.allowitemadding = true
   end
   if mydb.usedummies == nil then
      mydb.usedummies = false
   end
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
function FCZS.prototype:GetItemInfo(iteminfo)
   local mydb = DKPmon.DKP:GetDB("FCZS")
   if iteminfo.quality < mydb.qualthreshold then return nil,nil end -- TODO: Quality threshold through the AceDB
   
   local cInfo = DKPmon.CustomInfo:Get("FCZS")
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
function FCZS.prototype:FillTooltip(dkpinfo)
   GameTooltip:AddLine(" ")
   GameTooltip:AddDoubleLine(string.format(L["DKP = %g"], dkpinfo.cost), string.format("%s(#%d)",  dkpinfo.poolName, dkpinfo.poolIndex), 
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
function FCZS.prototype:AddDistributionActionOptions(dewOptions, bidstate)
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
function FCZS.prototype:BuildWinnerSelectList(itembutton, dewOptions, dkpinfo, bidders)
   local i, nametab
   for i, nametab in ipairs(bidders) do
      local bidderinfo = DKPmon.RaidRoster:GetPlayerInfo(nametab.name) -- information about the player who placed this bid
      if bidderinfo == nil then
	 DKPmon:Print(string.format(L["Error -- player %s has bid on this item but has never been in the raid! Not listing them."], nametab.name))
      else
	 local playerpnts = self:GetPlayerPoints(bidderinfo.bidchar.name, dkpinfo.poolIndex)
	 local namestr
	 if nametab.name == bidderinfo.bidchar.name then
	    namestr = string.format("|cff%s%s|r(%g)", bidderinfo.char.classhex, nametab.name, playerpnts)
	 else
	    namestr = string.format("|cff%s%s|r[|cff%s%s|r](%g)", bidderinfo.char.classhex, nametab.name, bidderinfo.bidchar.classhex, bidderinfo.bidchar.name, playerpnts)
	 end
	 dewOptions.args[string.format("%d", i)] = { 
	    type = 'execute', name = namestr, order = 35000 - playerpnts, 
	    desc = string.format(L["Select %s to win the item"], nametab.name),
	    func = function() itembutton.bidinfo.winner = nametab.name; itembutton:UpdateStatusText(); end
	 }
      end
   end
end


StaticPopupDialogs["DKPMON_FCZS_CONFIRM_SETITEMVALUE"] = {
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
function FCZS.prototype:BuildItemActionMenu(itembutton, dewOptions, iteminfo)
   if DKPmon.Looting:GetBidState() == 0 then -- Building item list
      if iteminfo.allowed then return false end
      if self.potentialitemvalues == nil then self.potentialitemvalues = {} end
      if self.potentialitemvalues[iteminfo.name] == nil then
	 self.potentialitemvalues[iteminfo.name] = {
	    value = 0, pool = 1
	 }
      end
      local cInfo = DKPmon.CustomInfo:Get("FCZS")
      local mydb = DKPmon.DKP:GetDB("FCZS")
      dewOptions.args.fczs = {
	 type = 'group',
	 name = L['Specify item value'],
	 desc = L['Specify the value of this item'],
	 args = {
	    assign = {
	       type = 'execute', name = L['Assign value'], desc = L['Assign this value to this item'],
	       func = function()
			 if self.potentialitemvalues[iteminfo.name] == 0 then DKPmon:Print(L["Cannot assign a value of zero"]); return end
			 StaticPopupDialogs["DKPMON_FCZS_CONFIRM_SETITEMVALUE"].text = 
			    string.format(L["Make %s worth %g points from pool %s?"], 
					  iteminfo.link, self.potentialitemvalues[iteminfo.name].value, cInfo.poolnames[self.potentialitemvalues[iteminfo.name].pool])
			 StaticPopupDialogs["DKPMON_FCZS_CONFIRM_SETITEMVALUE"].OnAccept = 
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
			 StaticPopup_Show("DKPMON_FCZS_CONFIRM_SETITEMVALUE")
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
	       type = 'text', name = L['Set value'], desc = L['Set the number of points this item is worth'],
	       usage = '<value>',
	       get = function() return self.potentialitemvalues[iteminfo.name].value end,
	       set = function(v) self.potentialitemvalues[iteminfo.name].value = v end,
	       validate = function(v) local val = tonumber(v); if val == nil then return false end; return not (val < 0); end,
	       order = 3
	    }
	 }
      }
      -- Fill in the validate field of dewOptions.args.fczs.args.poolchoice
      local i, name
      for i, name in ipairs(cInfo.poolnames) do
	 dewOptions.args.fczs.args.poolchoice.validate["p"..i] = name
      end
      return true
   end

   if DKPmon.Looting:GetBidState() == 1 then -- If bidding's open
      dewOptions.args.fczs = {
	 type = 'text', name = L['Add/remove a bidder'], desc = L['Add, or remove, a player from the list of bidders for this item.'],
	 usage = '<name>', get = false,
	 validate = function(v)
		       -- Make sure the name's in the raid
		       local name = string.upper(string.sub(v,1,1))..string.lower(string.sub(v, 2))
		       return DKPmon.RaidRoster:IsPlayerInRaid(name)
		    end,
	 set = function(v)
		  local name = string.upper(string.sub(v,1,1))..string.lower(string.sub(v, 2))
		  DKPmon.Looting:ReceiveBid(name, { item = itembutton.id, dkp = nil })
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
function FCZS.prototype:ProcessQueryConsole(bidname)
   local cInfo = DKPmon.CustomInfo:Get("FCZS")
   local tab = DKPmon.PointsDB:GetTable(bidname)
   if tab == nil then
      return L["You have no points."]
   end
   local reply = L["Your points are:"]
   for p, _ in pairs(tab.points) do
      local pool = tonumber(p)
      reply = string.format("%s %s = %g;", reply, cInfo.poolnames[pool], self:GetPlayerPoints(bidname, pool))
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
function FCZS.prototype:GetNPools()
   return DKPmon.CustomInfo:Get("FCZS").numpools
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
function FCZS.prototype:GetPoolName(pool)
   return DKPmon.CustomInfo:Get("FCZS").poolnames[pool]
end

--[[
PlaceBid
Description:
  Place, or remove, a bid for the given person on this item.
Input:
  bidder -- String; in-game name of the person bidding (i.e. not their bidname)
  dkpinfo -- information sent along for the DKP system to update this bid.
  bidderlist -- table; the list of bidders for this item. Each entry = { name = <name of person bidding>, dkpinfo = <information about the bid> }
  nbidders -- number; number of elements in the bidderlist table
Returns:
  boolean 
    nil = bid rejected
    false = bid removed
    true = bid accepted
]]
function FCZS.prototype:PlaceBid(itembutton, bidder, dkpinfo, bidderlist, nbidders)
   -- For Points as Currency, bid placement is a toggle; which means dkpinfo is nil
   -- If they're not in the bidderlist, then they get added. If they are already in the list, they get removed.
   
   -- Search the biddinglist to see if this person's already bid on this item
   local i
   for i = 1, nbidders do
      if bidderlist[i].name == bidder then
	 -- Remove this element from the list
	 table.remove(bidderlist, i)
	 return false
      end
   end
   -- Person wasn't in the list, so add them
   table.insert(bidderlist, { name = bidder })
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
function FCZS.prototype:GetCost(winner, itemdkp, winnerdkp)
    if (itemdkp.override ~= nil) then
        return { [itemdkp.poolIndex] = itemdkp.override }
    else
        return { [itemdkp.poolIndex] = itemdkp.cost }
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
function FCZS.prototype:DeductPoints(itemwinners)
   local i, tab
   local cInfo = DKPmon.CustomInfo:Get("FCZS")
   local mydb = DKPmon.DKP:GetDB("FCZS")
   if mydb.pointswaiting == nil then mydb.pointswaiting = {} end
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
	       DKPmon.Comm:SendToBidder("M", string.format(L["You have been charged %g %s points for %s."], c, cInfo.poolnames[p], tab.item.link), tab.winner)
	    end
	 end
      end
      -- Add the value of the item to the list of points remaining to be awarded
      if (mydb.usedummies) or ((not mydb.usedummies) and tab.winner ~= L["Disenchant"] and tab.winner ~= L["Bank"]) then
	 if mydb.pointswaiting[tab.item.source] == nil then mydb.pointswaiting[tab.item.source] = { onlist = false } end
	 local p, c
	 for p, c in pairs(tab.dkp) do
	    if mydb.pointswaiting[tab.item.source][tonumber(p)] == nil then
	       mydb.pointswaiting[tab.item.source][tonumber(p)] = 0
	    end
	    mydb.pointswaiting[tab.item.source][tonumber(p)] = mydb.pointswaiting[tab.item.source][p] + tonumber(c)
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
function FCZS.prototype:GetAwardFrame()
   if self.awardframe then return self.awardframe end
   local f = CreateFrame("Frame", "DKPmonFCZSAwardFrame", nil)
   --   f:SetFrameLevel(6)
   f:SetWidth(200)
   f:SetHeight(45)
   self.awardframe = f
   
   DKPmon.FrameSkinner:BackdropFrame(f, {0, 0, 0, 0.7}, {0.7, 0.7, 0.7, 0.9} )
   
   DKPmon.FrameSkinner:Skin(f)
   
   local b = CreateFrame("Button", "DKPmonFCZSAwardFrameActionButton", f, "UIPanelButtonTemplate")
   f.selectbutton = b
   b:SetWidth(175); b:SetHeight(22)
   b:SetFrameLevel(6)
   b:SetText(L["Set points to award"])
   b:ClearAllPoints()
   b:SetPoint("TOP", f, "TOP", 0, -10)
   local fczs = self
   b:SetScript("OnClick", function() fczs:OnAwardButtonClick() end)
   b:Show()
   
   self.customaward = { pool = 1, amount = 0 }
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
function FCZS.prototype:OnAwardButtonClick()
   if self.awardactionmenu == nil then
      local cInfo = DKPmon.CustomInfo:Get("FCZS")
      local fczs = self
      local dewtab = { type = 'group', args = {} }
      -- Add in the menu for specifying a custom number of points to award
      local custab = { type = 'group', name = L['Specify custom amount'], desc = L['Specify a custom number of points to award to everyone'], args = {}, order = 3 }
      custab.args.appendcurr = {
	 type = 'execute', name = L['Append custom'], desc = L['Append the currently specified custom amount to the list of points to be awarded.'],
	 func = function()
		   if fczs.customaward.amount == 0 then return end
		   DKPmon.Awarding:AppendPointAward({ pool = fczs.customaward.pool, amount = fczs.customaward.amount, source = "Custom" })
		end,
	 order = 2
      }
      custab.args.pool = { 
	 type = 'text', name = L['Select pool'], desc = L['Select the pool to award points to'],
	 get = function()
		  return "p"..fczs.customaward.pool
	       end,
	 set = function(v)
		  fczs.customaward.pool = tonumber(string.sub(v, 2))
	       end,
	 validate = {},
	 order = 3
      }
      local i, pname
      for i, pname in pairs(cInfo.poolnames) do
	 custab.args.pool.validate["p"..i] = pname
      end
      custab.args.amount = {
	 type = 'text', name = L['Specify points'], usage = "<number>", desc = L["Specify the number of points to award. This can be negative."],
	 get = function()
		  return string.format("%g", fczs.customaward.amount)
	       end,
	 set = function(v)
		  fczs.customaward.amount = tonumber(v)
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
   -- Add in options for adding waiting points from item distribution
   local mydb = DKPmon.DKP:GetDB("FCZS")
   local itemtab = { type = 'group', name = L['Points outstanding'], desc = L["Award points still waiting to be awarded from item distribution"], args = {}, order = 1 }
   local source, stab
   local numselected = DKPmon.Awarding:GetNumSelected()
   if mydb.pointswaiting == nil then
      mydb.pointswaiting = {}
   end
   if numselected == 0 then
      DKPmon:Print(L["Must have more than 0 players selected to award points to before you can select any outstanding points to be awarded."])
   else
      local addeditems = false
      for source, stab in pairs(mydb.pointswaiting) do
	 local s, tb = source, stab
	 addeditems = true
	 itemtab.args[source] = { 
	    type = 'execute', name = source, desc = string.format(L["Award points for %s"], source), 
	    func = function()
		      local pool, amt
		      for pool, amt in pairs(tb) do
			 if tonumber(pool) ~= nil then
			    DKPmon.Awarding:AppendPointAward({pool = tonumber(pool), amount = amt/numselected, source = s})
			 end
		      end
		      tb.onlist = true
		   end,
	 }
      end
      if addeditems then
	 self.awardactionmenu.args.pointstoaward = itemtab
      end
   end
   dewdrop:Open(self.awardframe.selectbutton, 'children', self.awardactionmenu, 'point', "TOP", 'relativepoint', "TOP")
end

--[[
OnPurgePointsList 
Description:
  Called from the points awarding routines when the user purges the points list.
Input:
Returns:
]]
function FCZS.prototype:OnPurgePointsList()
   local source, stab
   local mydb = DKPmon.DKP:GetDB("FCZS")
   for source, stab in pairs(mydb.pointswaiting) do
      stab.onlist = false
   end
end

--[[
PointsAwarded
Description:
  Called from the points awarding routines _after_ all the points in its list have been awarded.
Input:
Returns:
]]
function FCZS.prototype:PointsAwarded()
   local source, stab
   local mydb = DKPmon.DKP:GetDB("FCZS")
   for source, stab in pairs(mydb.pointswaiting) do
      if stab.onlist then
	 mydb.pointswaiting[source] = nil
      end
      DKPmon:TableDelete(stab)
   end
end

--[[
GetFubarOptionsMenu
Description:
  Return the options menu for this DKP system to be added to the fubar. This must be a valid Ace Options table, or nil
Input:
Returns:
  nil or an Ace Options table
]]
function FCZS.prototype:GetFubarOptionsMenu()
   if self.fubarmenu then return self.fubarmenu end
   local mydb = DKPmon.DKP:GetDB("FCZS")
   local tab = {
      type = 'group',
      name = 'Fixed cost zero-sum options',
      desc = 'Options for the fixed cost zero-sum DKP System',
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
	 usedummies = {
	    type = 'toggle',
	    name = L['Award DE/Bank points.'],
	    desc = L['Enable this to include item points from disenchanted and banked items in the zero-sum calculations.'],
	    get = function()
		     return mydb.usedummies
		  end,
	    set = function(v)
		     mydb.usedummies = v
		  end,
	    order = 3
	 }
      }
   }
   self.fubarmenu = tab
   return tab
end

-- Last, but not least, create a FCZS object and register it to DKPmon as a DKP system
local FCZSObj = FCZS:new()
DKPmon.DKP:Register(FCZSObj, "FCZS", L["Fixed cost zero-sum"])
