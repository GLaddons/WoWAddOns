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
   The "base class" for all DKP systems
]]

local AceOO = AceLibrary("AceOO-2.0")

DKPmon_DKP_Interface = AceOO.Interface ( { Initialize = "function",
					   GetItemInfo = "function", 
                                           FillTooltip = "function", 
                                           AddDistributionActionOptions = "function",
                                           BuildWinnerSelectList = "function",
                                           BuildItemActionMenu = "function",
                                           ProcessQueryConsole = "function",
                                           GetNPools = "function",
                                           GetPoolName = "function",
					   GetPlayerPoints = "function",
					   SetPlayerPoints = "function",
                                           PlaceBid = "function",
                                           GetCost = "function",
					   OnCloseBidding = "function",
					   OnWinnerAnnounce = "function",
                                           DeductPoints = "function",
                                           GetAwardFrame = "function",
					   OnPurgePointsList = "function",
                                           PointsAwarded = "function",
					   GetFubarOptionsMenu = "function" } )

DKPmon_DKP_BaseClass = AceOO.Class(DKPmon_DKP_Interface)

--  Function prototypes

--[[
Initialize
Description:
  Initialize the DKP system. Effectively called from within the OnEnable() function of DKPmon
Input:
  None
Returns:
  None
]]

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
     
--[[
FillTooltip()
Description:
  Called when an item in the Looting Window is moused over to add the DKP-system specific information to the GameTooltip for the moused over item
Input:
  dkpinfo -- table; same table returned from self:GetItemInfo()
Returns:
  Nothing
]]

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

--[[
ProcessQueryConsole(bidname, bidclass)
Description:
  Build, and return, a message string to send regarding the point totals of the given bidname
Input:
  bidname -- name to look up the points for
Returns:
  String -- message to be displayed to the person who did the query
]]

--[[
GetNPools
Description:
  Return the number of point pools being used by the DKP system
Input:
  None
Returns:
  Number.
]]

--[[
GetPoolName
Description:
  Find out what the given pool number is called
Input:
  pool -- number in the range [1, GetNPools()]
Returns:
  string -- name by which to refer to the pool
]]

--[[
GetPlayerPoints
Description:
  Return the number of points the given player has in the given pool
Input:
  name -- string; Name of the player to look up
  pool -- number; index of the pool. Must be in the range [1,GetNPools()]
Output:
  number -- the number of points the player has.
]]
function DKPmon_DKP_BaseClass.prototype:GetPlayerPoints(name, pool)
   return DKPmon.PointsDB:GetPlayerPoints(name, pool)
end

--[[
SetPlayerPoints
Description:
  Set the number of points the given player has in the given pool to the amount given.
Input:
  charInfo -- CharInfo struct for the player to award points to
  pool -- number; index of the pool. Must be in the range [1,GetNPools()]
  points -- number; number of points to set the player's points to. Can be negative.
Output:
  none
]]
function DKPmon_DKP_BaseClass.prototype:SetPlayerPoints(charInfo, pool, points)
   if points < 0 then
      DKPmon.PointsDB:SetPoints(charInfo, pool, 0, -points)
   else
      DKPmon.PointsDB:SetPoints(charInfo, pool, points, 0)
   end
end

--[[
PlaceBid
Description:
  Place, or remove, a bid for the given person on this item.
Input:
  itembutton -- the itembutton for the item that's being bid on
  bidder -- String; in-game name of the person bidding (i.e. not their bidname)
  dkpinfo -- information sent along for the DKP system to update this bid.
  bidderlist -- table; the list of bidders for this item. Each entry = { name = <name of person bidding>, dkpinfo = <information about the bid> }
  nbidders -- number; number of elements in the bidderlist table
Returns:
  boolean -- nil = bid rejected
    false = bid removed
    true = bid accepted
]]

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

--[[
DeductPoints(itemwinners)
Description:
  Deduct the points for won items.
Input:
  itemwinners -- ItemWinners struct
Returns:
  None
]]

--[[
OnCloseBidding
Description:
  Called by the LootFrame when the close bidding time expires; signalling the close of bidding.
Input:
  None
Returns:
  None
]]
function DKPmon_DKP_BaseClass.prototype:OnCloseBidding()
end

--[[
OnWinnerAnnounce
Description:
  Called by the LootFrame just after an item winner is printed to raid chat.
Input:
  index -- number; index of the item announced
  link -- string; itemlink of the item announced
  winner -- string; name of the character who won the item
Returns:
  None
]]
function DKPmon_DKP_BaseClass.prototype:OnWinnerAnnounce(index, link, winner)
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

--[[
OnPurgePointsList 
Description:
  Called from the points awarding routines when the user purges the points list.
Input:
Returns:
]]

--[[
PointsAwarded
Description:
  Called from the points awarding routines _after_ all the points in its list have been awarded.
Input:
Returns:
]]

--[[
GetFubarOptionsMenu
Description:
  Return the options menu for this DKP system to be added to the fubar. This must be a valid Ace Options table, or nil
Input:
Returns:
  nil or an Ace Options table
]]

