GUILDLAUNCH_SVARS = GUILDLAUNCH_SVARS or {}

local L = getglobal("GL_ProfilerLocalizations");

local link_parser = function(link_to_parse)
	local _, _, itemid, enchant, socket1, socket2, socket3, temp, subid = string.find(link_to_parse, "item:(%d+):(%d+):(%d+):(%d+):(%d+):(%d+):(-?%d+):")
	return itemid, enchant, socket1, socket2, socket3, subid
end

local enchant_parser = function(link_to_parse)
	local _, _, itemid, item_name = string.find(link_to_parse, "enchant:(.+)|h%[.+: (.+)%]|")
	return itemid, item_name
end

local safe_round = function(num,digit)
	-- edge cases
	if(not tonumber(num)) then 
		return nil; 
	end
	if(digit==nil) then 
		digit=0; 
	end
	if(num==0) then 
		return num; 
	end
	
	-- prepare the format
	local fmt
	if(digit<10) then 
		fmt="%.0"..digit.."f";
	else 
		fmt="%."..digit.."f"; 
	end
	
	-- return it
	return format(fmt,num);
end

local initialize_profile = function()
	DEFAULT_CHAT_FRAME:AddMessage("|cffff8c00"..L["GL_INITIALIZING_PROFILE"].."|r")
	GUILDLAUNCH_SVARS.locale = GetLocale()
	GUILDLAUNCH_SVARS.server = GetRealmName()
	GUILDLAUNCH_SVARS.gender = UnitSex("player")
	GUILDLAUNCH_SVARS.character = UnitName("player")
	GUILDLAUNCH_SVARS.faction = UnitFactionGroup("player")
	GUILDLAUNCH_SVARS.race = UnitRace("player")
	GUILDLAUNCH_SVARS.class = UnitClass("player")
	GUILDLAUNCH_SVARS.battlegrounds = {}
	GUILDLAUNCH_SVARS.bobo = {"test"}
	GUILDLAUNCH_SVARS.quests = {}
	GUILDLAUNCH_SVARS.pvp_stats = {}
	GUILDLAUNCH_SVARS.pets = {}
	GUILDLAUNCH_SVARS.stats = {}
	GUILDLAUNCH_SVARS.skills = {}
	GUILDLAUNCH_SVARS.trade_skills = {}
	GUILDLAUNCH_SVARS.crafting = {}
	GUILDLAUNCH_SVARS.achievements = {} 
end

local initialize_glprofiler_variables = function()
	if (GUILDLAUNCH_SVARS["trade_skills"] == nil) then
		GUILDLAUNCH_SVARS.trade_skills = {}
		DEFAULT_CHAT_FRAME:AddMessage("|cffff8c00"..L["GL_RESETTING_TRADESKILLS"].."|r")
	end
	if (GUILDLAUNCH_SVARS["crafting"] == nil) then
		GUILDLAUNCH_SVARS.crafting = {}
		DEFAULT_CHAT_FRAME:AddMessage("|cffff8c00"..L["GL_RESETTING_CRAFTING"].."|r")
	end
	if (GUILDLAUNCH_SVARS["skills"] == nil) then
		GUILDLAUNCH_SVARS.skills = {}
		DEFAULT_CHAT_FRAME:AddMessage("|cffff8c00"..L["GL_RESETTING_SKILLS"].."|r")
	end
end

local update_skills = function()
	GUILDLAUNCH_SVARS.skills = {}
	local skill_title
	for i = 1, 0 do
		local skill_name, skill_header, _, skillRank, _, _, skillMaxRank = GetSkillLineInfo(i)
		if skill_header then
			skill_title = skill_name
			GUILDLAUNCH_SVARS.skills[skill_title] = {}
		elseif skill_title then
			GUILDLAUNCH_SVARS.skills[skill_title][skill_name] = { current = skillRank, max = skillMaxRank }
		end
	end

	local delete = {}
	for trade_skills in pairs(GUILDLAUNCH_SVARS.trade_skills) do
		local remove = true
		for trade_title, trade_name in pairs(GUILDLAUNCH_SVARS.skills) do
			for skill in pairs(trade_name) do
				if skill == trade_skills then 
					remove = nil 
					break 
				end
			end
		end
		if remove then 
			DEFAULT_CHAT_FRAME:AddMessage("|cffff8c00"..L["GL_REMOVING_UNKOWN_SKILL"]..": "..trade_skills.."|r") 
			table.insert(delete, trade_skills) 
		end
	end
	for _, j in ipairs(delete) do GUILDLAUNCH_SVARS.trade_skills[j] = nil end

	delete = {}
	for craft_skills in pairs(GUILDLAUNCH_SVARS["crafting"]) do
		local remove = true
		for trade_title, trade_name in pairs(GUILDLAUNCH_SVARS.skills) do
			for skill in pairs(trade_name) do
				if skill == craft_skills then
					--DEFAULT_CHAT_FRAME:AddMessage("|cffff8c00"..skill.."|r") 
					remove = nil
					break 
				end
			end
		end
		if remove then 
			DEFAULT_CHAT_FRAME:AddMessage("|cffff8c00"..L["GL_REMOVING_UNKOWN_SKILL"]..": "..craft_skills.."|r") 
			table.insert(delete, craft_skills) 
		end
	end
	for _, j in ipairs(delete) do GUILDLAUNCH_SVARS.crafting[j] = nil end
end

local get_id_from_link = function(link)
	if not link then return end
  	local itemIdInfo = string.gsub(link,".-\124H([^\124]*)\124h.*", "%1");
	local type, itemid, enchantId, jewelId1, jewelId2, jewelId3, jewelId4, suffixId, uniqueId = strsplit(":",itemIdInfo);
	return itemid;
end

local update_tradeskills = function()
	local char_trade = GetTradeSkillLine()
	local item_count = 0;
	if char_trade and (char_trade ~= "" or char_trade ~= UNKNOWN) then
		ExpandTradeSkillSubClass(0)
		GUILDLAUNCH_SVARS.trade_skills[char_trade] = {}
		if (GUILDLAUNCH_SVARS["test_data"] == nil) then
			GUILDLAUNCH_SVARS["test_data"] = {}
		end
		GUILDLAUNCH_SVARS["test_data"][char_trade] = {}
		GUILDLAUNCH_SVARS["test_data"][char_trade]["test_link"] = {}
		local trade_title
		local trade_count = GetNumTradeSkills()
		for i = 1, trade_count do
			local trade_name, trade_diff = GetTradeSkillInfo(i)
			if trade_diff == "header" then
				trade_title = trade_name
                if GUILDLAUNCH_SVARS.trade_skills[char_trade][trade_title] == nil then
                    GUILDLAUNCH_SVARS.trade_skills[char_trade][trade_title] = {}
                end
			elseif trade_title and trade_name ~= "" then
				local trade_itemid	
				local trade_link
				local trade_item_name,_,trade_item_rarity,trade_item_level,trade_item_min_level,trade_item_type, trade_item_sub_type,_,trade_equip_loc,trade_item_texture
				
				GUILDLAUNCH_SVARS["test_data"][char_trade][trade_title] = {}
					
				--[[if trade_title == "Enchant" or trade_title == "Engrave" or trade_title == "Modify" or trade_title == "Inscribe" or trade_title == "Emboss" or trade_title == "Tinker" or trade_title == "Embroider" then
					trade_link = GetTradeSkillRecipeLink(i)
					DEFAULT_CHAT_FRAME:AddMessage(trade_link)
					GUILDLAUNCH_SVARS["test_data"][char_trade]["test_link"..item_count] = trade_link
					
					DEFAULT_CHAT_FRAME:AddMessage("|cffff8c00" .. trade_itemid .. "|r")
					DEFAULT_CHAT_FRAME:AddMessage("|cffff8c00Enchant|r")
				else]]
				trade_link = GetTradeSkillItemLink(i)
				if (string.find(trade_link, "enchant:",1,true) == nil) then
					trade_link = GetTradeSkillItemLink(i)
					trade_itemid = get_id_from_link(trade_link)
					trade_item_name,_,trade_item_rarity,trade_item_level,trade_item_min_level,trade_item_type, trade_item_sub_type,_,trade_equip_loc,trade_item_texture = GetItemInfo(trade_itemid)				
					--GUILDLAUNCH_SVARS["test_data"][char_trade]["test_link"..item_count] = trade_link	
				else
					trade_link = GetTradeSkillRecipeLink(i)
					trade_itemid, trade_item_name = enchant_parser(trade_link)
					--GUILDLAUNCH_SVARS["test_data"][char_trade]["test_link"..item_count] = trade_link	
					--DEFAULT_CHAT_FRAME:AddMessage(trade_link)
				end				

				--end

				GUILDLAUNCH_SVARS.trade_skills[char_trade][trade_title][trade_item_name] = {}
				GUILDLAUNCH_SVARS.trade_skills[char_trade][trade_title][trade_item_name]["trade_itemid"] = trade_itemid
				GUILDLAUNCH_SVARS.trade_skills[char_trade][trade_title][trade_item_name]["trade_item_name"] = trade_item_name
				GUILDLAUNCH_SVARS.trade_skills[char_trade][trade_title][trade_item_name]["difficulty"] = trade_diff
				GUILDLAUNCH_SVARS.trade_skills[char_trade][trade_title][trade_item_name]["rarity"] =  trade_item_rarity
				GUILDLAUNCH_SVARS.trade_skills[char_trade][trade_title][trade_item_name]["level"] = trade_item_level
				GUILDLAUNCH_SVARS.trade_skills[char_trade][trade_title][trade_item_name]["min_level"] = trade_item_min_level
				GUILDLAUNCH_SVARS.trade_skills[char_trade][trade_title][trade_item_name]["type"] = trade_item_type
				GUILDLAUNCH_SVARS.trade_skills[char_trade][trade_title][trade_item_name]["sub_type"] = trade_item_sub_type
				GUILDLAUNCH_SVARS.trade_skills[char_trade][trade_title][trade_item_name]["equip_loc"] = trade_equip_loc
				GUILDLAUNCH_SVARS.trade_skills[char_trade][trade_title][trade_item_name]["texture"] = trade_item_texture

				local reagent_count = GetTradeSkillNumReagents(i)
				GUILDLAUNCH_SVARS.trade_skills[char_trade][trade_title][trade_item_name]["reagent_count"] = string.reagent_count
				local totalReagents = 0;
				GUILDLAUNCH_SVARS.trade_skills[char_trade][trade_title][trade_item_name]["reagents"] = {}
				--DEFAULT_CHAT_FRAME:AddMessage("|cffff8c00"..i.."--"..trade_item_name.."|r")
				for j=1, reagent_count, 1 do
					local reagentName, reagentTexture, reagentCount, playerReagentCount = GetTradeSkillReagentInfo(i, j)
					if reagentName then
						GUILDLAUNCH_SVARS.trade_skills[char_trade][trade_title][trade_item_name]["reagents"][reagentName] = {}
						GUILDLAUNCH_SVARS.trade_skills[char_trade][trade_title][trade_item_name]["reagents"][reagentName]["number"] = reagentCount
						GUILDLAUNCH_SVARS.trade_skills[char_trade][trade_title][trade_item_name]["reagents"][reagentName]["texture"] = reagentTexture
						totalReagents = totalReagents + reagentCount;
					end
				end
				
				item_count = item_count + 1;
			end
		end
	end
	DEFAULT_CHAT_FRAME:AddMessage("|cffff8c00"..char_trade.." "..L["GL_TRADESKILL_UPDATED"].." "..item_count.." items collected|r")
end

local get_quests = function()
	GUILDLAUNCH_SVARS.quests = {}
	quest_on = 0
	local i=1
	local area = ""
	local questTitle = ""
	num_entries, num_quests = GetNumQuestLogEntries();
	-- these numbers are all buggered up
	-- this will make it so that you can have 1 quest in each zone and still be alright with some buffer
	while (questTitle ~= nil and i < 50) do
		SelectQuestLogEntry(i);
		questTitle, level, difficulty, suggested_group, header, collapsed, completed = GetQuestLogTitle(i)
		if header then
			area = questTitle
		else
			GUILDLAUNCH_SVARS.quests[quest_on] = {}
			GUILDLAUNCH_SVARS.quests[quest_on].title = questTitle
			GUILDLAUNCH_SVARS.quests[quest_on].difficulty = difficulty
			GUILDLAUNCH_SVARS.quests[quest_on].area = area
			GUILDLAUNCH_SVARS.quests[quest_on].suggested_group = suggested_group
			GUILDLAUNCH_SVARS.quests[quest_on].completed = completed
			GUILDLAUNCH_SVARS.quests[quest_on].objectives = {}
			quest_on= quest_on+ 1			
		end
		i = i + 1
	end
	--DEFAULT_CHAT_FRAME:AddMessage("|cffff8c00Quest info updated|r")
end

local update_pvp = function()
	GUILDLAUNCH_SVARS.pvp_stats = {}
	GUILDLAUNCH_SVARS.pvp_stats.rank = 0
	GUILDLAUNCH_SVARS.pvp_stats.yesterday_hks, GUILDLAUNCH_SVARS.pvp_stats.yesterday_contribution = GetPVPYesterdayStats()	
	GUILDLAUNCH_SVARS.pvp_stats.hk,	GUILDLAUNCH_SVARS.pvp_stats.highest_rank = GetPVPLifetimeStats()
	GUILDLAUNCH_SVARS.pvp_stats.honor_currency = 0; --GetHonorCurrency()
	GUILDLAUNCH_SVARS.pvp_stats.arena_currency = 0; --GetArenaCurrency()
end

local parse_bag = function(id, num)
	local bag_contents = {}
	for i = 1, num do
		bag_contents[i] = {}
		local item_link = GetContainerItemLink(id, i)
		-- most of our current code trackes stuff based off of ID for using item stats
		-- but we need to grab the rest anyway
		if item_link then
			-- texture and count
			local item_name = GetItemInfo(item_link)
			bag_contents[i].item_name = item_name
			bag_contents[i].texture,
			bag_contents[i].count = GetContainerItemInfo(id, i)
			-- detailed info
			bag_contents[i].id,
			bag_contents[i].enchant,
			bag_contents[i].socket1,
			bag_contents[i].socket2,
			bag_contents[i].socket3,
			bag_contents[i].subid = link_parser(item_link)
		end
	end
	return bag_contents
end

local update_bank = function()
	-- get the bank main bag
	GUILDLAUNCH_SVARS.bank = { contents = parse_bag(BANK_CONTAINER, NUM_BANKGENERIC_SLOTS) }
	-- get another bag for each slot
	for bag_on = 1, GetNumBankSlots() do
		-- get the first bag after the player's bags
		local bag = bag_on + NUM_BAG_FRAMES
		-- get the link
		local link = GetInventoryItemLink("player",(ContainerIDToInventoryID(bag)))
		if link then
			-- get the item info
			local _, _, id = string.find(link, "item:(%d+):")
			-- get the texture
			local texture = GetInventoryItemTexture("player",(ContainerIDToInventoryID(bag)))
			-- save the bag info
			GUILDLAUNCH_SVARS.bank["Bag"..bag_on] = {item_name = item_name, bag_id = id, texture = texture, contents = parse_bag(bag, GetContainerNumSlots(bag)) }
		end
	end

	GUILDLAUNCH_SVARS.bank.scan_date = date("%Y-%m-%d")
	DEFAULT_CHAT_FRAME:AddMessage("|cffff8c00"..L["BANK_UPDATE_COMPLETE"].."|r")
end

local update_guildbank = function()
	local name
	local qty
	local j
	local item
	local num_guild_bank_tabs = GetNumGuildBankTabs()
	local total_items = 0

	GUILDLAUNCH_SVARS.guildbank = {}
	GUILDLAUNCH_SVARS.guildbank.num_tabs = num_guild_bank_tabs
	GUILDLAUNCH_SVARS.guildbank.money = GetGuildBankMoney()

	for tab_on = 1, num_guild_bank_tabs do
		local tab_name, icon, _, _, _, _ = GetGuildBankTabInfo(tab_on)
		GUILDLAUNCH_SVARS.guildbank["Tab"..tab_on] = {name=tab_name,icon=icon}
		local tab_contents = {}
		for j = 1,98 do
			_,qty = GetGuildBankItemInfo(tab_on ,j)
			item = GetGuildBankItemLink(tab_on ,j)			
			tab_contents[j] = {}
			if (item~=nil) then
				local _, _, item_id = string.find(item, "item:(%d+):")
				item_name,_,_,_,_,_,_,_,_ = GetItemInfo(item)
				tab_contents[j].item_name = item_name
				tab_contents[j].item_id = item_id 
				tab_contents[j].qty = qty
				total_items = total_items + 1
			end
		end
		GUILDLAUNCH_SVARS.guildbank["Tab"..tab_on].contents = tab_contents	
	end

	GUILDLAUNCH_SVARS.guildbank.scan_date = date("%Y-%m-%d")
end

local refresh_banktabs = function()
	local num_bank_tabs = GetNumGuildBankTabs()
	for tab_on = 1, num_bank_tabs do
		QueryGuildBankTab(tab_on)		 	
	end	
	DEFAULT_CHAT_FRAME:AddMessage("|cffff8c00"..L["BANK_UPDATE_COMPLETE"].."|r")
end

local update_friends = function()
	GUILDLAUNCH_SVARS.friends = {}
	for i = 1, GetNumFriends() do
		local name = GetFriendInfo(i)
		table.insert(GUILDLAUNCH_SVARS.friends, name)
	end 
end

local update_talents = function()
	GUILDLAUNCH_SVARS.talents = {}
	local loaded = LoadAddOn("Blizzard_TalentUI")
	if loaded then
		local talents = ""	
		local numGroups = 0
		local numTabs = 0

		for k = 1, numGroups do	
			GUILDLAUNCH_SVARS.talents[k] = {}					
			for i = 1, numTabs do
				local id, name, description, iconTexture, pointsSpent, background, previewPointsSpent, isUnlocked = GetTalentTabInfo(i, false, false, k) 
				GUILDLAUNCH_SVARS.talents[k][name] = { points_spent = pointsSpent }
	
				for j = 1, GetNumTalents(i) do
					local rank = select(5, GetTalentInfo(i, j, false, false, k))
					talents = talents..rank
				end
			end
			GUILDLAUNCH_SVARS.talents[k]["talent_link"] = talents;
			talents = ""
		end
	end
end

local update_base_stats = function()
	GUILDLAUNCH_SVARS.stats.basestats = {}

	-- base stats
	for i = 1, 5 do
		GUILDLAUNCH_SVARS.stats.basestats[i] = {}
		local base, stat, posbuff, negbuff = UnitStat("player",i)
		GUILDLAUNCH_SVARS.stats.basestats[i] = {number = i, base = base, stat = stat, posbuff = posbuff, negbuff = negbuff}
	end

	-- resistance info
	GUILDLAUNCH_SVARS.stats.resistance = {}
	for i = 0, 6 do
		GUILDLAUNCH_SVARS.stats.resistance[i] = {}
		local base, stat, posbuff, negbuff = UnitResistance("player",i)
		GUILDLAUNCH_SVARS.stats.resistance[i] = {number = i, base = base, stat = stat, posbuff = posbuff, negbuff = negbuff}
	end

	-- general stat info
	GUILDLAUNCH_SVARS.stats.mana = UnitManaMax("player")
	GUILDLAUNCH_SVARS.stats.powertype = UnitPowerType("player")
	GUILDLAUNCH_SVARS.stats.health = UnitHealthMax("player")
	
	-- extra 'global' stat info
	GUILDLAUNCH_SVARS.stats.parry = GetParryChance()
	GUILDLAUNCH_SVARS.stats.block = GetBlockChance()
	GUILDLAUNCH_SVARS.stats.dodge = GetDodgeChance()
	GUILDLAUNCH_SVARS.stats.crit = GetCritChance()
	
	local _, _, base, posBuff, negBuff = UnitArmor("player")
	GUILDLAUNCH_SVARS.stats.armor = {base = base, posbuff = posBuff, negbuff = negBuff}

	local base, posBuff = UnitDefense("player")
	GUILDLAUNCH_SVARS.stats.armor = {base = base, posbuff = posBuff, negbuff = 0}

	local base, posBuff = UnitDefense("player")
	GUILDLAUNCH_SVARS.stats.armor = {base = base, posbuff = posBuff, negbuff = 0}

end

local update_melee_stats = function()
	GUILDLAUNCH_SVARS.stats.meleestats = {}

	local base, posBuff, negBuff = UnitAttackPower("player")
	GUILDLAUNCH_SVARS.stats.meleestats.attack = {base = base, posbuff = posBuff, negbuff = negBuff}
	GUILDLAUNCH_SVARS.stats.meleestats.attackdps = safe_round(max((base+posBuff+negBuff), 0)/ATTACK_POWER_MAGIC_NUMBER,1);
	
	base,posBuff,negBuff = GetCombatRating(CR_EXPERTISE),safe_round(GetCombatRatingBonus(CR_EXPERTISE),2),0;
	GUILDLAUNCH_SVARS.stats.meleestats["Expertise"]={base = base, posbuff = posBuff, negbuff = negBuff}
	base,posBuff,negBuff = GetCombatRating(CR_HIT_MELEE),safe_round(GetCombatRatingBonus(CR_HIT_MELEE),2),0;
	GUILDLAUNCH_SVARS.stats.meleestats["HitRating"]={base = base, posbuff = posBuff, negbuff = negBuff}
	base,posBuff,negBuff = GetCombatRating(CR_CRIT_MELEE),safe_round(GetCombatRatingBonus(CR_CRIT_MELEE),2),0;
	GUILDLAUNCH_SVARS.stats.meleestats["CritRating"]={base = base, posbuff = posBuff, negbuff = negBuff}
	base,posBuff,negBuff = GetCombatRating(CR_HASTE_MELEE),safe_round(GetCombatRatingBonus(CR_HASTE_MELEE),2),0;
	GUILDLAUNCH_SVARS.stats.meleestats["HasteRating"]={base = base, posbuff = posBuff, negbuff = negBuff}
	base,posBuff,negBuff = GetCombatRating(CR_ARMOR_PENETRATION),safe_round(GetCombatRatingBonus(CR_ARMOR_PENETRATION),2),0;
	GUILDLAUNCH_SVARS.stats.meleestats["ArmorPenRating"]={base = base, posbuff = posBuff, negbuff = negBuff}
	GUILDLAUNCH_SVARS.stats.meleestats["AttackPowerDPS"]=safe_round(max((base+posBuff+negBuff), 0)/ATTACK_POWER_MAGIC_NUMBER,1);	
	
	local lowDmg, hiDmg, offlowDmg, offhiDmg, posBuff, negBuff, percentmod = UnitDamage("player");
	GUILDLAUNCH_SVARS.stats.meleestats["Damage"] = {lowDmg = safe_round(lowDmg,0), hiDmg = safe_round(hiDmg,0), offlowDmg = safe_round(offlowDmg,0), offhiDmg = safe_round(offhiDmg,0), posBuff = posBuff, negBuff = negBuff, percentmod = percentmod}

		
	GUILDLAUNCH_SVARS.stats.meleestats["CritChance"]=safe_round(GetCritChance(),2)
	
	local speed,offhandSpeed = UnitAttackSpeed("player")
	GUILDLAUNCH_SVARS.stats.meleestats["MainHand"]={};
	GUILDLAUNCH_SVARS.stats.meleestats["MainHand"]["AttackSpeed"]=safe_round(speed,2)
		
	if ( offhandSpeed ) then
		GUILDLAUNCH_SVARS.stats.meleestats["OffHand"]={};
		GUILDLAUNCH_SVARS.stats.meleestats["OffHand"]["AttackSpeed"]=safe_round(offhandSpeed,2)
	end			
	
end

local update_ranged_stats = function()
	GUILDLAUNCH_SVARS.stats.rangedstats = {}

	local base, posBuff, negBuff = UnitRangedAttackPower("player")
	GUILDLAUNCH_SVARS.stats.rangedstats.attackpower = {base = base, posbuff = posBuff, negbuff = negBuff}
	
	local speed, lowDmg, hiDmg, posBuff, negBuff, percent = UnitRangedDamage("player");
	GUILDLAUNCH_SVARS.stats.rangedstats.attack = {speed = safe_round(speed, 2), lowDmg = safe_round(lowDmg), hiDmg = safe_round(hiDmg), posBuff = posBuff, negBuff = negBuff, percent = safe_round(percent, 2)}
		
	base,posBuff,negBuff = GetCombatRating(CR_HASTE_RANGED),safe_round(GetCombatRatingBonus(CR_HASTE_RANGED),2),0;
	GUILDLAUNCH_SVARS.stats.rangedstats["HasteRating"]={base = base, posbuff = posBuff, negbuff = negBuff}	
	
	base,posBuff,negBuff = GetCombatRating(CR_HIT_RANGED),safe_round(GetCombatRatingBonus(CR_HIT_RANGED),2),0;
	GUILDLAUNCH_SVARS.stats.rangedstats["HitRating"]={base = base, posbuff = posBuff, negbuff = negBuff}
	
	base,posBuff,negBuff = GetCombatRating(CR_CRIT_RANGED),safe_round(GetCombatRatingBonus(CR_CRIT_RANGED),2),0;
	GUILDLAUNCH_SVARS.stats.rangedstats["CritRating"]={base = base, posbuff = posBuff, negbuff = negBuff}
	
	GUILDLAUNCH_SVARS.stats.rangedstats["CritChance"]=safe_round(GetRangedCritChance(),2)
end

local update_spell_stats = function()
	GUILDLAUNCH_SVARS.stats.spellstats = {}
	
	GUILDLAUNCH_SVARS.stats.spellstats["BonusHealing"] = GetSpellBonusHealing()
	
	local holySchool = 2;
	local minCrit = GetSpellCritChance(holySchool)

	for i=holySchool,MAX_SPELL_SCHOOLS do
		bonusDamage = GetSpellBonusDamage(i)
		spellCrit = GetSpellCritChance(i)
		minCrit = min(minCrit,spellCrit)
	end
	GUILDLAUNCH_SVARS.stats.spellstats["CritChance"] = safe_round(minCrit,2)
	
	GUILDLAUNCH_SVARS.stats.spellstats["BonusDamage"]=GetSpellBonusDamage(holySchool)
	
	base,posBuff,negBuff = GetCombatRating(CR_HIT_SPELL),safe_round(GetCombatRatingBonus(CR_HIT_SPELL),2),0;
	GUILDLAUNCH_SVARS.stats.spellstats["HitRating"]={base = base, posBuff = posBuff, negBuff = negBuff}
	
	base,posBuff,negBuff = GetCombatRating(CR_CRIT_SPELL),safe_round(GetCombatRatingBonus(CR_CRIT_SPELL),2),0;
	GUILDLAUNCH_SVARS.stats.spellstats["CritRating"]={base = base, posBuff = posBuff, negBuff = negBuff}
	
	base,posBuff,negBuff = GetCombatRating(CR_HASTE_SPELL),safe_round(GetCombatRatingBonus(CR_HASTE_SPELL),2),0;
	GUILDLAUNCH_SVARS.stats.spellstats["HasteRating"]={base = base, posBuff = posBuff, negBuff = negBuff}
	
	GUILDLAUNCH_SVARS.stats.spellstats["Penetration"] = GetSpellPenetration()
	
	local base,casting = GetManaRegen();
	base = floor( (base * 5.0) + 0.5);
	casting = floor( (casting * 5.0) + 0.5);
	GUILDLAUNCH_SVARS.stats.spellstats["ManaRegen"] = {base = base, casting = casting}	
end

local update_defense_stats = function()
	GUILDLAUNCH_SVARS.stats.defensestats = {};
	
	local base,posBuff,negBuff,modBuff,effBuff,stat;
	base,modBuff = UnitDefense("player");
	posBuff,negBuff = 0,0;
	if ( modBuff > 0 ) then
		posBuff = modBuff;
	elseif ( modBuff < 0 ) then
		negBuff = modBuff;
	end	
	
	GUILDLAUNCH_SVARS.stats.defensestats["Defense"] = {base = base, posBuff = posBuff, negBuff = negBuff}
	base,effBuff,stat,posBuff,negBuff=UnitArmor("player");
	GUILDLAUNCH_SVARS.stats.defensestats["Armor"] = {base = base, posBuff = posBuff, negBuff = negBuff}
	GUILDLAUNCH_SVARS.stats.defensestats["ArmorReduction"] = PaperDollFrame_GetArmorReduction(effBuff, UnitLevel("player"));
	base,posBuff,negBuff = 0,0,0; --GetCombatRating(CR_DEFENSE_SKILL),safe_round(GetCombatRatingBonus(CR_DEFENSE_SKILL),2),0;
	GUILDLAUNCH_SVARS.stats.defensestats["DefenseRating"]= {base = base, posBuff = posBuff, negBuff = negBuff}
	GUILDLAUNCH_SVARS.stats.defensestats["DefensePercent"]=0;--GetDodgeBlockParryChanceFromDefense();
	base,posBuff,negBuff = 0,0,0; --GetCombatRating(CR_DODGE),safe_round(GetCombatRatingBonus(CR_DODGE),2),0;
	GUILDLAUNCH_SVARS.stats.defensestats["DodgeRating"]= {base = base, posBuff = posBuff, negBuff = negBuff}
	GUILDLAUNCH_SVARS.stats.defensestats["DodgeChance"]= safe_round(GetDodgeChance(),2);
	base,posBuff,negBuff = 0,0,0; --GetCombatRating(CR_BLOCK),safe_round(GetCombatRatingBonus(CR_BLOCK),2),0;
	GUILDLAUNCH_SVARS.stats.defensestats["BlockRating"]= {base = base, posBuff = posBuff, negBuff = negBuff}
	GUILDLAUNCH_SVARS.stats.defensestats["BlockChance"]= safe_round(GetBlockChance(),2);
	base,posBuff,negBuff = 0,0,0; --GetCombatRating(CR_PARRY),safe_round(GetCombatRatingBonus(CR_PARRY),2),0;
	GUILDLAUNCH_SVARS.stats.defensestats["ParryRating"]= {base = base, posBuff = posBuff, negBuff = negBuff}
	GUILDLAUNCH_SVARS.stats.defensestats["ParryChance"]= safe_round(GetParryChance(),2);
	GUILDLAUNCH_SVARS.stats.defensestats["Resilience"]={};
	GUILDLAUNCH_SVARS.stats.defensestats["Resilience"]["Melee"]=0,0,0; --GetCombatRating(CR_CRIT_TAKEN_MELEE);
	GUILDLAUNCH_SVARS.stats.defensestats["Resilience"]["Ranged"]=0,0,0; --GetCombatRating(CR_CRIT_TAKEN_RANGED);
	GUILDLAUNCH_SVARS.stats.defensestats["Resilience"]["Spell"]=0,0,0; --GetCombatRating(CR_CRIT_TAKEN_SPELL);
end

local update_stats = function()
	GUILDLAUNCH_SVARS.stats = {}
	update_base_stats()
	update_melee_stats()
	update_ranged_stats()
	update_spell_stats()
	update_defense_stats()
end

local update_equipped_items = function()
	GUILDLAUNCH_SVARS.equipped = {}	
	
	local all_slots = { "HeadSlot",
						"NeckSlot",
						"ShoulderSlot",
						"BackSlot",
						"ChestSlot",
						"ShirtSlot",
						"TabardSlot",
						"WristSlot",
						"HandsSlot",
						"WaistSlot",
						"LegsSlot",
						"FeetSlot",
						"Finger0Slot",
						"Finger1Slot",
						"Trinket0Slot",
						"Trinket1Slot",
						"MainHandSlot",
						"SecondaryHandSlot",
						"Bag0Slot",
						"Bag1Slot",
						"Bag2Slot",
						"Bag3Slot"
					}
	
	for i, v in ipairs(all_slots) do
    	--print(i .. " " .. v)
		local slotId = GetInventorySlotInfo(v)
		local link = GetInventoryItemLink("player", slotId)
		if (link) then
			local item_name = GetItemInfo(link)
			local inventory_itemid = link_parser(link)	
			GUILDLAUNCH_SVARS.equipped[v] = {item_id = inventory_itemid, item_name = item_name}	
		end    	
	end					
end	


local record_reputation = function()
	GUILDLAUNCH_SVARS.reputation = {}
	local collapsed = {}
	for i = 1, GetNumFactions() do
		local faction_info = { GetFactionInfo(i) }
		local faction_name = select(1, faction_info)
		local is_collapsed = select(10, faction_info)
		if is_collapsed then collapsed[faction_name] = true end
	end
	ExpandFactionHeader(0)
	for i = 1, GetNumFactions() do
		local name, _, standing, bottom_value, top_value, earned, at_war, _, header = GetFactionInfo(i)
		if header then
			faction_group = name
		end
		if name and not header then
			GUILDLAUNCH_SVARS.reputation[name] = { standing = standing, value = earned, at_war = at_war, faction_group = faction_group, top_value=top_value, bottom_value = bottom_value }
		end
	end
	for i = 1, GetNumFactions() do
		local name = GetFactionInfo(i)
		if collapsed[name] then CollapseFactionHeader(i) end
	end
end


local update_inventory = function()
	GUILDLAUNCH_SVARS.money = GetMoney()
	GUILDLAUNCH_SVARS.inventory = { backpack = parse_bag(0, 16) }
	for bag = 1, NUM_BAG_FRAMES do
		local name = "Bag"..bag
		local link = GetInventoryItemLink("player",(ContainerIDToInventoryID(bag)))
		local texture = GetInventoryItemTexture("player",(ContainerIDToInventoryID(bag)))
		if link then
			local _, _, id = string.find(link, "item:(%d+):")
			GUILDLAUNCH_SVARS.inventory[name] = { bag_id = id, texture = texture, contents = parse_bag(bag, GetContainerNumSlots(bag)) }
		end
	end
end

local update_guild = function()
	local name, rank_name, rank_index = GetGuildInfo("player")
	if name then
		GUILDLAUNCH_SVARS.guild = name
		GUILDLAUNCH_SVARS.guildrank = rank_index
		GUILDLAUNCH_SVARS.guildrankname = rank_name
		GUILDLAUNCH_SVARS.guildmembers = {}
		GuildRoster()
		local count = GetNumGuildMembers(true)
		for i = 1, count do
			local name, rank_name, rank_index, level, class = GetGuildRosterInfo(i)
			local race = UnitRace(name);
			if (race == nil) then
				race = "Unknown"
			end
			GUILDLAUNCH_SVARS.guildmembers[name] = { rank_name = rank, guildrank = rank_index, class = class, level = level, race = race }
		end
	elseif GUILDLAUNCH_SVARS.guild then
		GUILDLAUNCH_SVARS.guild = nil
		GUILDLAUNCH_SVARS.guildrank = nil
		GUILDLAUNCH_SVARS.guildrankname = nil
		GUILDLAUNCH_SVARS.guildmembers = nil
	end
end

local update_guild_ranks = function()
	local num_guild_ranks = GuildControlGetNumRanks()
	--DEFAULT_CHAT_FRAME:AddMessage("|cffff8c00"..num_guild_ranks.."|r")
	GUILDLAUNCH_SVARS.guild_ranks = {}

	for i=1, num_guild_ranks do
		local rank_name = GuildControlGetRankName(i)
		--DEFAULT_CHAT_FRAME:AddMessage("|cffff8c00"..i.."--"..rank_name.."|r")
		GUILDLAUNCH_SVARS.guild_ranks[rank_name] = {id = i}
	end
end

local update_active_pet = function()
	GUILDLAUNCH_SVARS.pets = GUILDLAUNCH_SVARS.pets or {}	
	petIcon, petName, petLevel, petFamily, petLoyalty = GetStablePetInfo(0)
	DEFAULT_CHAT_FRAME:AddMessage("|cffff8c00--"..petName.."<---|r")
	if petName then
		GUILDLAUNCH_SVARS.pets[petName] = {}
		GUILDLAUNCH_SVARS.pets[petName] = {texture = petIcon, level = petLevel, family = petFamily, loyalty = petLoyalty}
		-- DEFAULT_CHAT_FRAME:AddMessage("|cffff8c00--"..petName.."|r")
	end
end


local update_pet_info = function(unit_id)
	-- get the pet info
	GUILDLAUNCH_SVARS.pets = GUILDLAUNCH_SVARS.pets or {}
	local num_stable_pets = 0
	-- 0 is the first pet
	petIcon, petName, petLevel, petFamily, petLoyalty = GetStablePetInfo(0)

	if petName then
		GUILDLAUNCH_SVARS.pets[petName] = {}
		GUILDLAUNCH_SVARS.pets[petName] = {texture = petIcon, level = petLevel, family = petFamily, loyalty = petLoyalty}
	end

	for i=1, num_stable_pets do
		petIcon, petName, petLevel, petFamily, petLoyalty = GetStablePetInfo(i)
		if petName then
			GUILDLAUNCH_SVARS.pets[petName] = {}
			GUILDLAUNCH_SVARS.pets[petName] = {texture = petIcon, level = petLevel, family = petFamily, loyalty = petLoyalty}
		end
	end
	DEFAULT_CHAT_FRAME:AddMessage("|cffff8c00Pet info updated|r")
end

local update_achievements = function()
	GUILDLAUNCH_SVARS.achievements = {}
	local title, parentCatId, achID, achName, completed
	
	for _, catid in pairs(GetCategoryList()) do	
		title, parentCatId = GetCategoryInfo(catid)
		GUILDLAUNCH_SVARS.achievements[catid] = {}
		GUILDLAUNCH_SVARS.achievements[catid]["Title"] = title
		GUILDLAUNCH_SVARS.achievements[catid]["ParentCat"] = parentCatId
		GUILDLAUNCH_SVARS.achievements[catid]["Achievements"] = {}
    	for index = 1, GetCategoryNumAchievements(catid) do
      		achID, achName, achPoints, completed, month, day, year, description, flags, image = GetAchievementInfo(catid, index)
      		GUILDLAUNCH_SVARS.achievements[catid]["Achievements"][achID] = {}
      		GUILDLAUNCH_SVARS.achievements[catid]["Achievements"][achID]["name"] = achName
			GUILDLAUNCH_SVARS.achievements[catid]["Achievements"][achID]["points"] = achPoints    
			GUILDLAUNCH_SVARS.achievements[catid]["Achievements"][achID]["completed"] = completed
			GUILDLAUNCH_SVARS.achievements[catid]["Achievements"][achID]["icon"] = image
    	end
  	end
end

local update_profile = function()
	GUILDLAUNCH_SVARS.level = UnitLevel("player")
	update_pvp()
	update_skills()
	record_reputation()
	update_inventory()
	update_talents()
	update_stats()
	update_equipped_items()
	update_friends()
	update_inventory()
	update_guild()
	update_guild_ranks()
	get_quests()
	update_achievements()
end


local onevent = function(self, event, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9)
	-- most things will happen nicely on their own using events
	-- http://www.wowwiki.com/Events_that_fire_during_the_Loading_Process for explanation of why certain things are done where
	--DEFAULT_CHAT_FRAME:AddMessage("|cffff8c00Event:"..event.."|r")
	if event == "PLAYER_LOGIN" then
		local mod_version = GetAddOnMetadata("GuildLaunchProfiler", "Version")
		local export_version = GetAddOnMetadata("GuildLaunchProfiler", "X-ExportVersion")
		DEFAULT_CHAT_FRAME:AddMessage("|cffff8c00Guild Launch Profiler Version "..mod_version.." Loaded|r")
		if GUILDLAUNCH_SVARS.mod_version and GUILDLAUNCH_SVARS.mod_version ~= mod_version then
			DEFAULT_CHAT_FRAME:AddMessage("|cffff8c00Stored Data Version is: "..GUILDLAUNCH_SVARS.mod_version.."|r")
			GUILDLAUNCH_SVARS = {}
			initialize_profile()
		end
		GUILDLAUNCH_SVARS.mod_version = mod_version
		GUILDLAUNCH_SVARS.export_version = export_version
		GUILDLAUNCH_SVARS.wow_version = GetBuildInfo()
		if not GUILDLAUNCH_SVARS.locale then 
			initialize_profile() 
		end
		-- give us a place to initiate a profile load
		UnitPopupButtons["GUILDLAUNCH_SVARS"] = { text = "Create Guild Launch Profile", dist = 0 }
		table.insert(UnitPopupMenus["SELF"], "GUILDLAUNCH_SVARS")
		hooksecurefunc("UnitPopup_OnClick", update_profile)
	elseif event == "PLAYER_ENTERING_WORLD" then
		self:UnregisterEvent(event)
		self.played = GetTime() + 3
		DEFAULT_CHAT_FRAME:AddMessage("|cffff8c00The Guild Launch Profiler will attempt to gather data automatically. You can initiate a data gather by right clicking your player portrait and choosing Create Guild Launch Profile|r")
	elseif event == "TIME_PLAYED_MSG" then
		self.played = nil
		GUILDLAUNCH_SVARS.time_played = arg1
		GUILDLAUNCH_SVARS.level_played = arg2
		if not self.updated then
			self.updated = true
			update_profile()
		end
	elseif event == "PET_STABLE_SHOW" then
		update_pet_info()		
	elseif event == "TRADE_SKILL_SHOW" then
		update_tradeskills()
	elseif event == "CHARACTER_POINTS_CHANGED" then
		update_talents()
	elseif event == "FRIENDLIST_UPDATE" then
		update_friends()
	elseif event == "PLAYER_GUILD_UPDATE" then
		update_guild()
	elseif event == "PLAYER_LEVEL_UP" then
		--DEFAULT_CHAT_FRAME:AddMessage("Level Up"..arg2.." "..arg3.." "..arg4.." "..arg5.." "..arg6.." "..arg7)
		GUILDLAUNCH_SVARS.level = arg1
		GUILDLAUNCH_SVARS.levelinfo = GUILDLAUNCH_SVARS.levelinfo or {}
		GUILDLAUNCH_SVARS.levelinfo[arg1] = {
			hp = arg2,
			mp = arg3,
			strength = arg5,
			agility = arg6,
			stamina = arg7,
			intellect = arg8,
			spirit = arg9,
		}
		update_profile()
	elseif event == "UNIT_INVENTORY_CHANGED" and arg1 == "player" then
		update_inventory()
	elseif event == "BANKFRAME_CLOSED" then
		update_bank()
	elseif event == "HONOR_CURRENCY_UPDATE" or event == "PLAYER_PVP_RANK_CHANGED" then
		update_pvp()
	elseif event == "GUILDBANKFRAME_OPENED" then
		refresh_banktabs()
	elseif (event == "GUILDBANK_UPDATE_TABS" or event=="GUILDBANKBAGSLOTS_CHANGED") then
		update_guildbank();
	elseif (event == "VARIABLES_LOADED") then
		initialize_glprofiler_variables();
	end
end

local on_update = function(self, e)
	if self.played then
		local time = GetTime()
		if self.played <= time then
			self.played = nil
			RequestTimePlayed()
		end
	end
	if self.recorded then
		self.recorded = self.recorded + e
		if self.recorded >= 10 then
			self.recorded = nil
		end
	end
end


-- we don't need the name right now, but we might for some reason later
local mod_frame = CreateFrame("Frame","GuildLaunchProfiler")
mod_frame:RegisterEvent("PLAYER_LOGIN")
mod_frame:RegisterEvent("PLAYER_ENTERING_WORLD")
mod_frame:RegisterEvent("TRADE_SKILL_SHOW")
mod_frame:RegisterEvent("UPDATE_BATTLEFIELD_STATUS")
mod_frame:RegisterEvent("UPDATE_BATTLEFIELD_SCORE")
mod_frame:RegisterEvent("BANKFRAME_CLOSED")
mod_frame:RegisterEvent("UNIT_INVENTORY_CHANGED")
mod_frame:RegisterEvent("PLAYER_LEVEL_UP")
mod_frame:RegisterEvent("PLAYER_GUILD_UPDATE")
mod_frame:RegisterEvent("FRIENDLIST_UPDATE")
mod_frame:RegisterEvent("TIME_PLAYED_MSG")
mod_frame:RegisterEvent("PLAYER_PVP_RANK_CHANGED")
mod_frame:RegisterEvent("ARENA_TEAM_ROSTER_UPDATE")
mod_frame:RegisterEvent("CHARACTER_POINTS_CHANGED")
mod_frame:RegisterEvent("UPDATE_BATTLEFIELD_SCORE")
mod_frame:RegisterEvent("UPDATE_BATTLEFIELD_STATUS")
mod_frame:RegisterEvent("PET_STABLE_SHOW")
mod_frame:RegisterEvent("GUILDBANKFRAME_OPENED");
mod_frame:RegisterEvent("GUILDBANK_UPDATE_TABS");
mod_frame:RegisterEvent("GUILDBANKBAGSLOTS_CHANGED");
mod_frame:RegisterEvent("PLAYERBANKSLOTS_CHANGED");
mod_frame:RegisterEvent("VARIABLES_LOADED");
mod_frame:SetScript("OnEvent", onevent)
mod_frame:SetScript("OnUpdate", function(self, arg1) on_update(self, arg1) end)
