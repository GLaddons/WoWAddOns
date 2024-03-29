﻿-- Version 1570
--CT_ITEMREG = "(|c%x+|Hitem:%d+:%d+:%d+:%d+:%d+:%d+:(%-?%d+):(%-?%d+):%d+|h%[.-%]|h|r)%";
--CT_ITEMREG_MULTI = "(|c%x+|Hitem:%d+:%d+:%d+:%d+:%d+:%d+:(%-?%d+):(%-?%d+):%d+|h%[.-%]|h|r)x(%d+)%";
CT_ITEMREG = "(|c(%x+)|Hitem:([-%d:]+)|h%[(.-)%]|h|r)%";
CT_ITEMREG_MULTI = "(|c(%x+)|Hitem:([-%d:]+)|h%[(.-)%]|h|r)x(%d+)%";

CT_RaidTracker_Zones = {
	"---- Classic --------------",
	"Molten Core",
	"Blackwing Lair",
	"Zul'Gurub",
	"Onyxia's Lair",
	"Ahn'Qiraj Ruins",
	"Ahn'Qiraj Temple",
	"Worldboss",
	-- TBC
	"---- The Burning Crusade --",
	"Karazhan",
	"Gruul's Lair",
	"Magtheridon's Lair",
	"Serpentshrine Cavern",
	"Caverns Of Time",
	"Tempest Keep: The Eye",
	"Black Temple",
	"Battle of Mount Hyjal",
	"Zul'Aman",
	"Sunwell Plateau",
	-- WotLK
	"---- WoTLK ----------------",
	"The Obsidian Sanctum",
	"Vault of Archavon",
	"The Eye of Eternity",
	"Naxxramas",
	"Ulduar",
	"Trial of the Crusader",
	"Trial of the Grand Crusader",
	"Icecrown Citdel",
	"The Ruby Sanctum",
	"---- Test -----------------",
    -- TEST
    "Ragefire Chasm",
    "The Stockade",
};

CT_RaidTracker_Bosses = {
	["Molten Core"] = {
		"Lucifron",
		"Magmadar",
		"Gehennas",
		"Garr",
		"Baron Geddon",
		"Shazzrah",
		"Sulfuron Harbinger",
		"Golemagg the Incinerator",
		"Majordomo Executus",
		"Ragnaros",
	},
	["Blackwing Lair"] = {
		"Razorgore the Untamed",
		"Vaelastrasz the Corrupt",
		"Broodlord Lashlayer",
		"Firemaw",
		"Ebonroc",
		"Flamegor",
		"Chromaggus",
		"Nefarian",
	},
	["Zul'Gurub"] = {
		"High Priestess Jeklik",
		"High Priest Venoxis",
		"High Priestess Mar'li",
		"High Priest Thekal",
		"High Priestess Arlokk",
		"Hakkar",
		"Bloodlord Mandokir",
		"Jin'do the Hexxer",
		"Gahz'ranka",
		"Hazza'rah",
		"Gri'lek",
		"Renataki",
		"Wushoolay",
	},
	["Ahn'Qiraj Temple"] = {
		"The Prophet Skeram",
		"Fankriss the Unyielding",
		"Battleguard Sartura",
		"Princess Huhuran",
		"Twin Emperors",
		"C'Thun",
		"Vem",
		"Princess Yauj",
		"Lord Kri",
		"Viscidus",
		"Ouro",
	},
	["Ahn'Qiraj Ruins"] = {
		"Kurinnaxx",
		"General Rajaxx",
		"Ayamiss the Hunter",
		"Moam",
		"Buru The Gorger",
		"Ossirian The Unscarred",
	},
	["Worldboss"] = {
	  "Onyxia",
		"Lord Kazzak",
		"Azuregos",
		-- tbc
		"Highlord Kruul",
		"Doom Lord Kazzak",
		"Doomwalker",
	  -- tbc
	},
	["Emerald Dragon"] = {
		"Ysondre",
		"Taerar",
		"Emeriss",
		"Lethon",
	},
	-- TBC
	["Karazhan"] = {
		"Attumen the Huntsman",
		"Moroes",
		"Maiden of Virtue",
		["Theater Event"] = {
			"Unknown",
			"The Crone",
			"The Big Bad Wolf",
			"Romulo and Julianne",
		},
		"The Curator",
		"Terestian Illhoof",
		"Shade of Aran",
		"Chess Event",
		"Prince Malchezaar",

		"Netherspite",
		"Nightbane",
		"Rokad the Ravager",
		"Hyakiss the Lurker",
		"Shadikith the Glider",
		"Echo of Medivh",
		"Image of Medivh",
	},
	["Gruul's Lair"] = {
		"High King Maulgar",
		"Gruul the Dragonkiller",
	},
	["Magtheridon's Lair"] = {
		"Magtheridon",
	},
	["Serpentshrine Cavern"] = {
		"Hydross the Unstable",
		"The Lurker Below",
		"Leotheras the Blind",
		"Fathom-Lord Karathress",
		"Morogrim Tidewalker",
		"Lady Vashj",
	},
	["Caverns Of Time"] = {
		"Unknown",
	},
	["Black Temple"] = {
		"High Warlord Naj'entus",
		"Supremus",
		"Gurtogg Bloodboil",
		"Teron Gorefiend",
		"Shade of Akama",
		"Reliquary of Souls",
		"Mother Shahraz",
		"Illidari Council",
		"Illidan Stormrage",
	},
	["Tempest Keep: The Eye"] = {
		"Al'ar",
		"High Astromancer Solarian",
		"Void Reaver",
		"Kael'thas Sunstrider",
	},
	["Battle of Mount Hyjal"] = {
		"Rage Winterchill",
		"Anetheron",
		"Kaz'rogal",
		"Azgalor",
		"Archimonde",
	},
	["Zul'Aman"] = {
		"Nalorakk",
		"Akil'Zon",
		"Jan'Alai",
		"Halazzi",
		"Witch Doctor",
		"Hex Lord Malacrass",
		"Zul'jin",
	},
	["Sunwell Plateau"] = {
      "Kalecgos",
      "Sathrovarr the Corruptor",
      "Brutallus",
      "Felmyst",
      "Eredar Twins",
      "Entropius",
      "Kil'jaeden",
   },
   -- WotLK
	["The Eye of Eternity"] = {
		"Malygos",
	},

	["The Obsidian Sanctum"] = {
		"Sartharion",
		"Sartharion + 1 Drakes",
		"Sartharion + 2 Drakes",
		"Sartharion + 3 Drakes",
	},

	["Vault of Archavon"] = {
		"Archavon the Stone Watcher",
		"Emalon the Storm Watcher",
        "Koralon the Flame Watcher",
        "Toravon the Ice Watcher",
	},
	["Naxxramas"] = {
		"Patchwerk",
		"Grobbulus",
		"Gluth",
		"Thaddius",
		"Instructor Razuvious",
		"Gothik the Harvester",
		--"Highlord Mograine",
		"Four Horsemen",
		--"Thane Korth'azz",
		--"Lady Blaumeux",
		--"Sir Zeliek",
		"Noth the Plaguebringer",
		"Heigan the Unclean",
		"Loatheb",
		"Anub'Rekhan",
		"Grand Widow Faerlina",
		"Maexxna",
		"Sapphiron",
		"Kel'Thuzad",
	},
	["Ulduar"] = {
		-- Ulduar Start
		"Flame Leviathan",
		"Razorscale",
		"Mimiron",
		"Auriaya",
		"Thorim",
		"General Vezax",
		"Hodir",
		"Ignis the Furnace Master",
		"XT-002 Deconstructor",
		"Kologarn",
		"Freya",
		"Yogg-Saron",
		"Algalon the Observer",
		"The Assembly of Iron",
		-- Ulduar End
	},
	["Trial of the Crusader"] = {
		"Anub'arak",
		"Faction Champions",
		"Lord Jaraxxus",
		"Northrend Beasts",
		"Twin Val'kyr",
	},
	["Trial of the Grand Crusader"] = {
		"Anub'arak",
		"Faction Champions",
		"Lord Jaraxxus",
		"Northrend Beasts",
		"Twin Val'kyr",
	},
	["Icecrown Citadel"] = {
		"Lord Marrowgar",
		"Lady Deathwhisper",
		"Gunship Battle", -- this will likely require work on the emotes
		"Deathbringer Saurfang",
		"Rotface",
		"Festergut",
		"Professor Putricide",
		"Blood Prince Council",
		"Blood-Queen Lana'thel",
		"Valithria Dreamwalker",
		"Sindragosa",
		"The Lich King",
	},
	["The Ruby Sanctum"] = {
		"General Zarithrian",
		"Baltharus the Warborn",
		"Saviana Ragefire",
		"Halion",
		"Halion - Hardmode"
	},
    -- TEST
	["Ragefire Chasm"] = {
      		"Oggleflint",
            "Taragaman the Hungerer",
      		"Jergosh the Invoker",
      		"Bazzalan",
   	},
	["The Stockade"] = {
      		"Bazil Thredd",
            "Bruegal Ironknuckle",
      		"Dextren Ward",
      		"Hamhock",
      		"Kam Deepfury",
      		"Targorr the Dread",
   	},
	--TBC
	["Trash mob"] = 1,
};

CT_RaidTracker_lang_LeftGroup = "([^%s]+) has left the raid group";
CT_RaidTracker_lang_JoinedGroup = "([^%s]+) has joined the raid group";
CT_RaidTracker_lang_ReceivesLoot1 = "([^%s]+) receives loot: "..CT_ITEMREG..".";
CT_RaidTracker_lang_ReceivesLoot2 = "You receive loot: "..CT_ITEMREG..".";
CT_RaidTracker_lang_ReceivesLoot3 = "([^%s]+) receives loot: "..CT_ITEMREG_MULTI..".";
CT_RaidTracker_lang_ReceivesLoot4 = "You receive loot: "..CT_ITEMREG_MULTI..".";
CT_RaidTracker_lang_ReceivesLootYou = "You";

CT_RaidTracker_ZoneTriggers = {
	["Molten Core"] = "Molten Core",
	["Blackwing Lair"] = "Blackwing Lair",
	["Zul'Gurub"] = "Zul'Gurub",
	["Onyxia's Lair"] = "Onyxia's Lair",
	["Ruins of Ahn'Qiraj"] = "Ahn'Qiraj Ruins",
	["Ahn'Qiraj"] = "Ahn'Qiraj Temple",
	-- TBC
	["Karazhan"] = "Karazhan",
	["Gruul's Lair"] = "Gruul's Lair",
	["Magtheridon's Lair"] = "Magtheridon's Lair",
	["Serpentshrine Cavern"] = "Serpentshrine Cavern",
	["Caverns Of Time"] = "Caverns Of Time",
	["Black Temple"] = "Black Temple",
	["Tempest Keep"] = "Tempest Keep: The Eye",
	["Hyjal Summit"] = "Battle of Mount Hyjal",
	["Zul'Aman"] = "Zul'Aman",
	["Sunwell Plateau"] = "Sunwell Plateau",
	-- WotLK
	["The Eye of Eternity"] = "The Eye of Eternity",
	["The Obsidian Sanctum"] = "The Obsidian Sanctum",
	["Vault of Archavon"] = "Vault of Archavon",
	["Naxxramas"] = "Naxxramas",
	["Ulduar"] = "Ulduar",
	["Trial of the Crusader"] = "Trial of the Crusader",
	["Trial of the Grand Crusader"] = "Trial of the Grand Crusader",
	["Icecrown Citadel"] = "Icecrown Citadel",
	["The Ruby Sanctum"] = "The Ruby Sanctum",
	-- TEST
    ["Ragefire Chasm"] = "Ragefire Chasm",
    ["The Stockade"] = "The Stockade",
};

CT_RaidTracker_BossUnitTriggers = {
	["Lucifron"] = "Lucifron",
	["Magmadar"] = "Magmadar",
	["Gehennas"] = "Gehennas",
	["Garr"] = "Garr",
	["Baron Geddon"] = "Baron Geddon",
	["Shazzrah"] = "Shazzrah",
	["Sulfuron Harbinger"] = "Sulfuron Harbinger",
	["Golemagg the Incinerator"] = "Golemagg the Incinerator",
	["Majordomo Executus"] = "Majordomo Executus",
	["Ragnaros"] = "Ragnaros",
	["Core Hound"] = "IGNORE",
	["Firesworn"] = "IGNORE",
	["Core Rager"] = "IGNORE",
	["Flamewaker Healer"] = "IGNORE",
	["Flamewaker Elite"] = "IGNORE",
	["Son of Flame"] = "IGNORE",

	["Razorgore the Untamed"] = "Razorgore the Untamed",
	["Vaelastrasz the Corrupt"] = "Vaelastrasz the Corrupt",
	["Broodlord Lashlayer"] = "Broodlord Lashlayer",
	["Firemaw"] = "Firemaw",
	["Ebonroc"] = "Ebonroc",
	["Flamegor"] = "Flamegor",
	["Chromaggus"] = "Chromaggus",
	["Nefarian"] = "Nefarian",
	["Lord Victor Nefarius"] = "Nefarian",
	["Grethok the Controller"] = "IGNORE",
	["Blackwing Guardsman"] = "IGNORE",
	["Blackwing Legionnaire"] = "IGNORE",
	["Blackwing Mage"] = "IGNORE",
	["Death Talon Dragonspawn"] = "IGNORE",
	["Black Drakonid"] = "IGNORE",
	["Blue Drakonid"] = "IGNORE",
	["Bronze Drakonid"] = "IGNORE",
	["Green Drakonid"] = "IGNORE",
	["Red Drakonid"] = "IGNORE",
	["Chromatic Drakonid"] = "IGNORE",
	["Bone Construct"] = "IGNORE",
	["Corrupted Infernal"] = "IGNORE",
	["Corrupted Blue Whelp"] = "IGNORE",
	["Corrupted Red Whelp"] = "IGNORE",
	["Corrupted Green Whelp"] = "IGNORE",
	["Corrupted Bronze Whelp"] = "IGNORE",
	["Death Talon Hatcher"] = "IGNORE",
	["Blackwing Taskmaster"] = "IGNORE",

	["High Priestess Jeklik"] = "High Priestess Jeklik",
	["High Priest Venoxis"] =	"High Priest Venoxis",
	["High Priestess Mar'li"] =	"High Priestess Mar'li",
	["High Priest Thekal"] = "High Priest Thekal",
	["High Priestess Arlokk"] =	"High Priestess Arlokk",
	["Hakkar"] = "Hakkar",
	["Bloodlord Mandokir"] = "Bloodlord Mandokir",
	["Jin'do the Hexxer"] = "Jin'do the Hexxer",
	["Gahz'ranka"] = "Gahz'ranka",
	["Hazza'rah"] = "Hazza'rah",
	["Gri'lek"] = "Gri'lek",
	["Renataki"] = "Renataki",
	["Wushoolay"] = "Wushoolay",
	["Zulian Prowler"] = "IGNORE",
	["Zulian Guardian"] = "IGNORE",
	["Parasitic Serpent"] = "IGNORE",
	["Spawn of Mar'li"] = "IGNORE",
	["Ohgan"] = "IGNORE",
	["Frenzied Bloodseeker Bat"] = "IGNORE",
	["Poisonous Cloud"] = "IGNORE",

	["Onyxia"] = "Onyxia",
	["Lord Kazzak"] = "Lord Kazzak",
	["Azuregos"] = "Azuregos",
	["Ysondre"] = "Ysondre",
	["Taerar"] = "Taerar",
	["Emeriss"] = "Emeriss",
	["Lethon"] = "Lethon",

	["Onyxian Whelp"] = "IGNORE",
	["Onyxian Warder"] = "IGNORE",
	["Shade of Taerar"] = "IGNORE",
	["Spirit Shade"] = "IGNORE",
	["Demented Druid Spirit"] = "IGNORE",

	["Kurinnaxx"] = "Kurinnaxx",
	["General Rajaxx"] = "General Rajaxx",
	["Ayamiss the Hunter"] = "Ayamiss the Hunter",
	["Buru the Gorger"] = "Buru The Gorger",
	["Moam"] = "Moam",
	["Ossirian the Unscarred"] = "Ossirian The Unscarred",
	["Buru Egg"] = "IGNORE",
	["Canal Frenzy"] = "IGNORE",
	["Mana Fiend"] = "IGNORE",
	["Silicate Feeder"] = "IGNORE",
	["Hive'Zara Hatchling"] = "IGNORE",
	["Hive'Zara Larva"] = "IGNORE",
	["Vekniss Hatchling"] = "IGNORE",
	["Anubisath Warrior"] = "IGNORE",

	["The Prophet Skeram"] = "The Prophet Skeram",
	["Fankriss the Unyielding"] = "Fankriss the Unyielding",
	["Battleguard Sartura"] = "Battleguard Sartura",
	["Princess Huhuran"] = "Princess Huhuran",
	["Emperor Vek'lor"] = "Twin Emperors",
	["Emperor Vek'nilash"] = "Twin Emperors",
	["C'Thun"] = "C'Thun",
	["Vem"] = "Vem",
	["Princess Yauj"] = "Princess Yauj",
	["Lord Kri"] = "Lord Kri",
	["Viscidus"] = "Viscidus",
	["Ouro"] = "Ouro",
	["Ouro Scarab"] = "IGNORE",
	["Spawn of Fankriss"] = "IGNORE",
	["Qiraji Scorpion"] = "IGNORE",
	["Qiraji Scarab"] = "IGNORE",
	["Vile Scarab"] = "IGNORE",
	["Yauj Brood"] = "IGNORE",
	["Sartura's Royal Guard"] = "IGNORE",
	["Sartura's Royal Guard"] = "IGNORE",
	["Poison Cloud"] = "IGNORE",
	["Vekniss Drone"] = "IGNORE",
	["Glob of Viscidus"] = "IGNORE",

	["Spotlight"] = "IGNORE",
	["Roach"] = "IGNORE",
	["Snake"] = "IGNORE",
	["Brown Snake"] = "IGNORE",
	["Crimson Snake"] = "IGNORE",
	["Black Kingsnake"] = "IGNORE",
	["Beetle"] = "IGNORE",
	["Dupe Bug"] = "IGNORE",
	["Fire Beetle"] = "IGNORE",
	["Scorpion"] = "IGNORE",
	["Frog"] = "IGNORE",
	["Hooktooth Frenzy"] = "IGNORE",
	["Sacrificed Troll"] = "IGNORE",
	["Spider"] = "IGNORE",
	["Rat"] = "IGNORE",
	["Jungle Toad"] = "IGNORE",
	["Field Repair Bot 74A"] = "IGNORE",

	-- TBC
	--Karazhan
	["Doom Lord Kazzak"] = "Doom Lord Kazzak",
	["Doomwalker"] = "Doomwalker",
	["Attumen the Huntsman"] = "Attumen the Huntsman",
	["Dorothee"] = "IGNORE",
	["Maiden of Virtue"] = "Maiden of Virtue",
	["Midnight"] = "IGNORE",
	["Moroes"] = "Moroes",
		["Baron Rafe Dreuger"] = "IGNORE", -- Moroes add
		["Baroness Dorothea Millstipe"] = "IGNORE", -- Moroes add
		["Lady Catriona Von'Indi"] = "IGNORE", -- Moroes add
		["Lady Keira Berrybuck"] = "IGNORE", -- Moroes add
		["Lord Crispin Ference"] = "IGNORE", -- Moroes add
		["Lord Robin Daris"] = "IGNORE", -- Moroes add
	["Netherspite"] = "Netherspite",
	["Nightbane"] = "Nightbane",
	["Prince Malchezaar"] = "Prince Malchezaar",
	["Shade of Aran"] = "Shade of Aran",
	["Strawman"] = "IGNORE",
	["Terestian Illhoof"] = "Terestian Illhoof",
	["Kil'rek"] = "IGNORE",
	["The Big Bad Wolf"] = "The Big Bad Wolf",
	["The Crone"] = "The Crone",
	["The Curator"] = "The Curator",
	["Tinhead"] = "IGNORE",
	["Tito"] = "IGNORE",
	["Rokad the Ravager"] = "Rokad the Ravager",
	["Hyakiss the Lurker"] = "Hyakiss the Lurker",
	["Shadikith the Glider"] = "Shadikith the Glider",
	["Chess Event"] = "Chess Event",
	["Julianne"] = "Romulo and Julianne",
	["Roar"] = "IGNORE",
	["Romulo"] = "IGNORE",
	["Echo of Medivh"] = "Echo of Medivh",
	["Image of Medivh"] = "Image of Medivh",
	-- Zul'Aman
	["Nalorakk"] = "Nalorakk",
	["Akil'Zon"] = "Akil'zon",
	["Jan'Alai"] = "Jan'alai",
	["Halazzi"] = "Halazzi",
	["Witch Doctor"] = "Witch Doctor",
	["Hex Lord Malacrass"] = "Hex Lord Malacrass",
	["Zul'jin"] = "Zul'jin",
	--Gruul
	["High King Maulgar"] = "High King Maulgar",
	["Gruul the Dragonkiller"] = "Gruul the Dragonkiller",
	["Blindeye the Seer"] = "IGNORE",
	["Kiggler the Crazed"] = "IGNORE",
	["Krosh Firehand"] = "IGNORE",
	["Olm the Summoner"] = "IGNORE",
	-- Magtheridon
	["Magtheridon"] = "Magtheridon",
	["Hellfire Warder"] = "IGNORE",
	["Hellfire Channeler"] = "IGNORE",
	--Serpentshrine Cavern
	["Hydross the Unstable"] = "Hydross the Unstable",
	["The Lurker Below"] = 		"The Lurker Below",
	["Leotheras the Blind"] = "Leotheras the Blind",
	["Fathom-Lord Karathress"] = "Fathom-Lord Karathress",
	["Morogrim Tidewalker"] = "Morogrim Tidewalker",
	["Lady Vashj"] = "Lady Vashj",
		-- Bossadds
			-- Hydross Adds
      ["Pure Spawn of Hydross"] = "IGNORE", -- Pure Spawn of Hydross
      ["Tainted Spawn of Hydross"] = "IGNORE", -- Tainted Spawn of Hydross
      ["Tainted Water Elemental"] = "IGNORE", -- Tainted Water Elemental
      ["Purified Water Elemental"] = "IGNORE", -- Purified Water Elemental

      -- Morogrim Adds
      ["Tidewalker Lurker"] = "IGNORE", -- Tidewalker Lurker
      ["Water Globule"] = "IGNORE", -- Water Globule (Waterbubbles Tidewalker summons at 25%)

			-- Fathom-Lord Karathress Adds
			["Spitfire Totem"] = "IGNORE", -- Spitfire Totem
			["Greater Earthbind Totem"] = "IGNORE", -- Greater Earthbind Totem
			["Greater Poison Cleansing Totem"] = "IGNORE", -- Greater Poison Cleansing Totem
			["Fathom Lurker"] = "IGNORE", -- Fathom Lurker
			["Fathom Sporebat"] = "IGNORE", -- Fathom Sporebat
			["Fathom-Guard Caribdis"] = "IGNORE", -- Fathom-Guard Caribdis
			["Fathom-Guard Tidalvess"] = "IGNORE", -- Fathom-Guard Tidalvess
			["Fathom-Guard Sharkkis"] = "IGNORE", -- Fathom-Guard Sharkkis

			-- The Lurker Below Adds
			["Coilfang Guardian"] = "IGNORE", -- Coilfang Guardian
			["Coilfang Ambusher"] = "IGNORE", -- Coilfang Ambusher

			-- Leotheras the Blind Adds
			["Inner Demon"] = "IGNORE", -- Inner Demon

      -- Vashj Adds
      ["Toxic Spore Bat"] = "IGNORE",  -- Toxic Spore Bat
      ["Tainted Elemental"] = "IGNORE", -- Tainted Elemental
      ["Coilfang Elite"] = "IGNORE", -- Coilfang Elite
      ["Coilfang Strider"] = "IGNORE", -- Coilfang Strider
      ["Enchanted Elemental"] = "IGNORE", -- Enchanted Elemental
      -- SSC Trashmobs
      ["Coilfang Beast-Tamer"] = "IGNORE",	-- Coilfang Beast-Tamer
      ["Vashj'ir Honor Guard"] = "IGNORE",	-- Vashj'ir Honor Guard
      ["Greyheart Tidecaller"] = "IGNORE", -- Greyheart Tidecaller
      ["Tidewalker Harpooner"] = "IGNORE", -- Tidewalker Harpooner
      ["Coilfang Hate-Screamer"] = "IGNORE", -- Coilfang Hate-Screamer
      ["Tidewalker Warrior"] = "IGNORE", -- Tidewalker Warrior
      ["Serpentshrine Lurker"] = "IGNORE", -- Serpentshrine Lurker
      ["Greyheart Nether-Mage"] = "IGNORE", -- Greyheart Nether-Mage
      ["Coilfang Priestess"] = "IGNORE", -- Coilfang Priestess
      ["Tidewalker Shaman"] = "IGNORE", -- Tidewalker Shaman
      ["Greyheart Shield-Bearer"] = "IGNORE", -- Greyheart Shield-Bearer
      ["Coilfang Serpentguard"] = "IGNORE", -- Coilfang Serpentguard
      ["Greyheart Skulker"] = "IGNORE", -- Greyheart Skulker
      ["Serpentshrine Sporebat"] = "IGNORE", -- Serpentshrine Sporebat
      ["Greyheart Technician"] = "IGNORE", -- Greyheart Technician
      ["Coilfang Fathom-Witch"] = "IGNORE", -- Coilfang Fathom-Witch
      ["Tidewalker Depth-Seer"] = "IGNORE", -- Tidewalker Depth-Seer
      ["Underbog Colossus"] = "IGNORE", -- Underbog Colossus
      ["Tidewalker Hydromancer"] = "IGNORE", -- Tidewalker Hydromancer
      ["Coilfang Shatterer"] = "IGNORE", -- Coilfang Shatterer
      -- SSC Trashmobs without loot
			["Coilfang Frenzy"] = "IGNORE", -- Coilfang Frenzy
			["Serpentshrine Tidecaller"] = "IGNORE", -- Serpentshrine Tidecaller
			["Colossus Lurker"] = "IGNORE", -- Colossus Lurker
			["Colossus Rager"] = "IGNORE", -- Colossus Rager
			["Serpentshrine Parasite"] = "IGNORE", -- Serpentshrine Parasite
			["Underbog Mushroom"] = "IGNORE", -- Underbog Mushroom
			["Water Elemental Totem"] = "IGNORE", -- Water Elemental Totem
			["Greyheart Spellbinder"] = "IGNORE", -- Greyheart Spellbinder
			["Priestess Spirit"] = "IGNORE", -- Priestess Spirit
	--Black Temple
	["High Warlord Naj'entus"] = "High Warlord Naj'entus",
	["Supremus"] = "Supremus",
	["Gurtogg Bloodboil"] = "Gurtogg Bloodboil",
	["Teron Gorefiend"] = "Teron Gorefiend",
	["Shade of Akama"] = "Shade of Akama",
	["Essence of Anger"] = "Reliquary of Souls",
	["Mother Shahraz"] = "Mother Shahraz",
	 ["Gathios the Shatterer"] = "Illidari Council",
	 ["High Nethermancer Zerevor"] = "Illidari Council",
	 ["Lady Malande"] = "Illidari Council",
	 ["Veras Darkshadow"] = "Illidari Council",
	["Illidan Stormrage"] = "Illidan Stormrage",
	--Tempest Keep: The Eye
	["Al'ar"] = "Al'ar",
	["High Astromancer Solarian"] = "High Astromancer Solarian",
	["Void Reaver"] = "Void Reaver",
	["Kael'thas Sunstrider"] = "Kael'thas Sunstrider",
    -- Bossadds
	-- Al'ar Adds
    ["Ember of Al'ar"] = "IGNORE", -- Ember of Al'ar
    -- Astromancer Adds
    ["Solarium Agent"] = "IGNORE", -- Solarium Agent
    ["Solarium Priest"] = "IGNORE", -- Solarium Priest
    -- Kael'thas Adds
    ["Lord Sanguinar"] = "IGNORE", -- Lord Sanguinar
    ["Grand Astromancer Capernian"] = "IGNORE", -- Grand Astromancer Capernian
    ["Master Engineer Telonicus"] = "IGNORE", -- Master Engineer Telonicus
    ["Phoenix Egg"] = "IGNORE", -- Phoenix Egg
    ["Phoenix"] = "IGNORE", -- Phoenix
    ["Thaladred the Darkener"] = "IGNORE", -- Thaladred the Darkener
    -- Kael'thas Weapons
    ["Infinity Blades"] = "IGNORE", -- Infinity Blades
    ["Cosmic Infuser"] = "IGNORE", -- Cosmic Infuser
    ["Netherstrand Longbow"] = "IGNORE", -- Netherstrand Longbow
    ["Phaseshift Bulwark"] = "IGNORE", -- Phaseshift Bulwark
    ["Staff of Disintegration"] = "IGNORE", -- Staff of Disintegration
    ["Devastation"] = "IGNORE", -- Devastation
    ["Warp Slicer"] = "IGNORE", -- Warp Slicer
	-- TK Trash
	["Astromancer"] = "IGNORE", -- Astromancer
	["Astromancer Lord"] = "IGNORE", -- Astromancer Lord
	["Novice Astromancer"] = "IGNORE", -- Novice Astromancer
	["Crimson Hand Blood Knight"] = "IGNORE", -- Crimson Hand Blood Knight
	["Tempest Falconer"] = "IGNORE", -- Tempest Falconer
	["Crimson Hand Inquisitor"] = "IGNORE", -- Crimson Hand Inquisitor
	["Crimson Hand Battle Mage"] = "IGNORE", -- Crimson Hand Battle Mage
	["Bloodwarder Squir"] = "IGNORE", -- Bloodwarder Squire
	["Crystalcore Mechanic"] = "IGNORE", -- Crystalcore Mechanic
	["Crystalcore Sentinel"] = "IGNORE", -- Crystalcore Sentinel
	["Crystalcore Devastator"] = "IGNORE", -- Crystalcore Devastator
	["Bloodwarder Legionnaire"] = "IGNORE", -- Bloodwarder Legionnaire
	["Bloodwarder Marshal"] = "IGNORE", -- Bloodwarder Marshal
	["Nether Scryer"] = "IGNORE", -- Nether Scryer
	["Phoenix-Hawk Hatchlings"] = "IGNORE", -- Phoenix-Hawk Hatchling
	["Phoenix-Hawk"] = "IGNORE", -- Phoenix-Hawk
	["Tempest-Smith"] = "IGNORE", -- Tempest-Smith
	["Star Scryer"] = "IGNORE", -- Star Scryer
	["Apprentice Star Scryer"] = "IGNORE", -- Apprentice Star Scryer
	["Bloodwarder Vindicator"] = "IGNORE", -- Bloodwarder Vindicator
	["Crimson Hand Centurion"] = "IGNORE", -- Crimson Hand Centurion

	["Lord Illidan Stormrage"] = "Lord Illidan Stormrage",
	["Highlord Kruul"] = "Highlord Kruul",

	--Battle of Mount Hyjal
	["Rage Winterchill"] = "Rage Winterchill",
	["Anetheron"] = "Anetheron",
	["Kaz'rogal"] = "Kaz'rogal",
	["Azgalor"] = "Azgalor",
	["Archimonde"] = "Archimonde",

  	--Sunwell Plateau
	["Kalecgos"] =  "IGNORE", -- Kalecgos
		["Sathrovarr the Corruptor"] = "Sathrovarr the Corruptor",
		["Sathrovarr the Corruptor"] = "Kalecgos",
	["Brutallus"] = "Brutallus",
		["Madrigosa"] = "IGNORE", -- Madrigosa
	["Felmyst"] = "Felmyst",
	["Lady Sacrolash"] = "Eredar Twins",
	["Grand Warlock Alythess"] = "Eredar Twins",
	["Entropius"] = "Entropius",
	["Kil'jaeden"] = "Kil'jaeden",
	["M'uru"] = "IGNORE",
	["Shadowsword Berserker"] = "IGNORE", -- Shadowsword Berserker
	["Shadowsword Fury Mage"] = "IGNORE", -- Shadowsword Fury Mage
	["Void Sentinel"] = "IGNORE", -- Void Sentinel
	["Void Spawn"] = "IGNORE", -- Void Spawn

	-- Wotlk

	-- Eye of Eternity
	["Malygos"] = "Malygos",
	-- Obsidian Sanctum
	["Sartharion"] = "Sartharion",
	-- Vault of Archavon
	["Archavon the Stone Watcher"] = "Archavon the Stone Watcher",
	["Emalon the Storm Watcher"] = "Emalon the Storm Watcher",
    ["Koralon the Flame Watcher"] = "Koralon the Flame Watcher",
    ["Toravon the Ice Watcher"] = "Toravon the Ice Watcher",
	-- Naxxramas
	["Patchwerk"] = "Patchwerk",
	["Grobbulus"] = "Grobbulus",
	["Gluth"] = "Gluth",
	["Thaddius"] = "Thaddius",
	["Instructor Razuvious"] = "Instructor Razuvious",
	["Gothik the Harvester"] = "Gothik the Harvester",
	["Noth the Plaguebringer"] = "Noth the Plaguebringer",
	["Heigan the Unclean"] = "Heigan the Unclean",
	["Loatheb"] = "Loatheb",
	["Anub'Rekhan"] = "Anub'Rekhan",
	["Grand Widow Faerlina"] = "Grand Widow Faerlina",
	["Maexxna"] = "Maexxna",
	["Sapphiron"] = "Sapphiron",
	["Kel'Thuzad"] = "Kel'Thuzad",
	["Fangnetz"] = "IGNORE",
	["Verstrahlter Br\195\188hschleimer"] = "IGNORE",

	["Crypt Guard"] = "IGNORE",
	["Grobbulus Cloud"] = "IGNORE",
	["Deathknight Understudy"] = "IGNORE",
	["Maggot"] = "IGNORE",
	["Maexxna Spiderling"] = "IGNORE",
	["Plagued Warrior"] = "IGNORE",
	["Zombie Chow"] = "IGNORE",
	["Corpse Scarab"] = "IGNORE",
	["Naxxramas Follower"] = "IGNORE",
	["Naxxramas Worshipper"] = "IGNORE",
	["Web Wrap"] = "IGNORE",
	["Fallout Slime"] = "IGNORE",
	["Diseased Maggot"] = "IGNORE",
	["Rotting Maggot"] = "IGNORE",
	["Living Poison"] = "IGNORE",
	["Spore"] = "IGNORE",
	-- 4 Horsemen
	-- ["Highlord Mograine"] = "Four Horsemen", -- From old Naxx
	["Baron Rivendare"] = "Four Horsemen",
	["Thane Korth'azz"] = "Four Horsemen",
	["Lady Blaumeux"] = "Four Horsemen",
	["Sir Zeliek"] = "Four Horsemen",

	-- Ulduar
	["Flame Leviathan"] = "Flame Leviathan",
	["Ignis the Furnace Master"] = "Ignis the Furnace Master",
	["Razorscale"] = "Razorscale",
	["XT-002 Deconstructor"] = "XT-002 Deconstructor",
	["The Assembly of Iron"] = "The Assembly of Iron",
	["Kologarn"] = "Kologarn",
	["Auriaya"] = "Auriaya",
	["Mimiron"] = "Mimiron",
	["Freya"] = "Freya",
	["Thorim"] = "Thorim",
	["Hodir"] = "Hodir",
	["General Vezax"] = "General Vezax",
	["Yogg-Saron"] = "Yogg-Saron",
	["Algalon the Observer"] = "Algalon the Observer",
	["Stormcaller Brundir"] = "IGNORE", -- The Assembly of Iron
	["Steelbreaker"] = "IGNORE", -- The Assembly of Iron
	["Runemaster Molgeim"] = "IGNORE", -- The Assembly of Iron
	-- Trial of the * Crusader
	["Icehowl"] = "Northrend Beasts",
	["Lord Jaraxxus"] = "Lord Jaraxxus",
	["Fjola Lightbane"] = "IGNORE",
	["Edyis Darkbane"] = "IGNORE",
	["Twin Val'kyr"] = "Twin Val'kyr",
	["Anub'arak"] = "Anub'arak",
	["Faction Champions"] = "Faction Champions",
	-- END of the * Crusader
	-- icecrown citadel
	["Lord Marrowgar"] = "Lord Marrowgar",
	["Lady Deathwhisper"] = "Lady Deathwhisper",
	["Gunship Battle"] = "Gunship Battle", -- this will likely require work on the emotes
	["Deathbringer Saurfang"] = "Deathbringer Saurfang",
	["Rotface"] = "Rotface",
	["Festergut"] = "Festergut",
	["Professor Putricide"] = "Professor Putricide",
	["Blood Prince Council"] = "Blood Prince Council",
	["Blood-Queen Lana'thel"] = "Blood-Queen Lana'thel",
	["Valithria Dreamwalker"] = "Valithria Dreamwalker",
	["Sindragosa"] = "Sindragosa",
	["The Lich King"] = "The Lich King", -- may still need to work on unit name
	-- end icecrown citadel
	-- TEST
	-- Ruby Sanctum
	["General Zarithrian"] = "General Zarithrian",
	["Baltharus the Warborn"] = "Baltharus the Warborn",
	["Saviana Ragefire"] = "Saviana Ragefire", -- this will likely require work on the emotes
	["Halion"] = "Halion",
	-- End Ruby Sanctum
	-- Ragefire Chasm
    ["Oggleflint"] = "Oggleflint",
    ["Taragaman the Hungerer"] = "Taragaman the Hungerer",
    ["Jergosh the Invoker"] = "Jergosh the Invoker",
    ["Bazzalan"] = "Bazzalan",

    -- The Stockade

    ["Bazil Thredd"] = "Bazil Thredd",
    ["Bruegal Ironknuckle"] = "Bruegal Ironknuckle",
    ["Dextren Ward"] = "Dextren Ward",
    ["Hamhock"] = "Hamhock",
    ["Kam Deepfury"] = "Kam Deepfury",
    ["Targorr the Dread"] = "Targorr the Dread",

	["DEFAULTBOSS"] = "Trash mob",
};

-- ulduar yells
CT_RaidTracker_lang_bossKills_Mimiron_Yell = "It would appear that I've made a slight miscalculation. I allowed my mind to be corrupted by the fiend in the prison, overriding my primary directive. All systems seem to be functional now. Clear.";
CT_RaidTracker_lang_bossKills_Mimiron_BossName = "Mimiron";
CT_RaidTracker_lang_bossKills_Thorim_Yell_1 = "I feel as though I am awakening from a nightmare, but the shadows in this place yet linger."
CT_RaidTracker_lang_bossKills_Thorim_Yell_2 = "Sif...was Sif here? Impossible! She died by my brother's hand. A dark nightmare indeed."
CT_RaidTracker_lang_bossKills_Thorim_Yell_3 = "I need time to reflect. I will aid your cause if you should require it. I owe you at least that much. Farewell."
CT_RaidTracker_lang_bossKills_Thorim_Yell_h1 = "You! Fiend! You are not my beloved! Be gone!"
CT_RaidTracker_lang_bossKills_Thorim_Yell_h2 = "Behold the hand behind all the evil that has befallen Ulduar! Left my kingdom in ruins, corrupted my brother and slain my wife!"
CT_RaidTracker_lang_bossKills_Thorim_Yell_h3 = "And now it falls to you, champions, to avenge us all! The task before you is great, but I will lend you my aid as I am able. You must prevail!"
CT_RaidTracker_lang_bossKills_Thorim_BossName = "Thorim";
CT_RaidTracker_lang_bossKills_Hodir_Yell = "I... I am released from his grasp... at last.";
CT_RaidTracker_lang_bossKills_Hodir_BossName = "Hodir";
CT_RaidTracker_lang_bossKills_Freya_Yell = "His hold on me dissipates. I can see clearly once more. Thank you, heroes."
CT_RaidTracker_lang_bossKills_Freya_BossName = "Freya";
-- Iron Council / Assmebly of Iron
CT_RaidTracker_lang_bossKills_Assembly_of_Iron_Yell_1 = "Impossible..." -- hardmode or steelbreaker last
CT_RaidTracker_lang_bossKills_Assembly_of_Iron_Yell_2 = "You rush headlong into the maw of madness!" -- brundir last
CT_RaidTracker_lang_bossKills_Assembly_of_Iron_Yell_3 = "What have you gained from my defeat? You are no less doomed, mortals!" -- molegeim last
CT_RaidTracker_lang_bossKills_Assembly_of_Iron_Yell_BossName = "The Assembly of Iron"
-- Trial of the * Crusader
CT_RaidTracker_lang_bossKills_TwinValkyr = "The Scourge cannot be stopped..."
CT_RaidTracker_lang_bossKills_TwinValkyr_BossName = "Twin Val'kyr"
CT_RaidTracker_lang_bossKills_Anubarak = "I have failed you, master..."
CT_RaidTracker_lang_bossKills_Anubarak_BossName = "Anub'arak"
-- FACTION CHAMPIONS - WORKING ON THIS ONE
CT_RaidTracker_lang_bossKills_FactionChampsAlliance = "GLORY TO THE ALLIANCE"
CT_RaidTracker_lang_bossKills_FactionChampsAlliance_BossName = "Faction Champions"
CT_RaidTracker_lang_bossKills_FactionChampsHorde = "That was just a taste of what the future brings. FOR THE HORDE!"
CT_RaidTracker_lang_bossKills_FactionChampsHorde_BossName = "Faction Champions"
CT_RaidTracker_lang_bossKills_FactionChamps = "A shallow and tragic victory. We are weaker as a whole from the losses suffered today. Who but the Lich King could benefit from such foolishness? Great warriors have lost their lives. And for what? The true threat looms ahead - the Lich King awaits us all in death."
CT_RaidTracker_lang_bossKills_FactionChamps_BossName = "Faction Champions"
-- End Trial of the * Crusader
-- icecrown yells
CT_RaidTracker_lang_bossKills_GunshipBattleOne = "The Alliance falter. Onward to the Lich King!"
CT_RaidTracker_lang_bossKills_GunshipBattleTwo = "Don't say I didn't warn ya, scoundrels! Onward, brothers and sisters!"
CT_RaidTracker_lang_bossKills_GunshipBattle_BossName = "Gunship Battle"
CT_RaidTracker_lang_bossKills_DeathbringerSaurfang = "I... Am... Released..."
CT_RaidTracker_lang_bossKills_DeathbringerSaurfang_BossName = "Deathbringer Saurfang"
CT_RaidTracker_lang_bossKills_BloodPrinceCouncil = "My queen, they... come."
CT_RaidTracker_lang_bossKills_BloodPrinceCouncil_BossName = "Blood Prince Council"
CT_RaidTracker_lang_bossKills_ValithriaDreamwalker = "I AM RENEWED! Ysera grant me the favor to lay these foul creatures to rest!"
CT_RaidTracker_lang_bossKills_ValithriaDreamwalker_BossName = "Valithria Dreamwalker"
-- end icecrown yells
-- ruby sanctum
CT_RaidTracker_lang_bossKills_HalionHardmode = "Relish this victory, mortals, for it will be your last. This world will burn with the master's return!"
CT_RaidTracker_lang_bossKills_HalionHardmode_BossName = "Halion"
-- end ruby sanctum
-- other yells
CT_RaidTracker_lang_BossKills_Majordomo_Yell = "Impossible! Stay your attack, mortals... I submit! I submit!";
CT_RaidTracker_lang_BossKills_Majordomo_BossName = "Majordomo Executus";
CT_RaidTracker_lang_BossKills_Ignore_Razorgore_Yell = "I'm free!  That device shall never torment me again!";
CT_RaidTracker_lang_BossKills_Chess_Event_Yell = "Als sich der Fluch, der auf den T\195\188ren der Halle der Spiele lastete, l\195\182st, beginnen die Mauern von Karazhan zu beben."; -- need english translation
CT_RaidTracker_lang_BossKills_Chess_Event_BossName = "Chess Event";
--
CT_RaidTracker_lang_BossKills_Julianne_Die_Yell = "O happy dagger! This is thy sheath; there rust, and let me die!";
CT_RaidTracker_lang_BossKills_Julianne_BossName = "Julianne";
CT_RaidTracker_lang_BossKills_Sathrovarr_Yell = "I'm... never on... the losing... side...";
CT_RaidTracker_lang_BossKills_Sathrovarr_BossName = "Sathrovarr the Corruptor";

if (GetLocale() == "deDE") then
	CT_RaidTracker_lang_LeftGroup = "([^%s]+) hat die Schlachtgruppe verlassen.";
	CT_RaidTracker_lang_JoinedGroup = "([^%s]+) hat sich der Schlachtgruppe angeschlossen.";
	CT_RaidTracker_lang_ReceivesLoot1 = "([^%s]+) bekommt Beute: "..CT_ITEMREG..".";
	CT_RaidTracker_lang_ReceivesLoot2 = "Ihr erhaltet Beute: "..CT_ITEMREG..".";
	CT_RaidTracker_lang_ReceivesLoot3 = "([^%s]+) erh\195\164lt Beute: "..CT_ITEMREG_MULTI..".";
	CT_RaidTracker_lang_ReceivesLoot4 = "Ihr erhaltet Beute: "..CT_ITEMREG_MULTI..".";
	CT_RaidTracker_lang_ReceivesLootYou = "Ihr";

	CT_RaidTracker_ZoneTriggers = {
		["Geschmolzener Kern"] = "Molten Core",
		["Pechschwingenhort"] = "Blackwing Lair",
		["Zul'Gurub"] = "Zul'Gurub",
		["Onyxias Hort"] = "Onyxia's Lair",
		["Ruinen von Ahn'Qiraj"] = "Ahn'Qiraj Ruins",
		["Ahn'Qiraj"] = "Ahn'Qiraj Temple",
		-- TBC
		["Karazhan"] = "Karazhan",
		["Gruuls Unterschlupf"] = "Gruul's Lair",
		["Magtheridons Kammer"] = "Magtheridon's Lair",
		["H\195\182hle des Schlangenschreins"] = "Serpentshrine Lair",
		["Festung der St\195\188rme"] = "Tempest Keep: The Eye",
		["Hyjal der Vergangenheit"] = "Caverns Of Time",
		["Der Schwarze Tempel"] = "Black Temple",
		["Hyjalgipfel"] = "Battle of Mount Hyjal",
		["Zul'Aman"] = "Zul'Aman";
		["Sonnenbrunnenplateau"] = "Sunwell Plateau",
		-- WotLK
		["Das Auge der Ewigkeit"] = "The Eye of Eternity",
		["Das Obsidiansanktum"] = "The Obsidian Sanctum",
		["Archavons Kammer"] = "Vault of Archavon",
		["Naxxramas"] = "Naxxramas",
		["H\195\182llenfeuerbollwerk"] = "Naxxramas",
		["Ulduar"] = "Ulduar",
		["Trial of the Crusader"] = "Trial of the Crusader",
		["Trial of the Grand Crusader"] = "Trial of the Grand Crusader",
		["Icecrown Citadel"] = "Icecrown Citadel",
		["The Ruby Sanctum"] = "The Ruby Sanctum",
	};

	CT_RaidTracker_BossUnitTriggers = {
		["Taschendieb der Defias"] = "Lucifron",
		["Lucifron"] = "Lucifron",
		["Magmadar"] = "Magmadar",
		["Gehennas"] = "Gehennas",
		["Garr"] = "Garr",
		["Baron Geddon"] = "Baron Geddon",
		["Shazzrah"] = "Shazzrah",
		["Sulfuronherold"] = "Sulfuron Harbinger",
		["Golemagg der Verbrenner"] = "Golemagg the Incinerator",
		["Majordomus Executus"] = "Majordomo Executus",
		["Ragnaros"] = "Ragnaros",
		["Kernhund"] = "IGNORE",
		["Feueranbeter"] = "IGNORE",
		["Kernw\195\188terich"] = "IGNORE",
		["Flamewaker-Heiler"] = "IGNORE",
		["Flamewaker-Elite"] = "IGNORE",
		["Sohn der Flamme"] = "IGNORE",

		["Razorgore der Ungez\195\164hmte"] = "Razorgore the Untamed",
		["Vaelastrasz der Verdorbene"] = "Vaelastrasz the Corrupt",
		["Brutw\195\164chter Dreschbringer"] = "Broodlord Lashlayer",
		["Feuerschwinge"] = "Firemaw",
		["Schattenschwinge"] = "Ebonroc",
		["Flammenmaul"] = "Flamegor",
		["Chromaggus"] = "Chromaggus",
		["Nefarian"] = "Nefarian",
		["Lord Victor Nefarius"] = "Nefarian",
		["Grethok der Aufseher"] = "IGNORE",
		["Gardist der Pechschwingen"] = "IGNORE",
		["Legion\195\164r der Pechschwingen"] = "IGNORE",
		["Magier der Pechschwingen"] = "IGNORE",
		["Drachenbrut der Todeskrallen"] = "IGNORE",
		["Schwarzer Drakonid"] = "IGNORE",
		["Blauer Drakonid"] = "IGNORE",
		["Bronzener Drakonid"] = "IGNORE",
		["Gr\195\188ner Drakonid"] = "IGNORE",
		["Roter Drakonid"] = "IGNORE",
		["Prismatischer Drakonid"] = "IGNORE",
		["Knochenkonstrukt"] = "IGNORE",
		["Verdorbene H\195\182llenbestie"] = "IGNORE",
		["Verderbter blauer Welpe"] = "IGNORE",
		["Verderbter roter Welpe"] = "IGNORE",
		["Verderbter gr\195\188ner Welpe"] = "IGNORE",
		["Verderbter bronzener Welpe"] = "IGNORE",
		["Brutw\195\164chter der Todeskrallen"] = "IGNORE",
		["Zuchtmeister der Pechschwingen"] = "IGNORE",

		["Hohepriesterin Jeklik"] = "High Priestess Jeklik",
		["Hohepriester Venoxis"] =	"High Priest Venoxis",
		["Hohepriesterin Mar'li"] =	"High Priestess Mar'li",
		["Hohepriester Thekal"] = "High Priest Thekal",
		["Hohepriesterin Arlokk"] =	"High Priestess Arlokk",
		["Hakkar"] = "Hakkar",
		["Blutf\195\188rst Mandokir"] = "Bloodlord Mandokir",
		["Jin'do der Verhexer"] = "Jin'do the Hexxer",
		["Gahz'ranka"] = "Gahz'ranka",
		["Hazza'rah"] = "Hazza'rah",
		["Gri'lek"] = "Gri'lek",
		["Renataki"] = "Renataki",
		["Wushoolay"] = "Wushoolay",
		["Zulianischer Streuner"] = "IGNORE",
		["Zulianischer W\195\164chter"] = "IGNORE",
		["Schmarotzerschlange"] = "IGNORE",
		["Brut von Mar'li"] = "IGNORE",
		["Ohgan"] = "IGNORE",
		["Rasende Blutsucherfledermaus"] = "IGNORE",
		["Giftige Wolke"] = "IGNORE",

		["Kurinnaxx"] = "Kurinnaxx",
		["General Rajaxx"] = "General Rajaxx",
		["Ayamiss der J\195\164ger"] = "Ayamiss the Hunter",
		["Buru der Verschlinger"] = "Buru The Gorger",
		["Moam"] = "Moam",
		["Ossirian der Narbenlose"] = "Ossirian The Unscarred",
		["Ei von Buru"] = "IGNORE",
		["Kanalfrenzy"] = "IGNORE",
		["Manageist"] = "IGNORE",
		["Silikatfresser"] = "IGNORE",
		["Jungtier des Zaraschwarms"] = "IGNORE",
		["Larve des Zaraschwarms"] = "IGNORE",

		["Der Prophet Skeram"] = "The Prophet Skeram",
		["Fankriss der Unnachgiebige"] = "Fankriss the Unyielding",
		["Schlachtwache Sartura"] = "Battleguard Sartura",
		["Prinzessin Huhuran"] = "Princess Huhuran",
		["Imperator Vek'lor"] = "Twin Emperors",
		["Imperator Vek'nilash"] = "Twin Emperors",
		["C'Thun"] = "C'Thun",
		["Vem"] = "Vem",
		["Prinzessin Yauj"] = "Princess Yauj",
		["Lord Kri"] = "Lord Kri",
		["Viscidus"] = "Viscidus",
		["Ouro"] = "Ouro",
		["Skarab\195\164us von Ouro"] = "IGNORE",
		["Brut von Fankriss"] = "IGNORE",
		["Skorpion der Qiraji"] = "IGNORE",
		["Skarab\195\164us der Qiraji"] = "IGNORE",
		["\195\156bler Skarab\195\164us"] = "IGNORE",
		["Yaujbrut"] = "IGNORE",
		["Saturas K\195\182nigswache"] = "IGNORE",
		["Sarturas K\195\182nigswache"] = "IGNORE",
		["Jungtier der Vekniss"] = "IGNORE",
		["Krieger des Anubisath "] = "IGNORE",
		["Giftwolke"] = "IGNORE",
		["Drohne der Vekniss"] = "IGNORE",
		["Klumpen von Viscidus"] = "IGNORE",

		["Onyxia"] = "Onyxia",
		["Lord Kazzak"] = "Lord Kazzak",
		["Azuregos"] = "Azuregos",
		["Ysondre"] = "Ysondre",
		["Taerar"] = "Taerar",
		["Emeriss"] = "Emeriss",
		["Lethon"] = "Lethon",

		["Onyxia-Welpe"] = "IGNORE",
		["Onyxias W\195\164rter"] = "IGNORE",
		["Taerars Schemen"] = "IGNORE",
		["Geisterschatten"] = "IGNORE",
		["Verr\195\188ckter Druidengeist"] = "IGNORE",

		["Spotlight"] = "IGNORE",
		["Schabe"] = "IGNORE",
		["Natter"] = "IGNORE",
		["Braune Natter"] = "IGNORE",
		["Purpurrote Natter"] = "IGNORE",
		["Schwarze K\195\182nigsnatter"] = "IGNORE",
		["K\195\164fer"] = "IGNORE",
		["T\195\164uschk\195\164fer"] = "IGNORE",
		["Feuerk\195\164fer"] = "IGNORE",
		["Skorpion"] = "IGNORE",
		["Frosch"] = "IGNORE",
		["Fangzahnfrenzy"] = "IGNORE",
		["Opfertroll"] = "IGNORE",
		["Spinne"] = "IGNORE",
		["Ratte"] = "IGNORE",
		["Dschungelkr\195\182te"] = "IGNORE",
		["Feldreparaturbot-74A"] = "IGNORE",

		-- TBC
		["Verdammnislord Kazzak"] = "Doom Lord Kazzak",
		["Hochlord Kazzak"] = "Highlord Kruul",
		["Verdammniswandler"] = "Doomwalker",
		-- Karazhan
		["Attumen der J\195\164ger"] = "Attumen the Huntsman",
		["Tugendhafte Maid"] = "Maiden of Virtue",
		["Moroes"] = "Moroes",
			["Baron Rafe Dreuger"] = "IGNORE", -- Moroes add
			["Baroness Dorothea M\195\188hlenstein"] = "IGNORE", -- Moroes add
			["Lady Catriona Von'Indi"] = "IGNORE", -- Moroes add
			["Lady Keira Beerhas"] = "IGNORE", -- Moroes add
			["Lord Crispin Ference"] = "IGNORE", -- Moroes add
			["Lord Robin Daris"] = "IGNORE", -- Moroes add
		["Nethergroll"] = "Netherspite",
		["Schrecken der Nacht"] = "Nightbane",
		["Prinz Malchezaar"] = "Prince Malchezaar",
		["Arans Schemen"] = "Shade of Aran",
		["Terestian Siechhuf"] = "Terestian Illhoof",
		["Kil'rek"] = "IGNORE",
		["Der gro\195\159e b\195\182se Wolf"] = "The Big Bad Wolf",
		["Die b\195\182se Hexe"] = "The Crone",
		["Der Kurator"] = "The Curator",
		["Rokad der Verheerer"] = "Rokad the Ravager",
		["Hyakiss der Lauerer"] = "Hyakiss the Lurker",
		["Shadidkith der Gleiter"] = "Shadikith the Glider",
		["Schach Event"] = "Chess Event",
		["Julianne"] = "Romulo and Julianne",
		["Romulo"] = "IGNORE",
		["Echo Medivhs"] = "Echo of Medivh",
		["Abbild von Medivh"] = "Image of Medivh",
		-- Zul'Aman
		["Nalorakk"] = "Nalorakk",
		["Akil'zon"] = "Akil'zon",
		["Jan'alai"] = "Jan'alai",
		["Halazzi"] = "Halazzi",
		["Witch Doctor"] = "Witch Doctor",
		["Hexlord Malacrass"] = "Hex Lord Malacrass",
		["Zul'jin"] = "Zul'jin",
		-- Gruul
		["Hochk\195\182nig Maulgar"] = "High King Maulgar",
		["Gruul der Drachenschl\195\164chter"] = "Gruul the Dragonkiller",
		["Blindauge der Seher"] = "IGNORE",
		["Gicherer der Wahnsinnige"] = "IGNORE",
		["Krosh Feuerhand"] = "IGNORE",
		["Olm der Beschw\195\182rer"] = "IGNORE",
		--Magtheridon
		["Magtheridon"] = "Magtheridon",
		["H\195\182llenfeuerw\195\164rter"] = "IGNORE",
		["Kanalisierer d3es H\195\182llenfeuers"] = "IGNORE",

		--Serpentshrine Cavern
		["Hydross der Unstete"] = "Hydross the Unstable",
		["Das Grauen aus der Tiefe"] = "The Lurker Below",
		["Leotheras der Blinde"] = "Leotheras the Blind",
		["Tiefenlord Karathress"] = "Fathom-Lord Karathress",
		["Morogrim Gezeitenwandler"] = "Morogrim Tidewalker",
		["Lady Vashj"] = "Lady Vashj",

		-- Bossadds
			-- Hydross Adds
      ["Gereinigter Nachkomme Hydross"] = "IGNORE", -- Pure Spawn of Hydross
      ["Besudelter Nachkomme Hydross"] = "IGNORE", -- Tainted Spawn of Hydross
      ["Besudelter Wasserelementar"] = "IGNORE", -- Tainted Water Elemental
      ["Gel\195\164uterter Wasserelementar"] = "IGNORE", -- Purified Water Elemental

      -- Morogrim Adds
      ["Lauerer der Gezeitenwandler"] = "IGNORE", -- Tidewalker Lurker
      ["Wasserkugel"] = "IGNORE", -- Water Globule (Waterbubbles Tidewalker summons at 25%)

			-- Fathom-Lord Karathress Adds
			["Feuerspuckendes Totem"] = "IGNORE", -- Spitfire Totem
			["Großes Totem der Erdbindung"] = "IGNORE", -- Greater Earthbind Totem
			["Großes Totem der Giftreinigung"] = "IGNORE", -- Greater Poison Cleansing Totem
			["Tiefenlauerer"] = "IGNORE", -- Fathom Lurker
			["Tiefensegler"] = "IGNORE", -- Fathom Sporebat
			["Tiefenw\195\164chter Caribdis"] = "IGNORE", -- Fathom-Guard Caribdis
			["Tiefenw\195\164chter Flutvess"] = "IGNORE", -- Fathom-Guard Tidalvess
			["Tiefenw\195\164chter Haikis"] = "IGNORE", -- Fathom-Guard Sharkkis

			-- The Lurker Below Adds
			["W\195\164chter des Echsenkessels"] = "IGNORE", -- Coilfang Guardian
			["Wegelagerer des Echsenkessels"] = "IGNORE", -- Coilfang Ambusher

			-- Leotheras the Blind Adds
			["Innerer D\195\164mon"] = "IGNORE", -- Inner Demon

      -- Vashj Adds
      ["Toxischer Sporensegler"] = "IGNORE",  -- Toxic Spore Bat
      ["Besudelter Elementar"] = "IGNORE", -- Tainted Elemental
      ["Elitesoldat des Echsenkessels"] = "IGNORE", -- Coilfang Elite
      ["Schreiter des Echsenkessels"] = "IGNORE", -- Coilfang Strider
      ["Verzauberter Elementar"] = "IGNORE", -- Enchanted Elemental


      -- SSC Trashmobs
      ["Bestienb\195\164ndiger des Echsenkessels"] = "IGNORE",	-- Coilfang Beast-Tamer
      ["Ehrenwache der Vashj'ir"] = "IGNORE",	-- Vashj'ir Honor Guard
      ["Gezeitenrufer der Grauherzen"] = "IGNORE", -- Greyheart Tidecaller
      ["Harpunenk\195\164mpfer der Gezeitenwandler"] = "IGNORE", -- Tidewalker Harpooner
      ["Hasssch\195\188rer des Echsenkessels"] = "IGNORE", -- Coilfang Hate-Screamer
      ["Krieger der Gezeitenwandler"] = "IGNORE", -- Tidewalker Warrior
      ["Lauerer des Schlangenschreins"] = "IGNORE", -- Serpentshrine Lurker
      ["Nethermagier der Grauherzen"] = "IGNORE", -- Greyheart Nether-Mage
      ["Priesterin des Echsenkessels"] = "IGNORE", -- Coilfang Priestess
      ["Schamane der Gezeitenwandler"] = "IGNORE", -- Tidewalker Shaman
      ["Schildtr\195\164ger der Grauherzen"] = "IGNORE", -- Greyheart Shield-Bearer
      ["Schlangenwache des Echsenkessels"] = "IGNORE", -- Coilfang Serpentguard
      ["Schleicher der Grauherzen"] = "IGNORE", -- Greyheart Skulker
      ["Sporensegler des Echsenkessels"] = "IGNORE", -- Serpentshrine Sporebat
      ["Techniker der Grauherzen"] = "IGNORE", -- Greyheart Technician
      ["Tiefenhexe des Echsenkessels"] = "IGNORE", -- Coilfang Fathom-Witch
      ["Tiefenseher der Gezeitenwandler"] = "IGNORE", -- Tidewalker Depth-Seer
      ["Tiefensumpfkoloss"] = "IGNORE", -- Underbog Colossus
      ["Wasserbeschw\195\182rer der Gezeitenwandler"] = "IGNORE", -- Tidewalker Hydromancer
      ["Zertr\195\188mmerer des Echsenkessels"] = "IGNORE", -- Coilfang Shatterer

      -- SSC Trashmobs without loot
			["Echsenkesselfrenzy"] = "IGNORE", -- Coilfang Frenzy
			["Gezeitenrufer des Schlangenschreins"] = "IGNORE", -- Serpentshrine Tidecaller
			["Kolosslauerer"] = "IGNORE", -- Colossus Lurker
			["Kolossw\195\188ter"] = "IGNORE", -- Colossus Rager
			["Parasit des Schlangenschreins"] = "IGNORE", -- Serpentshrine Parasite
			["Tiefensumpfpilz"] = "IGNORE", -- Underbog Mushroom
			["Totem des Wasserelementars"] = "IGNORE", -- Water Elemental Totem
			["Zauberbinder der Grauherzen"] = "IGNORE", -- Greyheart Spellbinder
			["Geist einer Priesterin"] = "IGNORE", -- Priestess Spirit

		--Black Temple
			["Oberster Kriegsf\195\188rst Naj'entus"] = "High Warlord Naj'entus",
			["Supremus"] = "Supremus",
			["Gurtogg Siedeblut"] = "Gurtogg Bloodboil",
			["Teron Blutschatten"] = "Teron Gorefiend",
			["Akamas Schemen"] = "Shade of Akama",
			["Reliquium der Seelen"] = "Reliquary of Souls",
			 ["Essenz der Seelen"] = "Reliquary of Souls",
			 ["Essenz der Begierde"] = "Reliquary of Souls",
			 ["Essenz des Zorns"] = "Reliquary of Souls",
			["Mutter Shahraz"] = "Mother Shahraz",
			["Rat der Illidari"] = "Illidari Council",
			  ["Gathios der Zerschmetterer"] = "Illidari Council",
			  ["Hochnethermant Zerevor"] = "Illidari Council",
			  ["Lady Malande"] = "Illidari Council",
			  ["Veras Schwarzschatten"] = "Illidari Council",
			["Illidan Sturmgrimm"] = "Illidan Stormrage",
			["F\195\188rst Illidan Sturmgrimm"] = "Lord Illidan Stormrage",

		--Tempest Keep: The Eye
		["Al'ar"] = "Al'ar",
		["Hochastromant Solarian"] = "High Astromancer Solarian",
		["Hochastronom Solarian"] = "High Astromancer Solarian",
		["Leerh\195\164scher"] = "Void Reaver",
		["Kael'thas Sonnenwanderer"] = "Kael'thas Sunstrider", --todo
			-- Bossadds
			-- Al'ar Adds
			["Al'ars Asche"] = "IGNORE", -- Ember of Al'ar
			-- Astromancer Adds
			["Solarisagent"] = "IGNORE", -- Solarium Agent
			["Solarispriester"] = "IGNORE", -- Solarium Priest
			-- Kael'thas Adds
			["F\195\188rst Blutdurst"] = "IGNORE", -- Lord Sanguinar
			["Großastronom Capernian"] = "IGNORE", -- Grand Astromancer Capernian
			["Meisteringenieur Telonicus"] = "IGNORE", -- Master Engineer Telonicus
			["Ph\195\182nixei"] = "IGNORE", -- Phoenix Egg
			["Ph\195\182nix"] = "IGNORE", -- Phoenix
			["Thaladred der Verfinsterer"] = "IGNORE", -- Thaladred the Darkener
			-- Kael'thas Weapons
			["Klinge der Unendlichkeit"] = "IGNORE", -- Infinity Blades
			["Kosmische Macht"] = "IGNORE", -- Cosmic Infuser
			["Netherbespannter Langbogen"] = "IGNORE", -- Netherstrand Longbow
			["Phasenverschobenes Bollwerk"] = "IGNORE", -- Phaseshift Bulwark
			["Stab der Aufl\195\182sung"] = "IGNORE", -- Staff of Disintegration
			["Verw\195\188stung"] = "IGNORE", -- Devastation
			["Warpschnitter"] = "IGNORE", -- Warp Slicer
			-- TK Trash
			["Astronom"] = "IGNORE", -- Astromancer
			["Astronomlord"] = "IGNORE", -- Astromancer Lord
			["Astronomnovize"] = "IGNORE", -- Novice Astromancer
			["Blutritter der Purpurhand"] = "IGNORE", -- Crimson Hand Blood Knight
			["Falkner der St\195\188rme"] = "IGNORE", -- Tempest Falconer
			["Inquisitor der Purpurhand"] = "IGNORE", -- Crimson Hand Inquisitor
			["Kampfmagier der Purpurhand"] = "IGNORE", -- Crimson Hand Battle Mage
			["Knappe der Blutw\195\164rter"] = "IGNORE", -- Bloodwarder Squire
			["Kristallkernmechaniker"] = "IGNORE", -- Crystalcore Mechanic
			["Kristallkernschildwache"] = "IGNORE", -- Crystalcore Sentinel
			["Kristallkernverw\195\188ster"] = "IGNORE", -- Crystalcore Devastator
			["Legion\195\164r der Blutw\195\164rter"] = "IGNORE", -- Bloodwarder Legionnaire
			["Marschall der Blutw\195\164rter"] = "IGNORE", -- Bloodwarder Marshal
			["Netherseher"] = "IGNORE", -- Nether Scryer
			["Ph\195\182nixfalkenjunges"] = "IGNORE", -- Phoenix-Hawk Hatchling
			["Ph\195\182nixfalke"] = "IGNORE", -- Phoenix-Hawk
			["Schmied der St\195\188rme"] = "IGNORE", -- Tempest-Smith
			["Sternenseher"] = "IGNORE", -- Star Scryer
			["Sternenseherlehrling"] = "IGNORE", -- Apprentice Star Scryer
			["Verteidiger der Blutw\195\164rter"] = "IGNORE", -- Bloodwarder Vindicator
			["Zenturio der Purpurhand"] = "IGNORE", -- Crimson Hand Centurion

		--Battle of Mount Hyjal
		["Furor Winterfrost"] = "Rage Winterchill",
		["Anetheron"] = "Anetheron",
		["Kaz'rogal"] = "Kaz'rogal",
		["Azgalor"] = "Azgalor",
		["Archimonde"] = "Archimonde",

		--Sunwell Plateau
		["Kalecgos"] =  "IGNORE", -- Kalecgos
			["Sathrovarr the Corruptor"] = "Sathrovarr the Corruptor",
			["Sathrovarr the Corruptor"] = "Kalecgos",
		["Brutallus"] = "Brutallus",
			["Madrigosa"] = "IGNORE", -- Madrigosa
		["Teufelsruch"] = "Felmyst",
		["Lady Sacrolash"] = "Eredar Twins",
		["Grand Warlock Alythess"] = "Eredar Twins",
		["Entropius"] = "Entropius",
		["Kil'jaeden"] = "Kil'jaeden",
		["M'uru"] = "IGNORE",
		["Shadowsword Berserker"] = "IGNORE", -- Shadowsword Berserker
		["Shadowsword Fury Mage"] = "IGNORE", -- Shadowsword Fury Mage
		["Void Sentinel"] = "IGNORE", -- Void Sentinel
		["Void Spawn"] = "IGNORE", -- Void Spawn
		-- Wotlk

		-- Eye of Eternity
		["Malygos"] = "Malygos",

		-- Obsidian Sanctum
		["Sartharion"] = "Sartharion",

		-- Vault of Archavon
		["Archavon der Steinw\195\164chter"] = "Archavon the Stone Watcher",


		-- Naxxramas
		["Flickwerk"] = "Patchwerk",
		["Grobbulus"] = "Grobbulus",
		["Gluth"] = "Gluth",
		["Thaddius"] = "Thaddius",
		["Instrukteur Razuvious"] = "Instructor Razuvious",
		["Gothik der Ernter"] = "Gothik the Harvester",
		["Noth der Seuchenf\195\188rst"] = "Noth the Plaguebringer",
		["Heigan der Unreine"] = "Heigan the Unclean",
		["Loatheb"] = "Loatheb",
		["Anub'Rekhan"] = "Anub'Rekhan",
		["Gro\195\159witwe Faerlina"] = "Grand Widow Faerlina",
		["Maexxna"] = "Maexxna",
		["Sapphiron"] = "Sapphiron", -- needs translation
		["Kel'Thuzad"] = "Kel'Thuzad", -- needs translation
		["Gruftwache"] = "IGNORE",
		["Wolke von Grobbulus"] = "IGNORE",
		["Reservist der Todesritter"] = "IGNORE",
		["Made"] = "IGNORE",
		["Maexxnaspinnling"] = "IGNORE",
		["Verseuchter Krieger"] = "IGNORE",
		["Zombiefra\195\159"] = "IGNORE",
		["Leichenskarab\195\164us"] = "IGNORE",
		["Anh\195\164nger von Naxxramas"] = "IGNORE",
		["J\195\188nger von Naxxramas"] = "IGNORE",
		["Fangnetz"] = "IGNORE",
		["Verstrahlter Br\195\188hschleimer"] = "IGNORE",
		["Kranke Made"] = "IGNORE",
		["Faulende Made"] = "IGNORE",
		["Lebende Giftlache"] = "IGNORE",
		["Spore"] = "IGNORE",
		-- 4 Horsemen

		-- Ulduar
		["Flame Leviathan"] = "Flame Leviathan",
		["Ignis the Furnace Master"] = "Ignis the Furnace Master",
		["Razorscale"] = "Razorscale",
		["XT-002 Deconstructor"] = "XT-002 Deconstructor",
		["The Assembly of Iron"] = "The Assembly of Iron",
		["Kologarn"] = "Kologarn",
		["Auriaya"] = "Auriaya",
		["Mimiron"] = "Mimiron",
		["Freya"] = "Freya",
		["Thorim"] = "Thorim",
		["Hodir"] = "Hodir",
		["General Vezax"] = "General Vezax",
		["Yogg-Saron"] = "Yogg-Saron",
		["Algalon the Observer"] = "Algalon the Observer",
		["Stormcaller Brundir"] = "IGNORE", -- The Assembly of Iron
		["Steelbreaker"] = "IGNORE", -- The Assembly of Iron
		["Runemaster Molgeim"] = "IGNORE", -- The Assembly of Iron
		-- icecrown citadel - TRANSLATIONS WELCOME
		["Lord Marrowgar"] = "Lord Marrowgar",
		["Lady Deathwhisper"] = "Lady Deathwhisper",
		["Gunship Battle"] = "Gunship Battle", -- this will likely require work on the emotes
		["Deathbringer Saurfang"] = "Deathbringer Saurfang",
		["Rotface"] = "Rotface",
		["Festergut"] = "Festergut",
		["Professor Putricide"] = "Professor Putricide",
		["Blood Princes"] = "Blood Princes",
		["Blood-Queen Lana'thel"] = "Blood-Queen Lana'thel",
		["Valithria Dreamwalker"] = "Valithria Dreamwalker",
		["Sindragosa"] = "Sindragosa",
		["The Lich King"] = "The Lich King", -- may still need to work on unit name
		-- end icecrown citadel
		-- Ruby Sanctum
		["General Zarithrian"] = "General Zarithrian",
		["Baltharus the Warborn"] = "Baltharus the Warborn",
		["Saviana Ragefire"] = "Saviana Ragefire", -- this will likely require work on the emotes
		["Halion"] = "Halion",
		-- End Ruby Sanctum
		-- ["Hochlord Mograine"] = "Four Horsemen", -- From old Naxx
		["Baron Totenschwur"] = "Four Horsemen",
		["Thane Korth'azz"] = "Four Horsemen",
		["Lady Blaumeux"] = "Four Horsemen",
		["Sire Zeliek"] = "Four Horsemen",

		-- Eye of Eternity
		["Malygos"] = "Malygos",

		-- Obsidian Sanctum
		["Sartharion"] = "Sartharion",

		-- Vault of Archavon
		["Archavon der Steinw\195\164chter"] = "Archavon the Stone Watcher",

		["DEFAULTBOSS"] = "Trash mob",
	};

	-- ulduar yells
	CT_RaidTracker_lang_bossKills_Mimiron_Yell = "It would appear that I've made a slight miscalculation. I allowed my mind to be corrupted by the fiend in the prison, overriding my primary directive. All systems seem to be functional now. Clear.";
	CT_RaidTracker_lang_bossKills_Mimiron_BossName = "Mimiron";

	CT_RaidTracker_lang_bossKills_Thorim_Yell_1 = "I feel as though I am awakening from a nightmare, but the shadows in this place yet linger."
	CT_RaidTracker_lang_bossKills_Thorim_Yell_2 = "Sif...was Sif here? Impossible! She died by my brother's hand. A dark nightmare indeed."
	CT_RaidTracker_lang_bossKills_Thorim_Yell_3 = "I need time to reflect. I will aid your cause if you should require it. I owe you at least that much. Farewell."
	CT_RaidTracker_lang_bossKills_Thorim_Yell_h1 = "You! Fiend! You are not my beloved! Be gone!"
	CT_RaidTracker_lang_bossKills_Thorim_Yell_h2 = "Behold the hand behind all the evil that has befallen Ulduar! Left my kingdom in ruins, corrupted my brother and slain my wife!"
	CT_RaidTracker_lang_bossKills_Thorim_Yell_h3 = "And now it falls to you, champions, to avenge us all! The task before you is great, but I will lend you my aid as I am able. You must prevail!"
	CT_RaidTracker_lang_bossKills_Thorim_BossName = "Thorim";
	CT_RaidTracker_lang_bossKills_Hodir_Yell = "I... I am released from his grasp... at last.";
	CT_RaidTracker_lang_bossKills_Hodir_BossName = "Hodir";
	CT_RaidTracker_lang_bossKills_Freya_Yell = "His hold on me dissipates. I can see clearly once more. Thank you, heroes."
	CT_RaidTracker_lang_bossKills_Freya_BossName = "Freya";
	-- Iron Council / Assmebly of Iron
	CT_RaidTracker_lang_bossKills_Assembly_of_Iron_Yell_1 = "Impossible..." -- hardmode or steelbreaker last
	CT_RaidTracker_lang_bossKills_Assembly_of_Iron_Yell_2 = "You rush headlong into the maw of madness!" -- brundir last
	CT_RaidTracker_lang_bossKills_Assembly_of_Iron_Yell_3 = "What have you gained from my defeat? You are no less doomed, mortals!" -- molegeim last
	CT_RaidTracker_lang_bossKills_Assembly_of_Iron_Yell_BossName = "The Assembly of Iron"
    -- Trial of the * Crusader
    CT_RaidTracker_lang_bossKills_TwinValkyr = "The Scourge cannot be stopped..."
    CT_RaidTracker_lang_bossKills_TwinValkyr_BossName = "Twin Val'kyr"
    CT_RaidTracker_lang_bossKills_Anubarak = "I have failed you, master..."
    CT_RaidTracker_lang_bossKills_Anubarak_BossName = "Anub'arak"
    -- FACTION CHAMPIONS - WORKING ON THIS ONE
    CT_RaidTracker_lang_bossKills_FactionChampsAlliance = "GLORY TO THE ALLIANCE"
	CT_RaidTracker_lang_bossKills_FactionChampsAlliance_BossName = "Faction Champions"
	CT_RaidTracker_lang_bossKills_FactionChampsHorde = "That was just a taste of what the future brings. FOR THE HORDE!"
	CT_RaidTracker_lang_bossKills_FactionChampsHorde_BossName = "Faction Champions"
CT_RaidTracker_lang_bossKills_FactionChamps = "A shallow and tragic victory. We are weaker as a whole from the losses suffered today. Who but the Lich King could benefit from such foolishness? Great warriors have lost their lives. And for what? The true threat looms ahead - the Lich King awaits us all in death."
CT_RaidTracker_lang_bossKills_FactionChamps_BossName = "Faction Champions"
    -- End Trial of the * Crusader
 	-- other yells
	CT_RaidTracker_lang_BossKills_Majordomo_Yell = "Unm\195\182glich! Haltet ein, Sterbliche... Ich gebe auf! Ich gebe auf!";
	CT_RaidTracker_lang_BossKills_Majordomo_BossName = "Majordomus Executus";
	CT_RaidTracker_lang_BossKills_Ignore_Razorgore_Yell = "Ich bin frei! Dieses Ger\195\164t wird mich niemals wieder qu\195\164len!";
	CT_RaidTracker_lang_BossKills_Chess_Event_Yell = "Als sich der Fluch, der auf den T\195\188ren der Halle der Spiele lastete, l\195\182st, beginnen die Mauern von Karazhan zu beben.";
	CT_RaidTracker_lang_BossKills_Chess_Event_BossName = "Schach Event";
	CT_RaidTracker_lang_BossKills_Julianne_Die_Yell = "O willkommener Dolch! Dies werde deine Scheide. Roste da und lass mich sterben!"; -- need english translation
	CT_RaidTracker_lang_BossKills_Julianne_BossName = "Julianne";
	CT_RaidTracker_lang_BossKills_Sathrovarr_Yell = "Ich bin niemals auf der... Verlierer... seite!";
	CT_RaidTracker_lang_BossKills_Sathrovarr_BossName = "Sathrovarr der Verderber";

--	CT_RaidTracker_lang_BossKills_Ignore_Julianne_Yell = "Ich komme, Romulo! Oh... dies trink' ich dir!";
--	CT_RaidTracker_lang_BossKills_Ignore_Romulo_Yell = "Und du l\195\164chelst zu dem Streich, der mich ermordet.";

elseif (GetLocale() == "frFR") then
	CT_RaidTracker_lang_LeftGroup = "([^%s]+) a quitt\195\169 le groupe de raid";
	CT_RaidTracker_lang_JoinedGroup = "([^%s]+) a rejoint le group de raid";
	CT_RaidTracker_lang_ReceivesLoot1 = "([^%s]+) re\195\167oit le butin.+: "..CT_ITEMREG..".";
	CT_RaidTracker_lang_ReceivesLoot2 = "Vous recevez le butin.+: "..CT_ITEMREG..".";
	CT_RaidTracker_lang_ReceivesLoot3 = "([^%s]+) re\195\167oit le butin.+: "..CT_ITEMREG_MULTI..".";
	CT_RaidTracker_lang_ReceivesLoot4 = "Vous recevez le butin.+: "..CT_ITEMREG_MULTI..".";
	CT_RaidTracker_lang_ReceivesLootYou = "Vous";

	CT_RaidTracker_ZoneTriggers = {
		["C\197\147ur du Magma"] = "Molten Core",
		["Repaire de l'Aile noire"] = "Blackwing Lair",
		["Zul'Gurub"] = "Zul'Gurub",
		["Repaire d'Onyxia"] = "Onyxia's Lair",
		["Ruines d'Ahn'Qiraj"] = "Ahn'Qiraj Ruins",
		["Ahn'Qiraj"] = "Ahn'Qiraj Temple",
		["Naxxramas"] = "Naxxramas",

		-- TBC
			["Karazhan"] = "Karazhan",
			["Repaire de Gruul"] = "Gruul's Lair",
			["Le repaire de Magtheridon"] = "Magtheridon's Lair",
			["Caverne du sanctuaire du Serpent"] = "Serpentshrine Lair",
			["Donjon de la Temp\195\170te"] = "Tempest Keep: The Eye",
			["Grote des temps"] = "Caverns Of Time",
      ["Temple noir"] = "Black Temple",  -- Working
      ["Sommet d'Hyjal"] = "Battle of Mount Hyjal",  -- Working
			["Zul'Aman"] = "Zul'Aman",
			["Sonnenbrunnenplateau"] = "Sunwell Plateau",
		-- TBC
		["Ulduar"] = "Ulduar",
		["Trial of the Crusader"] = "Trial of the Crusader",
		["Trial of the Grand Crusader"] = "Trial of the Grand Crusader",
		-- TRANSLATIONS WELCOME
		["Icecrown Citadel"] = "Icecrown Citadel",
		["The Ruby Sanctum"] = "The Ruby Sanctum",
	};

	CT_RaidTracker_BossUnitTriggers = {
		["Lucifron"] = "Lucifron",
		["Magmadar"] = "Magmadar",
		["Gehennas"] = "Gehennas",
		["Garr"] = "Garr",
		["Baron Geddon"] = "Baron Geddon",
		["Shazzrah"] = "Shazzrah",
		["Messager de Sulfuron"] = "Sulfuron Harbinger",
		["Golemagg l'Incin\195\169rateur"] = "Golemagg the Incinerator",
		["Chambellan Executus"] = "Majordomo Executus",
		["Ragnaros"] = "Ragnaros",
		["Chien du Magma"] = "IGNORE",
		["Lige du feu"] = "IGNORE",
		["Rageur du Magma"] = "IGNORE",
		["Soigneur Flamewaker"] = "IGNORE",
		["Elite Flamewaker"] = "IGNORE",
		["Fils des flammes"] = "IGNORE",

		["Razorgore l'Indompt\195\169"] = "Razorgore the Untamed",
		["Caelastrasz le Corrumpu"] = "Vaelastrasz the Corrupt",
		["Seigneur des couv\195\169es Lashslayer"] = "Broodlord Lashlayer",
		["Gueule-de-feu"] = "Firemaw",
		["Ebonroc"] = "Ebonroc",
		["Flamegor"] = "Flamegor",
		["Chromaggus"] = "Chromaggus",
		["Nefarian"] = "Nefarian",
		["Seigneur Victor Nefarius"] = "Nefarian",
		["Grethok le Contr\195\180leur"] = "IGNORE",
		["Garde de l'Aile noire"] = "IGNORE",
		["L\195\169gionnaire de l'Aile noire"] = "IGNORE",
		["Mage de l'Aile noire"] = "IGNORE",
		["Draconide Griffemort"] = "IGNORE",
		["Drak\195\180nide noir"] = "IGNORE",
		["Drak\195\180nide bleu"] = "IGNORE",
		["Drak\195\180nide bronze"] = "IGNORE",
		["Drak\195\180nide vert"] = "IGNORE",
		["Drak\195\180nide rouge"] = "IGNORE",
		["Drak\195\180nide chromatique"] = "IGNORE",
		["Assemblage d'os"] = "IGNORE",
		["Infernal corrompu"] = "IGNORE",
		["Dragonnet bleu corrompu"] = "IGNORE",
		["Dragonnet rouge corrompu"] = "IGNORE",
		["Dragonnet vert corrompu"] = "IGNORE",
		["Dragonnet bronze corrompu"] = "IGNORE",
		["Eveilleur Griffemort"] = "IGNORE",
		["Contrema\195\174tre de l'Aile noire"] = "IGNORE",
		["Nuage toxique"] = "IGNORE",

		["Grande pr\195\170tresse Jeklik"] = "High Priestess Jeklik",
		["Grand pr\195\170tre Venoxis"] =	"High Priest Venoxis",
		["Grande pr\195\170tresse Mar'li"] =	"High Priestess Mar'li",
		["Grand pr\195\170tre Thekal"] = "High Priest Thekal",
		["Grande pr\195\170tresse Arlokk"] =	"High Priestess Arlokk",
		["Hakkar"] = "Hakkar",
		["Seigneur sanglant Mandokir"] = "Bloodlord Mandokir",
		["Jin'do le Mal\195\169ficieur"] = "Jin'do the Hexxer",
		["Gahz'ranka"] = "Gahz'ranka",
		["Hazza'rah"] = "Hazza'rah",
		["Gri'lek"] = "Gri'lek",
		["Renataki"] = "Renataki",
		["Wushoolay"] = "Wushoolay",
		["R\195\180deur zulien"] = "IGNORE",
		["Gardien zulien"] = "IGNORE",
		["Serpent parasite"] = "IGNORE",
		["Rejetons de Mar'li"] = "IGNORE",
		["Ohgan"] = "IGNORE",
		["Chauve-souris sanguinaire fr\195\169n\195\169tique"] = "IGNORE",

		["Kurinnaxx"] = "Kurinnaxx",
		["G\195\169n\195\169ral Rajaxx"] = "General Rajaxx",
		["Ayamiss le Chasseur"] = "Ayamiss the Hunter",
		["Buru Grandgosier"] = "Buru the Gorger",
		["Moam"] = "Moam",
		["Ossirian l'Intouch\195\169"] = "Ossirian the Unscarred",
		["\197\146uf de Buru"] = "IGNORE",
		["Furie des canaux"] = "IGNORE",
		["D\195\169mon de mana"] = "IGNORE",
		["Nourrisseur silicieux"] = "IGNORE",
		["Jeune de la Ruche'Zara"] = "IGNORE",
		["Larve de la Ruche'Zara"] = "IGNORE",

		["Le Proph\195\168te Skeram"] = "The Prophet Skeram",
		["Fankriss l'Inflexible"] = "Fankriss the Unyielding",
		["Garde de guerre Sartura"] = "Battleguard Sartura",
		["Princesse Huhuran"] = "Princess Huhuran",
		["Empereur Vek'lor"] = "Twin Emperors",
		["Empereur Vek'nilash"] = "Twin Emperors",
		["C'Thun"] = "C'Thun",
		["Vem"] = "Vem",
		["Princesse Yauj "] = "Princess Yauj",
		["Seigneur Kri"] = "Lord Kri",
		["Viscidus"] = "Viscidus",
		["Ouro"] = "Ouro",
		["Scarab\195\169e d'Ouro"] = "IGNORE",
		["Rejeton de Fankriss"] = "IGNORE",
		["Scorpion qiraji"] = "IGNORE",
		["Scarab\195\169e qiraji"] = "IGNORE",
		["Scarab\195\169e vil"] = "IGNORE",
		["Rejeton de Yauj"] = "IGNORE",
		["Garde royal de Sartura"] = "IGNORE",
		["Jeune vekniss"] = "IGNORE",
		["Guerrier Anubisath"] = "IGNORE",
		["Nuage empoisonn\195\169"] = "IGNORE",
		["Bourdon vekniss"] = "IGNORE",
		["Globule de Viscidus"] = "IGNORE",

		["Le Recousu"] = "Patchwerk",
		["Grobbulus"] = "Grobbulus",
		["Gluth"] = "Gluth",
		["Thaddius"] = "Thaddius",
		["Instructeur Razuvious"] = "Instructor Razuvious",
		["Gothik le Moissonneur"] = "Gothik the Harvester",
		["Généralissime Mograine"] = "Highlord Mograine",
		["Thane Korth'azz"] = "Thane Korth'azz",
		["Dame Blaumeux"] = "Lady Blaumeux",
		["Sire Zeliek"] = "Sir Zeliek",
		["Noth le Porte-peste"] = "Noth the Plaguebringer",
		["Heigan l'Impur"] = "Heigan the Unclean",
		["Horreb"] = "Loatheb",
		["Anub'Rekhan"] = "Anub'Rekhan",
		["Grande veuve Faerlina"] = "Grand Widow Faerlina",
		["Maexxna"] = "Maexxna",
		["Sapphiron"] = "Sapphiron",
		["Kel'Thuzad"] = "Kel'Thuzad",
		["Gardien des cryptes"] = "IGNORE",
		["Nuage de Grobbulus"] = "IGNORE",
		["Doublure de chevalier de la mort"] = "IGNORE",
		["Asticot "] = "IGNORE",
		["Jeune araign\195\169e de Maexxna"] = "IGNORE",
		["Guerrier pestif\195\169r\195\169"] = "IGNORE",
		["Croq'zombie"] = "IGNORE",
		["Scarab\195\169e mange-cadavres"] = "IGNORE",
		["Suivant de Naxxramas"] = "IGNORE",
		["Adorateur de Naxxramas"] = "IGNORE",
		["Entoilage"] = "IGNORE",
		["Gel\195\169e pollu\195\169e"] = "IGNORE",
		["Asticot malade"] = "IGNORE",
		["Asticot pourrissant"] = "IGNORE",
		["Poison vivant"] = "IGNORE",
		["Spore"] = "IGNORE",

		["Onyxia"] = "Onyxia",
		["Seigneur Kazzak"] = "Lord Kazzak",
		["Azuregos"] = "Azuregos",
		["Ysondre"] = "Ysondre",
		["Taerar"] = "Taerar",
		["Emeriss"] = "Emeriss",
		["L\195\169thon"] = "Lethon",

		["Dragonnet d'onyx"] = "IGNORE",
		["Gardien d'onyx"] = "IGNORE",
		["Ombre de Taerar"] = "IGNORE",
		["Ombre spirituelle"] = "IGNORE",
		["Esprit de druide d\195\169ment"] = "IGNORE",

		["Tache de lumi\195\168re"] = "IGNORE",
		["Blatte"] = "IGNORE",
		["Serpent"] = "IGNORE",
		["Serpent brun"] = "IGNORE",
		["Serpent cramoisi"] = "IGNORE",
		["Cobra noir"] = "IGNORE",
		["Hanneton"] = "IGNORE",
		["Blatte m\195\169canique"] = "IGNORE",
		["Hanneton de feu"] = "IGNORE",
		["Scorpion"] = "IGNORE",
		["Grenouille"] = "IGNORE",
		["Crochedents fr\195\169n\195\169tique"] = "IGNORE",
		["Troll sacrifi\195\169"] = "IGNORE",
		["Araign\195\169e"] = "IGNORE",
		["Rat"] = "IGNORE",
		["Crapaud de la jungle"] = "IGNORE",
		["Robot r\195\169parateur 74A"] = "IGNORE",
		-- tbc
		["G\195\169n\195\169eralissime Kruul"] = "Highlord Kruul",

		-- TBC : Karazhan
		["Attumen le Veneur"]="Attumen the Huntsman",
		["Doroth\195\169e"]="Dorothee",
		["Damoiselle de vertu"]="Maiden of Virtue",
		["Minuit"]="Midnight",
		["Moroes"]="Moroes",
			["Baron Rafe Dreuger"] = "IGNORE", -- Moroes add
			["Baronne Dorothea Millstipe"] = "IGNORE", -- Moroes add
			["Dame Catriona Von'Indi"] = "IGNORE", -- Moroes add
			["Dame Keira Berrybuck"] = "IGNORE", -- Moroes add
			["Seigneur Crispin Ference"] = "IGNORE", -- Moroes add
			["Seigneur Robin Daris"] = "IGNORE", -- Moroes add
		["D\195\169dain-du-N\195\169ant"]="Netherspite",
		["Plaie-de-nuit"]="Nightbane",
		["Prince Malchezaar"]="Prince Malchezaar",
		["Ombre d'Aran"]="Shade of Aran",
		["Terestian Malsabot"]="Terestian Illhoof",
		["Kil'rek"] = "IGNORE",
		["Le Grand M\195\169chant Loup"]="The Big Bad Wolf",
		["La M\195\169g\195\168re"]="The Crone",
		["Le conservateur"]="The Curator",
		["Rodak le ravageur"]="Rokad the Ravager",
		["Hyakiss la R\195\180deuse"]="Hyakiss the Lurker",
		["Shadikith le glisseur"]="Shadikith the Glider",
		["Julianne"]="Romulo and Julianne",
		["Romulo"]="IGNORE",

		["Chess Event"]="Chess Event", -- translation needed
		-- Zul'Aman
		["Nalorakk"] = "Nalorakk",
		["Akil'Zon"] = "Akil'zon",
		["Jan'Alai"] = "Jan'alai",
		["Halazzi"] = "Halazzi",
		["Witch Doctor"] = "Witch Doctor",
		["Seigneur des mal\195\169fices Malacrass"] = "Hex Lord Malacrass",
		["Zul'jin"] = "Zul'jin",
		-- TBC : Grull
		["Haut Roi Maulgar"]="High King Maulgar",
		["Gruul le Tue-dragon"]="Gruul the Dragonkiller",
		["Oeillaveugle le Voyant"]="IGNORE", -- maulgar add
		["Kiggler le Cingl\195\169"]="IGNORE", -- maulgar add
		["Krosh Brasemain"]="IGNORE", -- maulgar add
		["Olm l'Invocateur"]="IGNORE", -- maulgar add

    -- Magtheridon
	  ["Magtheridon"] = "Magtheridon",
	  ["Canaliste des Flammes infernales"] = "IGNORE",
    ["Gardien des flammes infernales"] = "IGNORE",

		["Seigneur funeste Kazzak"] = "Doom Lord Kazzak",
		["Marche-funeste"] = "Doomwalker",

		--Serpentshrine Cavern
		["Hydross l'Instable"] = "Hydross the Unstable",
		["Le R\195\180deur d'En-bas"] = "The Lurker Below",
		["Leotheras l'Aveugle"] = "Leotheras the Blind",
		["Seigneur des fonds Karathress"] = "Fathom-Lord Karathress",
		["Morogrim Marcheur-des-flots"] = "Morogrim Tidewalker",
		["Dame Vashj"] = "Lady Vashj",

		--Black Temple
    ["Grand seigneur de guerre Naj'entus"] = "High Warlord Naj'entus",
    ["Supremus"] = "Supremus",
    ["Gurtogg Fi\195\168vresang"] = "Gurtogg Bloodboil",
    ["Teron Fielsang"] = "Teron Gorefiend",
    ["Ombre d'Akama"] = "Shade of Akama",
    ["Essence de la col\195\168re"] = "Essence of Souls",
    ["M\195\168re Shahraz"] = "Mother Shahraz",
    ["Conseil illidari"] = "Illidari Council", -- need translation
    ["Illidan Hurlorage"] = "Illidan Stormrage",
    ["Seigneur Illidan Hurlorage"] = "Lord Illidan Stormrage",

		--Tempest Keep: The Eye
		["Al'ar"] = "Al'ar",
		["Grande astromancienne Solarian"] = "High Astromancer Solarian",
		["Saccageur du Vide"] = "Void Reaver", --todo
		["Kael'thas Haut-soleil"] = "Kael'thas Sunstrider", --todo

		--Battle of Mount Hyjal
    ["Rage Froidhiver"] = "Rage Winterchill",
    ["Anetheron"] = "Anetheron",
    ["Kaz'rogal"] = "Kaz'rogal",
    ["Azgalor"] = "Azgalor",
    ["Archimonde"] = "Archimonde",

		--Sunwell Plateau
		["Kalecgos"] =  "IGNORE", -- Kalecgos
			["Sathrovarr the Corruptor"] = "Sathrovarr the Corruptor",
			["Sathrovarr the Corruptor"] = "Kalecgos",
		["Brutallus"] = "Brutallus",
			["Madrigosa"] = "IGNORE", -- Madrigosa
		["Felmyst"] = "Felmyst",
		["Lady Sacrolash"] = "Eredar Twins",
		["Grand Warlock Alythess"] = "Eredar Twins",
		["Entropius"] = "Entropius",
		["Kil'jaeden"] = "Kil'jaeden",
		["M'uru"] = "IGNORE",
		["Shadowsword Berserker"] = "IGNORE", -- Shadowsword Berserker
		["Shadowsword Fury Mage"] = "IGNORE", -- Shadowsword Fury Mage
		["Void Sentinel"] = "IGNORE", -- Void Sentinel
		["Void Spawn"] = "IGNORE", -- Void Spawn
		-- icecrown citadel : TRANSLATIONS WELCOME!
		["Lord Marrowgar"] = "Lord Marrowgar",
		["Lady Deathwhisper"] = "Lady Deathwhisper",
		["Gunship Battle"] = "Gunship Battle", -- this will likely require work on the emotes
		["Deathbringer Saurfang"] = "Deathbringer Saurfang",
		["Rotface"] = "Rotface",
		["Festergut"] = "Festergut",
		["Professor Putricide"] = "Professor Putricide",
		["Blood Princes"] = "Blood Princes",
		["Blood-Queen Lana'thel"] = "Blood-Queen Lana'thel",
		["Valithria Dreamwalker"] = "Valithria Dreamwalker",
		["Sindragosa"] = "Sindragosa",
		["The Lich King"] = "The Lich King", -- may still need to work on unit name
		-- end icecrown citadel
		-- Ruby Sanctum
		["General Zarithrian"] = "General Zarithrian",
		["Baltharus the Warborn"] = "Baltharus the Warborn",
		["Saviana Ragefire"] = "Saviana Ragefire", -- this will likely require work on the emotes
		["Halion"] = "Halion",
		-- End Ruby Sanctum
		-- tbc
		["DEFAULTBOSS"] = "Trash mob",
	};
	-- ulduar yells
	CT_RaidTracker_lang_bossKills_Mimiron_Yell = "It would appear that I've made a slight miscalculation. I allowed my mind to be corrupted by the fiend in the prison, overriding my primary directive. All systems seem to be functional now. Clear.";
	CT_RaidTracker_lang_bossKills_Mimiron_BossName = "Mimiron";

	CT_RaidTracker_lang_bossKills_Thorim_Yell_1 = "I feel as though I am awakening from a nightmare, but the shadows in this place yet linger."
	CT_RaidTracker_lang_bossKills_Thorim_Yell_2 = "Sif...was Sif here? Impossible! She died by my brother's hand. A dark nightmare indeed."
	CT_RaidTracker_lang_bossKills_Thorim_Yell_3 = "I need time to reflect. I will aid your cause if you should require it. I owe you at least that much. Farewell."
	CT_RaidTracker_lang_bossKills_Thorim_Yell_h1 = "You! Fiend! You are not my beloved! Be gone!"
	CT_RaidTracker_lang_bossKills_Thorim_Yell_h2 = "Behold the hand behind all the evil that has befallen Ulduar! Left my kingdom in ruins, corrupted my brother and slain my wife!"
	CT_RaidTracker_lang_bossKills_Thorim_Yell_h3 = "And now it falls to you, champions, to avenge us all! The task before you is great, but I will lend you my aid as I am able. You must prevail!"
	CT_RaidTracker_lang_bossKills_Thorim_BossName = "Thorim";
	CT_RaidTracker_lang_bossKills_Hodir_Yell = "I... I am released from his grasp... at last.";
	CT_RaidTracker_lang_bossKills_Hodir_BossName = "Hodir";
	CT_RaidTracker_lang_bossKills_Freya_Yell = "His hold on me dissipates. I can see clearly once more. Thank you, heroes."
	CT_RaidTracker_lang_bossKills_Freya_BossName = "Freya";
	-- Iron Council / Assmebly of Iron
	CT_RaidTracker_lang_bossKills_Assembly_of_Iron_Yell_1 = "Impossible..." -- hardmode or steelbreaker last
	CT_RaidTracker_lang_bossKills_Assembly_of_Iron_Yell_2 = "You rush headlong into the maw of madness!" -- brundir last
	CT_RaidTracker_lang_bossKills_Assembly_of_Iron_Yell_3 = "What have you gained from my defeat? You are no less doomed, mortals!" -- molegeim last
	CT_RaidTracker_lang_bossKills_Assembly_of_Iron_Yell_BossName = "The Assembly of Iron"
    -- Trial of the * Crusader
    CT_RaidTracker_lang_bossKills_TwinValkyr = "The Scourge cannot be stopped..."
    CT_RaidTracker_lang_bossKills_TwinValkyr_BossName = "Twin Val'kyr"
    CT_RaidTracker_lang_bossKills_Anubarak = "I have failed you, master..."
    CT_RaidTracker_lang_bossKills_Anubarak_BossName = "Anub'arak"
    -- FACTION CHAMPIONS - WORKING ON THIS ONE
    CT_RaidTracker_lang_bossKills_FactionChampsAlliance = "GLORY TO THE ALLIANCE"
	CT_RaidTracker_lang_bossKills_FactionChampsAlliance_BossName = "Faction Champions"
	CT_RaidTracker_lang_bossKills_FactionChampsHorde = "That was just a taste of what the future brings. FOR THE HORDE!"
	CT_RaidTracker_lang_bossKills_FactionChampsHorde_BossName = "Faction Champions"
CT_RaidTracker_lang_bossKills_FactionChamps = "A shallow and tragic victory. We are weaker as a whole from the losses suffered today. Who but the Lich King could benefit from such foolishness? Great warriors have lost their lives. And for what? The true threat looms ahead - the Lich King awaits us all in death."
CT_RaidTracker_lang_bossKills_FactionChamps_BossName = "Faction Champions"
    -- End Trial of the * Crusader
	-- other yells
	CT_RaidTracker_lang_BossKills_Majordomo_Yell = "Impossible ! Arr\195\170tez votre attaque, mortels... Je me rends ! Je me rends !";
	CT_RaidTracker_lang_BossKills_Majordomo_BossName = "Majordome Executus";
	CT_RaidTracker_lang_BossKills_Chess_Event_Yell = "Als sich der Fluch, der auf den T\195\188ren der Halle der Spiele lastete, l\195\182st, beginnen die Mauern von Karazhan zu beben."; -- need france translation
	--CT_RaidTracker_lang_BossKills_Chess_Event_Yell = "Les salles de Karazhan tremblent, tandis qu'est lev\195\169e la mal\195\169diction qui scellait les portes du hall du Flambeur.";
	CT_RaidTracker_lang_BossKills_Chess_Event_BossName = "Chess Event";
	CT_RaidTracker_lang_BossKills_Ignore_Razorgore_Yell = "Je suis libre ! Cet instrument ne me torturera plus jamais !";
	CT_RaidTracker_lang_BossKills_Julianne_Die_Yell = "O willkommener Dolch! Dies werde deine Scheide. Roste da und lass mich sterben!"; -- need english translation
	CT_RaidTracker_lang_BossKills_Julianne_BossName = "Julianne";
--	CT_RaidTracker_lang_BossKills_Ignore_Julianne_Yell = "Ich komme, Romulo! Oh... dies trink' ich dir!"; -- need france translation
--	CT_RaidTracker_lang_BossKills_Ignore_Romulo_Yell = "Und du l\195\164chelst zu dem Streich, der mich ermordet.";	-- need france translation
	CT_RaidTracker_lang_BossKills_Sathrovarr_Yell = "I'm... never on... the losing... side..."; -- need france translation
	CT_RaidTracker_lang_BossKills_Sathrovarr_BossName = "Sathrovarr the Corruptor"; -- need france translation

elseif (GetLocale() == "esES") then
	CT_RaidTracker_lang_LeftGroup = "([^%s]+) se ha marchado de la banda.";
	CT_RaidTracker_lang_JoinedGroup = "([^%s]+) se ha unido a la banda.";
	CT_RaidTracker_lang_ReceivesLoot1 = "([^%s]+) recibe el bot\195\173n: "..CT_ITEMREG..".";
	CT_RaidTracker_lang_ReceivesLoot2 = "Recibes bot\195\173n: "..CT_ITEMREG..".";
	CT_RaidTracker_lang_ReceivesLoot3 = "([^%s]+) recibe el bot\195\173n: "..CT_ITEMREG_MULTI..".";
	CT_RaidTracker_lang_ReceivesLoot4 = "Recibes bot\195\173n: "..CT_ITEMREG_MULTI..".";
	CT_RaidTracker_lang_ReceivesLootYou = "Recibes";

	CT_RaidTracker_ZoneTriggers = {
		["NÃºcleo de Magma"] = "Molten Core",
		["Guarida Alanegra"] = "Blackwing Lair",
		["Zul'Gurub"] = "Zul'Gurub",
		["Guarida de Onyxia"] = "Onyxia's Lair",
		["Ruinas de Ahn'Qiraj"] = "Ahn'Qiraj Ruins",
		["Ahn'Qiraj"] = "Ahn'Qiraj Temple",
		["Naxxramas"] = "Naxxramas",
		["Ulduar"] = "Ulduar",
		["Trial of the Crusader"] = "Trial of the Crusader",
		["Trial of the Grand Crusader"] = "Trial of the Grand Crusader",

		-- TBC
			["Karazhan"] = "Karazhan",
			["Guarida de Gruul"] = "Gruul's Lair",
			["Guarida de Magtheridon"] = "Magtheridon's Lair",
			["Caverne du sanctuaire du Serpent"] = "Serpentshrine Cavern",
			["Donjon de la Tempête"] = "Tempest Keep: The Eye",
			["Cavernas del Tiempo"] = "Caverns Of Time",
			["El Templo Oscuro"] = "Black Temple",
			["Hyjal"] = "Battle of Mount Hyjal",
			["Zul'Aman"] = "Zul'Aman";
		-- TBC

		-- TRANSLATIONS WELCOME
		["Icecrown Citadel"] = "Icecrown Citadel",
		["The Ruby Sanctum"] = "The Ruby Sanctum",
	};

	CT_RaidTracker_lang_BossKills_Majordomo_Yell = "Impossible ! Arr\195\170tez votre attaque, mortels... Je me rends ! Je me rends !";
	CT_RaidTracker_lang_BossKills_Majordomo_BossName = "Majordome Executus";
	CT_RaidTracker_lang_BossKills_Chess_Event_Yell = "Als sich der Fluch, der auf den T\195\188ren der Halle der Spiele lastete, l\195\182st, beginnen die Mauern von Karazhan zu beben."; -- need france translation
	--CT_RaidTracker_lang_BossKills_Chess_Event_Yell = "Les salles de Karazhan tremblent, tandis qu'est lev\195\169e la mal\195\169diction qui scellait les portes du hall du Flambeur.";
	CT_RaidTracker_lang_BossKills_Chess_Event_BossName = "Chess Event";
	CT_RaidTracker_lang_BossKills_Ignore_Razorgore_Yell = "Je suis libre ! Cet instrument ne me torturera plus jamais !";
	CT_RaidTracker_lang_BossKills_Julianne_Die_Yell = "O willkommener Dolch! Dies werde deine Scheide. Roste da und lass mich sterben!"; -- need english translation
	CT_RaidTracker_lang_BossKills_Julianne_BossName = "";
--	CT_RaidTracker_lang_BossKills_Ignore_Julianne_Yell = "Ich komme, Romulo! Oh... dies trink' ich dir!"; -- need france translation
--	CT_RaidTracker_lang_BossKills_Ignore_Romulo_Yell = "Und du l\195\164chelst zu dem Streich, der mich ermordet.";	-- need france translation
	CT_RaidTracker_lang_BossKills_Sathrovarr_Yell = "I'm... never on... the losing... side..."; -- need Spain translation
	CT_RaidTracker_lang_BossKills_Sathrovarr_BossName = "Sathrovarr the Corruptor";	-- need Spain translation
	elseif (GetLocale() == "ruRU") then
CT_RaidTracker_lang_LeftGroup = "([^%s]+) покидает рейдовую группу";
CT_RaidTracker_lang_JoinedGroup = "([^%s]+) присоединятся к рейдовой группе";
CT_RaidTracker_lang_ReceivesLoot1 = "([^%s]+) получает добычу: "..CT_ITEMREG..".";
CT_RaidTracker_lang_ReceivesLoot2 = "Ваша добыча: "..CT_ITEMREG..".";
CT_RaidTracker_lang_ReceivesLoot3 = "([^%s]+) получает добычу: "..CT_ITEMREG_MULTI..".";
CT_RaidTracker_lang_ReceivesLoot4 = "Ваша добыча: "..CT_ITEMREG_MULTI..".";
CT_RaidTracker_lang_ReceivesLootYou = "Вы";

CT_RaidTracker_ZoneTriggers = {
	["Molten Core"] = "Molten Core",
	["Blackwing Lair"] = "Blackwing Lair",
	["Zul'Gurub"] = "Zul'Gurub",
	["Onyxia's Lair"] = "Onyxia's Lair",
	["Ruins of Ahn'Qiraj"] = "Ahn'Qiraj Ruins",
	["Ahn'Qiraj"] = "Ahn'Qiraj Temple",
	["Naxxramas"] = "Naxxramas",
	["Ulduar"] = "Ulduar",
	-- TBC
	["Каражан"] = "Karazhan",
	["Gruul's Lair"] = "Gruul's Lair",
	["Magtheridon's Lair"] = "Magtheridon's Lair",
	["Serpentshrine Cavern"] = "Serpentshrine Cavern",
	["Caverns Of Time"] = "Caverns Of Time",
	["Черный храм"] = "Black Temple",
	["Tempest Keep"] = "Tempest Keep: The Eye",
	["Вершина Хиджала"] = "Battle of Mount Hyjal",
	["Zul'Aman"] = "Zul'Aman",
	["Плато Солнечного Колодца"] = "Sunwell Plateau",
	-- TBC
	["Trial of the Crusader"] = "Trial of the Crusader",
	["Trial of the Grand Crusader"] = "Trial of the Grand Crusader",

	-- TRANSLATIONS WELCOME
	["Icecrown Citadel"] = "Icecrown Citadel",
	["The Ruby Sanctum"] = "The Ruby Sanctum",
};

CT_RaidTracker_BossUnitTriggers = {
	["Lucifron"] = "Lucifron",
	["Magmadar"] = "Magmadar",
	["Gehennas"] = "Gehennas",
	["Garr"] = "Garr",
	["Baron Geddon"] = "Baron Geddon",
	["Shazzrah"] = "Shazzrah",
	["Sulfuron Harbinger"] = "Sulfuron Harbinger",
	["Golemagg the Incinerator"] = "Golemagg the Incinerator",
	["Majordomo Executus"] = "Majordomo Executus",
	["Ragnaros"] = "Ragnaros",
	["Core Hound"] = "IGNORE",
	["Firesworn"] = "IGNORE",
	["Core Rager"] = "IGNORE",
	["Flamewaker Healer"] = "IGNORE",
	["Flamewaker Elite"] = "IGNORE",
	["Son of Flame"] = "IGNORE",

	["Razorgore the Untamed"] = "Razorgore the Untamed",
	["Vaelastrasz the Corrupt"] = "Vaelastrasz the Corrupt",
	["Broodlord Lashlayer"] = "Broodlord Lashlayer",
	["Firemaw"] = "Firemaw",
	["Ebonroc"] = "Ebonroc",
	["Flamegor"] = "Flamegor",
	["Chromaggus"] = "Chromaggus",
	["Nefarian"] = "Nefarian",
	["Lord Victor Nefarius"] = "Nefarian",
	["Grethok the Controller"] = "IGNORE",
	["Blackwing Guardsman"] = "IGNORE",
	["Blackwing Legionnaire"] = "IGNORE",
	["Blackwing Mage"] = "IGNORE",
	["Death Talon Dragonspawn"] = "IGNORE",
	["Black Drakonid"] = "IGNORE",
	["Blue Drakonid"] = "IGNORE",
	["Bronze Drakonid"] = "IGNORE",
	["Green Drakonid"] = "IGNORE",
	["Red Drakonid"] = "IGNORE",
	["Chromatic Drakonid"] = "IGNORE",
	["Bone Construct"] = "IGNORE",
	["Corrupted Infernal"] = "IGNORE",
	["Corrupted Blue Whelp"] = "IGNORE",
	["Corrupted Red Whelp"] = "IGNORE",
	["Corrupted Green Whelp"] = "IGNORE",
	["Corrupted Bronze Whelp"] = "IGNORE",
	["Death Talon Hatcher"] = "IGNORE",
	["Blackwing Taskmaster"] = "IGNORE",

	["High Priestess Jeklik"] = "High Priestess Jeklik",
	["High Priest Venoxis"] =	"High Priest Venoxis",
	["High Priestess Mar'li"] =	"High Priestess Mar'li",
	["High Priest Thekal"] = "High Priest Thekal",
	["High Priestess Arlokk"] =	"High Priestess Arlokk",
	["Hakkar"] = "Hakkar",
	["Bloodlord Mandokir"] = "Bloodlord Mandokir",
	["Jin'do the Hexxer"] = "Jin'do the Hexxer",
	["Gahz'ranka"] = "Gahz'ranka",
	["Hazza'rah"] = "Hazza'rah",
	["Gri'lek"] = "Gri'lek",
	["Renataki"] = "Renataki",
	["Wushoolay"] = "Wushoolay",
	["Zulian Prowler"] = "IGNORE",
	["Zulian Guardian"] = "IGNORE",
	["Parasitic Serpent"] = "IGNORE",
	["Spawn of Mar'li"] = "IGNORE",
	["Ohgan"] = "IGNORE",
	["Frenzied Bloodseeker Bat"] = "IGNORE",
	["Poisonous Cloud"] = "IGNORE",

	["Onyxia"] = "Onyxia",
	["Lord Kazzak"] = "Lord Kazzak",
	["Azuregos"] = "Azuregos",
	["Ysondre"] = "Ysondre",
	["Taerar"] = "Taerar",
	["Emeriss"] = "Emeriss",
	["Lethon"] = "Lethon",

	["Onyxian Whelp"] = "IGNORE",
	["Onyxian Warder"] = "IGNORE",
	["Shade of Taerar"] = "IGNORE",
	["Spirit Shade"] = "IGNORE",
	["Demented Druid Spirit"] = "IGNORE",

	["Kurinnaxx"] = "Kurinnaxx",
	["General Rajaxx"] = "General Rajaxx",
	["Ayamiss the Hunter"] = "Ayamiss the Hunter",
	["Buru the Gorger"] = "Buru The Gorger",
	["Moam"] = "Moam",
	["Ossirian the Unscarred"] = "Ossirian The Unscarred",
	["Buru Egg"] = "IGNORE",
	["Canal Frenzy"] = "IGNORE",
	["Mana Fiend"] = "IGNORE",
	["Silicate Feeder"] = "IGNORE",
	["Hive'Zara Hatchling"] = "IGNORE",
	["Hive'Zara Larva"] = "IGNORE",
	["Vekniss Hatchling"] = "IGNORE",
	["Anubisath Warrior"] = "IGNORE",

	["The Prophet Skeram"] = "The Prophet Skeram",
	["Fankriss the Unyielding"] = "Fankriss the Unyielding",
	["Battleguard Sartura"] = "Battleguard Sartura",
	["Princess Huhuran"] = "Princess Huhuran",
	["Emperor Vek'lor"] = "Twin Emperors",
	["Emperor Vek'nilash"] = "Twin Emperors",
	["C'Thun"] = "C'Thun",
	["Vem"] = "Vem",
	["Princess Yauj"] = "Princess Yauj",
	["Lord Kri"] = "Lord Kri",
	["Viscidus"] = "Viscidus",
	["Ouro"] = "Ouro",
	["Ouro Scarab"] = "IGNORE",
	["Spawn of Fankriss"] = "IGNORE",
	["Qiraji Scorpion"] = "IGNORE",
	["Qiraji Scarab"] = "IGNORE",
	["Vile Scarab"] = "IGNORE",
	["Yauj Brood"] = "IGNORE",
	["Sartura's Royal Guard"] = "IGNORE",
	["Sartura's Royal Guard"] = "IGNORE",
	["Poison Cloud"] = "IGNORE",
	["Vekniss Drone"] = "IGNORE",
	["Glob of Viscidus"] = "IGNORE",

	["Patchwerk"] = "Patchwerk",
	["Grobbulus"] = "Grobbulus",
	["Gluth"] = "Gluth",
	["Thaddius"] = "Thaddius",
	["Instructor Razuvious"] = "Instructor Razuvious",
	["Gothik the Harvester"] = "Gothik the Harvester",
	["Highlord Mograine"] = "Highlord Mograine",
	["Thane Korth'azz"] = "Thane Korth'azz",
	["Lady Blaumeux"] = "Lady Blaumeux",
	["Sir Zeliek"] = "Sir Zeliek",
	["Noth the Plaguebringer"] = "Noth the Plaguebringer",
	["Heigan the Unclean"] = "Heigan the Unclean",
	["Loatheb"] = "Loatheb",
	["Anub'Rekhan"] = "Anub'Rekhan",
	["Grand Widow Faerlina"] = "Grand Widow Faerlina",
	["Maexxna"] = "Maexxna",
	["Sapphiron"] = "Sapphiron",
	["Kel'Thuzad"] = "Kel'Thuzad",

		["Fangnetz"] = "IGNORE",
		["Verstrahlter Br\195\188hschleimer"] = "IGNORE",

	["Crypt Guard"] = "IGNORE",
	["Grobbulus Cloud"] = "IGNORE",
	["Deathknight Understudy"] = "IGNORE",
	["Maggot"] = "IGNORE",
	["Maexxna Spiderling"] = "IGNORE",
	["Plagued Warrior"] = "IGNORE",
	["Zombie Chow"] = "IGNORE",
	["Corpse Scarab"] = "IGNORE",
	["Naxxramas Follower"] = "IGNORE",
	["Naxxramas Worshipper"] = "IGNORE",
	["Web Wrap"] = "IGNORE",
	["Fallout Slime"] = "IGNORE",
	["Diseased Maggot"] = "IGNORE",
	["Rotting Maggot"] = "IGNORE",
	["Living Poison"] = "IGNORE",
	["Spore"] = "IGNORE",

	["Spotlight"] = "IGNORE",
	["Roach"] = "IGNORE",
	["Snake"] = "IGNORE",
	["Brown Snake"] = "IGNORE",
	["Crimson Snake"] = "IGNORE",
	["Black Kingsnake"] = "IGNORE",
	["Beetle"] = "IGNORE",
	["Dupe Bug"] = "IGNORE",
	["Fire Beetle"] = "IGNORE",
	["Scorpion"] = "IGNORE",
	["Frog"] = "IGNORE",
	["Hooktooth Frenzy"] = "IGNORE",
	["Sacrificed Troll"] = "IGNORE",
	["Spider"] = "IGNORE",
	["Rat"] = "IGNORE",
	["Jungle Toad"] = "IGNORE",
	["Field Repair Bot 74A"] = "IGNORE",

	-- TBC
	--Karazhan
	["Каззак Владыка Рока"] = "Doom Lord Kazzak",
	["Владыка Рока"] = "Doomwalker",
	["Attumen the Huntsman"] = "Attumen the Huntsman",
	["Dorothee"] = "IGNORE",
	["Maiden of Virtue"] = "Maiden of Virtue",
	["Midnight"] = "IGNORE",
	["Moroes"] = "Moroes",
		["Baron Rafe Dreuger"] = "IGNORE", -- Moroes add
		["Baroness Dorothea Millstipe"] = "IGNORE", -- Moroes add
		["Lady Catriona Von'Indi"] = "IGNORE", -- Moroes add
		["Lady Keira Berrybuck"] = "IGNORE", -- Moroes add
		["Lord Crispin Ference"] = "IGNORE", -- Moroes add
		["Lord Robin Daris"] = "IGNORE", -- Moroes add
	["Netherspite"] = "Netherspite",
	["Nightbane"] = "Nightbane",
	["Prince Malchezaar"] = "Prince Malchezaar",
	["Shade of Aran"] = "Shade of Aran",
	["Strawman"] = "IGNORE",
	["Terestian Illhoof"] = "Terestian Illhoof",
	["Kil'rek"] = "IGNORE",
	["The Big Bad Wolf"] = "The Big Bad Wolf",
	["The Crone"] = "The Crone",
	["The Curator"] = "The Curator",
	["Tinhead"] = "IGNORE",
	["Tito"] = "IGNORE",
	["Rokad the Ravager"] = "Rokad the Ravager",
	["Hyakiss the Lurker"] = "Hyakiss the Lurker",
	["Shadikith the Glider"] = "Shadikith the Glider",
	["Chess Event"] = "Chess Event",
	["Julianne"] = "Romulo and Julianne",
	["Roar"] = "IGNORE",
	["Romulo"] = "IGNORE",
	["Echo of Medivh"] = "Echo of Medivh",
	["Image of Medivh"] = "Image of Medivh",
	-- Zul'Aman
	["Nalorakk"] = "Nalorakk",
	["Akil'Zon"] = "Akil'zon",
	["Jan'Alai"] = "Jan'alai",
	["Halazzi"] = "Halazzi",
	["Witch Doctor"] = "Witch Doctor",
	["Hex Lord Malacrass"] = "Hex Lord Malacrass",
	["Zul'jin"] = "Zul'jin",
	--Gruul
	["High King Maulgar"] = "High King Maulgar",
	["Gruul the Dragonkiller"] = "Gruul the Dragonkiller",
	["Blindeye the Seer"] = "IGNORE",
	["Kiggler the Crazed"] = "IGNORE",
	["Krosh Firehand"] = "IGNORE",
	["Olm the Summoner"] = "IGNORE",
	-- Magtheridon
	["Magtheridon"] = "Magtheridon",
	["Hellfire Warder"] = "IGNORE",
	["Hellfire Channeler"] = "IGNORE",
	--Serpentshrine Cavern
	["Hydross the Unstable"] = "Hydross the Unstable",
	["The Lurker Below"] = 		"The Lurker Below",
	["Leotheras the Blind"] = "Leotheras the Blind",
	["Fathom-Lord Karathress"] = "Fathom-Lord Karathress",
	["Morogrim Tidewalker"] = "Morogrim Tidewalker",
	["Lady Vashj"] = "Lady Vashj",
		-- Bossadds
			-- Hydross Adds
      ["Pure Spawn of Hydross"] = "IGNORE", -- Pure Spawn of Hydross
      ["Tainted Spawn of Hydross"] = "IGNORE", -- Tainted Spawn of Hydross
      ["Tainted Water Elemental"] = "IGNORE", -- Tainted Water Elemental
      ["Purified Water Elemental"] = "IGNORE", -- Purified Water Elemental

      -- Morogrim Adds
      ["Tidewalker Lurker"] = "IGNORE", -- Tidewalker Lurker
      ["Water Globule"] = "IGNORE", -- Water Globule (Waterbubbles Tidewalker summons at 25%)

			-- Fathom-Lord Karathress Adds
			["Spitfire Totem"] = "IGNORE", -- Spitfire Totem
			["Greater Earthbind Totem"] = "IGNORE", -- Greater Earthbind Totem
			["Greater Poison Cleansing Totem"] = "IGNORE", -- Greater Poison Cleansing Totem
			["Fathom Lurker"] = "IGNORE", -- Fathom Lurker
			["Fathom Sporebat"] = "IGNORE", -- Fathom Sporebat
			["Fathom-Guard Caribdis"] = "IGNORE", -- Fathom-Guard Caribdis
			["Fathom-Guard Tidalvess"] = "IGNORE", -- Fathom-Guard Tidalvess
			["Fathom-Guard Sharkkis"] = "IGNORE", -- Fathom-Guard Sharkkis

			-- The Lurker Below Adds
			["Coilfang Guardian"] = "IGNORE", -- Coilfang Guardian
			["Coilfang Ambusher"] = "IGNORE", -- Coilfang Ambusher

			-- Leotheras the Blind Adds
			["Inner Demon"] = "IGNORE", -- Inner Demon

      -- Vashj Adds
      ["Toxic Spore Bat"] = "IGNORE",  -- Toxic Spore Bat
      ["Tainted Elemental"] = "IGNORE", -- Tainted Elemental
      ["Coilfang Elite"] = "IGNORE", -- Coilfang Elite
      ["Coilfang Strider"] = "IGNORE", -- Coilfang Strider
      ["Enchanted Elemental"] = "IGNORE", -- Enchanted Elemental
      -- SSC Trashmobs
      ["Coilfang Beast-Tamer"] = "IGNORE",	-- Coilfang Beast-Tamer
      ["Vashj'ir Honor Guard"] = "IGNORE",	-- Vashj'ir Honor Guard
      ["Greyheart Tidecaller"] = "IGNORE", -- Greyheart Tidecaller
      ["Tidewalker Harpooner"] = "IGNORE", -- Tidewalker Harpooner
      ["Coilfang Hate-Screamer"] = "IGNORE", -- Coilfang Hate-Screamer
      ["Tidewalker Warrior"] = "IGNORE", -- Tidewalker Warrior
      ["Serpentshrine Lurker"] = "IGNORE", -- Serpentshrine Lurker
      ["Greyheart Nether-Mage"] = "IGNORE", -- Greyheart Nether-Mage
      ["Coilfang Priestess"] = "IGNORE", -- Coilfang Priestess
      ["Tidewalker Shaman"] = "IGNORE", -- Tidewalker Shaman
      ["Greyheart Shield-Bearer"] = "IGNORE", -- Greyheart Shield-Bearer
      ["Coilfang Serpentguard"] = "IGNORE", -- Coilfang Serpentguard
      ["Greyheart Skulker"] = "IGNORE", -- Greyheart Skulker
      ["Serpentshrine Sporebat"] = "IGNORE", -- Serpentshrine Sporebat
      ["Greyheart Technician"] = "IGNORE", -- Greyheart Technician
      ["Coilfang Fathom-Witch"] = "IGNORE", -- Coilfang Fathom-Witch
      ["Tidewalker Depth-Seer"] = "IGNORE", -- Tidewalker Depth-Seer
      ["Underbog Colossus"] = "IGNORE", -- Underbog Colossus
      ["Tidewalker Hydromancer"] = "IGNORE", -- Tidewalker Hydromancer
      ["Coilfang Shatterer"] = "IGNORE", -- Coilfang Shatterer
      -- SSC Trashmobs without loot
			["Coilfang Frenzy"] = "IGNORE", -- Coilfang Frenzy
			["Serpentshrine Tidecaller"] = "IGNORE", -- Serpentshrine Tidecaller
			["Colossus Lurker"] = "IGNORE", -- Colossus Lurker
			["Colossus Rager"] = "IGNORE", -- Colossus Rager
			["Serpentshrine Parasite"] = "IGNORE", -- Serpentshrine Parasite
			["Underbog Mushroom"] = "IGNORE", -- Underbog Mushroom
			["Water Elemental Totem"] = "IGNORE", -- Water Elemental Totem
			["Greyheart Spellbinder"] = "IGNORE", -- Greyheart Spellbinder
			["Priestess Spirit"] = "IGNORE", -- Priestess Spirit
	--Black Temple
	["Великий полководец Наджентус"] = "High Warlord Naj'entus",
	["Супремус"] = "Supremus",
	["Гуртогг Кипящая Кровь"] = "Gurtogg Bloodboil",
	["Терон Жестокосердный"] = "Teron Gorefiend",
	["Тень Акамы"] = "Shade of Akama",
	["Сущность гнева"] = "Reliquary of Souls",
	["Матушка Шахраз"] = "Mother Shahraz",
	 ["Гатиос Раскольщик"] = "Illidari Council",
	 ["Верховный хаомант Зеревор"] = "Illidari Council",
	 ["Леди Маланда"] = "Illidari Council",
	 ["Верас Черная Тень"] = "Illidari Council",
	["Иллидан Грозовая Ярость"] = "Illidan Stormrage",
	--Tempest Keep: The Eye
	["Al'ar"] = "Al'ar",
	["High Astromancer Solarian"] = "High Astromancer Solarian",
	["Void Reaver"] = "Void Reaver",
	["Kael'thas Sunstrider"] = "Kael'thas Sunstrider",
    -- Bossadds
	-- Al'ar Adds
    ["Ember of Al'ar"] = "IGNORE", -- Ember of Al'ar
    -- Astromancer Adds
    ["Solarium Agent"] = "IGNORE", -- Solarium Agent
    ["Solarium Priest"] = "IGNORE", -- Solarium Priest
    -- Kael'thas Adds
    ["Lord Sanguinar"] = "IGNORE", -- Lord Sanguinar
    ["Grand Astromancer Capernian"] = "IGNORE", -- Grand Astromancer Capernian
    ["Master Engineer Telonicus"] = "IGNORE", -- Master Engineer Telonicus
    ["Phoenix Egg"] = "IGNORE", -- Phoenix Egg
    ["Phoenix"] = "IGNORE", -- Phoenix
    ["Thaladred the Darkener"] = "IGNORE", -- Thaladred the Darkener
    -- Kael'thas Weapons
    ["Infinity Blades"] = "IGNORE", -- Infinity Blades
    ["Cosmic Infuser"] = "IGNORE", -- Cosmic Infuser
    ["Netherstrand Longbow"] = "IGNORE", -- Netherstrand Longbow
    ["Phaseshift Bulwark"] = "IGNORE", -- Phaseshift Bulwark
    ["Staff of Disintegration"] = "IGNORE", -- Staff of Disintegration
    ["Devastation"] = "IGNORE", -- Devastation
    ["Warp Slicer"] = "IGNORE", -- Warp Slicer
		-- TK Trash
		["Astromancer"] = "IGNORE", -- Astromancer
		["Astromancer Lord"] = "IGNORE", -- Astromancer Lord
		["Novice Astromancer"] = "IGNORE", -- Novice Astromancer
		["Crimson Hand Blood Knight"] = "IGNORE", -- Crimson Hand Blood Knight
		["Tempest Falconer"] = "IGNORE", -- Tempest Falconer
		["Crimson Hand Inquisitor"] = "IGNORE", -- Crimson Hand Inquisitor
		["Crimson Hand Battle Mage"] = "IGNORE", -- Crimson Hand Battle Mage
		["Bloodwarder Squir"] = "IGNORE", -- Bloodwarder Squire
		["Crystalcore Mechanic"] = "IGNORE", -- Crystalcore Mechanic
		["Crystalcore Sentinel"] = "IGNORE", -- Crystalcore Sentinel
		["Crystalcore Devastator"] = "IGNORE", -- Crystalcore Devastator
		["Bloodwarder Legionnaire"] = "IGNORE", -- Bloodwarder Legionnaire
		["Bloodwarder Marshal"] = "IGNORE", -- Bloodwarder Marshal
		["Nether Scryer"] = "IGNORE", -- Nether Scryer
		["Phoenix-Hawk Hatchlings"] = "IGNORE", -- Phoenix-Hawk Hatchling
		["Phoenix-Hawk"] = "IGNORE", -- Phoenix-Hawk
		["Tempest-Smith"] = "IGNORE", -- Tempest-Smith
		["Star Scryer"] = "IGNORE", -- Star Scryer
		["Apprentice Star Scryer"] = "IGNORE", -- Apprentice Star Scryer
		["Bloodwarder Vindicator"] = "IGNORE", -- Bloodwarder Vindicator
		["Crimson Hand Centurion"] = "IGNORE", -- Crimson Hand Centurion

	["Lord Illidan Stormrage"] = "Lord Illidan Stormrage",
	["Highlord Kruul"] = "Highlord Kruul",

	--Battle of Mount Hyjal
	["Лютый Хлад"] = "Rage Winterchill",
	["Анетерон"] = "Anetheron",
	["Каз'рогал"] = "Kaz'rogal",
	["Азгалор"] = "Azgalor",
	["Архимонд"] = "Archimonde",

  --Sunwell Plateau
	["Калецгос"] =  "IGNORE", -- Kalecgos
		["Сатроварр Осквернитель"] = "Sathrovarr the Corruptor",
		["Сатроварр Осквернитель"] = "Kalecgos",
	["Бруталл"] = "Brutallus",
		["Madrigosa"] = "IGNORE", -- Madrigosa
	["Сквернотуман"] = "Felmyst",
	["Lady Sacrolash"] = "Eredar Twins",
	["Grand Warlock Alythess"] = "Eredar Twins",
	["Энтропий"] = "Entropius",
	["Kil'jaeden"] = "Kil'jaeden",
	["М'ару"] = "IGNORE",
	["Shadowsword Berserker"] = "IGNORE", -- Shadowsword Berserker
	["Shadowsword Fury Mage"] = "IGNORE", -- Shadowsword Fury Mage
	["Void Sentinel"] = "IGNORE", -- Void Sentinel
	["Void Spawn"] = "IGNORE", -- Void Spawn
	-- TBC
	-- icecrown citadel : TRANSLATIONS WELCOME!
	["Lord Marrowgar"] = "Lord Marrowgar",
	["Lady Deathwhisper"] = "Lady Deathwhisper",
	["Gunship Battle"] = "Gunship Battle", -- this will likely require work on the emotes
	["Deathbringer Saurfang"] = "Deathbringer Saurfang",
	["Rotface"] = "Rotface",
	["Festergut"] = "Festergut",
	["Professor Putricide"] = "Professor Putricide",
	["Blood Princes"] = "Blood Princes",
	["Blood-Queen Lana'thel"] = "Blood-Queen Lana'thel",
	["Valithria Dreamwalker"] = "Valithria Dreamwalker",
	["Sindragosa"] = "Sindragosa",
	["The Lich King"] = "The Lich King", -- may still need to work on unit name
	-- end icecrown citadel
	-- Ruby Sanctum
	["General Zarithrian"] = "General Zarithrian",
	["Baltharus the Warborn"] = "Baltharus the Warborn",
	["Saviana Ragefire"] = "Saviana Ragefire", -- this will likely require work on the emotes
	["Halion"] = "Halion",
	-- End Ruby Sanctum
	["DEFAULTBOSS"] = "Trash mob",
};
-- ulduar yells
CT_RaidTracker_lang_bossKills_Mimiron_Yell = "It would appear that I've made a slight miscalculation. I allowed my mind to be corrupted by the fiend in the prison, overriding my primary directive. All systems seem to be functional now. Clear.";
CT_RaidTracker_lang_bossKills_Mimiron_BossName = "Mimiron";

CT_RaidTracker_lang_bossKills_Thorim_Yell_1 = "I feel as though I am awakening from a nightmare, but the shadows in this place yet linger."
CT_RaidTracker_lang_bossKills_Thorim_Yell_2 = "Sif...was Sif here? Impossible! She died by my brother's hand. A dark nightmare indeed."
CT_RaidTracker_lang_bossKills_Thorim_Yell_3 = "I need time to reflect. I will aid your cause if you should require it. I owe you at least that much. Farewell."
CT_RaidTracker_lang_bossKills_Thorim_Yell_h1 = "You! Fiend! You are not my beloved! Be gone!"
CT_RaidTracker_lang_bossKills_Thorim_Yell_h2 = "Behold the hand behind all the evil that has befallen Ulduar! Left my kingdom in ruins, corrupted my brother and slain my wife!"
CT_RaidTracker_lang_bossKills_Thorim_Yell_h3 = "And now it falls to you, champions, to avenge us all! The task before you is great, but I will lend you my aid as I am able. You must prevail!"
CT_RaidTracker_lang_bossKills_Thorim_BossName = "Thorim";
CT_RaidTracker_lang_bossKills_Hodir_Yell = "I... I am released from his grasp... at last.";
CT_RaidTracker_lang_bossKills_Hodir_BossName = "Hodir";
CT_RaidTracker_lang_bossKills_Freya_Yell = "His hold on me dissipates. I can see clearly once more. Thank you, heroes."
CT_RaidTracker_lang_bossKills_Freya_BossName = "Freya";
-- Iron Council / Assmebly of Iron
CT_RaidTracker_lang_bossKills_Assembly_of_Iron_Yell_1 = "Impossible..." -- hardmode or steelbreaker last
CT_RaidTracker_lang_bossKills_Assembly_of_Iron_Yell_2 = "You rush headlong into the maw of madness!" -- brundir last
CT_RaidTracker_lang_bossKills_Assembly_of_Iron_Yell_3 = "What have you gained from my defeat? You are no less doomed, mortals!" -- molegeim last
CT_RaidTracker_lang_bossKills_Assembly_of_Iron_Yell_BossName = "The Assembly of Iron"
-- Trial of the * Crusader
CT_RaidTracker_lang_bossKills_TwinValkyr = "The Scourge cannot be stopped..."
CT_RaidTracker_lang_bossKills_TwinValkyr_BossName = "Twin Val'kyr"
CT_RaidTracker_lang_bossKills_Anubarak = "I have failed you, master..."
CT_RaidTracker_lang_bossKills_Anubarak_BossName = "Anub'arak"
-- FACTION CHAMPIONS - WORKING ON THIS ONE
CT_RaidTracker_lang_bossKills_FactionChampsAlliance = "GLORY TO THE ALLIANCE"
CT_RaidTracker_lang_bossKills_FactionChampsAlliance_BossName = "Faction Champions"
CT_RaidTracker_lang_bossKills_FactionChampsHorde = "That was just a taste of what the future brings. FOR THE HORDE!"
CT_RaidTracker_lang_bossKills_FactionChampsHorde_BossName = "Faction Champions"
CT_RaidTracker_lang_bossKills_FactionChamps = "A shallow and tragic victory. We are weaker as a whole from the losses suffered today. Who but the Lich King could benefit from such foolishness? Great warriors have lost their lives. And for what? The true threat looms ahead - the Lich King awaits us all in death."
CT_RaidTracker_lang_bossKills_FactionChamps_BossName = "Faction Champions"
-- End Trial of the * Crusader
-- other yells
CT_RaidTracker_lang_BossKills_Majordomo_Yell = "Impossible! Stay your attack, mortals... I submit! I submit!";
CT_RaidTracker_lang_BossKills_Majordomo_BossName = "Majordomo Executus";
CT_RaidTracker_lang_BossKills_Ignore_Razorgore_Yell = "I'm free!  That device shall never torment me again!";
CT_RaidTracker_lang_BossKills_Chess_Event_Yell = "Als sich der Fluch, der auf den T\195\188ren der Halle der Spiele lastete, l\195\182st, beginnen die Mauern von Karazhan zu beben."; -- need english translation
CT_RaidTracker_lang_BossKills_Chess_Event_BossName = "Chess Event";
--
CT_RaidTracker_lang_BossKills_Julianne_Die_Yell = "O happy dagger! This is thy sheath; there rust, and let me die!";
CT_RaidTracker_lang_BossKills_Julianne_BossName = "Julianne";
CT_RaidTracker_lang_BossKills_Sathrovarr_Yell = "I'm... never on... the losing... side...";
CT_RaidTracker_lang_BossKills_Sathrovarr_BossName = "Sathrovarr the Corruptor";

end
