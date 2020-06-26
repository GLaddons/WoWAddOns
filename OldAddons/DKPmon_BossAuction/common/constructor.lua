--[[
Constructs the silent bid and open bidding modules from
common_base, common_custom, and the corresponding module .lua files.
]]

local L = DKPmonBA.L

function populateCommonMethods(o)
	--common_base
	o.prototype.FillTooltip=DKPmonBA.FillTooltip
	o.prototype.AddDistributionActionOptions=DKPmonBA.AddDistributionActionOptions
	o.prototype.RemoveBidder=DKPmonBA.RemoveBidder
	o.prototype.BuildWinnerSelectList=DKPmonBA.BuildWinnerSelectList
	o.prototype.BuildItemActionMenu = DKPmonBA.BuildItemActionMenu
	o.prototype.ProcessQueryConsole=DKPmonBA.ProcessQueryConsole
	o.prototype.GetNPools=DKPmonBA.GetNPools
	o.prototype.GetPoolName=DKPmonBA.GetPoolName
	o.prototype.DeductPoints=DKPmonBA.DeductPoints
	o.prototype.OnCloseBidding=DKPmonBA.OnCloseBidding
	o.prototype.GetAwardFrame=DKPmonBA.GetAwardFrame
	o.prototype.OnPurgePointsList=DKPmonBA.OnPurgePointsList
	o.prototype.PointsAwarded=DKPmonBA.PointsAwarded
	o.prototype.GetFubarOptionsMenu=DKPmonBA.GetFubarOptionsMenu
	o.prototype.OnWinnerAnnounce=DKPmonBA.OnWinnerAnnounce
	--common_custom
	o.prototype.CommonInitialize=DKPmonBA.CommonInitialize
	o.prototype.UpdateWinner=DKPmonBA.UpdateWinner
	o.prototype.ReceiveLeaderClaimHook=DKPmonBA.ReceiveLeaderClaimHook
	o.prototype.SetLeaderHook=DKPmonBA.SetLeaderHook
	o.prototype.SetItemHook=DKPmonBA.SetItemHook
	o.prototype.BuildBossTable=DKPmonBA.BuildBossTable
	o.prototype.OnSelectDkpPoolButtonClick=DKPmonBA.OnSelectDkpPoolButtonClick
	o.prototype.OnSelectPeriodicDkpButtonClick=DKPmonBA.OnSelectPeriodicDkpButtonClick
	o.prototype.OnSelectBossButtonClick=DKPmonBA.OnSelectBossButtonClick
	o.prototype.OnCustomPointsButtonClick=DKPmonBA.OnCustomPointsButtonClick
	o.prototype.SelectPeriodicDkp=DKPmonBA.SelectPeriodicDkp
	o.prototype.OnPeriodicInterval=DKPmonBA.OnPeriodicInterval
	o.prototype.StartAwardReminder=DKPmonBA.StartAwardReminder
	o.prototype.PLAYER_LEAVE_COMBAT=DKPmonBA.PLAYER_LEAVE_COMBAT	
	o.prototype.OnRemindCheck=DKPmonBA.OnRemindCheck
	o.prototype.OnAwardFrameShow=DKPmonBA.OnAwardFrameShow
	o.prototype.OnAwardFrameHide=DKPmonBA.OnAwardFrameHide
	o.prototype.UpdateTimerText=DKPmonBA.UpdateTimerText
	o.prototype.SecondsToClock=DKPmonBA.SecondsToClock
	o.prototype.CheckLeaderSetup=DKPmonBA.CheckLeaderSetup
	o.prototype.CheckMasterLoot=DKPmonBA.CheckMasterLoot
	o.prototype.CheckLootThreshold=DKPmonBA.CheckLootThreshold
	o.prototype.ZONE_CHANGED_NEW_AREA=DKPmonBA.ZONE_CHANGED_NEW_AREA
	o.prototype.COMBAT_LOG_EVENT=DKPmonBA.COMBAT_LOG_EVENT
	o.prototype.AwardBossDkp=DKPmonBA.AwardBossDkp
	o.prototype.DkpSystemInactive=DKPmonBA.DkpSystemInactive
end

--------------
-- Open Bid --
--------------
local openbid = DKPmonBA.AceOO.Class(DKPmon_DKP_BaseClass,"AceHook-2.1","AceEvent-2.0","AceDebug-2.0")
populateCommonMethods(openbid)
openbid.prototype.systemId="BossAuction"
openbid.prototype.optionsNameText=L['Boss Auction: Open-bid Options']
openbid.prototype.optionsDescText=L['Options for the open-bid version of the "Boss Auction" DKP System']
openbid.prototype.Initialize=DKPmonBA.open.Initialize
openbid.prototype.PlaceBid=DKPmonBA.open.PlaceBid
openbid.prototype.GetCost=DKPmonBA.open.GetCost
openbid.prototype.GetItemInfo=DKPmonBA.open.GetItemInfo
openbid.prototype.SendRemoveBidMessage = DKPmonBA.open.SendRemoveBidMessage
local OpenObj = openbid:new()
DKPmon.DKP:Register(OpenObj, "BossAuction", L["Boss Auction: Open Bid"])

----------------
-- Silent Bid --
----------------
--to zone events when this is enabled

local silentbid = DKPmonBA.AceOO.Class(DKPmon_DKP_BaseClass,"AceHook-2.1","AceEvent-2.0","AceDebug-2.0")
populateCommonMethods(silentbid)
--Since we share options and the masterloot/zone functionality, silentbid doesn't need initialization

silentbid.prototype.systemId="BossAuctionSilent"
silentbid.prototype.optionsNameText=L['Boss Auction: Silent-bid Options']
silentbid.prototype.optionsDescText=L['Options for the silent-bid version of the "Boss Auction" DKP System']
silentbid.prototype.Initialize=DKPmonBA.silent.Initialize
silentbid.prototype.SetBidStateHook=DKPmonBA.silent.SetBidStateHook
silentbid.prototype.AnnounceWinnersHook=DKPmonBA.silent.AnnounceWinnersHook
silentbid.prototype.PlaceBid=DKPmonBA.silent.PlaceBid
silentbid.prototype.GetCost=DKPmonBA.silent.GetCost
silentbid.prototype.GetItemInfo=DKPmonBA.silent.GetItemInfo
silentbid.prototype.SendRemoveBidMessage = DKPmonBA.silent.SendRemoveBidMessage
silentbid.prototype.RoundExpired = DKPmonBA.silent.RoundExpired

local SilentObj = silentbid:new()
DKPmon.DKP:Register(SilentObj, "BossAuctionSilent", L["Boss Auction: Silent Bid"])

DKPmonBA = nil
