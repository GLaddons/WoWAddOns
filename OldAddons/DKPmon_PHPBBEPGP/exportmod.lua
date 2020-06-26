--[[
    Copyright Daniel D. Neilson, 2006

    This file is part of DKPmon_PHPBB.

    DKPmon_PHPBB is free software; you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published by
    the Free Software Foundation; either version 2 of the License, or
    (at your option) any later version.

    DKPmon_PHPBB is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.

    You should have received a copy of the GNU General Public License
    along with DKPmon_PHPBB; if not, write to the Free Software
    Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
]]


-- Only works with dbversion 2.0
if DKPmon.DBDefaults.dbversion ~= 2.0 then return end

local AceOO = AceLibrary("AceOO-2.0")
local Export = AceOO.Class(DKPmon_ExportBaseClass)
local L = AceLibrary("AceLocale-2.2"):new("DKPmon_PHPBB")

--[[
Initialize
Description:
  Called from DKPmon's OnEnable() function to initialize this module, if required
Input: none
Returns: none
]]
function Export:Initialize()
   --
end

--[[
GetFubarItem
Description:
  Called to retreive the module's fubar menu
Input: none
Output: none
]]
function Export:GetFubarItem()
   if self.fubaritem ~= nil then return self.fubaritem end
   self.fubaritem = { 
      type = 'execute',
      name = L['Points database PHPBB export'],
      desc = L['Export your current points database in BB format to a text box for copying.'],
      func = function()
			Export:PerformExport()
	     end
   }
   return self.fubaritem
end


StaticPopupDialogs["DKPMON_PHPBB_EXPORT_DATA"] = {
   text = L["Cut and paste the text in the editbox into your forum post editor."],
   OnShow = nil, -- filled in by the export function
   hasEditBox = 1,
   button1 = L["Okay"],
   timeout = 0,
   whiledead = 1,
   hideOnEscape = 1
}

local	DEATHKNIGHT_COLOR = "[color=#C41E3B]"
local	DRUID_COLOR = "[color=#FF7C0A]"
local	HUNTER_COLOR = "[color=#AAD372]"
local	MAGE_COLOR = "[color=#68CCEF]"
local	PALADIN_COLOR = "[color=#F48CBA]"
local	PRIEST_COLOR = "[color=white]"
local	ROGUE_COLOR = "[color=#FFF468]"
local	SHAMAN_COLOR = "[color=#2359FF]"
local	WARRIOR_COLOR = "[color=#C69B6D]"
local	WARLOCK_COLOR = "[color=#9382C9]"

--[[
CompareElements
Description:
  Compares elements in the PHPBB table to determine order
Input: 
  foo - String, first to be compared
  bar - String, second to be compared
Output:
  Boolean, True if foo comes before bar, False if bar comes before foo
]]
local function CompareElements(foo,bar)
local fooval = 0
local barval = 0

if foo:find(DRUID_COLOR,1,true) then fooval = 9
elseif foo:find(HUNTER_COLOR,1,true) then fooval = 8
elseif foo:find(MAGE_COLOR,1,true) then fooval = 7
elseif foo:find(PALADIN_COLOR,1,true) then fooval = 6
elseif foo:find(PRIEST_COLOR,1,true) then fooval = 5
elseif foo:find(ROGUE_COLOR,1,true) then fooval = 4
elseif foo:find(SHAMAN_COLOR,1,true) then fooval = 3
elseif foo:find(WARRIOR_COLOR,1,true) then fooval = 2
elseif foo:find(WARLOCK_COLOR,1,true) then fooval = 1
elseif foo:find(DEATHKNIGHT_COLOR,1,true) then fooval = 10
end

local fooepgp = string.sub( foo, foo:find(" = %d+.-%d-") )
fooval = fooval + tonumber( string.sub( fooepgp, fooepgp:find('%d+') ) ) / 100000

if bar:find(DRUID_COLOR,1,true) then barval = 9
elseif bar:find(HUNTER_COLOR,1,true) then barval = 8
elseif bar:find(MAGE_COLOR,1,true) then barval = 7
elseif bar:find(PALADIN_COLOR,1,true) then barval = 6
elseif bar:find(PRIEST_COLOR,1,true) then barval = 5
elseif bar:find(ROGUE_COLOR,1,true) then barval = 4
elseif bar:find(SHAMAN_COLOR,1,true) then barval = 3
elseif bar:find(WARRIOR_COLOR,1,true) then barval = 2
elseif bar:find(WARLOCK_COLOR,1,true) then barval = 1
elseif bar:find(DEATHKNIGHT_COLOR,1,true) then barval = 10
end

local barepgp = string.sub( bar, bar:find(" = %d+.-%d-") )
barval = barval + tonumber( string.sub( barepgp, barepgp:find("%d+") ) ) / 100000

return fooval > barval
end

--[[
PerformExport
Description:
   Build the PHPBB table and popup a dialog with the data in a text box to be
  copy and pasted out.
Input:
Output:
]]

function Export:PerformExport()
   local dkpsys = DKPmon.DKP:Get()
   local numPools = dkpsys:GetNPools()
   local name, dbtab
   local pointsdb = DKPmon.PointsDB:GetTable()
   local oStr = ""
   local tStr = ""
   local cstrtab = {}
   local strtab = {}
   local pool
   for name, dbtab in pairs(pointsdb) do
      local charInfo = dbtab.info
      local empty = true
      if charInfo.class == "DRUID" then
      	cstrtab[1] = DRUID_COLOR..charInfo.name.."[/color]"
      elseif charInfo.class == "HUNTER" then
      	cstrtab[1] = HUNTER_COLOR..charInfo.name.."[/color]"
      elseif charInfo.class == "MAGE" then
      	cstrtab[1] = MAGE_COLOR..charInfo.name.."[/color]"
      elseif charInfo.class == "PALADIN" then
      	cstrtab[1] = PALADIN_COLOR..charInfo.name.."[/color]"
      elseif charInfo.class == "PRIEST" then
      	cstrtab[1] = PRIEST_COLOR..charInfo.name.."[/color]"
      elseif charInfo.class == "ROGUE" then
      	cstrtab[1] = ROGUE_COLOR..charInfo.name.."[/color]"
      elseif charInfo.class == "SHAMAN" then
      	cstrtab[1] = SHAMAN_COLOR..charInfo.name.."[/color]"
      elseif charInfo.class == "WARRIOR" then
      	cstrtab[1] = WARRIOR_COLOR..charInfo.name.."[/color]"
      elseif charInfo.class == "WARLOCK" then
      	cstrtab[1] = WARLOCK_COLOR..charInfo.name.."[/color]"
	  elseif charInfo.class == "DEATHKNIGHT" then
      	cstrtab[1] = DEATHKNIGHT_COLOR..charInfo.name.."[/color]"
      else
      	cstrtab[1] = charInfo.name
      end
---      cstrtab[1] = charInfo.name
---      cstrtab[2] = charInfo.class
---      cstrtab[3] = tostring(charInfo.level)
---      cstrtab[4] = charInfo.race
      for pool = 1, numPools do
        ep = DKPmon.PointsDB:GetEarned(name, pool)
        gp = DKPmon.PointsDB:GetSpent(name, pool)
      	points = dkpsys:GetPlayerPoints(charInfo.name, pool)
      	if ep ~= 0 then empty = false end
        cstrtab[1+pool] = tostring(ep).." / "..tostring(gp).." = "..tostring(points)
      end
      local charstr = strjoin(" -- ", unpack(cstrtab))
      if not empty then
      	table.insert(strtab, charstr)
      end
   end
   table.sort(strtab, CompareElements)
   for pool = 1, numPools do
   		tStr = tStr.."[b]"..dkpsys:GetPoolName(pool).."[/b]";
   end
   tStr = "[b]Name[/b] --  EP/GP = Priority\n\n"
   oStr = strjoin("\n", unpack(strtab))
   oStr = ""..tStr..""..oStr..""
   
   StaticPopupDialogs["DKPMON_PHPBB_EXPORT_DATA"].OnShow =
      function(self)
			 local this  = getglobal(self:GetName())
			 local ebox = getglobal(self:GetName().."EditBox") 
			 ebox:SetText(oStr)
			 ebox:HighlightText()
			 local button = getglobal(self:GetName().."Button1")
			 button:ClearAllPoints()
			 button:SetPoint("CENTER", self, "BOTTOM", 0, 35)
      end
   StaticPopup_Show("DKPMON_PHPBB_EXPORT_DATA")
end

DKPmon.ImpExpModules:RegisterExportModule(Export, "PHPBB")