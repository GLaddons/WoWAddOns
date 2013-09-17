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
Fubar menu layout:

- Show loot window
- Show award window
- Points Database
  - Broadcast (exec)
  - Sync (exec)
  - Always Sync (toggle)
- Raid Setup
  - I'm running this raid(toggle)
  - Disenchanter (text)
  - Banker (text)
  - Password (text field)
- DKP System Options
  - DKP System (multiple choice)
  - <options for each system)
- Logging
  - CTRT Compatibility Mode (toggle)
  - Log name (text)
  - Start log (exec)
  - Stop log (exec)
  - View logs (exec)
  - Enable automatic log start (toggle)
  - Delete Log
    - Delete all (exec)
    - Spacer (blank line)
    - <log name> (exec)
- Import modules (only if import modules are installed)
  - <module options>
- Export modules (only if export modules are installed)
  - <module options>
]]

local L = AceLibrary("AceLocale-2.2"):new("DKPmon")
local dewdrop = AceLibrary("Dewdrop-2.0")

-- Ace Options table for the console commands & fubar menu
DKPmon.Options = {}

-- Options table for the console commands
DKPmon.Options.console = {
   type = 'group',
   args = {
      biditem = {
	 type = 'text',
	 name = L['biditem'],
	 desc = L['Supply a list of item links to bid on.'],
	 usage = L['<itemlink>[<itemlink>]+'],
	 get = false,
	 set = function(v) DKPmon:ParseBidItems(v) end,
	 input = false
      },
      showloot = {
	 type = 'execute',
	 name = L['showbids'],
	 desc = L['Show the loot distribution interface.'],
	 func = function() DKPmon.Looting:Show() end
      },
      showaward = {
	 type = 'execute',
	 name = L['award'],
	 desc = L['Bring up the points awarding interface.'],
	 func = function() DKPmon.Awarding:Show() end
      },
      pointsdb = {
	 type = 'group',
	 name = L['pointsdb'],
	 desc = L['Functions for the points database'],
	 args = {
	    bcast = {
	       type = 'execute',
	       name = L['bcast'],
	       desc = L['Broadcast your points database to the other DKPmons in the raid.'],
	       func = function() DKPmon.PointsDB:SendBroadcast() end
	    },
	    sync = {
	       type = 'execute',
	       name = L['sync'],
	       desc = L['Request a database synchronization with the DKPmon users in the raid.'],
	       func = function() DKPmon.Comm:SendToDKPmon("S", DKPmon.db.realm.password); DKPmon.PointsDB:SendBroadcast(); end
	    },
	    alwayssync = {
	       type = 'toggle',
	       name = L['alwayssync'],
	       desc = L['Toggle whether or not to always send your database on a sync request.'],
	       get = function() return DKPmon.db.realm.alwayssync end,
	       set = function(v) DKPmon.db.realm.alwayssync = v end
	    },
	    password = {
	       type = 'text',
	       name = L['password'],
	       desc = L['Set your broadcast password.'],
	       usage = L['<password>'],
	       get = function() return DKPmon.db.realm.password end,
	       set = function(v) DKPmon.db.realm.password = v end,
	       input = false
	    },
	 },
      },
      raidsetup = {
	 type = 'group',
	 name = L['raidsetup'],
	 desc = L['Configure settings for the raid.'],
	 args = {
	    setde = {
	       type = 'text',
	       name = L['setde'],
	       desc = L["Set the name of the raid's disenchanter"],
	       usage = L['<name>'],
	       get = function() return DKPmon.db.realm.disenchanter end,
	       set = function(v) 
			if v == "" then DKPmon.db.realm.disenchanter = v end
			local n = DKPmon:ProperNameCaps(v); DKPmon.db.realm.disenchanter = n 
		     end,
	       validate = function(v)
			     if v == "" then return true end
			     local n = DKPmon:ProperNameCaps(v); 
			     if DKPmon.RaidRoster:GetPlayerInfo(n) ~= nil then
				return true
			     end
			     return false
			  end,
	       input = false
	    },
	    setbank = {
	       type = 'text',
	       name = L['setbank'],
	       desc = L["Set the name of the player to give all bankables to"],
	       usage = L['<name>'],
	       get = function() return DKPmon.db.realm.bankname end,
	       set = function(v) 
			if v == "" then DKPmon.db.realm.bankname = v end
			local n = DKPmon:ProperNameCaps(v); DKPmon.db.realm.bankname = n 
		     end,
	       validate = function(v)
			     if v == "" then return true end
			     local n = DKPmon:ProperNameCaps(v); 
			     if DKPmon.RaidRoster:GetPlayerInfo(n) ~= nil then
				return true
			     end
			     return false
			  end,
	       input = false
	    }
	 }
      }
   }
}

-- Options table for the fubar menu
DKPmon.Options.fubar = {
   type = 'group',
   args = {
      pointsdb = {
	 type = 'group',
	 name = L['Points database'],
	 desc = L['Functions for the points database'],
	 args = {
	    bcast = {
	       type = 'execute',
	       name = L['Broadcast database'],
	       desc = L['Broadcast your points database to the other DKPmons in the raid.'],
	       func = function() DKPmon.PointsDB:SendBroadcast() end,
	       order = 1
	    },
	    sync = {
	       type = 'execute',
	       name = L['Intiate database synchronization'],
	       desc = L['Request a database synchronization with the DKPmon users in the raid.'],
	       func = function() DKPmon.Comm:SendToDKPmon("S", DKPmon.db.realm.password); DKPmon.PointsDB:SendBroadcast(); end,
	       order = 2
	    },
	    alwayssync = {
	       type = 'toggle',
	       name = L['Always send on sync request'],
	       desc = L['Toggle whether or not to always send your database on a sync request.'],
	       get = function() return DKPmon.db.realm.alwayssync end,
	       set = function(v) DKPmon.db.realm.alwayssync = v end,
	       order = 3
	    },
	    password = {
	       type = 'text',
	       name = L['Set broadcast password'],
	       desc = L['Set your broadcast password.'],
	       usage = '<password>',
	       get = function() return DKPmon.db.realm.password end,
	       set = function(v) DKPmon.db.realm.password = v end,
	       input = false,
	       order = 4
	    },
	 },
	 order = 30
      },
      raidsetup = {
	 type = 'group',
	 name = L["Raid Setup"],
	 desc = L['Configure settings for the raid.'],
	 args = {
	    amrunning = {
	       type = 'toggle',
	       name = L["I'm running this raid."],
	       desc = L["Check this item if you're running loot distribution for the raid."],
	       get = function() return DKPmon:GetLeaderState() end,
	       set = function(v) DKPmon:SetLeader(v) end
	    },
	    setde = {
	       type = 'text',
	       name = L['Set disenchanter'],
	       desc = L["Set the name of the raid's disenchanter"],
	       usage = '<name>',
	       get = function() return DKPmon.db.realm.disenchanter end,
	       set = function(v) 
			if v == "" then DKPmon.db.realm.disenchanter = v end
			local n = DKPmon:ProperNameCaps(v); DKPmon.db.realm.disenchanter = n 
		     end,
	       validate = function(v)
			     if v == "" then return true end
			     local n = DKPmon:ProperNameCaps(v); 
			     if DKPmon.RaidRoster:GetPlayerInfo(n) ~= nil then
				return true
			     end
			     return false
			  end,
	       input = false
	    },
	    setbank = {
	       type = 'text',
	       name = L['Set banker'],
	       desc = L["Set the name of the player to give all bankables to"],
	       usage = '<name>',
	       get = function() return DKPmon.db.realm.bankname end,
	       set = function(v) 
			if v == "" then DKPmon.db.realm.bankname = v end
			local n = DKPmon:ProperNameCaps(v); DKPmon.db.realm.bankname = n 
		     end,
	       validate = function(v) 
			     if v == "" then return true end
			     local n = DKPmon:ProperNameCaps(v); 
			     if DKPmon.RaidRoster:GetPlayerInfo(n) ~= nil then
				return true
			     end
			     return false
			  end,
	       input = false
	    }
	 },
	 order = 40
      },
      logging = {
        type = "group",
	 name = L["Logging"],
	 desc = L["Options related to raid information logging."],
	 order = 60,
	 args = {
           ctrtcompat = {
              type = 'toggle',
              name = L["CTRT compatibility mode."],
              desc = L["Enable this to log non-boss mobs as 'Trash Mob' rather than by their name."],
              get = function() return DKPmon.Logging:GetTable().ctrtcompat end,
              set = function(v) DKPmon.Logging:GetTable().ctrtcompat = v end
           },
           glctrtcompat = {
              type = 'toggle',
              name = L["LOG_GLCTRT_EVENTS"],
              desc = L["LOG_GLCTRT_EVENTS_TOOLTIP"],
              get = function() return DKPmon.Logging:GetTable().glctrtlog end,
              set = function(v) DKPmon.Logging:GetTable().glctrtlog = v end
           },
	   logname = {
	      type = 'text',
	      name = L['Log name'],
	      desc = L['Specify a name for the log to start'],
	      usage = '<name>',
	      get = function() return DKPmon.Logging:GetTable().logname end,
	      set = function(v) DKPmon.Logging:GetTable().logname = v end,
	      order = 2
	   },
	   startlog = {
	      type = 'execute',
	      name = L['Start log'],
	      desc = L["Begin a log for your raid with the name specified under 'Log name.'"],
	      func = function()
	  	        local logtab = DKPmon.Logging:GetTable()
		        local logname = logtab.logname
		        if IsInRaid() == false then
		  	   DKPmon:Print(L["You must be in a raid to begin a log."])
			   return
		        end
		        if logname == nil or logname == "" then
			   DKPmon:Print(L["Cannot start a log until you give it a name"])
			   return
		        end
		        if logtab.active then
			   DKPmon:Print(L["You must stop your current log before beginning a new one."])
			   return
		        end
		        StaticPopup_Show("DKPMON_CONFIRM_STARTLOG", logname)
		        dewdrop:Close()
		     end,
	      order = 3
	   },
	   stoplog = {
	      type = 'execute',
	      name = L['Stop log'],
	      desc = L["Stop logging for your current log"],
	      func = function()
		        if IsInRaid() == false then
			   -- Not in a raid = definitely stop the log
			   DKPmon.Logging:StopLog()
			   return
		        end
		        if not DKPmon.Logging:GetTable().active then
			   DKPmon:Print(L["You do not have an active log to stop."])
			   return
		        end
		        StaticPopup_Show("DKPMON_CONFIRM_STOPLOG")
		        dewdrop:Close()
		     end,
	      order = 4
	   },
	   viewlog = {
	      type = 'execute',
	      name = L['View logs'],
	      desc = L['Open a window from which your log contents can be viewed'],
	      func = function()
			DKPmon.Logging.LogViewer:Show()
			dewdrop:Close()
		     end,
	      order = 5
	   },
           autolog = {
              type = 'toggle',
              name = L['Enable automatic log start'],
              desc = L['Toggle on to enable automatic log start when entering a raid instance.'],
              get = function() return DKPmon.Logging:GetTable().autologging end,
              set = function(v) DKPmon.Logging:GetTable().autologging = v end
           },
	   deletelog = {
	      type = 'group',
	      name = L["Delete log(s)"],
	      desc = L["Delete some, or all, of your stored logs"],
	      args = {
	         purgeall = {
		    type = 'execute',
		    name = L['Delete all logs'],
		    desc = L['Delete every single non-active stored log. This is not reversable.'],
		    func = function()
			      StaticPopup_Show("DKPMON_CONFIRM_DELETEALLLOGS")
			      dewdrop:Close()
			   end,
		    order = 1
	         },
	         spacer = {
		    type = 'header', name = ' ', order = 2
	         }
	      },
	      order = 7
	   },
	  }
      },
      showloot = {
	 type = 'execute',
	 name = L['Show loot distribution window'],
	 desc = L['Show the loot distribution interface.'],
	 func = function() DKPmon.Looting:Show() end,
	 order = 10
      },
      showaward = {
	 type = 'execute',
	 name = L['Show points awarding window.'],
	 desc = L['Bring up the points awarding interface.'],
	 func = function() DKPmon.Awarding:Show() end,
	 order = 20
      },
      
   }
}
