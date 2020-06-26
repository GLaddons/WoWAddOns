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

-- CHECK FOR EXISTING CUSTOMINFO --
if DKPmon.CustomInfo.db["FCZS"] ~= nil then
   --Already registered, don't register example settings
   return
end
DKPmon:Print("DKPmon_FCZS is using the example.lua file, you should create your own settings in custom.lua")
-- REMOVE ABOVE SECTION IN YOUR CUSTOM.LUA FILE --

--[[
   Example custom information table for the "Zero-sum" DKP system.
]]

local custom = {}
DKPmon.CustomInfo:Register(custom, "FCZS")

-- Must be indexed sequentially by number beginning with 1
custom.poolnames = {
   [1] = "MC/Ony",
   [2] = "BWL",
}
custom.numpools = #custom.poolnames -- How many point pools are defined in poolnames

--[[

User-specific item point values.

   - This is just a _giant_ table, indexed by the item's in-game name.
   - Each entry is a table with fields:
     - value : The point cost of the item
     - pool  : The pool from which to deduct points for the item

ex:
  ["Arcanist Belt "]={value=75,pool=1},
  -- This says that the "Arcanist Belt" is worth 75 pool 1 points.
]]
custom.itemvalues = {
}

--[[
 Example table:
custom.itemvalues = {
   ["Aged Core Leather Gloves"]={value=76,pool=1},
   ["Ancient Cornerstone Grimoire"]={value=300,pool=1},
   ["Ancient Petrified Leaf"]={value=400,pool=1},
   ["Arcanist Belt "]={value=75,pool=1},
   ["Arcanist Bindings"]={value=75,pool=1},
   ["Arcanist Boots"]={value=175,pool=1},
}
]]
