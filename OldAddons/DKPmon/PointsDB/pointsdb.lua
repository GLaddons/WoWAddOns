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
--[[
    Functions for manipulating the player-points database.
]]

local L = AceLibrary("AceLocale-2.2"):new("DKPmon")

-- Points multiplier to round all point values.
local trunc_multiplier = 1000

local PointsDB = {}
DKPmon.PointsDB = PointsDB

function PointsDB:GetTable(name)
   if name == nil then return DKPmon.db.realm.DKP.db end
   return DKPmon.db.realm.DKP.db[name]
end

--[[
GetPlayerPoints(name, pool)
Description:
  Fetches the number of <pool#> points that player "name" has.
Input:
  name: The bidname to lookup
  pool: The pool number to lookup
Output:
  integer: The total number of points the player has in the pool
]]
function PointsDB:GetPlayerPoints(name, pool)
   local tab = self:GetTable(name)
   if tab == nil then return 0; end
   tab = tab.points
   if tab[pool] == nil then return 0; end
   return tab[pool].earned - tab[pool].spent --+ tab[pool].adj
end


--[[
GetEarned
Description:
  Fetch the number of points the given player has earned in the given pool.
Input:
  name: The bidname to lookup
  pool: The pool number to lookup
Output:
  integer: The total number of points earned by the player
]]
function PointsDB:GetEarned(name, pool)
   local tab = self:GetTable(name)
   if tab == nil then return 0; end
   tab = tab.points
   if tab[pool] == nil then return 0; end
   return tab[pool].earned
end

--[[
GetSpent
Description:
  Fetch the number of points the given player has spent in the given pool.
Input:
  name: The bidname to lookup
  pool: The pool number to lookup
Output:
  integer: The total number of points spent by the player
]]
function PointsDB:GetSpent(name, pool)
   local tab = self:GetTable(name)
   if tab == nil then return 0; end
   tab = tab.points
   if tab[pool] == nil then return 0; end
   return tab[pool].spent
end

--[[
WipeDatabase
Description:
  Completely deletes the currently stored DKP database, and starts from scratch
]]
function PointsDB:WipeDatabase()
   DKPmon:TableDelete(self:GetTable())
   DKPmon.db.realm.DKP.db = {} -- just to make sure it's toast
   -- Reset the checksum
   DKPmon.db.realm.DKP.checksum = 0
end

-- Calculate the checksum for the database from scratch
function PointsDB:CalculateChecksum()
   local sum = 0
   local db = self:GetTable()
   local tab
   for _, tab in pairs(db) do
      local ptab
      for _, ptab in pairs(tab.points) do
	 sum = sum + ptab.earned + ptab.spent --+ ptab.adj
      end
   end
   DKPmon.db.realm.DKP.checksum = sum
end

--[[
AddDBEntry(name, class)
Description:
  Add an entry to the points database
Input:
  charInfo -- table; CharInfo struct for the player to add
Output:
  None
]]
function PointsDB:AddDBEntry(charInfo)
  DKPmon.Print('CharInfo AddDBEntry',charInfo.name)
   DKPmon.db.realm.DKP.db[charInfo.name] = { 
      info = {
	 name = charInfo.name, class = charInfo.class, level = charInfo.level, race = charInfo.race,
	 ts = DKPmon:GetTimestamp() -- guild = charInfo.guild, 
      },
      points = {} }
   DKPmon.Awarding:UpdateDBList(charInfo.name)
end

--[[
AwardPoints(name, class, pool, pnts)
Description:
  Awards points to the name given
Input:
  charInfo -- CharInfo struct for the character to award points to
  pool: The pool number to award points in
  pnts: The number of points to add.
Output:
  None
]]
function PointsDB:AwardPoints(charInfo, pool, pnts)
   -- If the name's not in the DB, then add it.
   if self:GetTable(charInfo.name) == nil then 
      self:AddDBEntry(charInfo)
   end
   local tab = self:GetTable(charInfo.name)
   if tab.points[pool] == nil then
      tab.points[pool] = { earned = 0, spent = 0 } --, adj = 0 }
   end
   -- Round the number of points to some number of decimal places.
   pnts = math.floor( pnts * trunc_multiplier + 0.5 ) / trunc_multiplier
   tab.points[pool].earned = tab.points[pool].earned + pnts 
   tab.points[pool].ts = DKPmon:GetTimestamp()
   -- Update the info part of the table, just in case guild or level changed
   --tab.info.guild = charInfo.guild
   tab.info.level = charInfo.level
   tab.info.ts = tab.points[pool].ts
   -- update the checksum
   DKPmon.db.realm.DKP.checksum = DKPmon.db.realm.DKP.checksum + pnts
end

--[[
SpendPoints(charInfo, pool, pnts)
Description:
  Spends points from the name given
Input:
  charInfo -- CharInfo struct for the character to award points to
  pool: The pool number to award points in
  pnts: The number of points to add.
Output:
  None
]]
function PointsDB:SpendPoints(charInfo, pool, pnts)
   -- If the name's not in the DB, then add it.
   if self:GetTable(charInfo.name) == nil then 
      self:AddDBEntry(charInfo)
   end
   local tab = self:GetTable(charInfo.name)
   if tab.points[pool] == nil then
      tab.points[pool] = { earned = 0, spent = 0 } --, adj = 0 }
   end
   -- Round the number of points to some number of decimal places.
   pnts = math.floor( pnts * trunc_multiplier + 0.5 ) / trunc_multiplier
   tab.points[pool].spent = tab.points[pool].spent + pnts 
   tab.points[pool].ts = DKPmon:GetTimestamp()
   -- Update the info part of the table, just in case guild or level changed
   --tab.info.guild = charInfo.guild
   tab.info.level = charInfo.level
   tab.info.ts = tab.points[pool].ts
   -- update the checksum
   DKPmon.db.realm.DKP.checksum = DKPmon.db.realm.DKP.checksum + pnts
end

--[[
SetPoints
Description:
  Set the earned and spent fields for the given pool to the given values.
Input:
  charInfo -- CharInfo struct for the character to award points to
  pool: The pool number to set the points of
  earned -- number; amount to set earned to
  spent -- number; amount to set spent to
Output:
  none
]]
function PointsDB:SetPoints(charInfo, pool, earned, spent)
   if type(earned) ~= "number" or type(spent) ~= "number" then 
      error(L["Bad types to earned and spent"])
      return
   end
   if self:GetTable(charInfo.name) == nil then 
      self:AddDBEntry(charInfo)
   end
   local tab = self:GetTable(charInfo.name)
   if tab.points[pool] == nil then
      tab.points[pool] = { earned = 0, spent = 0 } --, adj = 0 }
   end
   -- Round earned & spent
   earned = math.floor( earned * trunc_multiplier + 0.5 ) / trunc_multiplier
   spent = math.floor( spent * trunc_multiplier + 0.5 ) / trunc_multiplier
   local tp = tab.points[pool]
   local oSpent, oEarn = tp.spent, tp.earned
   tp.earned = earned
   tp.spent = spent
   tp.ts = DKPmon:GetTimestamp()
   -- Update the info part of the table, just in case guild or level changed
   tab.info.level = charInfo.level
   tab.info.ts = tp.ts
   -- update the checksum
   DKPmon.db.realm.DKP.checksum = DKPmon.db.realm.DKP.checksum + (earned + spent) - (oSpent + oEarn)
end

--[[
AwardFromList(playerlist, pointslist)
Description:
  Given a table of CharInfo structs, and a list of points to award/deduct, adjust all the player's points.
Input:
  playerlist -- table, indexed by name of CharInfo structs
  pointslist -- table, indexed in increasing number, of { pool = #, amount = #, source = string } tables
Output:
  None
]]
function PointsDB:AwardFromList(playerlist, pointslist)
   local pnts
   for _, pnts in ipairs(pointslist) do
      local charInfo
      for _, charInfo in pairs(playerlist) do
	 if pnts.amount > 0 then
	    self:AwardPoints(charInfo, pnts.pool, pnts.amount)
	 else
	    self:SpendPoints(charInfo, pnts.pool, -pnts.amount)
	 end
      end
   end
end
