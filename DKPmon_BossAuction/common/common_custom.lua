-----------------------------------------------
-- Custom Functions Common to both bid modes --
-----------------------------------------------

local L = DKPmonBA.L
local dewdrop = DKPmonBA.dewdrop
local deformat = DKPmonBA.deformat

	function DKPmonBA:CommonInitialize()
		local cInfo = DKPmon.CustomInfo:Get("BossAuction")
		self:SetDebugging(cInfo.debug)
		self:Debug("DKPmon_BossAuction debugging on")
				
		local db = DKPmon.DKP:GetDB("BossAuction")
		if db.qualityThreshold == nil then
			 db.qualityThreshold = 4
		end
		 if db.autoMasterLoot == nil then
			 db.autoMasterLoot = true
		 end
		 if db.pendingReminder == nil then
			 db.pendingReminder = true
		 end
			 
		 if db.selectedPool == nil then
			 db.selectedPool = 1
		 end		 
		 if db.autoTimedPoints == nil then
			 db.autoTimedPoints = true
		 end	
		 if db.awardTimedInBackground == nil then
		 	db.awardTimedInBackground = false
		 end
		 
		 --We want this to reset every login because setting it registers a timer
		 self.periodicDkpIndex = 0
		 self.dkpLeader = UnitName("player")
		 
		 if not self:IsBucketEventRegistered("ZONE_CHANGED_NEW_AREA") then
			 self:RegisterBucketEvent("ZONE_CHANGED_NEW_AREA",1,"ZONE_CHANGED_NEW_AREA")
		 end       		 
       
		 --self:Hook(DKPmon,"SetLeader","SetLeaderHook")
		 self:Hook(DKPmon,"ReceiveLeaderClaim","ReceiveLeaderClaimHook")
		self:Hook(DKPmon.LootItem,"SetItem","SetItemHook")
	end
	
   --Create a backreference so we can get at the itembutton from dkpinfo
   function DKPmonBA:SetItemHook(itembutton,iteminfo)
      self:Debug("Creating itemId back reference in dkpinfo")
      self.hooks[DKPmon.LootItem].SetItem(itembutton,iteminfo)
      itembutton:GetDKPInfo().itemId = itembutton.id --change to itemId, check if propigates
   end
   
	function DKPmonBA:ReceiveLeaderClaimHook(dkpmon,sender)
		self.hooks[DKPmon]["ReceiveLeaderClaim"](dkpmon,sender)
		if sender == nil then return end
		self.dkpLeader = sender
		if self:DkpSystemInactive() then return end
		self:CheckLeaderSetup()
		DKPmon:Print(string.format(L["DKP leader changed to %s"],sender))
	end
	
	--[[
		Hooks into DKPmon.SetLeader
		Calls CheckLeaderSetup
	]]
	function DKPmonBA:SetLeaderHook(dkpmon, val)
		self.hooks[DKPmon]["SetLeader"](dkpmon, val)
		if self:DkpSystemInactive() then return end
		self:CheckLeaderSetup()
	end
	

	--[[
	BuildBossTable
	Description:
	  Called when we are building the boss selection portions of the dewdrop menu.
	Input:
	  bosstab -- table; table, or subtable, of the fdkpCustom.bossvalues table
	Returns:
	  table -- dewdrop table to use as args field of a 'group' item
	]]
	function DKPmonBA:BuildBossTable(bosstab)
	   local dewtab = {}
	   local instanceIndex = 1
	   for instanceName, instanceData in pairs(bosstab) do
		if instanceData ~= nil then
			dewtab[instanceIndex] = { type='group',name=instanceName,desc=instanceName}
			local args = {}
			args.header = {type='header',name=instanceName, order = 1}
			local bossIndex = 1
			for bossName,_ in pairs(instanceData) do
				if bossName ~= "TimedPoints" then
					args[bossIndex] = {
						type = 'execute',
						name=bossName,
						desc = string.format(L["Award points for boss: %s"], bossName),
						func = function()
							self:AwardBossDkp(instanceName, bossName)
						end
					}
					bossIndex = bossIndex + 1
				end
			end
			dewtab[instanceIndex]["args"] = args
		end
			instanceIndex = instanceIndex + 1
	   end
	   
	   return dewtab
	end
	
	
	--[[
	Called when the "Select DKP Pool" button is clicked
	]]
	function DKPmonBA:OnSelectDkpPoolButtonClick()
		if self.selectDkpPoolActionMenu == nil then
			local mydb = DKPmon.DKP:GetDB("BossAuction")		
			local cInfo = DKPmon.CustomInfo:Get("BossAuction")
			
			local ptab = cInfo.poolnames
			validateTab = {}
			for i = 1,cInfo.numpools do
				validateTab["p"..i] = ptab[i]
			end
					
			local dewtab = { type = 'text', name=L['Select Dkp Pool'], desc = L['Select which dkp pool to use for awarding and bidding.'],
			usage='<number>',
			get = function() return "p"..mydb.selectedPool end,
			set = function(v) mydb.selectedPool = tonumber(string.sub(v,2)) end,
			validate = validateTab,
			order = 1 
			 }
	
			self.selectDkpPoolActionMenu = dewtab
			
		end
		
		dewdrop:Open(self.awardframe.selectDkpPoolButton, 'children', self.selectDkpPoolActionMenu, 'point', 'TOP', 'relativepoint', 'TOP')
		
	end
	
	--[[
	Called when "Select Periodic DKP" button is clicked
	]]
	function DKPmonBA:OnSelectPeriodicDkpButtonClick()
		if self.selectPeriodicDkpActionMenu == nil then
			local cInfo = DKPmon.CustomInfo:Get("BossAuction")
			--Construct Validate table
	
			local validateTab = {}
			validateTab["p0"] = L["Timed Points Off."]
			
			for i,pdTab in ipairs(cInfo.periodicDkp) do
				validateTab["p"..i] = string.format(L["%d dkp every %d minutes"], pdTab.amount, pdTab.interval)
			end		
				
			local dewtab = {type = 'text', name=L['Timed Points'], desc=L['Select the timed points rate to use'],
				usage = '<number>',
				get = function() return "p"..self.periodicDkpIndex end,
				set = function(v) self:SelectPeriodicDkp(tonumber(string.sub(v,2))) end,
				validate = validateTab,
				order = 1
				}
	
			self.selectPeriodicDkpActionMenu = dewtab
			
		end
		
	   dewdrop:Open(self.awardframe.selectPeriodicDkpButton, 'children', self.selectPeriodicDkpActionMenu, 'point', "TOP", 'relativepoint', "TOP")
			
	end
	
	--[[
	Called when Select Boss Button is clicked
	]]
	function DKPmonBA:OnSelectBossButtonClick()
		if self.selectBossActionMenu == nil then
		  local cInfo = DKPmon.CustomInfo:Get("BossAuction")
		  local dewtab = { type = 'group' }
			local args = self:BuildBossTable(cInfo.bossvalues)
			args.header = {type='header',name=L['Instances'], order = 1}
			dewtab.args = args
		  
		  self.selectBossActionMenu = dewtab
	   end
	   dewdrop:Open(self.awardframe.selectBossButton, 'children', self.selectBossActionMenu, 'point', "TOP", 'relativepoint', "TOP")
	end
	
	
	--[[
	Called when Custom Points Button is clicked
	]]
	function DKPmonBA:OnCustomPointsButtonClick()
		if self.customPointsActionMenu == nil then
			local mydb = DKPmon.DKP:GetDB("BossAuction")		
			local cInfo = DKPmon.CustomInfo:Get("BossAuction")
			-- Add in the menu for specifying a custom number of points to award
			local dewtab = { type = 'group', args={}}
			dewtab.args.appendcurr = {
			type = 'execute', name = L['Append current'], desc = L['Append the currently specified custom amount to the list of points to be awarded.'],
			func = function()
				if self.customaward.amount == 0 then return end
				DKPmon.Awarding:AppendPointAward({ pool = mydb.selectedPool, amount = self.customaward.amount, source = self.customaward.title })
			end,
			order = 2
			}
			dewtab.args.pool = {
			type = 'text', name = L['Event Title'], desc = L['Type a title for this dkp event.'], usage=L["<Event Title>"],
			get = function() return self.customaward.title end,
			set = function(v)
				self.customaward.title = v
			end,
			validate = function(v)
				return v ~= nil and v ~= ""
			end,
			order = 3
			}
			dewtab.args.amount = {
			type = 'text', name = L['Specify points'], usage = "<number>", desc = L["Specify the number of points to award. This can be negative."],
			get = function()
				return string.format("%g", self.customaward.amount)
			end,
			set = function(v)
				self.customaward.amount = tonumber(v)
			end,
			validate = function(v)
				return tonumber(v) ~= nil
			end,
			input = false,
			order = 4
			}
			self.customPointsActionMenu = dewtab
		end
		
		dewdrop:Open(self.awardframe.customPointsButton, 'children', self.customPointsActionMenu, 'point', "TOP", 'relativepoint', "TOP")
		
	end
	
	
	--[[
	Switch to this periodic dkp's index, registers events to award points when the timer expires
	   ]]
	function DKPmonBA:SelectPeriodicDkp(index)
		self:Debug("SelectPeriodicDkp(): Index set to "..index)
		self.periodicDkpIndex = index
		--Unregister event
		if self.periodicEventId ~= nil and self:IsEventScheduled(self.periodicEventId) then
				self:CancelScheduledEvent(self.periodicEventId)
				DKPmon:Print(L["Current Timed Points event cancelled."])
				self.periodicEventId = nil
		end	
	
		if index == 0 then
			return
		else
			local cInfo = DKPmon.CustomInfo:Get("BossAuction")
			local pdkp = cInfo.periodicDkp[index]
			if pdkp == nil then
				DKPmon:Print("ERROR: Invalid periodicDKP index!: "..index)
				return
			end
			--Register event
			self.periodicEventId = "DKPmon_BossAuction-" .. math.random()
			self:ScheduleRepeatingEvent(self.periodicEventId, self.OnPeriodicInterval,pdkp.interval*60,self)
			DKPmon:Print(string.format(L["%s: %d dkp will be awarded every %.2f minutes."],pdkp.name,pdkp.amount, pdkp.interval))
			--Starts the timer
			DKPmon.Awarding:Show()
		end
	end
	--[[
	Callback for the periodic dkp.
	Appends periodic dkp point award.
	]]
	function DKPmonBA:OnPeriodicInterval()
		local cInfo = DKPmon.CustomInfo:Get("BossAuction")	
		local pdkp = cInfo.periodicDkp[self.periodicDkpIndex]
		if pdkp == nil then
			DKPmon:Print("ERROR:  Couldn't get periodic dkp table, this should never happen!")
			self:SelectPeriodicDkp(0)
			return
		end
		
		local mydb = DKPmon.DKP:GetDB("BossAuction")
		self:Debug("OnPeriodicInterval(): Adding Timed award")

		local originallyVisible = DKPmon.Awarding.frame:IsVisible()
		DKPmon.Awarding:AppendPointAward({pool=mydb.selectedPool, amount=pdkp.amount,source=pdkp.name})
									
		if mydb.awardTimedInBackground then
			if table.getn(DKPmon.Awarding.pointstoaward) ~= 1 then
				DKPmon:Print(L["Not automatically awarding timed points because there are other awards listed."])
			else
				DKPmon.Awarding:AwardOutstandingPoints()
				if not originallyVisible then
					DKPmon.Awarding:Hide()
				end
			end
		else
			self:StartAwardReminder()
		end
	end
	
	--[[
	if option is checked and events aren't register, remind user every 30 secs or when leaving combat
	
	returns:
		true -- reminder active
		false -- reminder inactive
	]]
	function DKPmonBA:StartAwardReminder()
		local mydb = DKPmon.DKP:GetDB("BossAuction")
		
		--Reminder isn't set, unregister events just in case
		if not mydb.pendingReminder or table.getn(DKPmon.Awarding.pointstoaward) == 0 then 
			if self.periodicRemindCheckId ~= nil then
				self:CancelScheduledEvent(self.periodicRemindCheckId)
				self.periodicRemindCheckId = nil			
				if self:IsEventRegistered("PLAYER_LEAVE_COMBAT") then
					self:UnregisterEvent("PLAYER_LEAVE_COMBAT")
				end			
			end
			return false
		else	
			--The reminder is on, if event not already registered, register them.
			if self.periodicRemindCheckId == nil then
				if not self:IsEventRegistered("PLAYER_LEAVE_COMBAT") then
					self:RegisterEvent("PLAYER_LEAVE_COMBAT")
				end
				self.periodicRemindCheckId = "DKPmon_BossAuction-" .. math.random()
				self:ScheduleRepeatingEvent(self.periodicRemindCheckId, self.OnRemindCheck,30,self)
			end
			return true
		end
	end
	
	function DKPmonBA:PLAYER_LEAVE_COMBAT()
		if self:DkpSystemInactive() then return end
		self:OnRemindCheck()
	end
	--[[
	Called every 30 seconds when pending DKP
	]]
	function DKPmonBA:OnRemindCheck()
		--Points still pending, give message if out of combat
		if not UnitAffectingCombat("player") and not UnitIsDeadOrGhost("player") and self:StartAwardReminder() then
			DKPmon:Print(L['You have pending DKP, showing award window'])
			DKPmon.Awarding:Show()
		end
	end
	
	--[[
		When award frame is shown update timer text and continue updating
	]]
	function DKPmonBA:OnAwardFrameShow()
		self:UpdateTimerText()
		--Already updating text
		if self.textUpdateEventId ~= nil then 
			if self.periodicEventId == nil then
				self:CancelScheduledEvent(self.textUpdateEventId)
			end
			return 
		end
	
		if self.periodicEventId ~= nil then
			self.textUpdateEventId = "DKPmon_BossAuction-" .. math.random()
			self:ScheduleRepeatingEvent(self.textUpdateEventId, self.UpdateTimerText,1,self)	
		end
	end
	--[[
	When award frame is hidden cancel timer text updates
	]]
	function DKPmonBA:OnAwardFrameHide()
		--Remind if pending points
		self:StartAwardReminder()
		if self.textUpdateEventId ~= nil then
			self:CancelScheduledEvent(self.textUpdateEventId)
			self.textUpdateEventId = nil
		end
	end
	--[[
	Update the timer text
	]]
	function DKPmonBA:UpdateTimerText()
		local isScheduled, timeLeft
		if self.periodicEventId ~= nil then
			isScheduled, timeLeft = self:IsEventScheduled(self.periodicEventId)
		end
		if not isScheduled then 
			self.awardframe.nextPeriodicDkpString:SetText(L['Timed Points Inactive.'])
			--Will unregister for us
			self:OnAwardFrameHide()
			return
		end
		self.awardframe.nextPeriodicDkpString:SetText(string.format(L['Timed Points timer: %s'],self:SecondsToClock(timeLeft)))
	end
	--[[
	Convert nSeconds to HH:MM:SS format
	]]
	function DKPmonBA:SecondsToClock(nSeconds)
		nHours = string.format("%02.f", math.floor(nSeconds/3600));
		nMins = string.format("%02.f", math.floor(nSeconds/60 - (nHours*60)));
		nSecs = string.format("%02.f", math.floor(nSeconds - nHours*3600 - nMins *60));
		return nHours..":"..nMins..":"..nSecs
	end
	
	function DKPmonBA:CheckLeaderSetup()
		if self:DkpSystemInactive() then return end
		self:Debug("CheckLeaderSetup()")
		if IsInRaid() == false then
			--Print log reminder
			local currentLog = DKPmon.Logging:GetCurrentLog()
			if currentLog ~= nil then
				DKPmon:Print(string.format("Reminder: You have a log (%s) going but you're not in a raid",currentLog.raidkey))
			end
			return
		end
				
		if DKPmon:GetLeaderState() then
			--We're the dkp leader
			local mydb = DKPmon.DKP:GetDB("BossAuction")
			local zone = GetRealZoneText()
			local cInfo = DKPmon.CustomInfo:Get("BossAuction")	
			for instance, _ in pairs(cInfo.bossvalues) do
				if zone == instance then					
					--Entered a boss zone
					self.currentInstance = instance
					
					self:CheckMasterLoot()			
					DKPmon:Print(string.format(L["Entered instance: %s. Log is %s, timed points are %s."],instance, 
						(DKPmon.Logging:GetCurrentLog() == nil) and L["inactive"] or L["active"],
						(self.periodicDkpIndex == 0) and L["off"] or L["on"]))	
					
					if mydb.autoTimedPoints and self.periodicDkpIndex == 0 then
						local tIndex = cInfo.bossvalues[instance].TimedPoints
						if tIndex == nil then
							DKPmon:Print(L["ERROR: No default timed points index defined in the boss values for this instance."])
						else
							self:SelectPeriodicDkp(tIndex)
						end
					end
					
					if not self:IsEventRegistered("COMBAT_LOG_EVENT") then
                  self:Debug("Registering COMBAT_LOG_EVENT")
                  self:RegisterEvent("COMBAT_LOG_EVENT")
					end
					return				
				end					

			end
			self.currentInstance = nil
		else
			--Not leading
			if self:IsEventRegistered("COMBAT_LOG_EVENT") then
				self:UnregisterEvent("COMBAT_LOG_EVENT")
			end	
		end	
		
	end
	
	function DKPmonBA:CheckMasterLoot()
		if self:DkpSystemInactive() then return end
		--We're not the dkp leader, we don't care about master loot
		if not DKPmon:GetLeaderState() then return end
		 
		local mydb = DKPmon.DKP:GetDB("BossAuction")
		if mydb.autoMasterLoot and GetNumGroupMembers() > 0 then
			--and IsRaidLeader() then
			--MasterLoot check
			
				local lootmethod, mlPartyId, mlRaidId = GetLootMethod()
				--2nd two args are nil if masterloot, 0 if player master
				local currentMasterLooter = nil
			
				if mlRaidId ~= nil then
					if mlRaidId == 0 then
						currentMasterLooter = UnitName("player")
					else
						currentMasterLooter = UnitName("raid"..mlRaidId)
					end	
				end
			
				if lootmethod ~= "master" or currentMasterLooter ~= self.dkpLeader or
						GetLootThreshold() ~= mydb.qualityThreshold then
					--master loot needs to be set
					if IsRaidLeader() then
					 	DKPmon:Print(string.format(L["Setting master looter to %s"],self.dkpLeader))
						local qt = mydb.qualityThreshold
						if 2 <= qt and qt <= 6 then
							SetLootMethod("master", self.dkpLeader,qt)
						else
							SetLootMethod("master", self.dkpLeader)
						end
					else
						DKPmon:Print(string.format(L["Master loot is not set, ask the raid leader to do so."]))
					end
				end
				
				--[[ delayed loot threshold check
				When I experimented with master loot before setting the threshold had to be done a second or so after
				setting master loot otherwise settings would revert.  This delay accommodates that.
				]]
				self:ScheduleEvent(self.CheckLootThreshold,1,self)		
		end	
	end
	
	function DKPmonBA:CheckLootThreshold()
		local mydb = DKPmon.DKP:GetDB("BossAuction")
		local qt = mydb.qualityThreshold
		if qt < 2 or qt >6 then
			return
		end
		
		if GetLootThreshold() ~= qt then
			SetLootThreshold(qt)			
		end
	end
	
	--[[
	If this is a checked zone look for bosses and register mob target/mouse events
	]]
	function DKPmonBA:ZONE_CHANGED_NEW_AREA()
		self:Debug("ZONE_CHANGED_NEW_AREA()")
		if self:DkpSystemInactive() then return end
		self:CheckLeaderSetup()
	end
	
   --[[
      If the mob that died is a boss and we're leading add the points.
   ]]   
   function DKPmonBA:COMBAT_LOG_EVENT(timestamp, event, sourceGUID, sourceName, sourceFlags, destGUID, destName, destFlags)
      if self:DkpSystemInactive() then return end
      if not DKPmon:GetLeaderState() then return end
      
      if destName == nil then return end
      
      if CombatLog_Object_IsA(destFlags, COMBATLOG_FILTER_HOSTILE_UNITS) and event=="PARTY_KILL" then
      
		local cInfo = DKPmon.CustomInfo:Get("BossAuction")
		   if self.currentInstance == nil then
		      self:CheckLeaderSetup()
			   self:Debug("ERROR: Current Instance not set but we're looking for bosses for some reason")
			   return
		   end
	
		   local bossTab = cInfo.bossvalues[self.currentInstance]
		   for bossName,_ in pairs(bossTab) do
		      if bossName == destName then
		         DKPmon:Print(string.format(L['Boss defeated (%s) awarding dkp.'], destName))
				   self:AwardBossDkp(self.currentInstance,destName)
			   end				
		   end
		end
	end
	
	--[[
		Award the Boss DKP for the instanceName/bossName
	]]
	function DKPmonBA:AwardBossDkp(instanceName,bossName)
		local cInfo = DKPmon.CustomInfo:Get("BossAuction")
		local bossValue = cInfo.bossvalues[instanceName][bossName]
		if bossValue == nil then
			DKPmon:Print(string.format("ERROR: Couldn't get boss value for %s.%s",instanceName,bossName))
			return
		end
		local mydb = DKPmon.DKP:GetDB("BossAuction")
		DKPmon.Awarding:Show()
		DKPmon.Awarding:AppendPointAward({pool=mydb.selectedPool, amount=bossValue,source=string.format(L['Killed %s'],bossName) })
	end
	--[[
		DKPmon does not call disable on modules so this function is used
		to prevent actions from happening when the dkp system is not active.
	   ]]
	function DKPmonBA:DkpSystemInactive()
		return DKPmon.DKP:GetDKPSystemID() ~= self.systemId
	end
	
	function DKPmonBA:UpdateWinner(itembutton)
		local winner = nil
		local high = 0
		for bidderIndex=1,itembutton.bidinfo.nbidders do
			local bidTab = itembutton.bidinfo.bidders[bidderIndex]
			if bidTab.dkp.bid > high then
				winner = bidTab.name
				high = bidTab.dkp.bid
			end
		end
				
		--If no winner, set default
		if winner == nil then
			winner = L["Disenchant"]
		end						
		itembutton.bidinfo.winner = winner		
		itembutton:UpdateStatusText();
	end	
	