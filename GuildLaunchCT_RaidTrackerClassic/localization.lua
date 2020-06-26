-- Version 1570
--CT_ITEMREG = "(|c%x+|Hitem:%d+:%d+:%d+:%d+:%d+:%d+:(%-?%d+):(%-?%d+):%d+|h%[.-%]|h|r)%";
--CT_ITEMREG_MULTI = "(|c%x+|Hitem:%d+:%d+:%d+:%d+:%d+:%d+:(%-?%d+):(%-?%d+):%d+|h%[.-%]|h|r)x(%d+)%";
CT_ITEMREG = "(|c(%x+)|Hitem:([-%d:]+)|h%[(.-)%]|h|r)%";
CT_ITEMREG_MULTI = "(|c(%x+)|Hitem:([-%d:]+)|h%[(.-)%]|h|r)x(%d+)%";
CT_PLAYER_FACTION, localizedPlayerFaction = UnitFactionGroup("player")

CT_RaidTracker_Zones = {
	"Molten Core",
	"Onyxia's Lair",
	"Azshara",
	"Blasted Lands",
	"Hinterlands",
	"Ashenvale",
	"Feralas",
	"Duskwood",
	"Blackwing Lair",
	"Zul'Gurub",
	"Ruins of Ahn'Qiraj",
	"Temple of Ahn'Qiraj",
	"Naxxramas",
};

CT_RaidTracker_Bosses = {
	["Molten Core"] = {
		"Lucifron",
		"Magmadar",
		"Gehennas",
		"Garr",
		"Shazzrah",
		"Baron Geddon",
		"Golemagg the Incinerator",
		"Sulfuron Harbinger",
		"Majordomo Executus",
		"Ragnaros",
	},
	["Onyxia's Lair"] = {
		"Onyxia",
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
		"High Priest Venoxis",
		"High Priestess Jeklik",
		"High Priestess Mar'li",
		"High Priest Thekal",
		"Hakkar",
		"Bloodlord Mandokir & Ohgan",
		"Edge of Madness",
		"Gahz'ranka",
		"Jin'do the Hexxer",
	},
	["Ruins of Ahn'Qiraj"] = {
		"Kurinnaxx",
		"General Rajaxx",
		"Moam",
		"Buru the Gorger",
		"Ayamiss the Hunter",
		"Ossirian the Unscarred",
	},
	["Temple of Ahn'Qiraj"] = {
		"The Prophet Skeram",
		"Battleguard Sartura",
		"Fankriss the Unyielding",
		"Princess Huhuran",
		"Twin Emperors",
		"Bug Trio",
		"Viscidus",
		"Ouro",
		"C'Thun",
	},
	["Naxxramas"] = {
		"Anub'Rekhan",
		"Grand Widow Faerlina",
		"Maexxna",
		"Noth the Plaguebringer",
		"Heigan the Unclean",
		"Loatheb",
		"Instructor Razuvious",
		"Gothik the Harvester",
		"The Four Horsemen",
		"Patchwerk",
		"Grobbulus",
		"Gluth",
		"Thaddius",
		"Sapphiron",
		"Kel'Thuzad",
	},
	["Azshara"] = {
		"Azuregos",
	},
	["Blasted Lands"] = {
		"Kazzak",
	},
	["Hinterlands"] = {
		"Emeriss",
		"Lethon",
		"Taerar",
		"Ysondre"
	},
	["Ashenvale"] = {
		"Emeriss",
		"Lethon",
		"Taerar",
		"Ysondre"
	},
	["Feralas"] = {
		"Emeriss",
		"Lethon",
		"Taerar",
		"Ysondre"
	},
	["Duskwood"] = {
		"Emeriss",
		"Lethon",
		"Taerar",
		"Ysondre"
	},
	["The Stockade"] = {
		--"Defias Captive",
	},
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
	["Molten Core"] = "Molten Core",
	["Azshara"] = "Azshara",
	["Blasted Lands"] = "Blasted Lands",
	["Hinterlands"] = "Hinterlands",
	["Ashenvale"] = "Ashenvale",
	["Feralas"] = "Feralas",
	["Duskwood"] = "Duskwood",
	["Blackwing Lair"] = "Blackwing Lair",
	["Zul'Gurub"] = "Zul'Gurub",
	["Ruins of Ahn'Qiraj"] = "Ruins of Ahn'Qiraj",
	["Temple of Ahn'Qiraj"] = "Temple of Ahn'Qiraj",
	["Naxxramas"] = "Naxxramas",
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
	--MC
	["Lucifron"] = "Lucifron",
	["Magmadar"] = "Magmadar",
	["Gehennas"] = "Gehennas",
	["Garr"] = "Garr",
	["Shazzrah"] = "Shazzrah",
	["Baron Geddon"] = "Baron Geddon",
	["Golemagg the Incinerator"] = "Golemagg the Incinerator",
	["Sulfuron Harbinger"] = "Sulfuron Harbinger",
	["Majordomo Executus"] = "Majordomo Executus",
	["Ragnaros"] = "Ragnaros",
	--Ony
	["Onyxia"] = "Onyxia",
	--World Bosses
	["Azuregos"] = "Azuregos",
	["Kazzak"] = "Kazzak",
	["Emeriss"] = "Emeriss",
	["Lethon"] = "Lethon",
	["Taerar"] = "Taerar",
	["Ysondre"] = "Ysondre",
	--BWL
	["Razorgore the Untamed"] = "Razorgore the Untamed",
	["Vaelastrasz the Corrupt"] = "Vaelastrasz the Corrupt",
	["Broodlord Lashlayer"] = "Broodlord Lashlayer",
	["Firemaw"] = "Firemaw",
	["Ebonroc"] = "Ebonroc",
	["Flamegor"] = "Flamegor",
	["Chromaggus"] = "Chromaggus",
	["Nefarian"] = "Nefarian",
	--ZG
	["High Priest Venoxis"] = "High Priest Venoxis",
	["High Priestess Jeklik"] = "High Priestess Jeklik",
	["High Priestess Mar'li"] = "High Priestess Mar'li",
	["High Priest Thekal"] = "High Priest Thekal",
	["Bloodlord Mandokir & Ohgan"] = "Bloodlord Mandokir & Ohgan",
	["Edge of Madness"] = "Edge of Madness",
	["Gahz'ranka"] = "Gahz'ranka",
	["Jin'do the Hexxer"] = "Jin'do the Hexxer",
	["Hakkar"] = "Hakkar",
	--AQ20
	["Kurinnaxx"] = "Kurinnaxx",
	["General Rajaxx"] = "General Rajaxx",
	["Moam"] = "Moam",
	["Buru the Gorger"] = "Buru the Gorger",
	["Ayamiss the Hunter"] = "Ayamiss the Hunter",
	["Ossirian the Unscarred"] = "Ossirian the Unscarred",
	--AQ40
	["The Prophet Skeram"] = "The Prophet Skeram",
	["Battleguard Sartura"] = "Battleguard Sartura",
	["Fankriss the Unyielding"] = "Fankriss the Unyielding",
	["Princess Huhuran"] = "Princess Huhuran",
	["Twin Emperors"] = "Twin Emperors",
	["Bug Trio"] = "Bug Trio",
	["Viscidus"] = "Viscidus",
	["Ouro"] = "Ouro",
	["C'Thun"] = "C'Thun",
	--Naxx
	["Anub'Rekhan"] = "Anub'Rekhan",
	["Grand Widow Faerlina"] = "Grand Widow Faerlina",
	["Maexxna"] = "Maexxna",
	["Noth the Plaguebringer"] = "Noth the Plaguebringer",
	["Heigan the Unclean"] = "Heigan the Unclean",
	["Loatheb"] = "Loatheb",
	["Instructor Razuvious"] = "Instructor Razuvious",
	["Gothik the Harvester"] = "Gothik the Harvester",
	["The Four Horsemen"] = "The Four Horsemen",
	["Patchwerk"] = "Patchwerk",
	["Grobbulus"] = "Grobbulus",
	["Gluth"] = "Gluth",
	["Thaddius"] = "Thaddius",
	["Sapphiron"] = "Sapphiron",
	["Kel'Thuzad"] = "Kel'Thuzad",

	-- Ragefire Chasm
    ["Adarogg"] 					= "Adarogg",
    ["Dark Shaman Koranthal"] 		= "Dark Shaman Koranthal",
    ["Slagmaw"] 					= "Slagmaw",
    ["Lava Guard Gordoth"] 			= "Lava Guard Gordoth",
    -- The Stockade
    ["Hogger"] 						= "Hogger",
    ["Lord Overheat"] 				= "Lord Overheat",
    ["Randolph Moloch"]				= "Randolph Moloch",
    --["Defias Captive"]				= "Defias Captive",

	["DEFAULTBOSS"] 				= "Trash mob",
};

CT_RaidTracker_lang_BossKills_Majordomo_Yell = "Impossible! Stay your attack, mortal... I submit! I submit!";
CT_RaidTracker_lang_BossKills_Majordomo_BossName = "Majordomo Executus";
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
	    ["Defias Captive"] = "Defias Captive",
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
