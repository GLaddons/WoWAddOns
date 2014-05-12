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

local PointsDB = DKPmon.PointsDB
local L = AceLibrary("AceLocale-2.2"):new("DKPmon")

--[[
CharInfoToString
Description:
  Serialize the character information passed in the CharInfo struct
Input:
  charInfo -- table; CharInfo struct
Output:
  string -- with this format: "<name>|<class>|<level>|<race>"
]]
function PointsDB:CharInfoToString(charInfo)
   return string.format("%s|%s|%d|%s", charInfo.name, charInfo.class, charInfo.level, charInfo.race) -- , charInfo.guild or "-Not guilded-")
end

--[[
GeneratePlayerSyncStr
Description:
  Generate the string that will be sent to synchronize the given players' points database entry.
Input:
  name -- string; the player's name. Assumes that the player is in the database
Output:
  string -- with this format:
    <charInfo>:<timestamp>:<poolinfo>:<poolinfo>...
    where <charInfo> is the serialization of the player character info (via Bidder:CharInfoToString())
    <timestamp> is the timestamp for the charinfo
    <poolinfo> = <pool#>|<timestamp>|<earned>|<spent>
]]
local psynstrtab = {}
function PointsDB:GeneratePlayerSyncStr(name)
   local tab = self:GetTable(name)
   table.insert(psynstrtab, string.format("%s:%d", self:CharInfoToString(tab.info), tab.info.ts))
   local pool, ptab
   for pool, ptab in pairs(tab.points) do
      table.insert(psynstrtab, string.format("%s|%g|%g|%g", pool,
					     ptab.ts, ptab.earned, ptab.spent)) --, ptab.adj)
   end
   local oStr = strjoin(":", unpack(psynstrtab))
   -- Empty the temp table
   local k
   for k in ipairs(psynstrtab) do
      psynstrtab[k] = nil
   end
   return oStr
end

--[[
UpdatePlayerDBFromString
Description:
  Given the string output from GeneratePlayerSyncStr, parse the string
   and update the player's database entry as timestamps indicate '
Input:
  string -- see above for formatting
Output:
  None
]]
function PointsDB:UpdatePlayerDBFromString(str)
   local parse = { strsplit(":", str) }
   local charInfo = DKPmon:StringToCharInfo(parse[1])
   local ts = tonumber(parse[2])
   local ptab = self:GetTable(charInfo.name)
   if ptab == nil then
      self:AddDBEntry(charInfo)
      ptab = self:GetTable(charInfo.name)
   else
      if ptab.info.ts < ts then
	 ptab.info.level = charInfo.level
	 --ptab.info.guild = charInfo.guild
	 ptab.info.ts = ts
      end
   end
   local i = 3
   while parse[i] ~= nil do
      local pool, ts, earned, spent = strsplit("|", parse[i])
      pool = tonumber(pool); ts = tonumber(ts); earned = tonumber(earned); spent = tonumber(spent); --adj = tonumber(adj)
      if ptab.points[pool] == nil then
	 ptab.points[pool] = { earned = earned, spent = spent, ts = ts } --, adj = adj
      else
	 if ptab.points[pool].ts < ts then -- only update if our timestamp's less than the one given '
	    ptab.points[pool].ts = ts
	    ptab.points[pool].earned = earned
	    ptab.points[pool].spent = spent
--	    ptab.points[pool].adj = adj
	 end
      end
      i = i + 1
   end
   --DKPmon:TableDelete(parse)
end

--[[
BuildBCastStr
Description:
  Build the string to send for broadcasting the entire points database
Input:
Output:
  string -- formatted as:
   <playerstr>&<playerstr>&<playerstr>&...
   where <playerstr> is as returned from GeneratePlayerSyncStr
]]
function PointsDB:BuildBCastStr()
   local name
   local pointsdb = self:GetTable()
   local strtab = {}
   for name, _ in pairs(pointsdb) do
      local pstr = self:GeneratePlayerSyncStr(name)
      table.insert(strtab, pstr)
   end
   return strjoin("&", unpack(strtab))
end

--[[
ParseBCastStr
Description:
  Given a string as output by BuildBCastStr, parse the string and update our local database as appropriate
Input:
  str -- string; formatted as the output of BuildBCastStr
Output:
  None
]]
function PointsDB:ParseBCastStr(str)
   local playerstrs = { strsplit("&", str) }
   local str
   for _, str in ipairs(playerstrs) do
      self:UpdatePlayerDBFromString(str)
   end
   --DKPmon:TableDelete(playerstrs)
   self:CalculateChecksum()
end

--[[
SendBroadcast
Description:
  Send our points database over the raid addon comm channel so other people can sync to it.
Input:
Output:
]]
function PointsDB:SendBroadcast()
   local str = self:BuildBCastStr()
   DKPmon.Comm:SendToDKPmon("BC", { pw = DKPmon.db.realm.password, info = str} )
end


--[[
ReceiveBroadcast
Description:
  Called when we receive points database broadcast information over the comm channel
Input:
  sender -- string; person who sent the broadcast
  params -- string; string formatted as the output of BuildBCastStr
Output:
  boolean -- true if we are going to try to process the info, false to requeue it for later
]]
function PointsDB:ReceiveBroadcast(sender, params)
   if sender == Bidder:GetFixedUpUnitName("player") then return true end
   -- We already have a broadcast waiting to be processed. Put this receive back on the queue
   if self.bcaststr ~= nil then return false end
   if params.pw ~= DKPmon.db.realm.password then return true end
   local ret = StaticPopup_Show("DKPMON_CONFIRM_RECEIVEBCAST", sender)
   if ret == nil then
      -- Couldn't show the popup for some reason
      return false
   end
   self.bcaststr = params.info
   return true
end
DKPmon.Comm:RegisterCommand("BC", PointsDB.ReceiveBroadcast, PointsDB)

--[[
ProcessBroadcast
Description:
  Called when the user clicks the "Yes" button on the dialog asking whether the received broadcast information should be processed. This will sync our database with that information.
Input:
Output:
]]
function PointsDB:ProcessBroadcast()
   if self.bcaststr == nil then return end
   self:ParseBCastStr(self.bcaststr)
   self.bcaststr = nil
end

--[[
KillBroadcast
Description:
  Called when the user clicks the "No" button on the dialog asking whether the received broadcast information should be processed. This will just discard the information
Input:
Output:
]]
function PointsDB:KillBroadcast()
   self.bcaststr = nil
end

--[[
ReceiveSyncRequest
Description:
  Process a database synchronization request
Input:
Output:
  true
]]
function PointsDB:ReceiveSyncRequest(sender, params)
   if sender == Bidder:GetFixedUpUnitName("player") then return true end
   if params ~= DKPmon.db.realm.password then return true end
   if DKPmon.db.realm.alwayssync then 
      self:SendBroadcast()
      return true
   end
   local ret = StaticPopup_Show("DKPMON_CONFIRM_PARTICIPATESYNC", sender)
   if ret == nil then 
      -- Couldn't show the popup for some reason
      return false
   end
   return true
end
DKPmon.Comm:RegisterCommand("S", PointsDB.ReceiveSyncRequest, PointsDB)


--[[
ReceiveBidderPointsDBRequest
Description:
  Process the "RPDB" communication command
]]
function PointsDB:ReceiveBidderPointsDBRequest(sender, params)
   -- If I'm not the loot master, then I tell the person running the mod.
   if not DKPmon:GetLeaderState() then return true end

   -- If the parameter is different from the checksum that we have for our database, then
   -- we need to send our database to all the Bidders.
   if params ~= DKPmon.db.realm.DKP.checksum then
      local dkpsys = DKPmon.DKP:Get()
      local tab = {
	 checksum = DKPmon.db.realm.DKP.checksum,
	 poolnames = {},
	 db = {}
      }
      -- Add the poolnames
      local dkpsys = DKPmon.DKP:Get()
      local nPools, i = dkpsys:GetNPools()
      for i = 1, nPools do
	 table.insert(tab.poolnames, dkpsys:GetPoolName(i))
      end
      -- For every entry in the points database, add it to the tab.db
      local name, pdbTab
      local strtab = {}
      for name, pdbTab in pairs(DKPmon.db.realm.DKP.db) do
	 strtab[1] = string.format("%s|%s", name, pdbTab.info.class)
	 for i = 1, nPools do
	    strtab[1+i] = tostring(dkpsys:GetPlayerPoints(name,i)) -- = string.format("%s|%g", str, dkpsys:GetPlayerPoints(name, i)) -- self:GetPlayerPoints(name, i))
	 end
	 table.insert(tab.db, strjoin("|", unpack(strtab)))
      end

      -- Send the database information to all Bidder users
      DKPmon.Comm:SendToBidder("PDB", tab)
   end

   -- Tell the sender to display the DKP browsing window
   DKPmon.Comm:SendToBidder("DPDB", DKPmon.db.realm.DKP.checksum, sender)
   -- All done, remove the message from the processing queue
   return true
end
DKPmon.Comm:RegisterCommand("RPDB", PointsDB.ReceiveBidderPointsDBRequest, PointsDB)