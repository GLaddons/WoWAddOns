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

local L = AceLibrary("AceLocale-2.2"):new("DKPmon_FCZS")

local translations = {
   ["Item %s is assigned to an undefined pool."] = true,
   ["Unknown"] = true,
   ["DKP = %g"] = true,
   ["Error -- player %s has bid on this item but has never been in the raid! Not listing them."] = true,
   ["Select %s to win the item"] = true,
   ["Yes"] = true,
   ["No"] = true,
   ['Specify item value'] = true,
   ['Specify the value of this item'] = true,
   ['Assign value'] = true, 
   ['Assign this value to this item'] = true,
   ["Cannot assign a value of zero"] = true,
   ["Make %s worth %g points from pool %s?"] = true,
   ['Choose pool'] = true, 
   ['Choose which point pool this item is in'] = true,
   ['Set value'] = true, 
   ['Set the number of points this item is worth'] = true,
   ['Add/remove a bidder'] = true,
   ['Add, or remove, a player from the list of bidders for this item.'] = true,
   ["You have no points."] = true,
   ["Your points are:"] = true,
   ["Disenchant"] = true, -- Disenchant & Bank must be translated IDENTICALLY as they're reserved names
   ["Bank"] = true,
   ["Error -- %s has never been in the raid! I cannot deduct points because I don't know enough about them. Please make note of the following deductions and do them manually:"] = true,
   ["%s\n%g from pool %d"] = true,
   ["You have been charged %g %s points for %s."] = true,
   ["Set points to award"] = true,
   ['Specify custom amount'] = true,
   ['Specify a custom number of points to award to everyone'] = true,
   ['Append custom'] = true, 
   ['Append the currently specified custom amount to the list of points to be awarded.'] = true,
   ['Select pool'] = true, 
   ['Select the pool to award points to'] = true,
   ['Specify points'] = true,
   ["Specify the number of points to award. This can be negative."] = true,
   ['Points outstanding'] = true,
   ["Award points still waiting to be awarded from item distribution"] = true,
   ["Must have more than 0 players selected to award points to before you can select any outstanding points to be awarded."] = true,
   ["Award points for %s"] = true,

   ['Fixed cost zero-sum options'] = true,
   ['Options for the fixed cost zero-sum DKP System'] = true,
   ['Item quality threshold'] = true,
   ['Set the threshold on item quality to automatically include in the item list for bidding on.'] = true,
   ["|cff%sPoor|r"] = true,
   ["|cff%sCommon|r"] = true,
   ["|cff%sUncommon|r"] = true,
   ["|cff%sRare|r"] = true,
   ["|cff%sEpic|r"] = true,
   ["|cff%sLegendary|r"] = true,
   ["|cff%sArtifact|r"] = true,
   ['Item adding'] = true,
   ['Enable adding of items to SavedVariables database.'] = true,
   ['Award DE/Bank points.'] = true,
   ['Enable this to include item points from disenchanted and banked items in the zero-sum calculations.'] = true,
   ["Fixed cost zero-sum"] = true,
}

L:RegisterTranslations("enUS",
		       function() return translations end)