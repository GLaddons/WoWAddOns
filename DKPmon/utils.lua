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
    Generic utility functions
]]

function DKPmon:TableDelete(tab)
   local k,v
   for k,v in pairs(tab) do
      if type(tab[k]) == "table" then
	 self:TableDelete(tab[k])
      end
      tab[k] = nil
   end
   tab = nil
end
function DKPmon:DeleteTable(tab) self:TableDelete(tab) end

-- Returns a table indexed by the the names of the people in the raid.
-- Each table value is an integer set to 0
function DKPmon:BuildRaidmemberList()
   local tab = {}
   local i = 1
   while i ~= 41 do
      local name = GetRaidRosterInfo(i)
      if name ~= nil then
	 tab[name] = 0
      end
      i = i + 1
   end
   return tab
end

-- Given a name/word, captilize the first letter and lowercase the rest.
-- Return the result
function DKPmon:ProperNameCaps(name)
   return string.upper(string.sub(name, 1, 1))..string.lower(string.sub(name, 2))
end

function DKPmon:rgbToHex(rgb)
   return string.format("%02x%02x%02x", rgb.r*255, rgb.g*255, rgb.b*255)
end

function DKPmon:getClassHex(class)
   if (class == "DEATH KNIGHT") then
    class="DEATHKNIGHT"
   end
   return self:rgbToHex(RAID_CLASS_COLORS[class])
end

-- Return the current date/time as a single integer to be used as a timestamp
function DKPmon:GetTimestamp()
   local t = date("!*t")
   --[[
   date returns a table with the following fields: 
      year (four digits), 
      month (1--12), 
      day (1--31), 
      hour (0--23), 
      min (0--59), 
      sec (0--61), 
      wday (weekday, Sunday is 1), 
      yday (day of the year), 
      and isdst (daylight saving flag, a boolean).
   ]]
   return ((((t.year - 2006)*356 + t.yday)*24 + t.hour)*60 + t.min)*62 + t.sec
end

-- Given the serialized version of a CharInfo struct, build the table
-- and return it
-- String form: "<name>|<class>|<level>|<race>"
function DKPmon:StringToCharInfo(str)
   local name, class, level, race = strsplit("|", str)
   return { 
      name = name, class = class, level = tonumber(level), race = race,
      classhex = self:getClassHex(class) --,  guild = guild,
   }
end

-- Given an itemLink, extract and return the itemID string
function DKPmon:ExtractItemID(itemLink)
   local _, _, itemID = string.find(itemLink, "|Hitem:(.+)|h%[.+%]")
   return itemID
end