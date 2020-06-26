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

--[[ 
 This translation by Holger Niederschulte
]]

local L = AceLibrary("AceLocale-2.2"):new("DKPmon_EPGPCSV")

local translations = {
   -- Import module
   ['Points database CSV import'] = 'CSV-Import der Punktedatenbank',
   ['Overwrite your current points database with the database stored in DKPmon_CSV/importdata.lua'] = 'Die vorhandene Datenbank mit den Daten aus der Datei DKPmon_CSV/importdata.lua \195\188berschreiben.',
   ["Doing this will wipe your current points database. Are you positive you want to continue?"] = "Dies l\195\182scht deine aktuelle Datenbank. Bist du sicher, dass du fortfahren willst?",
   ["Yes"] = "Ja",
   ["No"] = "Nein",
   ["CSV Import -- string %d is invalid; skipping"] = "CSV Import: String %d ist ung\195\188ltig; \195\188berspringe",
   ["CSV Import complete"] = "CSV Import abgeschlossen",
   
   -- Export module
   ['Points database CSV export'] = 'CSV-Export der Punktedatenbank',
   ['Export your current points database in CSV format to a text box for copying.'] = 'Exportiert die aktuelle Punktedatenbank im CSV-Format in ein Textfeld',
   ["Cut and paste the text in the editbox into your favourite text editor."] = "Kopiere den Text und f\195\188ge ihn in das von dir favorisierte Textverarbeitungsprogram ein.",
   ["Okay"] = "Okay",
}

L:RegisterTranslations("deDE",
		       function() return translations end)
