DKPmonBA.open={}

--[[
Initialize
Description:
  Initialize the DKP system. Effectively called from within the OnEnable() function of DKPmon
Input:
  None
Returns:
  None
]]

function DKPmonBA.open:Initialize()
	self:CommonInitialize()
	self:Debug("OB:Initialize()")
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

function DKPmonBA.open:GetItemInfo(iteminfo)
	local db = DKPmon.DKP:GetDB("BossAuction")
	if iteminfo.quality < db.qualityThreshold then return nil,nil end
	local cInfo = DKPmon.CustomInfo:Get("BossAuction")
	local dkpinfo = {}
	dkpinfo.poolIndex = db.selectedPool
	dkpinfo.minbid = cInfo.minbids[1]
	dkpinfo.contested = false
	return true, dkpinfo
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
function DKPmonBA.open:PlaceBid(itembutton, bidder, dkpinfo, bidderlist, nbidders)
	-- For auction style DKP, the player bids how much they're willing to spend on the item
	-- The item should go to the player with the highest bid when bidding is closed.
	--itembutton.iteminfo.dkpinfo just contains dkpinfo from GetItemInfo() {poolIndex,minbid}
	--dkpinfo contains the bid: dkpinfo.bid It's not the same as the other dkpinfo

	local thisbid = dkpinfo.bid
	local itemdkpinfo = itembutton:GetDKPInfo()
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
	local highestBid = 0
	local highestWho = nil
	local bidderDkp = nil
	local i
	for i = 1, nbidders do
		bidderDkp = bidderlist[i].dkp.bid
		if bidderDkp > highestBid then
			highestBid = bidderDkp
			highestWho = bidderlist[i].name
		end
		if bidderlist[i].name == bidder then
			playerIndex = i
		end
	end
	--Must be greater than last bid
	if playerIndex ~= nil and thisbid <= bidderlist[playerIndex].dkp.bid then return nil end
	--Bid OK
	if thisbid == highestBid then
		if itemdkpinfo.contested == nil then
			--If first contester make table and add original bidder
			itemdkpinfo.contested = {}
			table.insert(itemdkpinfo.contested, highestWho)
		end
		--Add this bidder to list of contesters
		table.insert(itemdkpinfo.contested, bidder)
	else
		itemdkpinfo.contested = nil
	end
	if playerIndex == nil then
	   -- Person wasn't in the list, so add them
	   table.insert(bidderlist, { name = bidder, dkp = { bid = thisbid} })
	else
		bidderlist[playerIndex].dkp.bid = thisbid
	end
    -- Send a message to all Bidders that a new bid was received 	
	DKPmon.Comm:SendToBidder("BADKP_RNB", { item = itembutton.id, bid = thisbid, bidder = bidder, contested = itemdkpinfo.contested })
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

function DKPmonBA.open:GetCost(winner, itemdkp, winnerdkp)
   -- winnerdkp is nil if there is no winner
   if (itemdkp.override ~= nil) then
        return { [itemdkp.poolIndex] = itemdkp.override }
   else
        if winnerdkp == nil then return { [itemdkp.poolIndex] = itemdkp.minbid } end
        return { [itemdkp.poolIndex] = winnerdkp.bid }
   end
end

function DKPmonBA.open:SendRemoveBidMessage(id,newHigh,newHighBidder,isContested,biddername)
	DKPmon.Comm:SendToBidder("BADKP_RB", { item = id, bid = newHigh, bidder = newHighBidder, contested = isContested, removed = biddername })
end

