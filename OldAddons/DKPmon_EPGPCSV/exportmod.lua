--[[
   no copyright by Vlorn

    This file is part of DKPmon_EPGPCSV.

    DKPmon_CSV is free software; you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published by
    the Free Software Foundation; either version 2 of the License, or
    (at your option) any later version.

    DKPmon_CSV is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.

    You should have received a copy of the GNU General Public License
    along with DKPmon_EPGPCSV; if not, write to the Free Software
    Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
    
    This Module is based on the original work by Daniel D. Neilson and modified 
    for use with the Discord EPGP Loot system. It should work with any EPGP type mod to
    to the DKPmon system.
    The primary difference from the native DKPmon_CSV mod is that DKPmon_EPGPCSV allows for
    the importing and exporting of both the points earned and points spent for a given player.


	This file has been modded to support the EPGP methods of points storage, the
	CSV MUST be formated with the following conventions
	 "<name>:<class>:<level>:<race>:<pool 0 pointsEarned>:<pool 0  pointsSpent>:<pool 1 pointsEarned>:... etc"
]]


-- Only works with dbversion 2.0
if DKPmon.DBDefaults.dbversion ~= 2.0 then return end

local AceOO = AceLibrary("AceOO-2.0")
local Export = AceOO.Class(DKPmon_ExportBaseClass)
local L = AceLibrary("AceLocale-2.2"):new("DKPmon_EPGPCSV")

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
      name = L['EPGP Points database CSV export'],
      desc = L['Export your current points database in CSV format to a text box for copying.'],
      func = function()
		Export:PerformExport()
	     end
   }
   return self.fubaritem
end


StaticPopupDialogs["DKPMON_CSV_EXPORT_DATA"] = {
   text = L["Cut and paste the text in the editbox into your favourite text editor."],
   OnShow = nil, -- filled in by the export function
   hasEditBox = 1,
   button1 = L["Okay"],
   timeout = 0,
   whiledead = 1,
   hideOnEscape = 1
}

--[[
PerformExport
Description:
   Build the CSV table and popup a dialog with the data in a text box to be
  copy and pasted out.
Input:
Output:
]]
function Export:PerformExport()
   local numPools = DKPmon.DKP:Get():GetNPools()
   local name, dbtab
   local pointsdb = DKPmon.PointsDB:GetTable()
   local oStr
   local dkpsys = DKPmon.DKP:Get()
   local cstrtab = {}
   local strtab = {}
   for name, dbtab in pairs(pointsdb) do
      local charInfo = dbtab.info
      cstrtab[1] = charInfo.name
      cstrtab[2] = charInfo.class
      cstrtab[3] = tostring(charInfo.level)
      cstrtab[4] = charInfo.race
      local pool 
      local ptab = 1
      for pool = 1, numPools do
	 cstrtab[4+ptab] = tostring(DKPmon.PointsDB:GetEarned(charInfo.name, pool))
	    ptab = ptab + 1
	 cstrtab[4+ptab] = tostring(DKPmon.PointsDB:GetSpent(charInfo.name, pool))  
      ptab = ptab + 1 
      end
      local charstr = strjoin(":", unpack(cstrtab))
      table.insert(strtab, charstr)
   end
   oStr = strjoin("\n", unpack(strtab))
   StaticPopupDialogs["DKPMON_CSV_EXPORT_DATA"].OnShow =
      function()
	 local this  = getglobal(this:GetName())
	 local ebox = getglobal(this:GetName().."EditBox") 
	 ebox:SetText(oStr)
	 ebox:HighlightText()
	 local button = getglobal(this:GetName().."Button1")
	 button:ClearAllPoints()
	 button:SetPoint("CENTER", this, "BOTTOM", 0, 35)
      end
   StaticPopup_Show("DKPMON_CSV_EXPORT_DATA")
end

DKPmon.ImpExpModules:RegisterExportModule(Export, "EPGPCSV")
