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


-- CHECK FOR EXISTING CUSTOMINFO --
if DKPmon.CustomInfo.db["EPGP"] ~= nil then
   --Already registered, don't register example settings
   return
end
DKPmon:Print("DKPmon_EPGP is using the example.lua file, you should create your own settings in custom.lua")
-- REMOVE ABOVE SECTION IN YOUR CUSTOM.LUA FILE --

--[[
   Example custom information table for the "EPGP" DKP system.
]]

local custom = {}
DKPmon.CustomInfo:Register(custom, "EPGP")

-- Must be indexed sequentially by number beginning with 1
custom.poolnames = {
   [1] = "First Pool",
   [2] = "Second Pool",
}
custom.numpools = #custom.poolnames -- How many point pools are defined in poolnames


------------------
-- Periodic DKP --
------------------
-- Insert tables of different timed rates to choose from, start with 1 for the first index

--[[
	TEMPLATE:

 	[index#] = {
		["TIMED DKP NAME"] = {
		amount = #(Dkp to award),
		interval = #(how often in minutes)
		}
	},
]]

custom.periodicDkp={
	[1] = {
		name = "Standard EP/Hour", 
		amount = 50,
		interval = 30
	},	
	[2] = {
		name = "Wipenight EP/Hour",
		amount = 75,
		interval = 30
	},	
}


--[[

User-specific item point values.

   - This is just a _giant_ table, indexed by the item's in-game name.
   - Each entry is a table with fields:
     - value : The point cost of the item
     - pool  : The pool from which to deduct points for the item

ex:
  ["The Decapitator"]={value=150,pool=1},
  -- This says that "The Decapitator" is worth 150 pool 1 points.
]]
custom.itemvalues = {--[ Maulgar ]--
["Pauldrons of the Fallen Hero"]={value=100,pool=1},     -- 100 GP
["Pauldrons of the Fallen Champion"]={value=100,pool=1}, -- 100 GP
["Pauldrons of the Fallen Defender"]={value=100,pool=1}, -- 100 GP

["Maulgar's Warhelm"]={value=100,pool=1},            -- 100 GP
["Malefic Mask of the Shadows"]={value=90,pool=1},   -- 90 GP

["Hammer of the Naaru"]={value=150,pool=1},          -- 150 GP
["Bladespire Warbands"]={value=60,pool=1},           -- 60 GP

["Belt of Divine Inspiration"]={value=70,pool=1},    -- 70 GP
["Brute Cloak of the Ogre-Magi"]={value=60,pool=1},  -- 60 GP

--[ Gruul ]--
["Leggings of the Fallen Hero"]={value=130,pool=1},     -- 130 GP
["Leggings of the Fallen Champion"]={value=130,pool=1}, -- 130 GP
["Leggings of the Fallen Defender"]={value=130,pool=1}, -- 130 GP

["Gauntlets of the Dragonslayer"]={value=90,pool=1},    -- 90 GP
["Shuriken of Negation"]={value=20,pool=1},             -- 20 GP
["Dragonspine Trophy"]={value=200,pool=1},              -- 200 GP
["Gronn-Stitched Girdle"]={value=60,pool=1},            -- 60 GP

["Teeth of Gruul"]={value=70,pool=1},                   -- 70 GP
["Cowl of Nature's Breath"]={value=90,pool=1},          -- 90 GP
["Eye of Gruul"]={value=30,pool=1},                     -- 30 GP

["Windshear Boots"]={value=60,pool=1},                  -- 60 GP
["Collar of Cho'gall"]={value=75,pool=1},               -- 75 GP
["Bloodmaw Magus-Blade"]={value=250,pool=1},            -- 250 GP

["Axe of the Gronn Lords"]={value=300,pool=1},          -- 300 GP
["Gauntlets of Martial Perfection"]={value=90,pool=1},  -- 90 GP
["Aldori Legacy Defender"]={value=190,pool=1},          -- 190 GP

--[ Magtheridon ]--
["Chestguard of the Fallen Defender"]={value=130,pool=1}, -- 130 GP
["Chestguard of the Fallen Hero"]={value=130,pool=1},     -- 130 GP
["Chestguard of the Fallen Champion"]={value=130,pool=1}, -- 130 GP
["Magtheridon's Head"]={value=70,pool=1},             -- 70 GP

["Cloak of the Pit Stalker"]={value=55,pool=1},       -- 55 GP
["Thundering Greathelm"]={value=100,pool=1},          -- 100 GP
["Glaive of the Pit"]={value=300,pool=1},             -- 300 GP
["Liar's Tongue Gloves"]={value=80,pool=1},           -- 80 GP
["Girdle of the Endless Pit"]={value=90,pool=1},      -- 90 GP
["Terror Pit Girdle"]={value=80,pool=1},              -- 80 GP

["Eredar Wand of Obliteration"]={value=35,pool=1},    -- 35 GP
["Karaborian Talisman"]={value=90,pool=1},            -- 90 GP
["Soul-Eater's Handwraps"]={value=90,pool=1},         -- 90 GP
["Eye of Magtheridon"]={value=70,pool=1},             -- 70 GP

["Crystalheart Pulse-Staff"]={value=300,pool=1},      -- 300 GP
["Aegis of the Vindicator"]={value=115,pool=1},       -- 115 GP

--[ Doom Lord Kazzak ]--
["Topaz-Studded Battlegrips"]={value=90,pool=1},        -- 90 GP

["Hope Ender"]={value=190,pool=1},                      -- 190 GP
["Ripfiend Shoulderplates"]={value=95,pool=1},          -- 95 GP
["Scaled Greaves of the Marksman"]={value=120,pool=1},  -- 120 GP
["Ring of Reciprocity"]={value=75,pool=1},              -- 75 GP

["Gold-Leaf Wildboots"]={value=65,pool=1},              -- 65 GP
["Ring of Flowing Light"]={value=40,pool=1},            -- 40 GP
["Exodar Life-Staff"]={value=290,pool=1},               -- 290 GP

["Leggings of the Seventh Circle"]={value=120,pool=1},  -- 120 GP
["Ancient Spellcloak of the Highborne"]={value=65,pool=1}, -- 65 GP

--[ Doomwalker ]--
["Faceguard of the Endless Watch"]={value=120,pool=1},  -- 120 GP

["Black-Iron Battlecloak"]={value=50,pool=1},           -- 50 GP
["Terrorweave Tunic"]={value=110,pool=1},               -- 110 GP
["Ethereum Nexus-Reaver"]={value=360,pool=1},           -- 360 GP
["Barrel-Blade Longrifle"]={value=270,pool=1},          -- 270 GP

["Gilded Trousers of Benediction"]={value=120,pool=1},  -- 120 GP
["Fathom-Helm of the Deeps"]={value=120,pool=1},        -- 120 GP
["Archaic Charm of Presence"]={value=25,pool=1},        -- 25 GP

["Anger-Spark Gloves"]={value=95,pool=1},               -- 95 GP
["Talon of the Tempest"]={value=240,pool=1},            -- 240 GP

--[ Serpentshrine Trash Mobs ]--
["Nether Vortex"]={value=60,pool=1},                    -- 60 GP

["Spyglass of the Hidden Fleet"]={value=85,pool=1},     -- 85 GP
["Wildfury Greatstaff"]={value=470,pool=1},             -- 470 GP
["Serpentshrine Shuriken"]={value=40,pool=1},           -- 40 GP

["Totem of the Maelstrom"]={value=50,pool=1},           -- 50 GP
["Boots of Courage Unending"]={value=110,pool=1},       -- 110 GP

["Pendant of the Perilous"]={value=85,pool=1},          -- 85 GP

--[ Hydross the Unstable ]--
["Scarab of Displacement"]={value=120,pool=1},          -- 120 GP
["Living Root of the Wildheart"]={value=90,pool=1},     -- 90 GP

["Ranger-General's Chestguard"]={value=170,pool=1},     -- 170 GP
["Pauldrons of the Wardancer"]={value=120,pool=1},      -- 120 GP
["Ring of Lethality"]={value=85,pool=1},                -- 85 GP
["Shoulderpads of the Stranger"]={value=135,pool=1},    -- 135 GP
["Band of Vile Aggression"]={value=40,pool=1},          -- 40 GP

["Blackfathom Warbands"]={value=65,pool=1},             -- 65 GP
["Wraps of Purification"]={value=95,pool=1},            -- 95 GP
["Brighthelm of Justice"]={value=170,pool=1},           -- 170 GP
["Idol of the Crescent Goddess"]={value=10,pool=1},     -- 10 GP

["Robe of Hateful Echoes"]={value=150,pool=1},          -- 150 GP
["Boots of the Shifting Nightmare"]={value=110,pool=1}, -- 110 GP
["Fathomstone"]={value=140,pool=1},                     -- 140 GP

--[ The Lurker Below ]--
["Mallet of the Tides"]={value=235,pool=1},             -- 235 GP

["Ancestral Ring of Conquest"]={value=85,pool=1},       -- 85 GP
["Choker of Animalistic Fury"]={value=55,pool=1},       -- 55 GP
["Boots of Effortless Striking"]={value=65,pool=1},     -- 65 GP
["Bracers of Eradication"]={value=95,pool=1},           -- 95 GP

["Earring of Soulful Meditation"]={value=85,pool=1},    -- 85 GP
["Glowing Breastplate of Truth"]={value=120,pool=1},    -- 120 GP
["Grove-Bands of Remulos"]={value=85,pool=1},           -- 85 GP
["Tempest-Strider Boots"]={value=135,pool=1},           -- 135 GP
["Libram of Absolute Truth"]={value=50,pool=1},         -- 50 GP

["Cord of Screaming Terrors"]={value=135,pool=1},       -- 135 GP
["Velvet Boots of the Guardian"]={value=110,pool=1},    -- 110 GP

--[ Morogrim Tidewalker ]--
["Ring of Sundered Souls"]={value=95,pool=1},           -- 95 GP

["Razor-Scale Battlecloak"]={value=85,pool=1},          -- 85 GP
["Girdle of the Tidal Call"]={value=55,pool=1},         -- 55 GP
["Talon of Azshara"]={value=330,pool=1},                -- 330 GP
["Mantle of the Tireless Tracker"]={value=135,pool=1},  -- 135 GP
["Warboots of Obliteration"]={value=120,pool=1},        -- 120 GP

["Pauldrons of the Argent Sentinel"]={value=95,pool=1}, -- 95 GP
["Luminescent Rod of the Naaru"]={value=50,pool=1},     -- 50 GP
["Band of the Vigilant"]={value=40,pool=1},             -- 40 GP
["Gnarled Chestpiece of the Ancients"]={value=120,pool=1},-- 120 GP

["Serpent-Coil Braid"]={value=120,pool=1},              -- 120 GP
["Illidari Shoulderpads"]={value=120,pool=1},           -- 120 GP
["Pendant of the Lost Ages"]={value=40,pool=1},         -- 40 GP

--[ Fathom-Lord Karathress ]--
["Leggings of the Vanquished Champion"]={value=200,pool=1},-- 200 GP
["Leggings of the Vanquished Defender"]={value=200,pool=1},-- 200 GP
["Leggings of the Vanquished Hero"]={value=200,pool=1}, -- 200 GP

["Frayed Tether of the Drowned"]={value=95,pool=1},     -- 95 GP

["Bloodsea Brigand's Vest"]={value=175,pool=1},         -- 175 GP
["World Breaker"]={value=390,pool=1},                   -- 390 GP

["Soul-Strider Boots"]={value=120,pool=1},              -- 120 GP
["Fathom-Brooch of the Tidewalker"]={value=60,pool=1},  -- 60 GP

["Sextant of Unstable Currents"]={value=90,pool=1},     -- 90 GP

--[ Leotheras the Blind ]--
["Gloves of the Vanquished Defender"]={value=155,pool=1},-- 155 GP
["Gloves of the Vanquished Champion"]={value=155,pool=1},-- 155 GP
["Gloves of the Vanquished Hero"]={value=155,pool=1},   -- 155 GP

["Girdle of the Invulnerable"]={value=120,pool=1},      -- 120 GP

["Tsunami Talisman"]={value=75,pool=1},                 -- 75 GP
["True-Aim Stalker Bands"]={value=65,pool=1},           -- 65 GP

["Coral-Barbed Shoulderpads"]={value=135,pool=1},       -- 135 GP
["Orca-Hide Boots"]={value=115,pool=1},                 -- 115 GP

["Fang of the Leviathan"]={value=330,pool=1},           -- 330 GP

--[ Lady Vashj ]--
["Helm of the Vanquished Hero"]={value=200,pool=1},
["Helm of the Vanquished Defender"]={value=200,pool=1},
["Helm of the Vanquished Champion"]={value=200,pool=1},

["Krakken-Heart Breastplate"]={value=150,pool=1},
["Cobra-Lash Boots"]={value=130,pool=1},
["Belt of One-Hundred Deaths"]={value=145,pool=1},
["Serpent Spine Longbow"]={value=375,pool=1},
["Fang of Vashj"]={value=375,pool=1},

["Coral Band of the Revived"]={value=105,pool=1},
["Lightfathom Scepter"]={value=380,pool=1},
["Runetotem's Mantle"]={value=75,pool=1},
["Glorious Gauntlets of Crestfall"]={value=160,pool=1},

["Prism of Inner Calm"]={value=100,pool=1},
["Vestments of the Sea-Witch"]={value=190,pool=1},
["Ring of Endless Coils"]={value=105,pool=1},

--[ The Eye Trash ]--
["Seventh Ring of the Tirisfalen"]={value=80,pool=1},             -- 80 GP

["Mantle of the Elven Kings"]={value=100,pool=1},                 -- 100 GP
["Bands of the Celestial Archer"]={value=60,pool=1},              -- 60 GP

["Girdle of Fallen Stars"]={value=135,pool=1},                    -- 135 GP
["Bark-Gloves of Ancient Wisdom"]={value=115,pool=1},             -- 115 GP

["Fire-Cord of the Magus"]={value=120,pool=1},                    -- 120 GP

--[ Al'ar ]--
["Netherbane"]={value=300,pool=1},
["Talon of the Phoenix"]={value=340,pool=1},
["Claw of the Phoenix"]={value=160,pool=1},
["Arcanite Steam-Pistol"]={value=300,pool=1},

["Phoenix-Wing Cloak"]={value=85,pool=1},

["Talon of Al'ar"]={value=70,pool=1},
["Gloves of the Searing Grip"]={value=100,pool=1},

["Talisman of the Sun King"]={value=155,pool=1},
["Tome of Fiery Redemption"]={value=10,pool=1},
["Fire Crest Breastplate"]={value=110,pool=1},
["Phoenix-Ring of Rebirth"]={value=90,pool=1},

["Mindstorm Wristbands"]={value=90,pool=1},
["Band of Al'ar"]={value=80,pool=1},

--[ Void Reaver ]--
["Pauldrons of the Vanquished Champion"]={value=155,pool=1},-- 155 GP
["Pauldrons of the Vanquished Defender"]={value=155,pool=1},-- 155 GP
["Pauldrons of the Vanquished Hero"]={value=155,pool=1},-- 155 GP

["Wristgaurds of Determination"]={value=90,pool=1},     -- 90 GP

["Warp-Spring Coil"]={value=120,pool=1},                -- 120 GP
["Void Reaver Greaves"]={value=165,pool=1},             -- 165 GP
["Fel-Steel Warhelm"]={value=165,pool=1},               -- 165 GP

["Fel Reaver's Piston"]={value=95,pool=1},              -- 95 GP
["Girdle of Zaetar"]={value=120,pool=1},                -- 120 GP

["Collar of the Grand Engineer"]={value=165,pool=1},    -- 165 GP

--[ High Astromancer Solarian ]--

["Ethereum Life-Staff"]={value=430,pool=1},
["Heartrazor"]={value=290,pool=1},
["Wand of the Forgotten Star"]={value=50,pool=1},

["Boots of the Resilient"]={value=130,pool=1},

["Greaves of the Bloodwarder"]={value=170,pool=1},
["Solarian's Sapphire"]={value=120,pool=1},
["Vambraces of Ending"]={value=75,pool=1},
["Star-Strider Boots"]={value=100,pool=1},

["Star-Soul Breeches"]={value=120,pool=1},
["Worldstorm Gauntlets"]={value=120,pool=1},
["Girdle of the Righteous Path"]={value=110,pool=1},

["Trousers of the Astromancer"]={value=120,pool=1},
["Void Star Talisman"]={value=60,pool=1},
}