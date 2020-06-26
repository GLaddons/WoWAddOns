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
   Import & export module registry
]]
local Registry = { 
   db =  { 
      import = {}, 
      export = {}, 
      havemodules = { 
	 import = false, 
	 export = false 
      } 
   }
}
DKPmon.ImpExpModules = Registry

local AceOO = AceLibrary("AceOO-2.0")
local L = AceLibrary("AceLocale-2.2"):new("DKPmon")

DKPmon_ImportBaseClass = AceOO.Interface( { Initialize = "function", GetFubarItem = "function" } )
DKPmon_ExportBaseClass = AceOO.Interface( { Initialize = "function", GetFubarItem = "function" } )

--[[
InitializeModules
Description:
   Called from DKPmon:OnEnable to initialize all points database import/export modules, and build the fubar menu options
  for said modules. 
Input:
Returns:
]]
function Registry:InitializeModules()
   local dewtab = DKPmon.Options.fubar.args
   if self.db.havemodules.import then
      dewtab.importmods = {
	 type = 'group', name = L['Import modules'], desc = L['Modules for importing to DKPmon'],
	 args = {}, order = 70
      }
      local id, module
      for id, module in pairs(self.db.import) do
	 module:Initialize()
	 dewtab.importmods.args[id] = module:GetFubarItem()
      end
   end

   if self.db.havemodules.export then
      dewtab.exportmods = {
	 type = 'group', name = L['Export modules'], desc = L['Modules for exporting from DKPmon'],
	 args = {}, order = 80
      }
      local id, module
      for id, module in pairs(self.db.export) do
	 module:Initialize()
	 dewtab.exportmods.args[id] = module:GetFubarItem()
      end
   end
end

--[[
RegisterImportModule
Description:
  Register a module for importing data to the Points database from another source
Input:
  module -- table; the "class" for the import module
  ID -- string; an identifier to register this module under
Returns:
  None
]]
function Registry:RegisterImportModule(module, ID)
   -- Sanity check the arguments
   if type(module) ~= "table" then
      error(L["RegisterImportModule -- first arg must be a table"])
      return
   end
   if not AceOO.inherits(module, DKPmon_ImportBaseClass) then
      error(L["RegisterImportModule -- module does not implement all functions in the baseclass interface"])
      return
   end
   if type(ID) ~= "string" then
      error(L["RegisterImportModule -- second arg must be a string"])
      return
   end
   if self.db.import[ID] ~= nil then
      error(string.format(L["RegisterImportModule -- %s already registered."], ID))
      return
   end
   self.db.import[ID] = module
   self.db.havemodules.import = true
end

--[[
RegisterExportModule
Description:
  Register a module for exporting data from the Points database to another sourc
Input:
  module -- table; the "class" for the export module
  ID -- string; an identifier to register this module under
Returns:
  None
]]
function Registry:RegisterExportModule(module, ID)
   -- Sanity check the arguments
   if type(module) ~= "table" then
      error(L["RegisterExportModule -- first arg must be a table"])
      return
   end
   if not AceOO.inherits(module, DKPmon_ExportBaseClass) then
      error(L["RegisterExportModule -- module does not implement all functions in the baseclass interface"])
      return
   end
   if type(ID) ~= "string" then
      error(L["RegisterExportModule -- second arg must be a string"])
      return
   end
   if self.db.export[ID] ~= nil then
      error(string.format(L["RegisterExportModule -- %s already registered."], ID))
      return
   end
   self.db.export[ID] = module
   self.db.havemodules.export = true
end

--[[
GetImportDB
Description:
   Get a table to save persistent data for a DKPmon import module
Input:
   ID -- The ID string that the import module is registered under
Output:
   table -- a place in the SavedVariables file for DKPmon where the import module
    with the given ID can save any data it needs to retain between sessions
]]
function Registry:GetImportDB(ID)
   if self.db.import[ID] == nil then
      error(string.format(L["Cannot get savedvariables database for unregistered import module %s"], ID))
      return nil
   end
   local tab = DKPmon.db.realm.PluginData
   if tab.import == nil then
      tab.import = {}
   end
   if tab.import[ID] == nil then
      tab.import[ID] = {}
   end
   return tab.import[ID]
end

--[[
GetExportDB
Description:
   Get a table to save persistent data for a DKPmon export module
Input:
   ID -- The ID string that the export module is registered under
Output:
   table -- a place in the SavedVariables file for DKPmon where the export module
    with the given ID can save any data it needs to retain between sessions
]]
function Registry:GetExportDB(ID)
   if self.db.export[ID] == nil then
      error(string.format(L["Cannot get savedvariables database for unregistered export module %s"], ID))
      return nil
   end
   local tab = DKPmon.db.realm.PluginData
   if tab.export == nil then
      tab.export = {}
   end
   if tab.export[ID] == nil then
      tab.export[ID] = {}
   end
   return tab.export[ID]
end
