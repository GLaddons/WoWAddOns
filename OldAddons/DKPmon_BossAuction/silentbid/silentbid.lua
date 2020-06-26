DKPmonBA.silent={}
local L = DKPmonBA.L

--[[
Initialize
Description:
  Initialize the DKP system. Effectively called from within the OnEnable() function of DKPmon
Input:
  None
Returns:
  None
]]

function DKPmonBA.silent:Initialize()
	self:CommonInitialize()
	self:Debug("SB:Initialize()")
	self.roundTimer = "DKPmon_BossAuctionS_roundTimer"
	self.biddingActive = false	

	self:Hook(DKPmon.Looting,"SetBidState","SetBidStateHook")
	self:Hook(DKPmon.Looting,"AnnounceWinners","AnnounceWinnersHook")
	--Call after 3 sec to allow Initialize() to return and DKPmon to setup
	self:ScheduleEvent(self.CheckLeaderSetup,3,self)
end

--[[
GetItemInfo()
Description:
  Given information on an item, check if the item is allowed to be bid on (meets quality requirements, is in a database, etc)
  and get the DKP information for the item.
Input:
  iteminfo -- ItemInfo table minus allowed & dkpinfo fields
Returns:
  allowed, dkpinfo
    allowed -- boolean or nil;  
     nil (item shouldn't be bid on), 
     false (item is okay, but more info is needed for it. So, the item can be added to the list, but bidding cannot be opened until the info is filled in)
     true (item's good to go)
    dkpinfo -- table; information on this item's cost, etc. (whatever's needed by the DKP system to know how many points to charge for the item). nil if allowed = nil
]]

function DKPmonBA.silent:GetItemInfo(iteminfo)
	local db = DKPmon.DKP:GetDB("BossAuction")
	if iteminfo.quality < db.qualityThreshold then return nil,nil end
	local cInfo = DKPmon.CustomInfo:Get("BossAuction")
	local dkpinfo = {}
	dkpinfo.poolIndex = db.selectedPool
	dkpinfo.minbid = cInfo.minbids[1]
   dkpinfo.tiedWith = {}
	return true,dkpinfo		
end

function DKPmonBA.silent:SetBidStateHook(dkpmonLooting,bidstate)
	--[[
	0 -- Building the list of bidable items
	1 -- Bidding is open, and we're accepting bids
	2 -- Bidding is closed and we're deciding winners
	3 -- Winners have been announced, waiting for point deduction
	]]	
	self.hooks[DKPmon.Looting]["SetBidState"](dkpmonLooting,bidstate)
	if self:DkpSystemInactive() then return end
	self:Debug(string.format("bidstate changed to: %d",bidstate))
	if bidstate == 1 then	   
		--Opened Bidding
      self:Debug("Bidding Open, resetting rounds, tieResolved = false for all items")
		self.biddingActive = true
		-- start rounds
		local cInfo = DKPmon.CustomInfo:Get("BossAuction")
		local silentrounds = cInfo.silentrounds		
		self.numBidRounds=table.getn(silentrounds)
		self.currentRound=0
      
      -- Remove tieResolved flag on items
      for i = 1, DKPmon.Looting.nitems do
         DKPmon.Looting.itembuttons[i]:GetDKPInfo().tieResolved = false
      end
   else
		--Cancel bidding operations
		self.biddingActive = false		
   end
   
   self:RoundExpired()
end

--[[
Intercept this function to randomnly resolve ties before they are announced
Mark that ties have been chosen so we don't repeat
]]
function DKPmonBA.silent:AnnounceWinnersHook(dkpmonLooting)
   if self:DkpSystemInactive() then
      self.hooks[DKPmon.Looting]["AnnounceWinners"](dkpmonLooting)
      return    
   end
   
   self:Debug("AnnounceWinnersHook()")
   local ib,dkpinfo
   for i = 1, dkpmonLooting.nitems do
      ib = dkpmonLooting.itembuttons[i]
      dkpinfo = ib:GetDKPInfo()
      if not dkpinfo.tieResolved then
         --Refresh tie info
         self:Debug("GetCost()")
         self:GetCost(ib:GetWinner(),dkpinfo,ib:GetWinnerDKP())
         if #dkpinfo.tiedWith > 0 then
            self:Debug("TIE!")
            --Tie needs resolving
            local s = string.format(L["Tie on #%d %s"],i,ib:GetItemInfo().link)
            s=s.." ("..ib:GetWinner()
            for _,tier in ipairs(dkpinfo.tiedWith) do
               s = s..", "..tier
            end
            s=s..")"
            SendChatMessage(s,"RAID")
            local rollResult = math.random(1,#dkpinfo.tiedWith+1)
            local rollWinner
            if rollResult == 1 then
               rollWinner = ib:GetWinner()
            else
               rollWinner = dkpinfo.tiedWith[rollResult - 1]
            end
            
            s = string.format(L["Rolling 1 to %d:  %d  (%s)"],#dkpinfo.tiedWith+1,rollResult,rollWinner)
            SendChatMessage(s,"RAID")
            if rollResult > 1 then
               --Current winner didn't win roll, set new winner
               ib.bidinfo.winner = rollWinner
               ib:UpdateStatusText()
            end
            dkpinfo.tieResolved = true
         end
      end
   end   
   
   self.hooks[DKPmon.Looting]["AnnounceWinners"](dkpmonLooting)
end

--[[
Called when it's time to refresh/start/update the bid rounds
]]
function DKPmonBA.silent:RoundExpired()
	self:Debug("RoundExpired called")	
	if not self.biddingActive then
		--bidding was cancelled, don't start another round
		if self:IsEventScheduled(self.roundTimer) then
			--Cancel current timer
			self:CancelScheduledEvent(self.roundTimer)			
		end				
		return
	end
	
	local looting = DKPmon.Looting
	local cInfo = DKPmon.CustomInfo:Get("BossAuction")
	local silentrounds = cInfo.silentrounds

	--Cancel current timer
	if self:IsEventScheduled(self.roundTimer) then
		self:CancelScheduledEvent(self.roundTimer)
		--Send end round event, bids, winner cost
		for i = 1,looting.nitems do
			local itembutton = looting.itembuttons[i]
			local itemdkpinfo = itembutton:GetDKPInfo()
			itembutton.biddingOpen = false
			local numBids = itembutton.bidinfo.nbidders
			self:UpdateWinner(itembutton)
			local costTab = self:GetCost(itembutton:GetWinner(),itemdkpinfo,itembutton:GetWinnerDKP())
			local highCost = costTab[itemdkpinfo.poolIndex]
			self:Debug("Sending end round message")
         
         DKPmon.Comm:SendToBidder("BADKPS_ER", { item = itembutton.id, bids = numBids, 
            cost = highCost, tied =  (#itemdkpinfo.tiedWith>0) })
		end		
	end
		
	--Send new round messages if item should continue
	local roundsGoing = false		
	self.currentRound = self.currentRound + 1
	if self.currentRound <= self.numBidRounds then
		for i = 1,looting.nitems do
			local itembutton = looting.itembuttons[i]
			local iteminfo = itembutton:GetDKPInfo()			
         itembutton.biddingOpen = true
         self:Debug("Sending new round message")
         DKPmon.Comm:SendToBidder("BADKPS_NR", { item = itembutton.id, time=silentrounds[self.currentRound],round=self.currentRound,numRounds=self.numBidRounds})
         roundsGoing = true
		end				
	end
	
	if roundsGoing then
		self:ScheduleRepeatingEvent(self.roundTimer, self.RoundExpired,silentrounds[self.currentRound],self)
	else
		--End now, close bidding, announce
		local time = looting.closetimeremaining
		if time == nil then
			DKPmon:Print("WARNING!!! DKPmon variable structure changed, BossAuction is unable to close bidding immediatly, tell Javek")
			looting:StartCloseBiddingTimer()
		else
			looting.closetimeremaining = 0
			looting:StartCloseBiddingTimer()
		end
	end				
end


--[[
PlaceBid
Description:
  Place, or remove, a bid for the given person on this item.
Input:
  itembutton -- the itembutton for the item that's being bid on
  bidder -- String; in-game name of the person bidding (i.e. not their bidname)
  dkpinfo -- information sent along for the DKP system to update this bid.
  bidderlist -- table; the list of bidders for this item. Each entry = { name = <name of person bidding>, dkpinfo = <information about the bid> }
  nbidders -- number; number of elements in the bidderlist table
Returns:
  boolean -- nil = bid rejected
    false = bid removed
    true = bid accepted
]]
function DKPmonBA.silent:PlaceBid(itembutton, bidder, dkpinfo, bidderlist, nbidders)
	-- For auction style DKP, the player bids how much they're willing to spend on the item
	-- The item should go to the player with the highest bid when bidding is closed.
	--itembutton.iteminfo.dkpinfo just contains dkpinfo from GetItemInfo() {poolIndex,minbid}
	--dkpinfo contains the bid: dkpinfo.bid It's not the same as the other dkpinfo

	local thisbid = dkpinfo.bid
	local itemdkpinfo = itembutton:GetDKPInfo()
	
	if not itembutton.biddingOpen then
		return nil
	end
	
	local minbid = itemdkpinfo.minbid
	
	local bidderinfo = DKPmon.RaidRoster:GetPlayerInfo(bidder)
	if bidderinfo == nil then
		DKPmon:Print(string.format(L["Error -- player %s has bid on this item but has never been in the raid! Not listing them."], bidder))
		return nil
	end
	local playerpnts = self:GetPlayerPoints(bidderinfo.bidchar.name, itemdkpinfo.poolIndex)
	
	--Initial rejections that don't rely on knowing the high bid
	if thisbid <= 0 then return nil end
	--Minbid is always valid, reject if less than minbid or more than player's dkp
	if thisbid ~= minbid and (thisbid < minbid or thisbid > playerpnts) then return nil end
	
   -- Search the biddinglist to see if this person's already bid on this item, record the highest bid
	local playerIndex = nil
	local i
	for i = 1, nbidders do
		if bidderlist[i].name == bidder then
			playerIndex = i
		end
	end

	if playerIndex == nil then
	   -- Person wasn't in the list, so add them
	   table.insert(bidderlist, { name = bidder, dkp = { bid = thisbid} })
	else
		bidderlist[playerIndex].dkp.bid = thisbid
	end
	    
	return true
end



--[[
GetCost(winner, itemdkp, winnerdkp)
Description:
  Given the dkpinfo about an item, and the winner return a table containing the costs to charge the winner.
Input:
  winner -- string; name of the winner
  itemdkp -- table; same table returned from self:GetItemInfo()
  winnerdkp -- table; same table used in self:PlaceBid()
Returns:
  table  -- {  [<pool#>] = <number -- the cost to the pool>, ... }
]]

function DKPmonBA.silent:GetCost(winner, itemdkp, winnerdkp)
   if (itemdkp.override ~= nil) then
        return { [itemdkp.poolIndex] = itemdkp.override }
   else
       -- winnerdkp is nil if there is no winner
       if winnerdkp == nil then return { [itemdkp.poolIndex] = itemdkp.minbid } end
       
       local cost = itemdkp.minbid
       local winnerbid = winnerdkp.bid
       local nextHighest = 0
       
       --try only new table if nil and clearing manually
       itemdkp.tiedWith = {}
       --local tiedWith = itemdkp.tiedWith
       
       local itembutton = DKPmon.Looting.itembuttons[itemdkp.itemId]
       local bidinfo = itembutton.bidinfo   
       if bidinfo.nbidders > 0 then
		    --There were bids
		    for i = 1, bidinfo.nbidders do
			    local tab = bidinfo.bidders[i]
			    --tab.name:bidder's name
			    --tab.dkp.bid:bidder's bid
			    
			    -- dkp leader could have selected someone down the list
			    -- so ignore higher bids
			    if tab.dkp.bid <= winnerbid
					    and tab.name ~= winner then
				    if tab.dkp.bid == winnerbid then
					    --tie, add to tied list
					    table.insert(itemdkp.tiedWith,tab.name)
				    end
				    if tab.dkp.bid > nextHighest then
					    nextHighest = tab.dkp.bid
				    end
			    end
		    end
       end
       
       if nextHighest == winnerbid then
   		    --if they tie don't add 1
   		    cost = winnerbid
       elseif nextHighest ~= 0 then
		    cost = nextHighest + 1
       end
       
       return { [itemdkp.poolIndex] = cost }
   end
end

function DKPmonBA.silent:SendRemoveBidMessage(id,newHigh,newHighBidder,isContested,biddername)
	DKPmon.Comm:SendToBidder("BADKPS_RB", { item = id, removed = biddername })
end

