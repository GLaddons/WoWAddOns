--[[
    Copyright Daniel D. Neilson, 2006

    This file is part of DKPmon_CSV.

    DKPmon_CSV is free software; you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published by
    the Free Software Foundation; either version 2 of the License, or
    (at your option) any later version.

    DKPmon_CSV is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.

    You should have received a copy of the GNU General Public License
    along with DKPmon_CSV; if not, write to the Free Software
    Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
]]

--[[ 
 This translation by Holger Niederschulte
]]

local L = AceLibrary("AceLocale-2.2"):new("DKPmon_CSV")

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