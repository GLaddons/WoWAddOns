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


local L = AceLibrary("AceLocale-2.2"):new("DKPmon_EPGP")

local translations = {
   ["Item %s is assigned to an undefined pool."] = true,
   ["Unknown"] = true,
   ["GP = %g"] = true,
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
   ['Set the number of points this item is worth - Use Assign Value to store the value'] = true,
   ['Add/remove a bidder'] = true,
   ['Add, or remove, a player from the list of bidders for this item.'] = true,
   ["You have no points."] = true,
   ["Your EP, GP and priority are:"] = true,
   ["Disenchant"] = true, -- Disenchant & Bank must be translated IDENTICALLY as they're reserved names
   ["Bank"] = true,
   ["Error -- %s has never been in the raid! I cannot deduct points because I don't know enough about them. Please make note of the following deductions and do them manually:"] = true,
   ["%s\n%g from pool %d"] = true,
   ["You have been charged %g %s GP for %s."] = true,
   ["Set points to award"] = true,
   ["Decay EP & GP"] = true,
   ['Specify custom amount'] = true,
   ['Specify a custom number of points to award to everyone'] = true,
   ['Append custom'] = true, 
   ['Append the currently specified custom amount to the list of points to be awarded.'] = true,
   ['Select pool'] = true, 
   ['Select the pool to award EP to'] = true,
   ['Specify points'] = true,
   ["Specify the number of EP to award. This can be negative."] = true,
   
   ["Greed"] = true,
   ["Need"] = true,
   
   ['Next Periodic EP: %s'] = true,
   ["Current Periodic EP event cancelled."] = true,
   ["%s: %d EP will be awarded every %.2f minutes."] = true,
   ["Decay the EPGP database"] = true,
   ['Decay EPGP'] = true,
   ['Remove a specified percentage of both EP & GP'] = true,
   ['Execute Decay'] = true,
   ['Confirm EPGP Decay for specified players and pools'] = true,
   ['Select the pool to decay'] = true,
   ["Specify the percent of EP & GP to remove."] = true,
   ['Specify percent'] = true,
   
   ['Periodic EP Inactive.'] = true,
   ["Select periodic EP"] = true,
   
   ["%d EP every %d minutes"] = true,
   ['Periodic EP'] = true,
   ["No periodic EP"] = true,
   ['Select the periodic EP to use'] = true,
      
   ['EPGP options'] = true,
   ['Options for the Effort Points/Gear Points DKP system'] = true,
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
   ["Effort Points/Gear Points"] = true,
   
   ["Greed factor"] = true,
   ["The GP cost for an item won on Need is multiplied by this factor to determine the cost of the same item on a Greed bid"] = true,
   ["Do you really want to decay the database?"] = true,
   ["Set Formula Value"] = true,
   ["Set Custom value"] = true,
   ["Set the number of points this item is worth to the EPGP formula value - Use Assign Value to store the value"] = true,
}

L:RegisterTranslations("enUS",
		       function() return translations end)