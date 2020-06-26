-- CHECK FOR EXISTING CUSTOMINFO --
if DKPmon.CustomInfo.db["BossAuction"] ~= nil then
   --Already registered, don't register example settings
   return
end
DKPmon:Print("DKPmon_BossAuction is using the example.lua file, you should create your own settings in custom.lua")
-- REMOVE ABOVE SECTION IN YOUR CUSTOM.LUA FILE --

--[[
Instructions:
   This file lets you specify custom information for the Boss Auction DKP system.
   Copy this file to custom.lua and edit it to your dkp system preferences
   You can define boss values, dkp pools, and minimum bids below.
]]

local custom = {}
DKPmon.CustomInfo:Register(custom, "BossAuction")

------------------
-- Minimum Bids --
------------------

-- Enter the minimum bid choices you wish to be available before opening bidding.
custom.minbids = {20,30}

---------------
-- DKP Pools --
---------------

-- Enter the names of your DKP pools in the following table.
custom.poolnames = {"DKP"}

-- Enter the number of poolnames you have above.
custom.numpools = 1

------------------
-- Timed Points --
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
		name = "Standard Timed DKP", 
		amount = 1,
		interval = 40
	},	
	[2] = {
		name = "New Instance Timed DKP",
		amount = 1,
		interval = 20
	}
}

-------------------------
-- Craft Material List --
-------------------------

-- Items in this list will pop up a reminder to master loot to the crafter when you anounce winners
custom.craftmats={"Nether Vortex","Heart of Darkness"}

-----------------------
-- Silent Bid Rounds --
-----------------------

-- The length and number of silent bid rounds.  For Example,
-- {30,20,20} is three rounds, 30 seconds, 20 seconds, and 20 seconds
custom.silentrounds={30,20,20}

-----------------
-- Boss Values --
-----------------
-- Boss Values to Select From:
-- If the instance name and boss name match the wow spelling exactly BossAuction will automatically award points
-- and auto master-loot.  Enter a boss named "TimedPoints" with a value corresponding to one of the groups in periodicDkp

--[[
	TEMPLATE:
	["INSTANCE NAME"] = {
			["BOSS NAME"] = #(Boss Value),
			["ANOTHER BOSS"] = #(Boss Value),
			...
	},
	["Another Instance"] = {
			["BOSS NAME"] = #(Boss Value),
			["ANOTHER BOSS"] = #(Boss Value),
			...
	},	
]]

custom.bossvalues = {
	["Karazahn"] = {
		["TimedPoints"]=1,
		["Attumen the Huntsman"] = 5,
		["Moroes"] = 5,
		["Maiden of Virtue"] = 5,
		["The Curator"] = 6,
		["Chess Event"] = 1,
		["Prince Malchezaar"] = 10,
		["Netherspite"] = 8,
		["Nightbane"] = 12,
		["Opera Event"] = 5,
		["Terestian Illhoof"] = 7,
		["Shade of Aran"] = 7,
		["Hyakiss the Lurker"] = 1,
		["Rokad the Ravager"] = 1,
		["Shadikith the Glider"] = 1
	},
	["Gruul's Lair"] = {
		["TimedPoints"]=1,
		["High King Maulgar"] = 5,
		["Gruul the Dragonkiller"] = 5
	},
	["Magtheridon's Lair"] = {
		["TimedPoints"]=1,
		["Magtheridon"] = 10
	},
	["Serpentshrine Cavern"] = {
		["TimedPoints"]=1,
		["Hydross the Unstable"] = 5,
		["The Lurker Below"] = 5,
		["Leotheras the Blind"] = 5,
		["Fathom-Lord Karathress"] = 5,
		["Morogrim Tidewalker"] = 5,
		["Lady Vashj"] = 10
	},
	["Tempest Keep"] = {
		["TimedPoints"]=1,
		["Al'ar"] = 5,
		["Void Reaver"] = 5,
		["High Astromancer Solarian"] = 5,
		["Kael'thas Sunstrider"] = 10
	},
	-- I had this for testing in the stockades, run in there if you want to try it out.
	["The Stockade"] = {
		["TimedPoints"]=1,
		["Defias Captive"] = 2,
		["Defias Inmate"] = 3
	},
	["Shattrath City"] = {
		["TimedPoints"]=1,
		["Rat"] = 1
	}
	
}
