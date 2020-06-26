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
   Example custom information table for the "Fixed DKP" DKP system.
   Note: This same table is also used by the "Fixed cost Zero-sum" DKP system.
]]

--[[
  To create your own custom fixedDKP configuration copy the contents of this
 file to Custom/fixeddkp.lua and remove the section below from the copy.
]]

-- CHECK FOR EXISTING CUSTOMINFO --
if DKPmon.CustomInfo.db["FDKP"] ~= nil then
   --Already registered, don't register example settings
   return
end
DKPmon:Print("Fixed DKP using default custom info")
-- REMOVE ABOVE SECTION IN YOUR FIXEDDKP.LUA FILE --

local custom = {}
DKPmon.CustomInfo:Register(custom, "FDKP")

-- Must be indexed sequentially by number beginning with 1
custom.poolnames = {
   [1] = "Pool 1",
   [2] = "Pool 2",
}
custom.numpools = #custom.poolnames -- How many point pools are defined in poolnames

--[[
User-specific boss point values.

   - Bosses are stored in tables indexed by the instance/zone in which the boss is found.
   - Note: The instance name should be spelled right. :-)

   - Each boss entry is a table indexed by the boss's name and contains a list of (value,poolindex) pairs.
   - Note that the boss' name -should- be identical to how you'd see it in the game.

  ex: ["Molten Core"] = {
        ["Lucifron"] = { { value = 10, pool = 1 },
                          { value = 20, pool = 2} }
      }
   -- This means that the "Molten Core" boss Lucifron is worth 10 pool 1 points and 20 pool 2 points when killed.
]]
custom.bossvalues = {
}

--[[ Example table:
custom.bossvalues = {
   -- Molten Core bosses
   ["The Molten Core"] = {
      ["Lucifron"] = { {value=6, pool=1} },
      ["Magmadar"] = { {value=6, pool=1} },
      ["Gahennas"] = { {value=8, pool=1} },
      ["Garr"]     = { {value=10, pool=1} },
      ["Baron Geddon"] = { {value=10, pool=1} },
      ["Shazzrah"] = { {value=10, pool=1} },
      ["Harbinger Sulfuron"] = { {value=10, pool=1} },
      ["Golemagg"] = { {value=10, pool=1} },
      ["Major Domo"] = { {value=14, pool=1} },
      ["Ragnaros"] = { {value=20, pool=1} }
   },
   ["Onyxia's Lair"] = {
      ["Onyxia"] = { {value=20, pool=1} }
   },
   
   -- Blackwing Lair bosses
   ["Blackwing Lair"] = {
      ["Razorgore"] = { {value=22, pool=2} },
      ["Vael"] = { {value=25, pool=2} },
      ["Broodlord"] = { {value=25, pool=2} },
      ["Firemaw"] = { {value=25, pool=2} },
      ["Ebonroc"] = { {value=20, pool=2} },
      ["Flamegor"] = { {value=20, pool=2} },
      ["Chromaggus"] = { {value=28, pool=2} },
      ["Nefarian"] = { {value=35, pool=2} }
   }
}
]]

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
