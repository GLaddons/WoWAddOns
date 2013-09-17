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
   DKP system custom information registry class for DKPmon
]]

local L = AceLibrary("AceLocale-2.2"):new("DKPmon")

local Registry = { db = {} }
DKPmon.CustomInfo = Registry

--[[
Register
Description:
  Register a table of custom information under the given sysID
Input:
  tab -- table of custom information to register
  sysID -- identifier to use to fetch the table of information. Can be string, number
Returns:
  None
]]
function Registry:Register(tab, sysID)   
   -- Sanity check the arguments
   if type(tab) ~= "table" then
      error(L["Register Custom Info -- first arg must be a table"])
      return
   end
   if type(sysID) ~= "number" and type(sysID) ~= "string" then
      error(L["Register Custom Info -- second arg must be a string or number"])
      return
   end
   if self.db[sysID] ~= nil then
      error(string.format(L["Register Custom Info -- %s already registered."], tostring(sysID)))
      return
   end
   self.db[sysID] = tab
end

--[[
Get
Description:
  Return the custom info table registered to the given ID
Input:
  sysID -- identifier to use to fetch the table of information. Can be string, number
Returns:
  None
]]
function Registry:Get(sysID)
   if self.db[sysID] == nil then
      error(string.format(L["GetCustomInfo() -- %s not registered."], tostring(sysID)))
      return nil
   end
   return self.db[sysID]
end
