DKPmonBA = {}

DKPmonBA.AceOO = AceLibrary("AceOO-2.0")
DKPmonBA.L = AceLibrary("AceLocale-2.2"):new("DKPmon_BossAuction")
DKPmonBA.dewdrop = AceLibrary("Dewdrop-2.0")
DKPmonBA.deformat = AceLibrary("Deformat-2.0")

local L = DKPmonBA.L
local dewdrop = DKPmonBA.dewdrop
local deformat = DKPmonBA.deformat


--[[
FillTooltip()
Description:
  Called when an item in the Looting Window is moused over to add the DKP-system specific information to the GameTooltip for the moused over item
Input:
  dkpinfo -- table; same table returned from self:GetItemInfo()
Returns:
  Nothing
]]
function DKPmonBA:FillTooltip(dkpinfo)
	GameTooltip:AddLine(" ")
	if dkpinfo.minbid ~= nil then
		GameTooltip:AddLine(string.format(L["Min Bid = %g"], dkpinfo.minbid), 1.0, 0.819, 0.0)
	end
		
	local bidstate = DKPmon.Looting:GetBidState()
	if bidstate == 0 then
			GameTooltip:AddLine(L["Right-click to set minimum bid."])
	elseif bidstate == 1 then
		GameTooltip:AddLine(L['Right-Click to add manual bids.'])
	end
end

--[[
AddDistributionActionOptions
Description:
  Called when the "Actions" button in the loot distribution window is pressed.
  This call allowed the DKP system to add any DKP-system specific options it might like to the action menu.
Input:
  dewOptions -- the AceOptions table to add to
  bidstate -- the current bidstate.
Returns:
  None
]]

function DKPmonBA:AddDistributionActionOptions(dewOptions, bidstate)

end

--[[
RemoveBidder
Description:
  Remove the given biddername from the list of bidders for the given item
Input:
  itembutton -- the itembutton for the item that's being bid on
  biddername -- the name of the bidder to remove.
Returns:
 nil
]]
function DKPmonBA:RemoveBidder(itembutton, biddername)
   local bidderlist = itembutton.bidinfo.bidders
   local nbidders = itembutton.bidinfo.nbidders
   
   local itemdkpinfo = itembutton:GetDKPInfo()
	local newHigh = 0
	local newHighBidder = nil
	local i
   -- Search the bidderlist to find the biddername we're removing
   for i = 1, nbidders do
      if bidderlist[i].name == biddername then
      	--remove bidder
		 bidderlist[i] = bidderlist[nbidders]
		 bidderlist[nbidders] = nil
		 itembutton.bidinfo.nbidders = itembutton.bidinfo.nbidders - 1
		 nbidders = nbidders - 1
		 -- Find the current highest bid
		 for i = 1, nbidders do
		    if bidderlist[i].dkp.bid > newHigh then
		       newHighBidder = bidderlist[i].name
		       newHigh = bidderlist[i].dkp.bid
		    end
		 end
		 if newHigh == 0 then newHigh = nil end
		 break
      end
   end
   if itemdkpinfo.contested then
	   	--Check if still contested
	   	itemdkpinfo.contested = nil

		if newHigh then
			local contestedList = {}
		   	for i = 1, nbidders do
	   			if bidderlist[i].dkp.bid == newHigh then
	   				table.insert(contestedList, bidderlist[i].name)
	   			end
		   	end
		   	if table.getn(contestedList) > 1 then
		   		itemdkpinfo.contested = contestedList
		   	end
		end
   end
   self:SendRemoveBidMessage(itembutton.id,newHigh,newHighBidder,itemdkpinfo.contested,biddername)
	itembutton:UpdateStatusText()
end


--[[
BuildWinnerSelectList(itembutton, dewOptions, iteminfo)
Description:
  Build the list of item bidders to select a winner from.
  Note: the "Disenchant" and "Guild bank" options will already be in the list.
Input:
  itembutton -- LootItem; lootitem class/table that's associated with the item passed.
  dewOptions -- table; dewOptions table to add the list to
  dkpinfo -- table; information about the item for the DKP system
  bidders -- table; indexed by number, starting at 1. Each entry is a table of the form: { name = string, dkpinfo = table }
    where "name" is the name of the player that placed the bid, and dkpinfo is the information about their bid
Returns:
  None
]]

function DKPmonBA:BuildWinnerSelectList(itembutton, dewOptions, dkpinfo, bidders)
   local i, nametab
   for i, nametab in ipairs(bidders) do
      local bidderinfo = DKPmon.RaidRoster:GetPlayerInfo(nametab.name) -- information about the player who placed this bid
      if bidderinfo == nil then
	 DKPmon:Print(string.format(L["Error -- player %s has bid on this item but has never been in the raid! Not listing them."], nametab.name))
      else
	 local playerpnts = self:GetPlayerPoints(bidderinfo.bidchar.name, dkpinfo.poolIndex)
	 local namestr
	 if nametab.name == bidderinfo.bidchar.name then
	    namestr = string.format("|cff%s%s|r(%g/%g)", bidderinfo.char.classhex, nametab.name, nametab.dkp.bid, playerpnts)
	 else
	    namestr = string.format("|cff%s%s|r[|cff%s%s|r](%g/%g)", bidderinfo.char.classhex, nametab.name, bidderinfo.bidchar.classhex, bidderinfo.bidchar.name, nametab.dkp.bid, playerpnts)
	 end
	 dewOptions.args[string.format("%d", i)] = { 
	    type = 'execute', name = namestr, order = 35000 - nametab.dkp.bid, 
	    desc = string.format(L["Select %s to win the item, OR <ctrl>-click to remove the bidder."], nametab.name),
	    func = function() 
	    	if IsControlKeyDown() then
				 dewdrop:Close()
				 self:RemoveBidder(itembutton, nametab.name)
	    	else
				 itembutton.bidinfo.winner = nametab.name; 
				 itembutton:UpdateStatusText(); 
			 end
		   end
	 }
      end
   end
end


--[[
BuildItemActionMenu(itembutton, dewOptions, iteminfo)
Description:
  Called when the user right-clicks on an item in the "Loot distribution" window.
  This is the DKP system's opportunity to do things like assign a point value to the item, if desired.
Input:
  itembutton -- LootItem; lootitem class/table that's associated with the item passed.
  dewOptions -- table; dewOptions table to add the list to
  iteminfo -- ItemInfo table
Returns:
  boolean; true -- items were added to the list
           false -- no items were added to the list.
]]

function DKPmonBA:BuildItemActionMenu(itembutton, dewOptions, iteminfo)
	-- Check our bidstate, 0 == closed, 1 == open
	local bidstate = DKPmon.Looting:GetBidState()
	if bidstate == 0 then
		--Minimum Bid menu
		local cInfo = DKPmon.CustomInfo:Get("BossAuction")
		local validateTab = {}
		local minbids = cInfo.minbids
		local itemdkpinfo = itembutton:GetDKPInfo()
		
		for i,min in ipairs(minbids) do
			validateTab[tostring(min)] = tostring(min)
		end
		
		dewOptions.args.minBid = {
			type='text', name=L['Minimum Bid'], desc=L['Select the minimum bid for this item.'],
			get = function() 
				return tostring(itemdkpinfo.minbid)
			end,
			set = function(v) 
				itemdkpinfo.minbid = tonumber(v)
			end,
			validate = validateTab,
			order = 1			
		}
	elseif bidstate == 1 then
		--Manual Bid Menu.
		dewOptions.args.addBidder = {
			type='execute',name=L['Add Bidder'],desc=L["Add the bidder once you've specified a name and bid amount"],
			func=function()	
				if itembutton.manBidderName == nil then
					DKPmon:Print(L["You must specify a bidder name"])
					return
				end
				if itembutton.manBidderBid == nil then
					DKPmon:Print(L["You must specify a bid amount"])
					return
				end
				itembutton:PlaceBid(itembutton.manBidderName,{bid = itembutton.manBidderBid}) 
			end,
			order=2
		}
		dewOptions.args.bidderName = {
			type='text',name=L['Bidder Name'],desc=L["Type the bidder's name."],
			usage=L["<Bidder Name>"],
			get=function() return itembutton.manBidderName end,
			set = function(v) itembutton.manBidderName = v end,
			validate = function(v) return v~= nil end,
			order = 3
		}
		dewOptions.args.bidderBid = {
			type='text',name=L['Bid'],desc=L["Enter the bid amount."],
			usage=L["<number>"],
			get=function(v) return itembutton.manBidderBid end,
			set=function(v) itembutton.manBidderBid = tonumber(v) end,
			validate = function(v) return tonumber(v) ~= nil end,
			order = 4
		}
		return true
	end
end

--[[
ProcessQueryConsole(bidname, bidclass)
Description:
  Build, and return, a message string to send regarding the point totals of the given bidname
Input:
  bidname -- name to look up the points for
Returns:
  String -- message to be displayed to the person who did the query
]]

function DKPmonBA:ProcessQueryConsole(bidname, bidclass)
   local cInfo = DKPmon.CustomInfo:Get("BossAuction")
   local tab = DKPmon.PointsDB:GetTable(bidname)
   if tab == nil then
   print('common_base.lua fired')
      return L["You have no points."]
   end
   local reply = L["Your points are: "]
	local poolNames = cInfo.poolnames
   for p, _ in pairs(tab.points) do
      local pool = tonumber(p)
      if pool ~= nil then
	      local poolName = cInfo.poolnames[pool]
	      if poolName ~= nil then
		      reply = string.format("%s %s = %g;", reply, cInfo.poolnames[pool], self:GetPlayerPoints(bidname, pool))	
	      end
      end
   end
   
   return reply
end

--[[
GetNPools
Description:
  Return the number of point pools being used by the DKP system
Input:
  None
Returns:
  Number.
]]

function DKPmonBA:GetNPools()
   return DKPmon.CustomInfo:Get("BossAuction").numpools
end

--[[
GetPoolName
Description:
  Find out what the given pool number is called
Input:
  pool -- number in the range [1, GetNPools()]
Returns:
  string -- name by which to refer to the pool
]]
function DKPmonBA:GetPoolName(pool)
   return DKPmon.CustomInfo:Get("BossAuction").poolnames[pool]
end

--[[
GetPlayerPoints
Description:
  Return the number of points the given player has in the given pool
Input:
  name -- string; Name of the player to look up
  pool -- number; index of the pool. Must be in the range [1,GetNPools()]
Output:
  number -- the number of points the player has.
]]
--Use Default

--[[
SetPlayerPoints
Description:
  Set the number of points the given player has in the given pool to the amount given.
Input:
  charInfo -- CharInfo struct for the player to award points to
  pool -- number; index of the pool. Must be in the range [1,GetNPools()]
  points -- number; number of points to set the player's points to. Can be negative.
Output:
  none
]]
--Use Default





--[[
DeductPoints(itemwinners)
Description:
  Deduct the points for won items.
Input:
  itemwinners -- ItemWinners struct
Returns:
  None
]]


function DKPmonBA:DeductPoints(itemwinners)
   local cInfo = DKPmon.CustomInfo:Get("BossAuction")
   local mydb = DKPmon.DKP:GetDB("BossAuction")
	local i, tab
   for i, tab in ipairs(itemwinners) do
      -- Deduct the points from the winner
      if tab.winner ~= L["Disenchant"] and tab.winner ~= L["Bank"] then
      	-- We don't deduct points for disenchanting or banking
		 	local wininfo = DKPmon.RaidRoster:GetPlayerInfo(tab.winner)
		 	if wininfo == nil then
		 		local msg = string.format(L["Error -- %s has never been in the raid! I cannot deduct points because I don't know enough about them. Please make note of the following deductions and do them manually:"], tab.winner)
		   		local p, c
				for p, c in pairs(tab.dkp) do
		   			msg = string.format(L["%s\n%g from pool %d"], msg, c, p)
		  		end
			 	DKPmon:Print(msg)
		 	else
		 		local p, c
		    	for p, c in pairs(tab.dkp) do
		    		DKPmon.PointsDB:SpendPoints(wininfo.bidchar, tonumber(p), c)
		       		DKPmon.Comm:SendToBidder("M", string.format(L["You have been charged %g %s points for %s."], c, cInfo.poolnames[p], tab.item.link), tab.winner)
		    	end
		 	end
	   	end
	end
end
	

--[[
OnCloseBidding
Description:
  Called by the LootFrame when the close bidding time expires; signalling the close of bidding.
Input:
  None
Returns:
  None
]]
function DKPmonBA:OnCloseBidding()
	for i = 1,DKPmon.Looting.nitems do
		local itembutton = DKPmon.Looting.itembuttons[i]
		self:UpdateWinner(itembutton)
	end
	DKPmon:Print(L["Bidding closed, you should now verify winners, announce, and deduct points."])
end

--[[
GetAwardFrame()
Description:
  Build, if required,  and return the subframe that will be attached to the points awarding frame to handle
  points awarding for this DKP system
Input:
  None
Returns:
  A frame
]]
function DKPmonBA:GetAwardFrame()
   if self.awardframe then return self.awardframe end
   local f = CreateFrame("Frame", "DKPmonFDKPAwardFrame", nil)
   --   f:SetFrameLevel(6)
   f:SetWidth(200)
   f:SetHeight(20 + 22*5)
   self.awardframe = f
   
   DKPmon.FrameSkinner:BackdropFrame(f, {0, 0, 0, 0.7}, {0.7, 0.7, 0.7, 0.9} )
   
   DKPmon.FrameSkinner:Skin(f)
   
 	local b = CreateFrame("Button", "DKPmonFDKPAwardFrameActionButton", f, "UIPanelButtonTemplate")
   f.selectDkpPoolButton = b
   b:SetWidth(175); b:SetHeight(22)
   b:SetFrameLevel(6)
   b:SetText(L["Select Pool"])
   b:ClearAllPoints()
   b:SetPoint("TOP", f, "TOP", 0, -10)
   b:SetScript("OnClick", function() self:OnSelectDkpPoolButtonClick() end)
   b:Show()

 	b = CreateFrame("Button", "DKPmonFDKPAwardFrameActionButton", f, "UIPanelButtonTemplate")
   f.selectPeriodicDkpButton = b
   b:SetWidth(175); b:SetHeight(22)
   b:SetFrameLevel(6)
   b:SetText(L["Timed Points"])
   b:ClearAllPoints()
   b:SetPoint("TOPLEFT", f.selectDkpPoolButton, "BOTTOMLEFT", 0, 0)
   b:SetScript("OnClick", function() self:OnSelectPeriodicDkpButtonClick() end)
   b:Show()
   
   local str = f:CreateFontString("DKPMon_AwardFrame_PeriodicDkpString","OVERLAY","GameFontNormal")
   str:SetText(L['Timed Points Inactive.'])
   f.nextPeriodicDkpString = str
   str:SetPoint("TOP", f.selectPeriodicDkpButton, "BOTTOM", 0, -4)
   str:Show()
	f:SetScript("OnShow",function() self:OnAwardFrameShow() end)
	f:SetScript("OnHide",function() self:OnAwardFrameHide() end)
	
 	b = CreateFrame("Button", "DKPmonFDKPAwardFrameActionButton", f, "UIPanelButtonTemplate")
   f.selectBossButton = b
   b:SetWidth(175); b:SetHeight(22)
   b:SetFrameLevel(6)
   b:SetText(L["Select Boss"])
   b:ClearAllPoints()
   b:SetPoint("TOPLEFT", f.selectPeriodicDkpButton, "BOTTOMLEFT", 0, -20)
   b:SetScript("OnClick", function() self:OnSelectBossButtonClick() end)
   b:Show()			
		
   local b = CreateFrame("Button", "DKPmonFDKPAwardFrameActionButton", f, "UIPanelButtonTemplate")
   f.customPointsButton = b
   b:SetWidth(175); b:SetHeight(22)
   b:SetFrameLevel(6)
   b:SetText(L["Custom Points"])
   b:ClearAllPoints()
   b:SetPoint("TOPLEFT", f.selectBossButton, "BOTTOMLEFT", 0, 0)
   b:SetScript("OnClick", function() self:OnCustomPointsButtonClick() end)
   b:Show()	
   
   self.customaward = { pool = 1, amount = 0 }
   return self.awardframe
end

--[[
OnPurgePointsList 
Description:
  Called from the points awarding routines when the user purges the points list.
Input:
Returns:
]]

function DKPmonBA:OnPurgePointsList()
--	DKPmon:Print("Purged Points")
end

--[[
PointsAwarded
Description:
  Called from the points awarding routines _after_ all the points in its list have been awarded.
Input:
Returns:
]]
function DKPmonBA:PointsAwarded()
--	DKPmon:Print("Points awarded")
end


--[[
GetFubarOptionsMenu
Description:
  Return the options menu for this DKP system to be added to the fubar. This must be a valid Ace Options table, or nil
Input:
Returns:
  nil or an Ace Options table
]]
function DKPmonBA:GetFubarOptionsMenu()
	if self.fubarmenu then return self.fubarmenu end
	local mydb = DKPmon.DKP:GetDB("BossAuction")
	local tab = {
	   type = 'group',
	   name = self.optionsNameText,
	   desc = self.optionsDescText,
	   args = {
	  	qualitythreshold = {
	  		type = 'text',
		 	name = L['Item quality threshold'],
		 	desc = L['Set the threshold on item quality to automatically include in the item list for bidding on.'],
		 	usage = '<number>',
		 	--Adjust value to correcty quality
		 	get = function() return "p"..mydb.qualityThreshold end,
		 	set = function(v) 
				mydb.qualityThreshold = tonumber(string.sub(v,2))
				self:CheckMasterLoot()
		 	end,
		 	validate = { 
		 		["p0"] = string.format(L["|cff%sPoor|r"], DKPmon:rgbToHex(ITEM_QUALITY_COLORS[0])), 
				["p1"] = string.format(L["|cff%sCommon|r"], DKPmon:rgbToHex(ITEM_QUALITY_COLORS[1])),
				["p2"] = string.format(L["|cff%sUncommon|r"], DKPmon:rgbToHex(ITEM_QUALITY_COLORS[2])),
				["p3"] = string.format(L["|cff%sRare|r"], DKPmon:rgbToHex(ITEM_QUALITY_COLORS[3])),
				["p4"] = string.format(L["|cff%sEpic|r"], DKPmon:rgbToHex(ITEM_QUALITY_COLORS[4])),
				["p5"] = string.format(L["|cff%sLegendary|r"], DKPmon:rgbToHex(ITEM_QUALITY_COLORS[5])),
				["p6"] = string.format(L["|cff%sArtifact|r"], DKPmon:rgbToHex(ITEM_QUALITY_COLORS[6])),
		 	},
		 	order = 1
			},
 			autoMasterLoot = {
				type = 'toggle',
				name = L['Auto Master Loot'],
				desc = L['Automatically activate master loot when entering a instance listed in the bossvalues of custom.lua'],
				get = function()
					return mydb.autoMasterLoot
				end,
				set = function(v)
					mydb.autoMasterLoot = v
					self:CheckMasterLoot()
				end,
				order = 2
			},
			autoStartTimed = {
				type = 'toggle',
				name = L['Auto Start Timed Points'],
				desc = L['Automatically start timed points corresponding to the TimedPoints entry in the bossvalues of custom.lua'],
				get = function()
					return mydb.autoTimedPoints
				end,
				set = function(v)
					mydb.autoTimedPoints = v
				end,
				order = 4
			},						
			pendingDkp = {				
				type = 'toggle',
				name = L['Pending DKP Reminder'],
				desc = L['Remind me if there is pending DKP when I leave combat and every 30secs'],
				get = function() return mydb.pendingReminder end,
				set = function(v)
					mydb.pendingReminder = v 
					self:StartAwardReminder()
				end,
				order = 5
			},
			awardTimedInBackground = {				
				type = 'toggle',
				name = L['Instant timed points award'],
				desc = L['Award timed points immediatly without giving you the opportunity to review the award.'],
				get = function() return mydb.awardTimedInBackground end,
				set = function(v)
					mydb.awardTimedInBackground = v 
				end,
				order = 6
			}			
	   }
	}
	self.fubarmenu = tab
	return tab	
end

--[[
OnWinnerAnnounce
Description:
  Called by the LootFrame just after an item winner is printed to raid chat.
Input:
  index -- number; index of the item announced
  link -- string; itemlink of the item announced
  winner -- string; name of the character who won the item
Returns:
  None
]]
function DKPmonBA:OnWinnerAnnounce(index, link, winner)
	local cInfo = DKPmon.CustomInfo:Get("BossAuction")
	local itembutton = DKPmon.Looting.itembuttons[index]
	local iteminfo = itembutton:GetItemInfo()
	local itemname = iteminfo.name
	--Craft mat check
	for _,mat in ipairs(cInfo.craftmats) do
		if itemname == mat then			
			message(string.format(L["Remember to give the %s to the crafter, not the winner!!!"],itemname))
		end	
	end
	
	--Print cost to raid
	local dkpinfo = itembutton:GetDKPInfo()
	local costTab = self:GetCost(itembutton:GetWinner(),dkpinfo,itembutton:GetWinnerDKP())
	local poolNames = cInfo.poolnames
	local s = L["Cost:"]	
	for poolIndex,amount in pairs(costTab) do 
		s=s..string.format(" %g %s",amount, poolNames[poolIndex])
	end
	SendChatMessage(s, "RAID")
end



