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

local L = AceLibrary("AceLocale-2.2"):new("DKPmon")

local RaidRoster = { } -- list = {}, left = {} }

DKPmon.RaidRoster = RaidRoster

function RaidRoster:GetTable()
   return DKPmon.db.realm.RaidRoster
end

--[[
BuildRoster
Description:
  Called from DKPmon:OnEnable() to build the raid roster in the event of logging in when already in a raid.
Input:
Returns:
]]
function RaidRoster:BuildRoster()
   -- Check if we're in a Battleground, and don't update anything if we are
   if (GetNumBattlefieldScores() > 0) then return end
   local numMembers = GetNumGroupMembers()
   local rostertab = self:GetTable()
   local haveLevelZeros = false
   if numMembers == 0 or IsInRaid() == false then
      DKPmon:SetLeader(false) -- Can't be running a raid if you're not in one.
      rostertab.list = {}
      rostertab.left = {}
      return
   end
   local i
   for i = 1, numMembers do
      local name, _, _, level, _, class = GetRaidRosterInfo(i)
      if level == 0 then -- player's offline
	 level = UnitLevel("raid"..i)
	 haveLevelZeros = haveLevelZeros or (level == 0)
      end
      if rostertab.list[name] == nil then
	 local level = UnitLevel("raid"..i)
	 haveLevelZeros = haveLevelZeros or (level == 0)
	 --local guild = GetGuildInfo("raid"..i)
	 --if guild == nil then guild = "-Unknown-" end
	 local race = UnitRace("raid"..i)
	 local hex = DKPmon:getClassHex(class)
	 local charInfo = { name = name, class = class, classhex = hex, level = level, race = race } --, guild = guild }
	 rostertab.list[name] = { char = charInfo, bidchar = charInfo, onlist = false }
      end
   end
   if haveLevelZeros then
      DKPmon:StartMetro("DKPmonUpdateLevelZeros")
   end
end

--[[
UpdateRoster
Description:
  Called whenever a RAID_ROSTER_CHANGED event is fired. This'll update our local listing of the people in the raid.
Input:
Returns:
]]
function RaidRoster:UpdateRoster()
   -- Check if we're in a Battleground, and don't update anything if we are
   if (GetNumBattlefieldScores() > 0) then return end
   local numMembers = GetNumGroupMembers()
   local rostertab = self:GetTable()
   local haveLevelZeros = false
   if numMembers == 0 or IsInRaid() == false then
      rostertab.list = {}
      rostertab.left = {}
      return
   end
   local i
   for i = 1, numMembers do
      local name = GetRaidRosterInfo(i)
      if rostertab.list[name] == nil then
	 self:AddMember(name, i)
      end
      haveLevelZeros = haveLevelZeros or (rostertab.list[name].char.level == 0)
      rostertab.list[name].present = true
   end
   local name, tab
   for name, tab in pairs(rostertab.list) do
      if tab.present then
         tab.present = nil
      else
	 self:RemoveMember(name)
      end
   end
   if haveLevelZeros then
      DKPmon:StartMetro("DKPmonUpdateLevelZeros")
   end
   -- Update the status text in the awarding points window.
   DKPmon.Awarding:UpdateRaidText()
end

function RaidRoster:GetRoster()
   return self:GetTable().list
end

--[[
UpdateLevelZeros
Description:
  Called from a metrognome timer when the raid roster contains members that are level zero.
  This function iterates over the raid roster, and updates the info of the players who are level
  zero.
Input:
Returns:
]]
function RaidRoster:UpdateLevelZeros()
   if (GetNumBattlefieldScores() > 0) then 
      DKPmon:StopMetro("DKPmonUpdateLevelZeros")
      return 
   end
   local numMembers = GetNumGroupMembers()
   local rostertab = self:GetTable()
   local haveL0 = false
   if numMembers == 0 or IsInRaid() == false then -- empty raid, not sure how we got called.
      DKPmon:StopMetro("DKPmonUpdateLevelZeros")
      return
   end
   local i
   for i = 1, numMembers do
      local name, _, _, level, _, class = GetRaidRosterInfo(i)
      if level ~= 0 and rostertab.list[name].char.level == 0 then
	 local race = UnitRace("raid"..i)
	 local hex = DKPmon:getClassHex(class)
	 local cInfo = rostertab.list[name].char
	 cInfo.class = class
	 cInfo.classhex = hex
	 cInfo.level = level
	 cInfo.race = race
      end
      haveL0 = haveL0 or (rostertab.list[name].char.level == 0)
   end
   if not haveL0 then
      DKPmon:StopMetro("DKPmonUpdateLevelZeros")
   end
end

--[[
AddMember
Description:
  Called to add a player to the raid
Input:
Returns:
]]
function RaidRoster:AddMember(name, i)
   local rostertab = self:GetTable()
   -- First, check if the player's already in the list of people who left the raid (i.e. they're rejoining)
   if rostertab.left[name] ~= nil then
      rostertab.list[name] = rostertab.left[name]
      rostertab.left[name] = nil
   else
      local name, _, _, level, _, class = GetRaidRosterInfo(i)
      local raidID = "raid"..i
      local level = UnitLevel(raidID)
      --local guild = GetGuildInfo(raidID)
      local race = UnitRace(raidID)
      local hex = DKPmon:getClassHex(class)
      local charInfo = { name = name, class = class, classhex = hex, level = level, race = race } --, guild = guild }
      rostertab.list[name] = { char = charInfo, bidchar = charInfo, onlist = false }
   end
   DKPmon.Logging:PlayerJoin(rostertab.list[name].bidchar)
end

--[[
RemoveMember
Description:
  Called to remove a player from the raid
Input:
Returns:
]]
function RaidRoster:RemoveMember(name)
   local rostertab = self:GetTable()
   if rostertab.list[name] == nil then return end
   -- Just move them into the list of people who've left the raid
   rostertab.left[name] = rostertab.list[name]
   rostertab.list[name] = nil
   DKPmon.Logging:PlayerLeave(rostertab.left[name].bidchar)
end

--[[
    SetBidname
Description:
  Change the bidname of the given player.
Input:
  name -- string; name of the player who's bidname we're changing
  charInfo -- table; CharInfo table to set the bidding name to
Returns:
]]
function RaidRoster:SetBidname(name, charInfo)
   local rostertab = self:GetTable()
   local tab = rostertab.list[name] or rostertab.left[name]
   if tab == nil then
      error(string.format(L["%s not present in the raid roster. This is -bad-"], name))
      return
   end
   if name == charInfo.name then return end -- character's name & bidding name are the same; nothing to do
   tab.bidchar = charInfo
   DKPmon.Logging:PlayerLeave(tab.char)
   DKPmon.Logging:PlayerJoin(tab.bidchar)
end

--[[
GetPlayerInfoMember
Description:
  Checks if the given player is in the raid, and if so it returns the player's RosterEntry table
Input:
  name -- string; in-game name of a player to look up
Returns:
  table or nil
]]
function RaidRoster:GetPlayerInfo(name)
   local rostertab = self:GetTable()
   if rostertab.list[name] ~= nil then return rostertab.list[name] end
   if rostertab.left[name] ~= nil then return rostertab.left[name] end
   return nil
end

--[[
]]
function RaidRoster:IsPlayerInRaid(name)  
   local rostertab = self:GetTable()
   return rostertab.list[name] ~= nil
end
