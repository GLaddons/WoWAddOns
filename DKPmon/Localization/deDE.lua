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
 This translation by Holger Niederschulte
]]

local L = AceLibrary("AceLocale-2.2"):new("DKPmon")

local translations = {
   ["DKPmon"] = "DKPmon",
   ["Disenchant"] = "Entzaubern",
   ["Bank"] = "Bank",
   ["Yes"] = "Ja",
   ["No"] = "Nein",
   
   -- Lootitem
   ["%d Bids  -- Winner = %s"] = "%d Gebote -- Gewinner = %s",
   ["Blocking for more info"] = "Blocking for more info",
   ['Disenchant the item'] = "Gegenstand entzaubern",
   ['Pass the item to the guild bank'] = "Gegenstand an die Gildenbank",
   ['Remove item'] = "Gegenstand entfernen",
   ['Remove this item from the list'] = "Gegenstand von der Liste entfernen",
   ['Distribute via masterlooter'] = "Mittels Pl\195\188ndermeister verteilen",
   ['Give this item to its winner via masterlooter'] = "Diesen Gegenstand durch den Pl\195\188ndermeister an den Gewinner geben",
   ["ERROR: Could not find %s in loot window."] = "FEHLER: Konnte %s nicht im Loot-Fenster finden",
   ["Selected winner for %s is not in the raid. Cannot distribute"] = "Der ausgew\195\164hlte Gewinner f\195\188r %s befindet sich nicht in der Schlachtgruppe. Kann Gegenstand nicht vergeben",
   ["ERROR: %s could not be found in the MasterLooter list for %s"] = "FEHLER: %s konnte in der Pl\195\188ndermeisterliste f\195\188r %s nicht gefunden werden",

   -- Lootframe
   ["DKPmon: Loot Distribution"] = "DKPmon: Loot-Verteilung",
   ["Actions"] = "Aktionen",
   ["DKP System: "] = "DKP-System",
   ["Logging: "] = "Logging",
   ["DKP System: %s"] = "DKP-System: %s",
   ["Logging: Disabled"] = "Logging: deaktiviert",
   ["Log: %s started %s"] = "Log: %s gestartet %s",
   ["Sorry, bidding was cancelled."] = "Entschuldigung, Auktion wurde abgebrochen.",
   ['Clear all'] = "Alles l\195\182schen",
   ['Clear all items from the distribution window'] = "Alle Gegenst\195\164nde aus dem Verteilungsfenster l\195\182schen",
   ['Open bidding'] = "Auktion er\195\182ffnen", 
   ['Open bidding on all items'] = "Auktion f\195\188r alle Gegenst\195\164nde er\195\182ffnen",
   ['Close timer'] = 'Countdown-Dauer', 
   ['Select time in which to close bidding'] = "W\195\164hle Countdown-Dauer",
   ['Close bidding'] = "Auktion beenden", 
   ['Start the timer to close bidding on all items'] = "Countdown zur Auktionsbeendigung f\195\188r alle Gegenst\195\164nde starten",
   ['Cancel closing timer'] = "Countdown abbrechen",
   ['Cancel the countdown timer for close of bidding'] = 'Den Countdown abbrechen um die Auktion vorzeitig zu beenden.',
   ["Bid closing countdown cancelled."] = "Countdown f\195\188r Auktionsende abgebrochen.",
   ['Cancel'] = "Abbrechen", 
   ['Cancel the open bidding and allow more items to be added'] = "Aktuelle Auktion abbrechen um weitere Gegenst\195\164nde hinzuzuf\195\188gen",
   ['Announce'] = "Verk\195\188nden", 
   ['Announce all item winners'] = "Gewinner verk\195\188nden",
   ["Deduct winners' points"] = "Punkte beim Gewinner abziehen", 
   ["You're not in a raid group."] = "Du bist in keiner Schlachtgruppe.",
   ["Item %d needs information filled in before bidding can begin."] = "Informationen f\195\188r den Gegenstand %d m\195\188ssen ausgef\195\188llt werden, bevor die Auktion gestartet werden kann.",
   ["Bidding is now open on:"] = "Auktion gestartet f\195\188r:",
   ["Error -- sent bid on non-existant item."] = "FEHLER: Gebot f\195\188r einen nicht-existierenden Gegenstand.",
   ["Error -- Received bid from %s on item that does not exist."] = "FEHLER: Gebot von %s f\195\188r einen nicht existierenden Gegenstand.",
   ["Your bid on item %s was rejected."] = "Dein Gebot f\195\188r %s wurde zur\195\188ckgewiesen.",
   ["Your bid on item %s was accepted."] = "Dein Gebot f\195\188r %s wurde akzeptiert.",
   ["Your bid on item %s was removed."] = "Dein Gebot f\195\188r %s wurde entfernt.",
   ["Bidding is now closed."] = "Auktion ist beendet.",
   ["Bidding closing in %g seconds."] = "Auktion endet in %g Sekunden.",
   ["Bidding temporarily cancelled."] = "Auktion vor\195\188bergehend unterbrochen.",
   ["And the winners are:"] = "Gewinner:",

   -- Looting/looting.lua
   ["Unknown mob"] = "Unbekannter Gegner",
   ["Invalid item link: %s"] = "Ung\195\188ltiger Item-Link: %s",
   
   -- Options table: console commands
   ['biditem'] = "biditem",
   ['Supply a list of item links to bid on.'] = 'Zeigt eine Liste von Gegenst\195\164nden, auf die geboten werden kann.',
   ['<itemlink>[<itemlink>]+'] = '<itemlink>[<itemlink>]+',
   ['showbids'] = 'showbids',
   ['Show the loot distribution interface.'] = '\195\182ffnet das Loot-Verteilungsfenster.',
   ['award'] = 'award',
   ['Bring up the points awarding interface.'] = '\195\182ffnet das Punktevergabe-Fenster.',
   ['pointsdb'] = 'pointsdb',
   ['Functions for the points database'] = 'Funktionen f\195\188r die Punkte-Datenban',
   ['bcast'] = 'bcast',
   ['Broadcast your points database to the other DKPmons in the raid.'] = 'Deine Punkte-Datenbank an andere DKPmons im Schlachtzug senden.',
   ['sync'] = 'sync',
   ['Request a database synchronization with the DKPmon users in the raid.'] = 'Erfragt eine Datenbank-Synchronisation mit anderen DKPmon-Nutzern im Schlachtzug.',
   ['alwayssync'] = 'alwayssync',
   ['Toggle whether or not to always send your database on a sync request.'] = 'W\195\164hlen ob deine Datenbank bei einer Synchronistaionsanfrage immer gesendet werden soll oder nicht.',
   ['password'] = 'password',
   ['Set your broadcast password.'] = 'Legt das \195\188bertragungspasswort fest.',
   ['<password>'] = '<password>',
   ['raidsetup'] = 'raidsetup',
   ['Configure settings for the raid.'] = 'Einstellungen f\195\188r den Schlachtzug konfigurieren.',
   ['setde'] = 'setde',
   ["Set the name of the raid's disenchanter. Case sensative! Remove spaces!"] = 'Den Namen f\195\188r den Entzauberer im Schlachtzug festlegen. Fall sensative! Leerzeichen entfernen!',
   ['<Name-Server>'] = '<Name-Server>',
   ['setbank'] = 'setbank',
   ["Set the name of the player to give all bankables to. Case sensative! Remove spaces!"] = 'Den Namen f\195\188r den Banker des Schlachtzugs festlegen. Fall sensative! Leerzeichen entfernen!',
   
   -- Options table: Fubar items
   ['Points database'] = "Punkte-Datenbank",
   ['Functions for the points database'] = "Funktionen f\195\188r die Punkte-Datenbank",
   ['Broadcast database'] = "Datenbank senden",
   ['Broadcast your points database to the other DKPmons in the raid.'] = "Deine Punkte-Datenbank an andere DKPmons im Schlachtzug senden.",
   ['Intiate database synchronization'] = "Datenbank-Synchronisation starten",
   ['Request a database synchronization with the DKPmon users in the raid.'] = "Erfragt eine Datenbank-Synchronisation mit anderen DKPmon-Nutzern im Schlachtzug.",
   ['Always send on sync request'] = "Immer bei Synchronisations-Anfrage senden",
   ['Toggle whether or not to always send your database on a sync request.'] = "W\195\164hlen ob deine Datenbank bei einer Synchronistaionsanfrage immer gesendet werden soll oder nicht.",
   ['Set broadcast password'] = "\195\188bertragungspasswort w\195\164hlen",
   ['Set your broadcast password.'] = "Legt das \195\188bertragungspasswort fest.",
   ["Raid Setup"] = "Schlachtzug-Konfiguration",
   ['Configure settings for the raid.'] = "Einstellungen f\195\188r den Schlachtzug konfigurieren.",
   ["I'm running this raid."] = "Ich manage die DKP",
   ["Check this item if you're running loot distribution for the raid."] = "Aktivieren wenn du die DKP-Verwaltung dieses Schlachtzugs \195\188bernimmst",
   ['Set disenchanter'] = "Entzauberer festlegen",
   ['Set banker'] = "Banker festlegen",
   ["Logging"] = "Logging",
   ["Options related to raid information logging."] = "Einstellungen f\195\188r das Loggen der Schlachtzug-Informationen.",
   ["CTRT compatibility mode."] = "CTRT compatibility mode.",
   ["Enable this to log non-boss mobs as 'Trash Mob' rather than by their name."] = "Enable this to log non-boss mobs as 'Trash Mob' rather than by their name.",
   ['Log name'] = "Log-Name",
   ['Specify a name for the log to start'] = "Namen f\195\188r den Log angeben",
   ['Start log'] = "Log starten",
   ["Begin a log for your raid with the name specified under 'Log name.'"] = "Startet einen Log f\195\188r den Raid mit dem Namen, der unter 'Log-Name' spezifiziert wurde.",
   ["You must be in a raid to begin a log."] = "Du musst in einem Schlachtzug sein, um einen Log zu starten.",
   ["Cannot start a log until you give it a name"] = "Log kann nicht ohne Namen starten.",
   ["You must stop your current log before beginning a new one."] = "Du musst den aktuellen Log beenden, bevor du einen neuen starten kannst.",
   ['Stop log'] = "Log beenden",
   ["Stop logging for your current log"] = "Beendet den aktuellen Log.",
   ["You do not have an active log to stop."] = "Es ist kein Log aktiv, der beendet werden k\195\182nnte.",
   ['View logs'] = "Logs ansehen",
   ['Open a window from which your log contents can be viewed'] = "\195\182ffnet ein Fenster von welchem aus die Logs eingesehen werden k\195\182nnen.",
   ['Enable automatic log start'] = 'Enable automatic log start (Needs translation)',
   ['Toggle on to enable automatic log start when entering a raid instance.'] = 'Toggle on to enable automatic log start when entering a raid instance. (Needs translation)',
   ["Delete log(s)"] = "Log('s) l\195\182schen",
   ["Delete some, or all, of your stored logs"] = "Erm\195\182glicht es gespeicherte Logs zu l\195\182schen.",
   ['Delete all logs'] = "Alle Logs l\195\182schen",
   ['Delete every single non-active stored log. This is not reversable.'] = "L\195\182scht ALLE nicht-aktiven Logs. Nicht wiederherstellbar!",
   ['Show loot distribution window'] = "Loot-Verteilungsfenster \195\182ffnen",
   ['Show the loot distribution interface.'] = "\195\182ffnet das Loot-Verteilungsfenster.",
   ['Show points awarding window.'] = "Punktevergabe-Fenster \195\182ffnen",
   ['Bring up the points awarding interface.'] = "\195\182ffnet das Punktevergabe-Fenster.",
   
   -- option functions
   ["Bidding is open, cannot add more items. Close bidding first."] = "Auktion im Gange. Es k\195\182nnen keine neuen Gegenst\195\164nde hinzugef\195\188gt werden. Beende die Auktion vorher.",
   ["Console"] = 'Console',

   -- PointsDB
   ["Bad types to earned and spent"] = "Bad types to earned and spent",
   
   -- Comm\comm.lua
   ["Communications command %s already registered."] = "Communications command %s already registered.",
   ["Expected function for dispatchfunc, got %s instead."] = "Expected function for dispatchfunc, got %s instead.",
   
   -- Custom/registry.lua
   ["Register Custom Info -- first arg must be a table"] = "Register Custom Info -- first arg must be a table",
   ["Register Custom Info -- second arg must be a string or number"] = "Register Custom Info -- second arg must be a string or number",
   ["Register Custom Info -- %s already registered."] = "Register Custom Info -- %s already registered.",
   ["GetCustomInfo() -- %s not registered."] = "GetCustomInfo() -- %s not registered.",
   
   -- main.lua
   ["/dkp"] = "/dkp",
   ["/dkpmon"] = "/dkpmon",
   ["Database version changed. Migrating to new format."] = "Datenbankversion ge\195\164ndert. Passe an neues Format an.",
   ["Log version changed. Migrating to new format."] = "Log-Version ge\195\164ndert. Passe an neues Format an.",
   ["Disabled"] = "deaktiviert",
   ["DKP Leader:"] = "DKP F\195hrer",
   ["Logging:"] = "Logging:",
   ["Click to open Points Awarding window."] = "Klicken zu offnen die Punktevergabe fenster.",
   ["I'm now the DKP lead."] = "Ich bin jetz der DKP F\195hrer.",
   ["DKP leader changed to "] = "DKP F\195hrer ist jetz ",

   -- DKP System registry
   ['DKP System Options'] = "DKp-System Optionen",
   ['Options related to the choice of DKP System.'] = "Einstellungen f\195\188r das gew\195\164hlte DKP-System.",
   ['DKP System.'] = "DKP-System",
   ['Choose which DKP system to use.'] = "W\195\164hle das zu nutzende DKP-System.",
   ["Register DKP system -- DKP system with sysID %s does not inherit from the DKPmon_DKP_BaseClass object"] = "Register DKP system -- DKP system with sysID %s does not inherit from the DKPmon_DKP_BaseClass object",
   ["Register DKP system -- second arg must be a string or number"] = "Register DKP system -- second arg must be a string or number",
   ["Register DKP system -- %s already registered."] = "Register DKP system -- %s already registered.",
   ["DKP System %s not registered."] = "DKP System %s not registered.",
   ["Cannot change systems right now. Bidding is open, and I can't open a dialog box."] = "Kann das DKP-System jetzt nicht wechseln, da eine Auktion l\195\164uft.",
   
   -- Fixed DKP system
   ["Item %s is assigned to an undefined pool."] = "Gegenstand %s ist keinem Pool zugeordnet",
   ["Unknown"] = "Unbekannt",
   ["DKP = %g"] = "DKP = %g",
   ["Error -- player %s has bid on this item but has never been in the raid! Not listing them."] = "Fehler: Spieler %s hat auf diesen Gegenstand geboten, hat aber nie an einem Raid teilgenommen! Wird nicht aufgelistet.",
   ["Select %s to win the item"] = 'W\195\164hle %s als Gewinner f\195\188r diesen Gegenstand',
   ['Specify item value'] = 'Gegenstandswert festlegen',
   ['Specify the value of this item'] = 'Den Wert des Gegenstands angeben',
   ['Assign value'] = 'Wert zuweisen',
   ['Assign this value to this item'] = 'Weist den Wert diesem Gegenstand zu',
   ["Cannot assign a value of zero"] = 'Kann keinen Wert von 0 zuweisen',
   ["Make %s worth %g points from pool %s?"] = "%s wirklich %g Punkte aus Pool %s zuweisen?",
   ['Choose pool'] = 'W\195\164hle Pool', 
   ['Choose which point pool this item is in'] = 'W\195\164hle zu welchem Punkte-Pool der Gegenstand geh\195\182rt',
   ['Set value'] = 'Wert festlegen', 
   ['Set the number of points this item is worth'] = 'Legt fest wieviel Punkte dieser Gegenstand wert ist.',
   ['Add/remove a bidder'] = 'Hinzuf\195\188gen/Entfernen eines Bieters',
   ['Add, or remove, a player from the list of bidders for this item.'] = 'Einen Bieter f\195\188r diesen Gegenstand hinzuf\195\188gen bzw. entfernen.',
   ["You have no points."] = "Du hast keine Punkte.",
   ["Your points are:"] = "Dein Punktestand lautet:",
   ["Error -- %s has never been in the raid! I cannot deduct points because I don't know enough about them. Please make note of the following deductions and do them manually:"] = "Fehler: %s hat noch nie an einem Raid teilgenommen. Ich weiss nicht genug \195\188ber diesen Spieler, daher kann ich keine Punkte abziehen. Bitte editiere die folgenden \195\164nderungen manuell.",
   ["%s\n%g from pool %d"] = "%s\n%g aus Pool %d",
   ["You have been charged %g %s points for %s."] = "Dir wurden %g %s Punkte f\195\188r %s berechnet.",
   ["Set points to award"] = "W\195\164hle zu vergebende Punkte",
   ["Select boss %s"] = "W\195\164hle Boss %s",
   ["Select boss' value"] = "W\195\164hle Boss-Punkte", 
   ["Select a boss to add the point value for"] = "W\195\164hle einen Boss um seine Punkte festzulegen",
   ['List of bosses'] = 'Liste der Bosse',
   ['Specify custom amount'] = 'Eigene Punkte festlegen', 
   ['Specify a custom number of points to award to everyone'] = 'Legt eine bestimmte Menge an Punkten fest, die jeder erh\195\164lt.',
   ['Append current'] = 'Eigene Punkte anh\195\164ngen', 
   ['Append the currently specified custom amount to the list of points to be awarded.'] = 'F\195\188gt die Punkte der Vergabeliste hinzu.',
   ['Select pool'] = 'W\195\164hle Pool',
   ['Select the pool to award points to'] = 'W\195\164hle den Pool mit dem die Punkte verrechnet werden sollen.',
   ['Specify points'] = 'Punkte festlegen',
   ["Specify the number of points to award. This can be negative."] = "Die zu verrechnenden Punkte festlegen. Der Wert kann negativ sein.",
   ['Fixed DKP options'] = 'Festpreis Optionen',
   ['Options for the "Fixed DKP" DKP System'] = 'Optionen f\195\188r das Festpreis-System',
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
   ["Fixed DKP"] = "Festpreis",

   -- Log viewer
   ["DKPmon: View Logs"] = "DKPmon: Logs betrachten",
   ["View log parts"] = "Log-Teile sehen",
   ["Select Log"] = "W\195\164hle Log",
   ['Player Information'] = 'Spielerinformation',
   ['Toggle display of player information'] = 'Anzeuge Spielerinformation ja/nein',
   ['Player Joins'] = 'Spieler Beitritt', 
   ['Toggle display of player join time information.'] = 'Anzeige Spieler Beitrittszeit ja/nein',
   ['Player Leaves'] = 'Spieler Austritt', 
   ['Toggle display of player leave time information.'] = 'Anzeige Spieler Austrittszeit ja /nein',
   ['Item drops'] = 'Gegenst\195\164nde', 
   ['Toggle display of item drops, who they went to, and how many points they cost.'] = 'Anzeige der Gegenst\195\164nde, wer sie bekam und was sie kosteten. ja/nein',
   ['Point awards'] = 'Punktevergabe', 
   ['Toggle display of points awarded and to whom.'] = 'Anzeige der vergebenen Punkte ja/nein',
   ['Select which log to view'] = 'W\195\164hle welches Log angezeigt werden soll',
   ["  Awarded to:"] = 'Vergeben an:',
   ["Viewing Log: %s"] = "Betrachte Log: %s",
   ["Started: %s"] = "Gestartet: %s",
   ["Ended: %s"] = "Geendet: %s",
   ["Player Information:"] = "Spielerinformation:",
   ["Player Join Times:"] = "Spieler Beitrittszeiten:",
   ["Player Leave Times:"] = "Spieler Austrittszeiten:",
   ["Loot List:"] = "Loot Liste:",
   ["List of Awarded Points:"] = "Liste vergebener Punkte:",

   -- Logging/log.lua
   ["Delete this log"] = "Diesen Log l\195\182schen",
   ["Logging already active, cannot start a new log"] = "Es wird bereits gelogt, kann keinen neuen Log starten",
   ["You're not in a raid. Cannot start logging."] = "Du bist in keiner Schlachtgruppe. Kann keinen Log starten.",
   ["Log -- Got request for playerleave for a player not in the raid"] = "Log: Bekam Anfrage f\195\188r Spieleraustritt eines nicht in der Schlachtgruppe befindlichen Spielers.",
   
   -- Import/export registry
   ['Import modules'] = 'Import modules',  
   ['Modules for importing to DKPmon'] = 'Modules for importing to DKPmon',
   ['Export modules'] = 'Export modules', 
   ['Modules for exporting from DKPmon'] = 'Modules for exporting from DKPmon',
   ["RegisterImportModule -- first arg must be a table"] = "RegisterImportModule -- first arg must be a table",
   ["RegisterImportModule -- module does not implement all functions in the baseclass interface"] = "RegisterImportModule -- module does not implement all functions in the baseclass interface",
   ["RegisterImportModule -- second arg must be a string"] = "RegisterImportModule -- second arg must be a string",
   ["RegisterImportModule -- %s already registered."] = "RegisterImportModule -- %s already registered.",
   ["RegisterExportModule -- first arg must be a table"] = "RegisterExportModule -- first arg must be a table",
   ["RegisterExportModule -- module does not implement all functions in the baseclass interface"] = "RegisterExportModule -- module does not implement all functions in the baseclass interface",
   ["RegisterExportModule -- second arg must be a string"] = "RegisterExportModule -- second arg must be a string",
   ["RegisterExportModule -- %s already registered."] = "RegisterExportModule -- %s already registered.",
   ["Cannot get savedvariables database for unregistered import module %s"] = "Cannot get savedvariables database for unregistered import module %s",
   ["Cannot get savedvariables database for unregistered export module %s"] = "Cannot get savedvariables database for unregistered export module %s",
 
   -- Dialog strings
  ["Bidding is active, are you sure you want to clear all?"] = "Auktion im Gange, sicher, dass du alles l\195\182schen willst?",
  ["Bidding is currently active, switching systems at this point will close the current bidding cycle.\nAre you sure you wish to continue?"] = "Auktion im Gange. Wechsel des DKP-Systems bricht die Auktion ab.\nBist du sicher, dass du Fortfahren m\195\182chtest?", 
  ["DKP System: %s\n\nAre you positive that you want to deduct points for the chosen winners?"] = "DKP System: %s\n\nSicher, dass du die Punkte bei den ausgew\195\164hlten Siegern abziehen willst?",
  ["Are you sure that you want to award points to the currently selected group?\nNote: You can click the view points button to see what points are awaiting awarding."] = "Sicher, dass du die Punkte an die gerade ausgew\195\164hlte Gruppe verteilen willst?",
  ["Received a broadcast from %s. Shall I sync your database with this information?"] = "Habe eine \195\188bertragung von %s erhalten. Soll ich deine Datenbank mit diesen Informationen synchronisieren?",
  ["Received a sync request from %s. Do you want to send your database?"] = "Habe eine Synchronisierungsanfrage von %s erhalten. Soll ich deine Datenbank senden?",
  ["Are you positive that you want to remove %s from the list?"] = "Bist du sicher, dass du %s aus der Liste entfernen willst?",
  ["Are you positive that you want to give %s to %s via masterlooter?"] = "Bist du sicher, dass du %s an %s mittels Masterlooter \195\188bergeben willst?",
  ["Begin a log with name '%s' ?"] = "Einen Log mit dem Namen '%s' starten?",
  ["Are you positive that you want to stop your current log?\nA stopped log cannot be resumed."] = "Bist du sicher, dass du den aktuellen Log stoppen willst?\nEin Fortsetzen ist nicht m\195\182glich.",
  ["Are you absolutely positive that you want to delete the log named below?\n\n%s\n\nThis operation cannot be reversed!"] = "Bist du absolut sicher, dass du unten aufgef\195\188hrten Log l\195\182schen willst?\n\n%s\n\nDies kann nicht r\195\188ckg\195\164ngig gemacht werden!",
  ["Are you absolutely positive that you want to delete all of your logs?\nThis is not reversable!"] = "Bist du absolut sicher, dass du alle Logs l\195\182schen willst?\nDies kann nicht r\195\188ckg\195\164ngig gemacht werden!",

  -- Raid roster
  ["%s not present in the raid roster. This is -bad-"] = "%s ist nicht in der Schlachtzugsaufstellung. Das ist -schlecht-",

  -- Award frame
  ["DKPmon: Points Awarding"] = "DKPmon: Punktevergabe",
  ["Select players"] = "W\195\164hle Spieler",
  ["Points to award:"] = "Zu vergebende Punkte",
  ["None"] = "kein",
  ["Purge List"] = "Liste leeren",
  ["Award points"] = "Punkte vergeben",
  ["%d/%d raid members selected"] = "%d%d Schlachtzugmitglieder ausgew\195\164hlt",
  ["%d/%d standby members selected"] = "%d%d Standbymitglieder ausgew\195\164hlt",
  ["%d/%d members selected from the database"] = "%d%d Mitglieder aus der Datenbank ausgew\195\164hlt",
  ['Select the players to award points to'] = 'W\195\164hle die Spieler, die Punkte erhalten sollen',
  ["Raid members"] = "Raid-Teilnehmer",
  ["Select members from the raid to award points to"] = 'W\195\164hle die Schlachtzugmitglieder, die Punkte erhalten sollen',
  ["Query raid"] = "Raid pr\195\188fen",
  ["Query the raid to determine everyone's bidding name, and whether they're online."] = "\195\188berpr\195\188fe den Raid um den Bieternamen zu erfahren, und zu pr\195\188fen ob sie online sind.",
  ["Select all"] = "Alle ausw\195\164hlen", 
  ["Select all members of the raid."] = "Alle Mitglieder des Schlachtzugs ausw\195\164hlen",
  ["Unselect all"] = "Alle abw\195\164hlen",
  ["Unselect all members of the raid."] = "Alle Mitglieder des Schlachtzugs abw\195\164hlen",
  ["Add/remove this player"] = "Diesen Spieler hinzuf\195\188gen/entfernen",
  ["Standby members"] = "Standbymitglieder", 
  ["Select members from standby to award points to"] = "W\195\164hle Standby-Mitglieder f\195\188r die Punktevergabe", 
  ["Query standby"] = "Standby pr\195\188fen", 
  ["Query the standby to determine everyone's bidding name, and whether they're online."] = "\195\188berpr\195\188fe Standby um den Bieternamen zu erfahren, und zu pr\195\188fen ob sie online sind.",
  ["Select all members of the standby."] = "Alle Mitglieder des Standby ausw\195\164hlen",
  ["Unselect all members of the standby."] = "Alle Mitglieder des Standby abw\195\164hlen",
  ["Database members"] = "Datenbank Mitglieder",
  ["Select members from the points database to award points to"] = "W\195\164hle die Mitglieder der Datenbank, die Punkte erhalten sollen",
  ["Select all members of the database."] = "Alle Mitglieder der Datenbank ausw\195\164hlen",
  ["Unselect all members of the database."] = "Alle Mitglieder der Datenbank abw\195\164hlen",
  ["Players starting with the letter %s"] = "Spieler mit dem Anfangsbuchstaben %s",
  ["Points awarded:"] = "Vergebene Punkte",
  ["You're already in the raid, turn off your standby flag."] = "Du bist bereits in einem Schlachtzug, deaktiviere Standby.",
  ["Invalid input. Expected table with pool number, amount number, and source string."] = "Invalid input. Expected table with pool number, amount number, and source string.",

  -- General Messages
  ["NO_RAID_LEADER"] = "There is no Raid Leader in this raid. A player must be set as running this raid on the DKPMon Raid Setup options to get the current DKP values.",  
  -- Guild Launch Additions
  ["LOG_GLCTRT_EVENTS"] = "Log Events to Guild Launch Raid Tracker",
  ["LOG_GLCTRT_EVENTS_TOOLTIP"] = "Enable this option to log events to Guild Launch CT_RaidTracker. This will also change the proper Raid Tracker settings to make this work.",
  ['Override Bid'] = "Override Bid",
  ['Enter a value to override the bid on this item this time only. This value will not be saved.'] = "Enter a value to override the bid on this item this time only. This value will not be saved.",
  ['Clear Bid Override'] = "Clear Bid Override",
  ['Clears the current override value'] = "Clears the current override value",  
}

L:RegisterTranslations("deDE",
		       function() return translations end)