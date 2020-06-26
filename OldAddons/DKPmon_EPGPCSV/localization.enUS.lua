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
local L = AceLibrary("AceLocale-2.2"):new("DKPmon_EPGPCSV")

local translations = {
   -- Import module
   ['EPGP Points database CSV import'] = true,
   ['Overwrite your current points database with the database stored in DKPmon_CSV/importdata.lua'] = true,
   ["Doing this will wipe your current points database. Are you positive you want to continue?"] = true,
   ["Yes"] = true, ["No"] = true,
   ["CSV Import -- string %d is invalid; skipping"] = true,
   ["CSV Import complete"] = true,
   
   -- Export module
   ['EPGP Points database CSV export'] = true,
   ['Export your current points database in CSV format to a text box for copying.'] = true,
   ["Cut and paste the text in the editbox into your favourite text editor."] = true,
   ["Okay"] = true,
}

L:RegisterTranslations("enUS",
		       function() return translations end)
