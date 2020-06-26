--[[
    Copyright Daniel D. Neilson, 2006

    This file is part of DKPmon_FCZS.

    DKPmon_FCZS is free software; you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published by
    the Free Software Foundation; either version 2 of the License, or
    (at your option) any later version.

    DKPmon_FCZS is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.

    You should have received a copy of the GNU General Public License
    along with DKPmon_FCZS; if not, write to the Free Software
    Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
]]

--[[
	Localization provided by Holger Niederschulte
]]

local L = AceLibrary("AceLocale-2.2"):new("DKPmon_FCZS")

local translations = {
   ["Item %s is assigned to an undefined pool."] = "Gegenstand %s ist keinem Pool zugeordnet.",
   ["Unknown"] = "Unbekannt",
   ["DKP = %g"] = "DKP = %g",
   ["Error -- player %s has bid on this item but has never been in the raid! Not listing them."] = "Fehler: Spieler %s hat auf diesen Gegenstand geboten, hat aber nie an einem Raid teilgenommen! Wird nicht aufgelistet.",
   ["Select %s to win the item"] = "W\195\164hle %s als Gewinner f\195\188r diesen Gegenstand",
   ["Yes"] = "Ja",
   ["No"] = "Nein",
   ['Specify item value'] = 'Gegenstandswert angeben',
   ['Specify the value of this item'] = 'Den Wert des Gegenstands angeben',
   ['Assign value'] = 'Wert zuweisen', 
   ['Assign this value to this item'] = 'Weist den Wert diesem Gegenstand zu',
   ["Cannot assign a value of zero"] = "Kann keinen Wert von 0 zuweisen",
   ["Make %s worth %g points from pool %s?"] = "%s wirklich %g Punkte aus Pool %s zuweisen?",
   ['Choose pool'] = 'W\195\164hle Pool', 
   ['Choose which point pool this item is in'] = 'W\195\164hle zu welchem Pool der Gegenstand geh\195\182rt.',
   ['Set value'] = 'Wert festlegen', 
   ['Set the number of points this item is worth'] = 'Legt fest wieviel Punkte dieser Gegenstand wert ist.',
   ['Add/remove a bidder'] = 'Hinzuf\195\188gen/Entfernen eines Bieters',
   ['Add, or remove, a player from the list of bidders for this item.'] = 'Einen Bieter f\195\188r diesen Gegenstand hinzuf\195\188gen bzw. entfernen.',
   ["You have no points."] = "Du hast keine Punkte.",
   ["Your points are:"] = "Dein Punktestand lautet:",
   ["Disenchant"] = "Entzaubern",
   ["Bank"] = "Bank",
   ["Error -- %s has never been in the raid! I cannot deduct points because I don't know enough about them. Please make note of the following deductions and do them manually:"] = "Fehler: %s hat noch nie an einem Raid teilgenommen. Ich weiss nicht genug \195\188ber diesen Spieler, daher kann ich keine Punkte abziehen. Bitte editiere die folgenden Änderungen manuell.",
   ["%s\n%g from pool %d"] = "%s\n%g aus Pool %d",
   ["You have been charged %g %s points for %s."] = "Dir wurden %g %s Punkte f\195\188r %s berechnet.",
   ["Set points to award"] = "W\195\164hle zu vergebende Punkte",
   ['Specify custom amount'] = 'Eigene Punkte festlegen',
   ['Specify a custom number of points to award to everyone'] = 'Legt eine bestimmte Menge an Punkten fest, die jeder erhält.',
   ['Append custom'] = 'Eigene Punkte anhängen', 
   ['Append the currently specified custom amount to the list of points to be awarded.'] = 'Fügt die Punkte der Vergabeliste hinzu.',
   ['Select pool'] = 'W\195\164hle Pool', 
   ['Select the pool to award points to'] = 'W\195\164hle den Pool mit dem die Punkte verrechnet werden sollen.',
   ['Specify points'] = 'Punkte festlegen',
   ["Specify the number of points to award. This can be negative."] = "Die zu verrechnenden Punkte festlegen. Der Wert kann negativ sein.",
   ['Points outstanding'] = 'Ausstehende Punkte',
   ["Award points still waiting to be awarded from item distribution"] = "Ausstehende Punkte aus der Gegenstands-Verteilung vergeben.",
   ["Must have more than 0 players selected to award points to before you can select any outstanding points to be awarded."] = "Es muss mindestens 1 Spieler ausgew\195\164hlt sein, bevor ausstehende Punkte vergeben werden k\195\182nnen.",
   ["Award points for %s"] = "Punkte f\195\188r %s vergeben",

   ['Fixed cost zero-sum options'] = 'Festpreis-Nullsummen Optionen',
   ['Options for the fixed cost zero-sum DKP System'] = 'Optionen f\195\188r das Festpreis-Nullsummen-System',
   ['Item quality threshold'] = 'Gegenstandsqualit\195\164tsgrenze',
   ['Set the threshold on item quality to automatically include in the item list for bidding on.'] = 'Legt die Qualit\195\164tsgrenze f\195\188r Gegenst\195\164nde f\195\188r das automatische Bieten fest.',
   ["|cff%sPoor|r"] = "|cff%sSchlecht|r",
   ["|cff%sCommon|r"] = "|cff%sVerbreitet|r",
   ["|cff%sUncommon|r"] = "|cff%sSelten|r",
   ["|cff%sRare|r"] = "|cff%sRar|r",
   ["|cff%sEpic|r"] = "|cff%sEpisch|r",
   ["|cff%sLegendary|r"] = "|cff%sLegend\195\164r|r",
   ["|cff%sArtifact|r"] = "|cff%sArtefakt|r",
   ['Item adding'] = 'Gegenstand hinzuf\195\188gen',
   ['Enable adding of items to SavedVariables database.'] = 'Erm\195\182glicht es Gegenst\195\164nde zur SavedVariables Datenbank hinzuzuf\195\188gen',
   ['Award DE/Bank points.'] = 'Vergabe von EZ/Bank-Gegenst\195\164nden',
   ['Enable this to include item points from disenchanted and banked items in the zero-sum calculations.'] = 'Aktivieren um Punkte f\195\188r entzauberte und auf die Bank gepackte Gegenst\195\164nde in die Nullsummen-Berechnung mit einzubeziehen.',
   ["Fixed cost zero-sum"] = "Festpreis-Nullsumme",
}

L:RegisterTranslations("deDE",
		       function() return translations end)