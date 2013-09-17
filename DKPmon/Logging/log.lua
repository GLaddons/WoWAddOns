--[[
    Copyright Daniel D. Neilson, 2006

    This file is part of DKPmon.

    DKPmon is free software; you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published by
    the Free Software Foundation; either version 2 of the License, or
    (at your option) any later version.

    DKPmon is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.

    You should have received a copy of the GNU General Public License
    along with DKPmon; if not, write to the Free Software
    Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
]]

local Log = { }
DKPmon.Logging = Log

local dewdrop = AceLibrary("Dewdrop-2.0")
local L = AceLibrary("AceLocale-2.2"):new("DKPmon")

function Log:GetTable()
   return DKPmon.db.realm.Log
end

function Log:GetCurrentLog()
   local log = self:GetTable()
   if log.active ~= true then return nil end
   return log.logs[log.currentLog]
end

--[[
Initialize
Description:
  Called by DKPmon OnEnable() function to do any initial leg work required.
  We will build up the Fubar menu for deleting logs
]]
function Log:Initialize()
   self:BuildDeleteLogMenu()

   local log = self:GetTable()
   if log.ctrtcompat == nil then
      log.ctrtcompat = false
   end
   if log.glctrtlog == nil then
      log.glctrtlog = false
  end
end

local function GetDeleteLogFubarTable(logid, logtab)
   local id = logid
   local logname = string.format("%s: %s to %s", logtab.raidkey, logtab.raidstart, logtab.raidend)
   local tab = {
      type = 'execute',
      name = logname,
      desc = L["Delete this log"],
      func = function()
		StaticPopupDialogs["DKPMON_CONFIRM_DELETELOG"].OnAccept = 
		   function()
		      DKPmon.Logging:DeleteLog(id)
		   end
		StaticPopup_Show("DKPMON_CONFIRM_DELETELOG", logname)
		dewdrop:Close()
	     end,
      order = id
   }
   return tab
end

--[[
BuildDeleteLogMenu
Description:
  Add an item to the Fubar menu for each stored log, except the active one, to allow it to be deleted
]]
function Log:BuildDeleteLogMenu()
   local fubar = DKPmon.Options.fubar.args.logging.args.deletelog.args
   local log = self:GetTable()
   local logid, logtab
   for logid, logtab in pairs(log.logs) do
      if tonumber(logid) ~= log.currentLog then
	 fubar["l"..tonumber(logid)] = GetDeleteLogFubarTable(tonumber(logid), logtab)
      end
   end
end


--[[
StartLog
Description:
  Called to start up a new log with the given name.
Input:
Output:
]]
function Log:StartLog(name)
   -- Check if logging's currently active. If it is, then stop the current log
   local log = self:GetTable()
   if log.active then 
      DKPmon:Print(L["Logging already active, cannot start a new log"])
      return
   end

   -- If we're not in a raid, we can't start a log
   if IsInRaid() == false then DKPmon:Print(L["You're not in a raid. Cannot start logging."]); return end

   local timestamp = DKPmon:GetTimestamp()
   local datestr = date("%m/%d/%y %H:%M:%S")
   log.active = true
   log.currentLog = timestamp
   log.logs[timestamp] = {
      raidkey = name,
      raidstart = datestr,
      raidzone = GetZoneText(),
      note = nil,
      playerinfos = {},
      playerjoins = {},
      playerleaves = {},
      lootlist = {},
      pointsawarded = {}
   }

   -- Build the initial list of playerinfos & playerjoins from the current raid roster
   local roster = DKPmon.RaidRoster:GetRoster()
   local name, rtab
   for name, rtab in pairs(roster) do
      self:PlayerJoin(rtab.bidchar)
   end
   
   -- Update the text string in the looting window
   DKPmon.Looting:SetTextStrings()
end

--[[
StopLog
Description:
  Stop logging for the currently active log
Input: none
Output: none
]]
function Log:StopLog()
   local log = self:GetTable()
   if log.active ~= true then return end -- logging's not active, nothing to do
   
   local clog = self:GetCurrentLog()
   
   clog.raidend = date("%m/%d/%y %H:%M:%S")

   log.active = false
   local logid = log.currentLog
   log.currentLog = nil

   -- Add this log to the list that can be deleted
   DKPmon.Options.fubar.args.logging.args.deletelog.args["l"..logid] = GetDeleteLogFubarTable(logid, log.logs[logid])

   -- Update the text string in the looting window
   DKPmon.Looting:SetTextStrings()
end

--[[
PlayerJoin
Description:
  Called to log a player join event. Will check if logging's active, and not log anything if it isn't
Input:
  charInfo -- CharInfo struct of the bidding name for the player joining the raid
Output: none
]]
function Log:PlayerJoin(charInfo)
   if self:GetTable().active ~= true then return end
   local log = self:GetCurrentLog()
   
   -- Add the character info to the playerinfos, maybe
   if log.playerinfos[charInfo.name] == nil then
      log.playerinfos[charInfo.name] = {
	 name = charInfo.name,
	 class = charInfo.class,
	 level = charInfo.level,
	 race = charInfo.race,
	 --guild = charInfo.guild
      }
   end
   
   local datestr = date("%m/%d/%y %H:%M:%S") -- TODO
   -- Add the join time
   if log.playerjoins[charInfo.name] == nil then
      log.playerjoins[charInfo.name] = {}
   end
   table.insert(log.playerjoins[charInfo.name], datestr)
end

--[[
PlayerLeave
Description:
  Called to log a player leave event. Will check if logging's active, and not log anything if it isn't
Input:
  charInfo -- CharInfo struct of the bidding name for the player leaving the raid
Output: none
]]
function Log:PlayerLeave(charInfo)
   if self:GetTable().active ~= true then return end
   local log = self:GetCurrentLog()
   
   -- Sanity check
   if log.playerinfos[charInfo.name] == nil then
      DKPmon:Print(L["Log -- Got request for playerleave for a player not in the raid"])
      return
   end
   
   local datestr = date("%m/%d/%y %H:%M:%S") -- TODO
   -- Add the leave time
   if log.playerleaves[charInfo.name] == nil then
      log.playerleaves[charInfo.name] = {}
   end
   table.insert(log.playerleaves[charInfo.name], datestr)
end

--[[
LootWins
Description:
  Called to log a list of item distributions.
Input:
  itemwinners -- ItemWinners struct
Output: none
]]
function Log:LootWins(itemwinners)
   if self:GetTable().active ~= true then return end
   local log = self:GetCurrentLog()
   
      local tab
      for _, tab in ipairs(itemwinners) do
         local entry = {
         	 name = tab.item.name,
         	 itemID = DKPmon:ExtractItemID(tab.item.link),
         	 class = tab.item.class,
         	 subclass = tab.item.subclass,
         	 colour = tab.item.colour,
         	 count = tab.item.count,
         	 received = "", -- for now
         	 time = tab.item.time,
         	 zone = tab.item.zone,
         	 source = tab.item.source,
         	 value = {}
         }
         -- Fill in the received field
         if tab.winner == L["Disenchant"] or tab.winner == L["Bank"] then
   	       entry.received = tab.winner
         else
         	 -- Grab the winner's raid roster entry, and find out what bidname they're using
         	 local winner = DKPmon.RaidRoster:GetPlayerInfo(tab.winner)
         	 if winner == nil then
         	    -- This shouldn't happen.
         	    entry.received = tab.winner
         	 else
         	    entry.received = winner.bidchar.name
         	 end
         end
            -- Fill in the values table
         local pool, amt
         for pool, amt in pairs(tab.dkp) do
      	 entry.value[tonumber(pool)] = tonumber(amt)
      end

      -- Add the entry to the log
      table.insert(log.lootlist, entry)
   end
end

--[[
AwardPoints
Description:
Input:
  playerlist -- table; { [<name>] = CharInfo, ... } (each is the bidding name's table that gets points)
  pointsawarded -- table; { { pool=<number>, amount=<number>, source=<string> } }
Output: none
]]
function Log:AwardPoints(playerlist, pointsawarded)
   if self:GetTable().active ~= true then return end
   local log = self:GetCurrentLog()

   -- Build the players list that goes in to every entry here
   local players = {}
   local cInfo
   for _, cInfo in pairs(playerlist) do
      table.insert(players, cInfo.name)
   end

   local datestr = date("%m/%d/%y %H:%M:%S") -- TODO
   
   -- Build up the award tables
   local sources = {}
   local ptab
   for _, ptab in ipairs(pointsawarded) do
      if sources[ptab.source] == nil then
	 local entry = {
	    players = players,
	    values = { [ptab.pool] = ptab.amount },
	    source = ptab.source,
	    time = datestr
	 }
	 sources[ptab.source] = entry
	 table.insert(log.pointsawarded, entry)
      else
	 local entry = sources[ptab.source]
	 if entry.values[ptab.pool] == nil then
	    entry.values[ptab.pool] = ptab.amount
	 else
	    entry.values[ptab.pool] = entry.values[ptab.pool] + ptab.amount
	 end
      end
   end
end

--[[
AwardPoints
Description: Logs Points Award to GuildLaunchCT_RaidTracker
Input:
  playerlist -- table; { [<name>] = CharInfo, ... } (each is the bidding name's table that gets points)
  pointsawarded -- table; { { pool=<number>, amount=<number>, source=<string> } }
Output: none
]]
function Log:RaidTrackerAwardPoints(playerlist, pointsawarded)
   -- Build the players list that goes in to every entry here
   local players = {}
   local cInfo
   local event_amount = 0;
   
   for _, cInfo in pairs(playerlist) do
      table.insert(players, cInfo.name)
   end
   
   --pprint(pointsawarded);
   
   -- Build up the award tables
   -- RaidTracker imports don't do multi pool, so whatever is awerded is just summed up
   local sources = {}
   local ptab
   for _, ptab in ipairs(pointsawarded) do
         event_amount = event_amount + ptab["amount"]
   end
   
   local event_name = "DKPMonAward"
   
   CT_RaidTracker_AddEventWithAttendees(event_name, event_amount, playerlist)
end

--[[
Track Loot Assignments
Description: Logs Item Assignments to GuildLaunchCT_RaidTracker
Input:
  itemwinners, { winner = winner, item = iinfo, dkp = DKP:GetCost(winner, iinfo.dkpinfo, winnerdkp) }
Output: none
]]
function Log:RaidTrackerLogItems(itemwinners)   
   local event_name = "DKPMonAward"
	--pprint(itemwinners);
   local tab
   for _, tab in ipairs(itemwinners) do
   		local item_value = 0;
        local entry = {
          name = tab.item.name,
          itemID = DKPmon:ExtractItemID(tab.item.link),
          class = tab.item.class,
          subclass = tab.item.subclass,
          colour = tab.item.colour,
          count = tab.item.count,
          received = "", -- for now
          time = tab.item.time,
          zone = tab.item.zone,
          source = tab.item.source,
          value = {}
      }
      -- Fill in the received field
      if tab.winner == L["Disenchant"] or tab.winner == L["Bank"] then
          entry.received = tab.winner
      else
          -- Grab the winner's raid roster entry, and find out what bidname they're using
          local winner = DKPmon.RaidRoster:GetPlayerInfo(tab.winner)
          if winner == nil then
             -- This shouldn't happen.
             entry.received = tab.winner
          else
             entry.received = winner.bidchar.name
          end
      end
     -- Fill in the values table
      local amt
      for _, amt in pairs(tab.dkp) do
         item_value = item_value + tonumber(amt)
      end

      CT_RaidTracker_AddItem(entry.received, event_name, tab.item.link, item_value)
  end
end

--[[
DeleteLog
Description:
Input:
  logid -- number; the number that the log is stored under in .logs
]]
function Log:DeleteLog(logid)
   local log = self:GetTable()
   -- Delete the log
   --DKPmon:TableDelete(log.logs[logid])
   log.logs[logid] = nil
   -- Remove its entry from the delete menu in the fubar
   DKPmon.Options.fubar.args.logging.args.deletelog.args["l"..logid] = nil
end

--[[
DeleteAllLogs
Description:
  Delete all logs in the database except the currently active log.
]]
function Log:DeleteAllLogs()
   local log = self:GetTable()
   local logid
   for logid, _ in pairs(log.logs) do
      if tonumber(logid) ~= log.currentLog then
	 --DKPmon:TableDelete(log.logs[logid])
	 log.logs[logid] = nil
      end
   end
   -- Wipe out the delete logs menu
   local purge = DKPmon.Options.fubar.args.logging.args.deletelog.args.purgeall
   local spacer = DKPmon.Options.fubar.args.logging.args.deletelog.args.spacer
   
   DKPmon.Options.fubar.args.logging.args.deletelog.args = { purgeall = purge, spacer = spacer }
end

function Log:MigrateLog()
   local log = self:GetTable()
   if log.dbversion == 1.0 then
      -- Go through each item in each log's lootlist, and just add a dummy itemID value.
      local raid
      for _,raid in pairs(log.logs) do
	 local loottab
	 for _, loottab in pairs(raid.lootlist) do
	    loottab.itemID = "0:0:0:0:0:0:0:0"
	 end
      end
      log.dbversion = 1.1
   end
end

--[[
LogToRaidTrackerActive
Description:
  Checks to see if the LogToRaidTrackerOptionsAreActive
]]

-- Guild Launch Check for CT_RaidTracker Compatible Logging
function Log:LogToRaidTrackerActive()
   local log = self:GetTable()
   
   if (log.glctrtlog == true) then
      local rt_interface = GetAddOnMetadata("GuildLaunchCT_RaidTracker", "X-DKPMonInterfaceVersion")
      --DKPmon:Print(rt_interface);
      if (rt_interface ~= nil and tonumber(rt_interface) >= 10000) then
            return true;
      else
            return false;
      end
  else
     return false;
  end
end

--[[
LogToRaidTrackerCheckValidity
Description:
  Checks to see if the current configuration of the Raid Track is valid for logging
]]

function Log:LogToRaidTrackerCheckValidity()
	local log = self:GetTable()
	
	if (log.glctrtlog == true) then
	    if (DKPmon.Logging:LogToRaidTrackerActive() == true) then
	    	if (CT_RaidTracker_GetCurrentRaid == nil) then
				return 3;
			else
				return 1;
			end
	    else
	        return 2;
	    end
	else
		return 1;
	end
end

function Log:LogToRaidTrackerReportValidity()
	local status = DKPmon.Logging:LogToRaidTrackerCheckValidity()
	if (status == 3) then
		if((IsInRaid() == false) and (GetNumGroupMembers() == 0)) then
			DKPmon:Print("You have logging to Guild Launch Raid Tracker active. However, you are not in a raid or a group so logging is currently disabled.");
			return false;
		else
			DKPmon:Print("You have logging to Guild Launch Raid Tracker active, but no current raid in the raid tracker. A raid has been started for you.");
			CT_RaidTrackerCreateNewRaid();	
			return true;
		end
	elseif (status == 2) then
		DKPmon:Print("You have logging to Guild Launch Raid Tracker active, but do not have the correct version of the Raid Tracker. Or you do not have the Raid Tracker loaded. Please download the most recent version.");	
		return false;
	elseif (status == 1) then
		return true;
		--DKPmon:Print("Rapid Raid Logging is Configured Properly"); -- TODO: Remove, only for testing
	end
end
