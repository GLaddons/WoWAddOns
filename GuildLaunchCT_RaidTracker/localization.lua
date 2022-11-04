-- Version 1570
--CT_ITEMREG = "(|c%x+|Hitem:%d+:%d+:%d+:%d+:%d+:%d+:(%-?%d+):(%-?%d+):%d+|h%[.-%]|h|r)%";
--CT_ITEMREG_MULTI = "(|c%x+|Hitem:%d+:%d+:%d+:%d+:%d+:%d+:(%-?%d+):(%-?%d+):%d+|h%[.-%]|h|r)x(%d+)%";
CT_ITEMREG = "(|c(%x+)|Hitem:([-%d:]+)|h%[(.-)%]|h|r)%";
CT_ITEMREG_MULTI = "(|c(%x+)|Hitem:([-%d:]+)|h%[(.-)%]|h|r)x(%d+)%";
CT_PLAYER_FACTION, localizedPlayerFaction = UnitFactionGroup("player")

CT_RaidTracker_Zones = {
	"---Shadowlands---",
	"Castle Nathria",
	"Sanctum of Domination",
	"Sepulcher of the First Ones",
	"---BfA---",
	"Uldir, Halls of Control",
	"Battle of Dazar'alor",
	"Crucible of Storms",
	"Azshara's Eternal Palace",
	"Ny'alotha, the Waking City",
	"---Legion---",
	"The Emerald Nightmare",
	"Trial of Valor",
	"The Nighthold",
	"Tomb of Sargeras",
	"Antorus, the Burning Throne",
	"----WoD----",
	"Highmaul",
	"Blackrock Foundry",
	"Hellfire Citadel",
	"----MoP----",
	"Siege of Orgrimmar",
	"Throne of Thunder",
	"Mogu'shan Vaults",
	"Terrace of Endless Spring",
	"Heart of Fear",
	"----Cata----",
	"Dragon Soul",
	"Firelands",
	"The Bastion of Twilight",
	"Throne of the Four Winds",
	"Blackwing Descent",
	"Baradin Hold",
	"----WotLK----",
	"Battle of Mount Hyjal",
	"Ragefire Chasm"
};

CT_RaidTracker_Bosses = {
	--Shadowlands
	["Castle Nathria"] = {
		"Shriekwing",
		"Altimor the Huntsman",
		"Hungering Destroyer",
		"Artificer Xymox",
		"Sun Kings Salvation",
		"Lady Inerva Darkvein",
		"The Council of Blood",
		"Sludgefist",
		"Stone Legion Generals",
		"Sire Denathrius"
	},
	["Sanctum of Domination"] = {
		"The Tarragrue",
		"Eye of the Jailer",
		"The Nine",
		"Remnant of Ner'zhul",
		"Soulrender Dormazain",
		"Painsmith Raznal",
		"Guardian of the First Ones",
		"Fatescribe Roh-Kalo",
		"Kel'Thuzad",
		"Sylvanas Windrunner"
	},
	["Sepulcher of the First Ones"] = {
		"Vigilant Guardian",
		"Skolex, the Insatiable Ravener",
		"Artificer Xy'mox",
		"Dausegne, the Fallen Oracle",
		"Prototype Pantheon",
		"Lihuvim, Principal Architech",
		"Halondrus the Reclaimer",
		"Anduin Wrynn",
		"Lords of Dread",
		"Rygelon",
		"The Jailer, Zovaal"
	},
	--BFA
		--8.0.-
	["Uldir, Halls of Control"] = {
		"Taloc the Corrupted",
		"MOTHER",
		"Fetid Devourer",
		"Zek'voz, Herald of N'zoth",
		"Vectis",
		"Zul, Reborn",
		"Mythrax the Unraveler",
		"G'huun"
	},
	["Battle of Dazar'alor"] = {
		"Champions of the Light", -- ra'wani kanae alliance  -- frida ironbellows horde
		"Grong", -- grong the revenant alliance -- grong horde
		"Jadefire Masters", -- anathos firecaller alliance -- Manceroy Flamefist horde
		"Opulence",
		"Conclave of the Chosen",
		"King Rastakhan",
		"High Tinker Mekkatorque",
		"Stormwall Blockade",
		"Lady Jaina Proudmoore"
	},
	["Crucible of Storms"] = {
		"Restless Cabal",
		"Uu'nat, Harbinger of the Void"
	},
	["Azshara's Eternal Palace"] = {
		"Commander Sivara",
		"Blackwater Behemoth",
		"Radiance of Azshara",
		"Lady Ashvane",
		"Orgozoa",
		"The Queen's Court",
		"Za'qul",
		"Queen Azshara"
	},
	["Ny'alotha, the Waking City"] = {
		"Wrathion",
		"Maut",
		"Prophet Skitra",
		"Dark Inquisitor Xanesh",
		"Vexiona",
		"The Hivemind",
		"Ra-den",
		"Shad'har the Insatiable",
		"Drest'agath",
		"Il'gynoth",
		"Carapace of N'Zoth",
		"N'Zoth"
	},
	--Legion
		--7.0.3
	["The Emerald Nightmare"] = {
		"Nythendra",
		"Il'gynoth, Heart of Corruption",
		"Elerethe Renferal",
		"Ursoc",
		"Dragons of Nightmare",
		"Cenarius",
		"Xavius"
	},
	["Trial of Valor"] = {
		"Odyn",
		"Guarm",
		"Helya"
	},
	["The Nighthold"] = {
		"Skorpyron",
		"Chronomatic Anomaly",
		"Trilliax",
		"Spellblade Aluriel",
		"Tichondrius",
		"Krosus",
		"High Botanist Tel'arn",
		"Star Augur Etraeus",
		"Grand Magistrix Elisande",
		"Gul'dan"
	},
	["Tomb of Sargeras"] = {
		"Goroth",
		"Demonic Inquisition",
		"Harjatan",
		"Sisters of the Moon",
		"Mistress Sassz'ine",
		"The Desolate Host",
		"Maiden of Vigilance",
		"Fallen Avatar",
		"Kil'jaeden"
	},
	["Antorus, the Burning Throne"] = {
		"Garothi Worldbreaker",
		"Felhounds of Sargeras",
		"War Council",
		"Portal Keeper Hasabel",
		"Eonar, the Lifebinder",
		"Imonar the Soulhunter",
		"Kin'garoth",
		"Varimathras",
		"The Coven of Shivarra",
		"Aggramar",
		"Argus the Unmaker"
	},
	--WoD
		--6.0.3
	["Highmaul"] = {
		"Kargath Bladefist",
		"The Butcher",
		"Tectus",
		"Brackenspore",
		"Twin Ogron",
		"Ko'ragh",
		"Imperator Mar'gok"
	},
	["Blackrock Foundry"] = {
		"Gruul",
		"Oregorger",
		"Beastlord Darmac",
		"Flamebender Ka'graz",
	    "Hans'gar and Franzok",
		"Operator Thogar",
		"The Blast Furnace",
		"Kromog",
		"The Iron Maidens",
		"Blackhand"
	},
	['Hellfire Citadel'] = {
		"Gorefiend",
		"Fel Lord Zakuun",
		"Kormrok",
		"Tyrant Velhari",
		"Mannoroth",
		"Kilrogg Deadeye",
		"Iron Reaver",
		"Hellfire Assault",
		"Socrethar the Eternal",
		"Hellfire High Council",
		"Shadow-Lord Iskar",
		"Archimonde",
		"Xhul'horac",
	},
	-- MoP
		-- 5.4
    ["Siege of Orgrimmar"] = {
		"Immerseus",
		"The Fallen Protectors",
		"Norushen",
		"Sha of Pride",
		"Galakras",
		"Iron Juggernaut",
	    "Kor'kron Dark Shaman",
		"General Nazgrim",
		"Malkorok",
		"Spoils of Pandaria",
		"Thok the Bloodthirsty",
		"Siegecrafter Blackfuse",
	    "Paragons of the Klaxxi",
	    "Garrosh Hellscream",
	},
    	-- 5.2
    ["Throne of Thunder"] = {
		"Jin'rokh the Breaker",
		"Horridon",
		"Council of Elders",
		"Tortos",
		"Megaera",
		"Ji-Kun",
	        "Durumu the Forgotten",
		"Primordius",
		"Dark Animus",
		"Iron Qon",
		"Twin Consorts",
		"Lei Shen",
	        "Ra-den",
	},
	["Mogu'shan Vaults"] = {
		"The Stone Guard",
		"Feng the Accursed",
		"Gara'jal the Spiritbinder",
		"The Spirit Kings",
		"Elegon",
		"Will of the Emperor",
	},
	["Terrace of Endless Spring"] = {
		"Protectors of the Endless",
		"Tsulong",
		"Lei Shi",
		"Sha of Fear",
	},
	["Heart of Fear"] = {
		"Imperial Vizier Zor'lok",
		"Blade Lord Ta'yak",
		"Garalon",
		"Wind Lord Mel'jarak",
		"Amber-Shaper Un'sok",
		"Grand Empress Shek'zeer",
	},
    -- WOTLK
	["Battle of Mount Hyjal"] = {
		"",
	},
	["Baradin Hold"] = {
		"Argaloth",
		"Occu’thar",
	},
	["Blackwing Descent"] = {
		"Magmaw",
		"Omnotron Defense System",
		"Omnotron",
		"Maloriak",
		"Atramedes",
		"Chimaeron",
		"Nefarian",
	},
	["Throne of the Four Winds"] = {
		"Conclave of Wind",
		"Al'Akir",
	},
	["The Bastion of Twilight"] = {
		"Valiona and Theralion",
		"Halfus Wyrmbreaker",
		"Ascendant Council",
		"Cho'gall",
	},
	["Firelands"] = {
		"Beth'tilac",
		"Lord Rhyolith",
		"Alysrazor",
		"Shannox",
		"Baleroc",
		"Majordomo Staghelm",
		"Ragnaros",
	},
	["Dragon Soul"] = {
		"Morchok",
		"Warlord Zon'ozz",
		"Yor'sahj the Unsleeping",
		"Hagara the Stormbinder",
		"Ultraxion",
		"Warmaster Blackhorn",
		"Spine of Deathwing",
		"Madness of Deathwing",
	},
    -- TEST
	["Ragefire Chasm"] = {
  		"Adarogg",
        "Dark Shaman Koranthal",
  		"Slagmaw",
  		"Lava Guard Gordoth",
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
CT_RaidTracker_lang_ReceivesLoot5 = "([^%s]+) receives bonus loot: "..CT_ITEMREG..".";
CT_RaidTracker_lang_ReceivesLoot6 = "You receive bonus loot: "..CT_ITEMREG..".";
CT_RaidTracker_lang_ReceivesLootYou = "You";

CT_RaidTracker_ZoneTriggers = {
	--Shadowlands
	["Castle Nathria"]				= "Castle Nathria",
	["Sanctum of Domination"]		= "Sanctum of Domination",
	["Sepulcher of the First Ones"] = "Sepulcher of the First Ones",
	--BFA
	["Uldir, Halls of Control"]		= "Uldir, Halls of Control",
	["Battle of Dazar'alor"] 		= "Battle of Dazar'alor",
	["Crucible of Storms"]			= "Crucible of Storms",
	["Azshara's Eternal Palace"]	= "Azshara's Eternal Palace",
	["Ny'alotha, the Waking City"]  = "Ny'alotha, the Waking City",
	-- Legion
	["The Emerald Nightmare"]		= "The Emerald Nightmare",
	["Halls of Valor"]				= "Trial of Valor",
	["The Nighthold"]				= "The Nighthold",
	["Tomb of Sargeras"]			= "Tomb of Sargeras",
	["Antorus, the Burning Throne"] = "Antorus, the Burning Throne",
	-- WoD
	["Highmaul"] 					= "Highmaul",
	["Blackrock Foundry"] 			= "Blackrock Foundry",
	["Hellfire Citadel"]			= "Hellfire Citadel",
	-- MoP
	["Siege of Orgrimmar"]			= "Siege of Orgrimmar",
    ["Throne of Thunder"] 			= "Throne of Thunder",
	["Mogu'shan Vaults"] 			= "Mogu'shan Vaults",
	["Terrace of Endless Spring"] 	= "Terrace of Endless Spring",
	["Heart of Fear"] 				= "Heart of Fear",
	-- WOTLK
	["Battle of Mount Hyjal"] 		= "Battle of Mount Hyjal",
	["Baradin Hold"] 				= "Baradin Hold",
	["Blackwing Descent"] 			= "Blackwing Descent",
	["Throne of the Four Winds"] 	= "Throne of the Four Winds",
	["The Bastion of Twilight"] 	= "The Bastion of Twilight",
	["Firelands"] 					= "Firelands",
	["Dragon Soul"]					= "Dragon Soul",
	-- TEST
    ["Ragefire Chasm"] 				= "Ragefire Chasm",
    ["The Stockade"]				= "The Stockade",
};

	if (CT_PLAYER_FACTION == 'Horde') then
		CT_DAZAR_CHAMPS = "Frida Ironbellows";
		CT_DAZAR_GRONG = "Grong";
		CT_DAZAR_JADEFIRE = "Manceroy Flamefist";
	elseif (CT_PLAYER_FACTION == 'Alliance') then
		CT_DAZAR_CHAMPS = "Ra'wani Kanae";
		CT_DAZAR_GRONG = "Grong the Revenant";
		CT_DAZAR_JADEFIRE = "Anathos Firecaller";
	end

CT_RaidTracker_BossUnitTriggers = {
	--Shadowlands
	--Castle Nathria
	["Shriekwing"] = "Shriekwing",
	["Huntsman Altimor"] = "Altimor the Huntsman",
	["Hungering Destroyer"] = "Hungering Destroyer",
	["Artificer Xymox"] = "Artificer Xymox",
	["Sun Kings Salvation"] = "Sun Kings Salvation",
	["Lady Inerva Darkvein"] = "Lady Inerva Darkvein",
	["The Council of Blood"] = "The Council of Blood",
	["Sludgefist"] = "Sludgefist",
	["Stone Legion Generals"] = "Stone Legion Generals",
	["Sire Denathrius"] = "Sire Denathrius",
	--Sanctum of Domination
	["The Tarragrue"] = "The Tarragrue",
	["Eye of the Jailer"] = "Eye of the Jailer",
	["Skyja"] = "The Nine",
	["Remnant of Ner'zhul"] = "Remnant of Ner'zhul",
	["Soulrender Dormazain"] = "Soulrender Dormazain",
	["Painsmith Raznal"] = "Painsmith Raznal",
	["Guardian of the First Ones"] = "Guardian of the First Ones",
	["Fatescribe Roh-Kalo"] = "Fatescribe Roh-Kalo",
	["Kel'Thuzad"] = "Kel'Thuzad",
	["Sylvanas Windrunner"] = "Sylvanas Windrunner",
	--Sepulcher of the First Ones
	["Vigilant Guardian"] = "Vigilant Guardian",
	["Skolex"] = "Skolex, the Insatiable Ravener",
	["Artificer Xy'mox"] = "Artificer Xy'mox",
	["Dausegne"] = "Dausegne, the Fallen Oracle",
	["Prototype Pantheon"] = "Prototype Pantheon",
	["Lihuvim"] = "Lihuvim, Principal Architech",
	["Halondrus the Reclaimer"] = "Halondrus the Reclaimer",
	["Anduin Wrynn"] = "Anduin Wrynn",
	["Lords of Dread"] = "Lords of Dread",
	["Rygelon"] = "Rygelon",
	["The Jailer"] = "The Jailer, Zovaal",
	--Uldir, Halls of Control
	["Taloc"] = "Taloc the Corrupted",
	["MOTHER"] = "MOTHER",
	["Fetid Devourer"] = "Fetid Devourer",
	["Zek'voz"] = "Zek'voz, Herald of N'zoth",
	["Vectis"] = "Vectis",
	["Zul"] = "Zul, Reborn",
	["Mythrax the Unraveler"] = "Mythrax the Unraveler",
	["G'huun"] = "G'huun",
	--Battle of Dazar'alor
	[CT_DAZAR_CHAMPS] = "Champions of the Light",
	[CT_DAZAR_GRONG] = "Grong",
	[CT_DAZAR_JADEFIRE] = "Jadefire Masters",
	["Opulence"] = "Opulence",
	["Akunda's Aspect"] = "Conclave of the Chosen",
	["King Rastakhan"] = "King Rastakhan",
	["High Tinker Mekkatorque"] = "High Tinker Mekkatorque",
	["Laminaria"] = "Stormwall Blockade",
	["Lady Jaina Proudmoore"] = "Lady Jaina Proudmoore",
	--Crucible of Storms
	["Fa'thuul the Feared"] = "Restless Cabal",
	["Uu'nat"] = "Uu'nat, Harbinger of the Void",
	--Azshara's Eternal Palace
	["Abyssal Commander Sivara"] = "Commander Sivara",
	["Blackwater Behemoth"] = "Blackwater Behemoth",
	["Radiance of Azshara"] = "Radiance of Azshara",
	["Lady Ashvane"] = "Lady Ashvane",
	["Orgozoa"] = "Orgozoa",
	["Silivaz the Zealous"] = "The Queen's Court",
	["Za'qul"] = "Za'qul",
	["Queen Azshara"] = "Queen Azshara",
	--Ny'alotha, the Waking City
	["Wrathion"] = "Wrathion",
	["Maut"] = "Maut",
	["Prophet Skitra"] = "Prophet Skitra", -- yell not working
	["Dark Inquisitor Xanesh"] = "Dark Inquisitor Xanesh",
	["Vexiona"] = "Vexiona",
	["Tek'ris"] = "The Hivemind",
	["Ra-den"] = "Ra-den",
	["Shad'har the Insatiable"] = "Shad'har the Insatiable",
	["Drest'agath"] = "Drest'agath",
	["Il'gynoth"] = "Il'gynoth",
	["Fury of N'Zoth"] = "Carapace of N'Zoth",
	["N'Zoth the Corruptor"] = "N'Zoth", --need yell
	-- The Emerald Nightmare
	["Nythendra"] = "Nythendra",
	["Il'gynoth"] = "Il'gynoth, Heart of Corruption",
	["Elerethe Renferal"] = "Elerethe Renferal",
	["Ursoc"] = "Ursoc",
	["Ysondre"] = "Dragons of Nightmare",
	["Cenarius"] = "Cenarius",
	["Xavius"] = "Xavius",
	-- Trial of Valor
	["Odyn"] = "Odyn",
	["Guarm"] = "Guarm",
	["Helya"] = "Helya",
	-- The Nighthold
	["Skorpyron"] = "Skorpyron",
	["Chronomatic Anomaly"] = "Chronomatic Anomaly",
	["Trilliax"] = "Trilliax",
	["Spellblade Aluriel"] = "Spellblade Aluriel",
	["Tichondrius"] = "Tichondrius",
	["Krosus"] = "Krosus",
	["Arcanist Tel'arn"] = "High Botanist Tel'arn",
	["Star Augur Etraeus"] = "Star Augur Etraeus",
	["Elisande"] = "Grand Magistrix Elisande",
	["Gul'dan"] = "Gul'dan",
	--Tomb of Sargeras
	["Goroth"] = "Goroth",
	["Belac"] = "Demonic Inquisition",
	["Harjatan"] = "Harjatan",
	["Priestess Lunaspyre"] = "Sisters of the Moon",
	["Mistress Sassz'ine"] = "Mistress Sassz'ine",
	["The Desolate Host"] = "The Desolate Host",
	["Maiden of Vigilance"] = "Maiden of Vigilance",
	["Fallen Avatar"] = "Fallen Avatar",
	["Kil'jaeden"] = "Kil'jaeden",
	-- Antorus, the Burning Throne
	["Garothi Worldbreaker"] = "Garothi Worldbreaker",
	["Shatug"] = "Felhounds of Sargeras",
	["War Council"] = "War Council",
	["Portal Keeper Hasabel"] = "Portal Keeper Hasabel",
	["Eonar, the Lifebinder"] = "Eonar, the Lifebinder",
	["Imonar the Soulhunter"] = "Imonar the Soulhunter",
	["Kin'garoth"] = "Kin'garoth",
	["Varimathras"] = "Varimathras",
	["The Coven of Shivarra"] = "The Coven of Shivarra",
	["Aggramar"] = "Aggramar",
	["Argus the Unmaker"] = "Argus the Unmaker",

	-- Highmaul
	["Kargath Bladefist"] 			= "Kargath Bladefist",
	["The Butcher"] 				= "The Butcher",
	["Tectus"] 						= "Tectus",
	["Brackenspore"] 				= "Brackenspore",
	["Phemos"] 						= "Twin Ogron",
	["Ko'ragh"] 					= "Ko'ragh",
	["Imperator Mar'gok"] 			= "Imperator Mar'gok",

	-- Blackrock Foundry
	["Gruul"] 						= "Gruul",
	["Oregorger"] 					= "Oregorger",
	["Beastlord Darmac"] 			= "Beastlord Darmac",
	["Flamebender Ka'graz"] 		= "Flamebender Ka'graz",
	["Franzok"]						= "Hans'gar and Franzok",
	["Operator Thogar"] 			= "Operator Thogar",
	["Heart of the Mountain"] 		= "The Blast Furnace",
	["Kromog"]						= "Kromog",
	["The Iron Maidens"] 			= "The Iron Maidens",
	-- Admiral Gar'an yells "Sisters, I... failed..." upon death
	-- Enforcer Sorka yells "It feels... so..."
	-- Marak the Blooded yells "My... blood..."
 	["Blackhand"] 					= "Blackhand",

	--Hellfire Citadel
	["Iron Reaver"]					= "Iron Reaver",
	["Gorefiend"]					= "Gorefiend",
	["Fel Lord Zakuun"]				= "Fel Lord Zakuun",
	["Kormrok"]						= "Kormrok",
	["Tyrant Velhari"]				= "Tyrant Velhari",
	["Mannoroth"]					= "Mannoroth",
	["Kilrogg Deadeye"]				= "Kilrogg Deadeye",
	["Reinforced Hellfire Door"]	= "Hellfire Assault",
	["Soul of Socrethar"]			= "Socrethar the Eternal",
	["Hellfire High Council"]		= "Hellfire High Council",
	["Shadow-Lord Iskar"]			= "Shadow-Lord Iskar",
	["Archimonde"]					= "Archimonde",
	["Xhul'horac"]					= "Xhul'horac",


	-- siege of orgrimmar
	["Immerseus"] 					= "Immerseus",
	["The Fallen Protectors"]		= "The Fallen Protectors", -- ? about death
	["Amalgam of Corruption"] 		= "Norushen",
	["Sha of Pride"] 				= "Sha of Pride",
	["Galakras"] 					= "Galakras",
	["Iron Juggernaut"] 			= "Iron Juggernaut",
	["Earthbreaker Haromm"] 		= "Kor'kron Dark Shaman",
	["General Nazgrim"] 			= "General Nazgrim",
	["Malkorok"] 					= "Malkorok",
	["Spoils of Pandaria"] 			= "Spoils of Pandaria",
	["Thok the Bloodthirsty"] 		= "Thok the Bloodthirsty",
	["Siegecrafter Blackfuse"] 		= "Siegecrafter Blackfuse",
	["Paragons of the Klaxxi"] 		= "Paragons of the Klaxxi", -- ? multiple mob death
	["Garrosh Hellscream"] 			= "Garrosh Hellscream",
	-- Throne of Thunder
	["Jin'rokh the Breaker"] 		= "Jin'rokh the Breaker",
	["Horridon"] 			        = "Horridon",
	["Council of Elders"] 			= "Council of Elders",
	["Kazra'jin"] 			        = "Council of Elders",
	["Sul the Sandcrawler"] 		= "IGNORE",
	["Frost King Malakk"] 			= "IGNORE",
	["High Priestess Mar'li"] 		= "IGNORE",
	["Tortos"] 			        	= "Tortos",
	["Megaera"] 			        = "Megaera",
	["Flaming Head"] 				= "Megaera",
	["Frozen Head"] 				= "Megaera",
	["Venomous Head"] 				= "Megaera",
	["Ji-Kun"] 			        	= "Ji-Kun",
	["Durumu the Forgotten"] 		= "Durumu the Forgotten",
	["Primordius"] 			        = "Primordius",
	["Dark Animus"] 				= "Dark Animus",
	["Iron Qon"] 			        = "Iron Qon",
	["Twin Consorts"] 				= "Twin Consorts",
	["Lu'lin"] 			        	= "Twin Consorts",
	["Suen"] 			        	= "IGNORE",
	["Lei Shen"] 			        = "Lei Shen",
	["Ra-den"] 			        	= "Ra-den",
	-- Mogushan
	["The Stone Guard"] 			= "The Stone Guard",
	["Amethyst Guardian"] 			= "The Stone Guard",
	["Cobalt Guardian"] 			= "IGNORE",
	["Jade Guardian"] 				= "IGNORE",
	["Jasper Guardian"] 			= "IGNORE",
	["Feng the Accursed"] 			= "Feng the Accursed",
	["Gara'jal the Spiritbinder"] 	= "Gara'jal the Spiritbinder",
	["The Spirit Kings"] 			= "The Spirit Kings",
	["Elegon"] 						= "Elegon",
	["Will of the Emperor"] 		= "Will of the Emperor",
	-- Endless
	["Protector Kaolan"] 			= "Protectors of the Endless",
	["Tsulong"] 					= "Tsulong",
	["Lei Shi"] 					= "Lei Shi",
	["Cheng Kang"] 					= "Sha of Fear",
	-- HoF
	["Imperial Vizier Zor'lok"] 	= "Imperial Vizier Zor'lok",
	["Blade Lord Ta'yak"] 			= "Blade Lord Ta'yak",
	["Garalon"] 					= "Garalon",
	["Wind Lord Mel'jarak"] 		= "Wind Lord Mel'jarak",
	["Amber-Shaper Un'sok"] 		= "Amber-Shaper Un'sok",
	["Grand Empress Shek'zeer"] 	= "Grand Empress Shek'zeer",
	-- Other
	["Argaloth"] 					= "Argaloth",
	["Occu’thar"] 					= "Occu’thar",
	["Magmaw"] 						= "Magmaw",
	["Omnotron Defense System"] 	= "Omnotron Defense System",
	["Omnotron"] 					= "Omnotron",
	["Maloriak"] 					= "Maloriak",
	["Atramedes"] 					= "Atramedes",
	["Chimaeron"] 					= "Chimaeron",
	["Nefarian"] 					= "Nefarian",
	["Conclave of Wind"] 			= "Conclave of Wind",
	["Al'Akir"] 					= "Al'Akir",
	["Valiona"] 					= "Valiona and Theralion",
	["Theralion"] 					= "Valiona and Theralion",
	["Halfus Wyrmbreaker"] 			= "Halfus Wyrmbreaker",
	["Ascendant Council"] 			= "Ascendant Council",
	["Elementium Monstrosity"] 		= "Ascendant Council",
	["Cho'gall"] 					= "Cho'gall",
	-- Firelands
	["Beth'tilac"] 					= "Beth'tilac",
	["Lord Rhyolith"] 				= "Lord Rhyolith",
	["Alysrazor"] 					= "Alysrazor",
	["Shannox"] 					= "Shannox",
	["Baleroc"] 					= "Baleroc",
	["Majordomo Staghelm"] 			= "Majordomo Staghelm",
	["Ragnaros"] 					= "Ragnaros",
	-- Dragon Soul
	["Morchok"] 					= "Morchok",
	["Warlord Zon'ozz"] 			= "Warlord Zon'ozz",
	["Yor'sahj the Unsleeping"] 	= "Yor'sahj the Unsleeping",
	["Hagara the Stormbinder"] 		= "Hagara the Stormbinder",
	["Ultraxion"] 					= "Ultraxion",
	["Warmaster Blackhorn"] 		= "Warmaster Blackhorn",
	["Deathwing"] 					= "Spine of Deathwing",
	["Madness of Deathwing"] 		= "IGNORE",
	-- Ragefire Chasm
    ["Adarogg"] 					= "Adarogg",
    ["Dark Shaman Koranthal"] 		= "Dark Shaman Koranthal",
    ["Slagmaw"] 					= "Slagmaw",
    ["Lava Guard Gordoth"] 			= "Lava Guard Gordoth",
    -- The Stockade
    ["Hogger"] 						= "Hogger",
    ["Lord Overheat"] 				= "Lord Overheat",
    ["Randolph Moloch"]				= "Randolph Moloch",

	["DEFAULTBOSS"] 				= "Trash mob",
};

-- samples
--CT_RaidTracker_lang_BossKills_Sathrovarr_Yell = "I'm... never on... the losing... side...";
--CT_RaidTracker_lang_BossKills_Sathrovarr_BossName = "Sathrovarr the Corruptor";
CT_RaidTracker_lang_BossKills_Omnotron_Yell = "Defense systems obliterated. Powering down...";
CT_RaidTracker_lang_BossKills_Omnotron_BossName = "Omnotron Defense System";
--CT_RaidTracker_lang_BossKills_ValionaTheralion_Yell = "I knew I should have stayed out of this...";
--CT_RaidTracker_lang_BossKills_ValionaTheralion_BossName = "Valiona and Theralion";
CT_RaidTracker_lang_BossKills_Conclave_of_Wind_Yell = "The Conclave of Wind has dissipated. Your honorable conduct and determination have earned you the right to face me in battle, mortals. I await your assault on my platform! Come!";
CT_RaidTracker_lang_BossKills_Conclave_of_Wind_BossName = "Conclave of Wind";

CT_RaidTracker_lang_BossKills_NewRagnaros_Yell = "Too soon! ... You have come too soon...";
CT_RaidTracker_lang_BossKills_NewRagnaros_Yell2 = "No, nooooo... this was to be my hour of triumph...";
CT_RaidTracker_lang_BossKills_NewRagnaros_BossName = "Ragnaros";

CT_RaidTracker_lang_BossKills_DeathwingFinal_Yell = "It is time. I will expend everything to bind every thread here, now, around the Dragon Soul. What comes to pass will NEVER be undone.";
CT_RaidTracker_lang_BossKills_DeathwingFinal_BossName = "Madness of Deathwing";


CT_RaidTracker_lang_BossKills_WillOfTheEmperor_Yell = "I fear that our war against our ancient enemies is still far from over.";
CT_RaidTracker_lang_BossKills_WillOfTheEmperor_BossName = "Will of the Emperor";

CT_RaidTracker_lang_BossKills_SpiritKings_Yell = "A secret passage has opened beneath the platform, this way!";
CT_RaidTracker_lang_BossKills_SpiritKings_BossName = "The Spirit Kings";

CT_RaidTracker_lang_BossKills_LeiShi_Yell = "I... ah... oh! Did I...? Was I...? It was... so... cloudy.";
CT_RaidTracker_lang_BossKills_LeiShi_BossName = "Lei Shi";

CT_RaidTracker_lang_BossKills_Tsulong_Yell = "I thank you, strangers. I have been freed.";
CT_RaidTracker_lang_BossKills_Tsulong_BossName = "Tsulong";

CT_RaidTracker_lang_BossKills_FallenProtectors_Yell = "May your souls become one with the land you gave your life to protect.";
CT_RaidTracker_lang_BossKills_FallenProtectors_BossName = "The Fallen Protectors";

CT_RaidTracker_lang_BossKills_Immerseus_Yell = "Ah, you have done it! The waters are pure once more.";
CT_RaidTracker_lang_BossKills_Immerseus_BossName = "Immerseus";

CT_RaidTracker_lang_BossKills_Immerseus_Yell2 = "Ah, you have done it. The waters are pure once more!";
CT_RaidTracker_lang_BossKills_Immerseus_BossName2 = "Immerseus";

CT_RaidTracker_lang_BossKills_Immerseus_Yell3 = "Can you feel their life-giving energies flow through you?";
CT_RaidTracker_lang_BossKills_Immerseus_BossName3 = "Immerseus";

CT_RaidTracker_lang_BossKills_Immerseus_Yell4 = "It will take much time for the Vale to heal, but you have given us hope!";
CT_RaidTracker_lang_BossKills_Immerseus_BossName4 = "Immerseus";

CT_RaidTracker_lang_BossKills_Spoils_Yell = "System resetting. Don't turn the power off, or the whole thing will probably explode."
CT_RaidTracker_lang_BossKills_Spoils_BossName = "Spoils of Pandaria";

CT_RaidTracker_lang_BossKills_Paragons_BossName = "Paragons of the Klaxxi";

CT_RaidTracker_lang_BossKills_Maidens_BossName = "The Iron Maidens"
CT_RaidTracker_lang_BossKills_Maidens_Marak_Yell = "My... blood...";
CT_RaidTracker_lang_BossKills_Maidens_Marak_BossName = "Marak the Blooded";

CT_RaidTracker_lang_BossKills_Maidens_Sorka_Yell = "It feels... so...";
CT_RaidTracker_lang_BossKills_Maidens_Sorka_BossName = "Enforcer Sorka";

CT_RaidTracker_lang_BossKills_Maidens_Garan_Yell = "Sisters, I... failed...";
CT_RaidTracker_lang_BossKills_Maidens_Garan_BossName = "Admiral Gar'an";

CT_RaidTracker_lang_BossKills_Kagraz_Yell = "My flame... burned too bright";
CT_RaidTracker_lang_BossKills_Kagraz_BossName = "Flamebender Ka'graz";

--Hellfire High Council
CT_RaidTracker_lang_BossKills_HellfireCouncil_BossName = "Hellfire High Council"
CT_RaidTracker_lang_BossKills_HellfireCouncil_Gurtogg_Yell = "ArRRgghhHhh...";
CT_RaidTracker_lang_BossKills_HellfireCouncil_Gurtogg_BossName = "Gurtogg Bloodboil";

CT_RaidTracker_lang_BossKills_HellfireCouncil_Blademaster_Yell = "I am everburning!";
CT_RaidTracker_lang_BossKills_HellfireCouncil_Blademaster_BossName = "Blademaster Jubei'thos";

CT_RaidTracker_lang_BossKills_HellfireCouncil_Dia_Yell = "The sweet mercy... of death.";
CT_RaidTracker_lang_BossKills_HellfireCouncil_Dia_BossName = "Dia Darkwhisper";

--Trial of Valor Legion
CT_RaidTracker_lang_BossKills_TrialofValor_Odyn_Yell = "ENOUGH! Your worth is proven! With you as my champions, Helya will fall and I will at long last be free of the curse that binds me here.";
CT_RaidTracker_lang_BossKills_TrialofValor_Odyn_BossName = "Odyn";

--Uldir BFA
CT_RaidTracker_lang_BossKills_Uldir_MOTHER_Yell = "System restored. Levels returned to secure thresholds.";
CT_RaidTracker_lang_BossKills_Uldir_MOTHER_BossName = "MOTHER";

--Battle of Dazar'alor
CT_RaidTracker_lang_BossKills_Dazar_Stormwall_Yell = 'The depths... call...';
CT_RaidTracker_lang_BossKills_Dazar_Stormwall_BossName = "Stormwall Blockade";

CT_RaidTracker_lang_BossKills_Dazar_Jaina_Yell = "No... it can't end like this!";
CT_RaidTracker_lang_BossKills_Dazar_Jaina_BossName = "Lady Jaina Proudmoore";

--Queen Azshara
CT_RaidTracker_lang_BossKills_Queen_Azshara_BossName = "Queen Azshara";

--Nyloatha
--The Prophet Skitra
CT_RaidTracker_lang_BossKills_TheProphetSkitra_BossName = "Prophet Skitra";
CT_RaidTracker_lang_BossKills_TheProphetSkitra_Yell = "How... did you... know...";
--N'Zoth"
CT_RaidTracker_lang_BossKills_NZoth_BossName = "N'Zoth";
CT_RaidTracker_lang_BossKills_NZoth_Yell = "Riperino";

--Castle Nathria
--Artificer Xy'mox
CT_RaidTracker_lang_BossKills_ArtificerXymox_BossName = "Artificer Xymox";
CT_RaidTracker_lang_BossKills_ArtificerXymox_Yell = "This exchange has no further value. Consider our business concluded, for now.";

--Sun King's Salvation
CT_RaidTracker_lang_BossKills_SunKings_BossName = "Sun Kings Salvation";
CT_RaidTracker_lang_BossKills_SunKings_Yell = "No! I will not be confined again!";

--The Council of Blood
CT_RaidTracker_lang_BossKills_CouncilofBlood_BossName = "The Council of Blood";

CT_RaidTracker_lang_BossKills_CouncilofBlood_Stavros_BossName = "Lord Stavros";
CT_RaidTracker_lang_BossKills_CouncilofBlood_Stavros_Yell = "But I am... the life... of the party...";
CT_RaidTracker_lang_BossKills_CouncilofBlood_Niklaus_BossName = "Castellan Niklaus";
CT_RaidTracker_lang_BossKills_CouncilofBlood_Niklaus_Yell = "What kind... of strategy... was that...";
CT_RaidTracker_lang_BossKills_CouncilofBlood_Frieda_BossName = "Baroness Frieda";
CT_RaidTracker_lang_BossKills_CouncilofBlood_Frieda_Yell = "You will always... be beneath me...";


--Stone Legion Generals
CT_RaidTracker_lang_BossKills_StoneLegionGenerals_BossName = "Stone Legion Generals";
CT_RaidTracker_lang_BossKills_StoneLegionGenerals_Crashaal_Yell = "To serve... was my... greatest honor...";
CT_RaidTracker_lang_BossKills_StoneLegionGenerals_Crashaal_BossName = "General Grashaal";
CT_RaidTracker_lang_BossKills_StoneLegionGenerals_Kaal_Yell = "My blood... for... master...";
CT_RaidTracker_lang_BossKills_StoneLegionGenerals_Kaal_BossName = "General Kaal";

--Anduin Wrynn
CT_RaidTracker_lang_BossKills_AnduinWrynn_BossName = "Anduin Wrynn";
CT_RaidTracker_long_BossKills_AnduinWrynn_Yell = "The Light has abandoned you.";

--Prototype Pantheon
CT_RaidTracker_lang_BossKills_PrototypePantheon_BossName = "Prototype Pantheon";
--Prototype of Absolution
CT_RaidTracker_lang_BossKills_PrototypePantheon_Absolution_Yell = "Your misdeeds... will drag you... to ruin...";
CT_RaidTracker_lang_BossKills_PrototypePantheon_Absolution_Yell2 = "You will... answer for... your transgressions.";
CT_RaidTracker_lang_BossKills_PrototypePantheon_Absolution_BossName = "Prototype of Absolution";
--Prototype of War
CT_RaidTracker_lang_BossKills_PrototypePantheon_War_Yell = "My war... has ended...";
CT_RaidTracker_lang_BossKills_PrototypePantheon_War_Yell2 = "Shameful... shameful defeat...";
CT_RaidTracker_lang_BossKills_PrototypePantheon_War_BossName = "Prototype of War";
--Prototype of Renewal
CT_RaidTracker_lang_BossKills_PrototypePantheon_Renewal_Yell = "The forest... must... endure...";
CT_RaidTracker_lang_BossKills_PrototypePantheon_Renewal_Yell2 = "My hunt... has ended...";
CT_RaidTracker_lang_BossKills_PrototypePantheon_Renewal_BossName = "Prototype of Renewal";
--Prototype of Duty
CT_RaidTracker_lang_BossKills_PrototypePantheon_Duty_Yell = "I fly... no... longer...";
CT_RaidTracker_lang_BossKills_PrototypePantheon_Duty_Yell2 = "I failed... the kyrian...";
CT_RaidTracker_lang_BossKills_PrototypePantheon_Duty_BossName = "Prototype of Duty";

--Lords of Dread
CT_RaidTracker_lang_BossKills_LordsofDread_BossName = "Lords of Dread";
CT_RaidTracker_lang_BossKills_LordsofDread_KinTessa_Yell = "I want... more... time...";
CT_RaidTracker_lang_BossKills_LordsofDread_KinTessa_Yell2 = "You... deceived... me...";
CT_RaidTracker_lang_BossKills_LordsofDread_KinTessa_BossName = "Kin'tessa";
--Halondrus
CT_RaidTracker_lang_BossKills_HalondrustheReclaimer_Yell = "The pattern is restored. My purpose resumes.";
CT_RaidTracker_lang_BossKills_HalondrustheReclaimer_BossName = "Halondrus the Reclaimer";


--Remnant of Ner'zhul
-- CT_RaidTracker_lang_BossKills_RemnantofNerzhul_BossName = "Remnant of Ner'zhul";
-- CT_RaidTracker_lang_BossKills_RemnantofNerzhul_Yell = "Ahhh... Rulkan... I come.. home...";
-- Fatescribe Roh-Kalo
-- CT_RaidTracker_lang_BossKills_Fatescribe_Yell = "Silence... at last...";
-- CT_RaidTracker_lang_BossKills_Fatescribe_BossName = "Fatescribe Roh-Kalo";
--Kel'Thuzad, died multiple times in fight and has no yell. Fun

-- Translations

if (GetLocale() == "deDE") then
	CT_RaidTracker_lang_LeftGroup = "([^%s]+) hat die Schlachtgruppe verlassen.";
	CT_RaidTracker_lang_JoinedGroup = "([^%s]+) hat sich der Schlachtgruppe angeschlossen.";
	CT_RaidTracker_lang_ReceivesLoot1 = "([^%s]+) bekommt Beute: "..CT_ITEMREG..".";
	CT_RaidTracker_lang_ReceivesLoot2 = "Ihr erhaltet Beute: "..CT_ITEMREG..".";
	CT_RaidTracker_lang_ReceivesLoot3 = "([^%s]+) erh\195\164lt Beute: "..CT_ITEMREG_MULTI..".";
	CT_RaidTracker_lang_ReceivesLoot4 = "Ihr erhaltet Beute: "..CT_ITEMREG_MULTI..".";
	CT_RaidTracker_lang_ReceivesLootYou = "Ihr";

	CT_RaidTracker_ZoneTriggers = {
		-- cata
		["Battle of Mount Hyjal"] = "Die Schlacht um den Berg Hyjal",
		["Baradin Hold"] = "Baradinfestung",
		["Blackwing Descent"] = "Pechschwingenabstieg",
		["Throne of the Four Winds"] = "Thron der vier Winde",
		["The Bastion of Twilight"] = "Bastion des Zwielichts",
		["Firelands"] = "Firelands",
		["Dragon Soul"] = "Dragon Soul",
		-- TEST
	    ["Ragefire Chasm"] = "Ragefire Chasm",
	    ["The Stockade"] = "The Stockade",
	};

	CT_RaidTracker_BossUnitTriggers = {
		["Argaloth"] = "Argaloth",
		["Magmaw"] = "Magmaw",
		["Omnotron Defense System"] = "Omnotron Defense System",
		["Omnotron"] = "Omnotron",
		["Maloriak"] = "Maloriak",
		["Atramedes"] = "Atramedes",
		["Chimaeron"] = "Chimaeron",
		["Nefarian"] = "Nefarian",
		["Conclave of Wind"] = "Conclave of Wind",
		["Al'Akir"] = "Al'Akir",
		["Valiona"] = "Valiona and Theralion",
		["Theralion"] = "Valiona and Theralion",
		["Halfus Wyrmbreaker"] = "Halfus Wyrmbreaker",
		["Ascendant Council"] = "Ascendant Council",
		["Elementium Monstrosity"] = "Ascendant Council",
		["Cho'gall"] = "Cho'gall",

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

	-- samples
	--CT_RaidTracker_lang_BossKills_Sathrovarr_Yell = "I'm... never on... the losing... side...";
	--CT_RaidTracker_lang_BossKills_Sathrovarr_BossName = "Sathrovarr the Corruptor";
	CT_RaidTracker_lang_BossKills_Omnotron_Yell = "Defense systems obliterated. Powering down...";
	CT_RaidTracker_lang_BossKills_Omnotron_BossName = "Omnotron Defense System";
	--CT_RaidTracker_lang_BossKills_ValionaTheralion_Yell = "I knew I should have stayed out of this...";
	--CT_RaidTracker_lang_BossKills_ValionaTheralion_BossName = "Valiona and Theralion";
	CT_RaidTracker_lang_BossKills_Conclave_of_Wind_Yell = "The Conclave of Wind has dissipated. Your honorable conduct and determination have earned you the right to face me in battle, mortals. I await your assault on my platform! Come!";
	CT_RaidTracker_lang_BossKills_Conclave_of_Wind_BossName = "Conclave of Wind";

elseif (GetLocale() == "frFR") then
	CT_RaidTracker_lang_LeftGroup = "([^%s]+) a quitt\195\169 le groupe de raid";
	CT_RaidTracker_lang_JoinedGroup = "([^%s]+) a rejoint le group de raid";
	CT_RaidTracker_lang_ReceivesLoot1 = "([^%s]+) re\195\167oit le butin.+: "..CT_ITEMREG..".";
	CT_RaidTracker_lang_ReceivesLoot2 = "Vous recevez le butin.+: "..CT_ITEMREG..".";
	CT_RaidTracker_lang_ReceivesLoot3 = "([^%s]+) re\195\167oit le butin.+: "..CT_ITEMREG_MULTI..".";
	CT_RaidTracker_lang_ReceivesLoot4 = "Vous recevez le butin.+: "..CT_ITEMREG_MULTI..".";
	CT_RaidTracker_lang_ReceivesLootYou = "Vous";

	CT_RaidTracker_ZoneTriggers = {
		["Battle of Mount Hyjal"] = "Battle of Mount Hyjal",
		["Baradin Hold"] = "Baradin Hold",
		["Blackwing Descent"] = "Blackwing Descent",
		["Throne of the Four Winds"] = "Throne of the Four Winds",
		["The Bastion of Twilight"] = "The Bastion of Twilight",
		["Firelands"] = "Firelands",
		["Dragon Soul"] = "Dragon Soul",
		-- TEST
	    ["Ragefire Chasm"] = "Ragefire Chasm",
	    ["The Stockade"] = "The Stockade",
	};

	CT_RaidTracker_BossUnitTriggers = {
		["Argaloth"] = "Argaloth",
		["Magmaw"] = "Magmaw",
		["Omnotron Defense System"] = "Omnotron Defense System",
		["Omnotron"] = "Omnotron",
		["Maloriak"] = "Maloriak",
		["Atramedes"] = "Atramedes",
		["Chimaeron"] = "Chimaeron",
		["Nefarian"] = "Nefarian",
		["Conclave of Wind"] = "Conclave of Wind",
		["Al'Akir"] = "Al'Akir",
		["Valiona"] = "Valiona and Theralion",
		["Theralion"] = "Valiona and Theralion",
		["Halfus Wyrmbreaker"] = "Halfus Wyrmbreaker",
		["Ascendant Council"] = "Ascendant Council",
		["Elementium Monstrosity"] = "Ascendant Council",
		["Cho'gall"] = "Cho'gall",

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

		-- trash
		["DEFAULTBOSS"] = "Trash mob",
	};

	-- samples
	--CT_RaidTracker_lang_BossKills_Sathrovarr_Yell = "I'm... never on... the losing... side...";
	--CT_RaidTracker_lang_BossKills_Sathrovarr_BossName = "Sathrovarr the Corruptor";
	CT_RaidTracker_lang_BossKills_Omnotron_Yell = "Defense systems obliterated. Powering down...";
	CT_RaidTracker_lang_BossKills_Omnotron_BossName = "Omnotron Defense System";
	--CT_RaidTracker_lang_BossKills_ValionaTheralion_Yell = "I knew I should have stayed out of this...";
	--CT_RaidTracker_lang_BossKills_ValionaTheralion_BossName = "Valiona and Theralion";
	CT_RaidTracker_lang_BossKills_Conclave_of_Wind_Yell = "The Conclave of Wind has dissipated. Your honorable conduct and determination have earned you the right to face me in battle, mortals. I await your assault on my platform! Come!";
	CT_RaidTracker_lang_BossKills_Conclave_of_Wind_BossName = "Conclave of Wind";

elseif (GetLocale() == "esES") then
	CT_RaidTracker_lang_LeftGroup = "([^%s]+) se ha marchado de la banda.";
	CT_RaidTracker_lang_JoinedGroup = "([^%s]+) se ha unido a la banda.";
	CT_RaidTracker_lang_ReceivesLoot1 = "([^%s]+) recibe el bot\195\173n: "..CT_ITEMREG..".";
	CT_RaidTracker_lang_ReceivesLoot2 = "Recibes bot\195\173n: "..CT_ITEMREG..".";
	CT_RaidTracker_lang_ReceivesLoot3 = "([^%s]+) recibe el bot\195\173n: "..CT_ITEMREG_MULTI..".";
	CT_RaidTracker_lang_ReceivesLoot4 = "Recibes bot\195\173n: "..CT_ITEMREG_MULTI..".";
	CT_RaidTracker_lang_ReceivesLootYou = "Recibes";

	CT_RaidTracker_ZoneTriggers = {
		["Battle of Mount Hyjal"] = "Battle of Mount Hyjal",
		["Baradin Hold"] = "Baradin Hold",
		["Blackwing Descent"] = "Blackwing Descent",
		["Throne of the Four Winds"] = "Throne of the Four Winds",
		["The Bastion of Twilight"] = "The Bastion of Twilight",
		["Firelands"] = "Firelands",
		["Dragon Soul"] = "Dragon Soul",
		-- TEST
	    ["Ragefire Chasm"] = "Ragefire Chasm",
	    ["The Stockade"] = "The Stockade",
	};

	-- samples
	--CT_RaidTracker_lang_BossKills_Sathrovarr_Yell = "I'm... never on... the losing... side...";
	--CT_RaidTracker_lang_BossKills_Sathrovarr_BossName = "Sathrovarr the Corruptor";
	CT_RaidTracker_lang_BossKills_Omnotron_Yell = "Defense systems obliterated. Powering down...";
	CT_RaidTracker_lang_BossKills_Omnotron_BossName = "Omnotron Defense System";
	--CT_RaidTracker_lang_BossKills_ValionaTheralion_Yell = "I knew I should have stayed out of this...";
	--CT_RaidTracker_lang_BossKills_ValionaTheralion_BossName = "Valiona and Theralion";
	CT_RaidTracker_lang_BossKills_Conclave_of_Wind_Yell = "The Conclave of Wind has dissipated. Your honorable conduct and determination have earned you the right to face me in battle, mortals. I await your assault on my platform! Come!";
	CT_RaidTracker_lang_BossKills_Conclave_of_Wind_BossName = "Conclave of Wind";

elseif (GetLocale() == "itIT") then
	CT_RaidTracker_lang_LeftGroup = "([^%s]+) lascia li gruppo";
	CT_RaidTracker_lang_JoinedGroup = "([^%s]+) si unisce al gruppo";
	CT_RaidTracker_lang_ReceivesLoot1 = "([^%s]+) ha ricevuto: "..CT_ITEMREG..".";
	CT_RaidTracker_lang_ReceivesLoot2 = "Hai ricevuto: "..CT_ITEMREG..".";
	CT_RaidTracker_lang_ReceivesLoot3 = "([^%s]+) ha ricevuto: "..CT_ITEMREG_MULTI..".";
	CT_RaidTracker_lang_ReceivesLoot4 = "Hai ricevuto: "..CT_ITEMREG_MULTI..".";
	CT_RaidTracker_lang_ReceivesLoot5 = "([^%s]+) ha ricevuto il bottino bonus: "..CT_ITEMREG..".";
	CT_RaidTracker_lang_ReceivesLoot6 = "Hai ricevuto il bottino bonus: "..CT_ITEMREG..".";
	CT_RaidTracker_lang_ReceivesLootYou = "Tu";

	CT_RaidTracker_BossUnitTriggers = {
		["The Blast Furnace"] = "Altoforno",
		["Flamebender Ka'graz"] = "Domafiamme Ka'graz",
		["Beastlord Darmac"] = "Signore delle Bestie Darmac",
		["Operator Thogar"] = "Operatore Thogar",
		["Blackhand"] = "Manonera",
		["Oregorger"] = "Tritaroccia",
		["The Blast Furnace"] = "Cuore della Montagna",
		["The Iron Maidens"] = "Dame di Ferro",

	}
	-- Iron Maidens Individual Name Translations
	-- Ammiraglio Gar'an - Admiral Gar'an
	-- Marak l'Insanguinata - Marak the Blooded
	-- Sovrintendente Solka - Enforcer Sorka


elseif (GetLocale() == "ruRU") then
	CT_RaidTracker_lang_LeftGroup = "([^%s]+) покидает рейдовую группу";
	CT_RaidTracker_lang_JoinedGroup = "([^%s]+) присоединятся к рейдовой группе";
	CT_RaidTracker_lang_ReceivesLoot1 = "([^%s]+) получает добычу: "..CT_ITEMREG..".";
	CT_RaidTracker_lang_ReceivesLoot2 = "Ваша добыча: "..CT_ITEMREG..".";
	CT_RaidTracker_lang_ReceivesLoot3 = "([^%s]+) получает добычу: "..CT_ITEMREG_MULTI..".";
	CT_RaidTracker_lang_ReceivesLoot4 = "Ваша добыча: "..CT_ITEMREG_MULTI..".";
	CT_RaidTracker_lang_ReceivesLootYou = "Вы";

	CT_RaidTracker_ZoneTriggers = {
			["Battle of Mount Hyjal"] = "Battle of Mount Hyjal",
			["Baradin Hold"] = "Baradin Hold",
			["Blackwing Descent"] = "Blackwing Descent",
			["Throne of the Four Winds"] = "Throne of the Four Winds",
			["The Bastion of Twilight"] = "The Bastion of Twilight",
			["Firelands"] = "Firelands",
			["Dragon Soul"] = "Dragon Soul",
			-- TEST
		    ["Ragefire Chasm"] = "Ragefire Chasm",
		    ["The Stockade"] = "The Stockade",
	};

	CT_RaidTracker_BossUnitTriggers = {
		["Argaloth"] = "Argaloth",
		["Magmaw"] = "Magmaw",
		["Omnotron Defense System"] = "Omnotron Defense System",
		["Omnotron"] = "Omnotron",
		["Maloriak"] = "Maloriak",
		["Atramedes"] = "Atramedes",
		["Chimaeron"] = "Chimaeron",
		["Nefarian"] = "Nefarian",
		["Conclave of Wind"] = "Conclave of Wind",
		["Al'Akir"] = "Al'Akir",
		["Valiona"] = "Valiona and Theralion",
		["Theralion"] = "Valiona and Theralion",
		["Halfus Wyrmbreaker"] = "Halfus Wyrmbreaker",
		["Ascendant Council"] = "Ascendant Council",
		["Elementium Monstrosity"] = "Ascendant Council",
		["Cho'gall"] = "Cho'gall",

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
		-- End Ruby Sanctum
		["DEFAULTBOSS"] = "Trash mob",
	};

	-- samples
	--CT_RaidTracker_lang_BossKills_Sathrovarr_Yell = "I'm... never on... the losing... side...";
	--CT_RaidTracker_lang_BossKills_Sathrovarr_BossName = "Sathrovarr the Corruptor";
	CT_RaidTracker_lang_BossKills_Omnotron_Yell = "Defense systems obliterated. Powering down...";
	CT_RaidTracker_lang_BossKills_Omnotron_BossName = "Omnotron Defense System";
	--CT_RaidTracker_lang_BossKills_ValionaTheralion_Yell = "I knew I should have stayed out of this...";
	--CT_RaidTracker_lang_BossKills_ValionaTheralion_BossName = "Valiona and Theralion";
	CT_RaidTracker_lang_BossKills_Conclave_of_Wind_Yell = "The Conclave of Wind has dissipated. Your honorable conduct and determination have earned you the right to face me in battle, mortals. I await your assault on my platform! Come!";
	CT_RaidTracker_lang_BossKills_Conclave_of_Wind_BossName = "Conclave of Wind";

end
