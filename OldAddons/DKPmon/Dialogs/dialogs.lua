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

local L = AceLibrary("AceLocale-2.2"):new("DKPmon")

local YesStr, NoStr = L["Yes"], L["No"]

--[[
Popup dialogs used by DKPmon
]]

StaticPopupDialogs["DKPMON_CONFIRM_LOOTCLEAR"] = {
   text = L["Bidding is active, are you sure you want to clear all?"],
   button1 = YesStr,
   button2 = NoStr,
   OnAccept = function()
		 DKPmon.Looting.bidstate = -1
		 DKPmon.Looting:Clear()
              end,
   OnCancel = function() end,
   sound = "levelup2",
   timeout = 10,
   whileDead = 1,
   hideOnEscape = 1
}

StaticPopupDialogs["DKPMON_CONFIRM_DKPSYSTEMCHANGE"] = {
   text = L["Bidding is currently active, switching systems at this point will close the current bidding cycle.\nAre you sure you wish to continue?"],
   button1 = YesStr,
   button2 = NoStr,
   OnAccept = nil, -- To be filled in just as this popup is called.
   OnCancel = function() end,
   sound = "levelup2",
   timeout = 10,
   whileDead = 1,
   hideOnEscape = 1
}

StaticPopupDialogs["DKPMON_CONFIRM_DEDUCTPOINTS"] = {
   text = L["DKP System: %s\n\nAre you positive that you want to deduct points for the chosen winners?"],
   button1 = YesStr,
   button2 = NoStr,
   OnAccept = function()
		 DKPmon.Looting:SetBidState(4)
		 DKPmon.Looting:DeductPoints()
	      end,
   OnCancel = function() end,
   sound = "levelup2",
   timeout = 10,
   whileDead = 1,
   hideOnEscape = 1
}

StaticPopupDialogs["DKPMON_CONFIRM_AWARDPOINTS"] = {
   text = L["Are you sure that you want to award points to the currently selected group?\nNote: You can click the view points button to see what points are awaiting awarding."],
   button1 = YesStr,
   button2 = NoStr,
   OnAccept = function()
                 DKPmon.Awarding:AwardOutstandingPoints()
              end,
   OnCancel = function() end,
   sound = "levelup2",
   timeout = 10,
   whileDead = 1,
   hideOnEscape = 1
}

StaticPopupDialogs["DKPMON_CONFIRM_RECEIVEBCAST"] = {
   text = L["Received a broadcast from %s. Shall I sync your database with this information?"],
   button1 = YesStr,
   button2 = NoStr,
   OnAccept = function()
                 DKPmon.PointsDB:ProcessBroadcast()
              end,
   OnCancel = function() 
		 DKPmon.PointsDB:KillBroadcast()
	      end,
   sound = "levelup2",
   timeout = 0,
   whileDead = 1,
   hideOnEscape = 1
}

StaticPopupDialogs["DKPMON_CONFIRM_PARTICIPATESYNC"] = {
   text = L["Received a sync request from %s. Do you want to send your database?"],
   button1 = YesStr,
   button2 = NoStr,
   OnAccept = function()
                 DKPmon.PointsDB:SendBroadcast()
              end,
   OnCancel = function() end,
   sound = "levelup2",
   timeout = 0,
   whileDead = 1,
   hideOnEscape = 1
}

StaticPopupDialogs["DKPMON_CONFIRM_REMOVEITEM"] = {
   text = L["Are you positive that you want to remove %s from the list?"],
   button1 = YesStr,
   button2 = NoStr,
   OnAccept = nil, -- will be filled in by creater
   OnCancel = function() end,
   sound = "levelup2",
   timeout = 0,
   whileDead = 1,
   hideOnEscape = 1
}

StaticPopupDialogs["DKPMON_CONFIRM_DISTRIBUTEML"] = {
   text = L["Are you positive that you want to give %s to %s via masterlooter?"],
   button1 = YesStr,
   button2 = NoStr,
   OnAccept = nil, -- will be filled in by creater
   OnCancel = function() end,
   sound = "levelup2",
   timeout = 0,
   whileDead = 1,
   hideOnEscape = 1
}

StaticPopupDialogs["DKPMON_CONFIRM_STARTLOG"] = {
   text = L["Begin a log with name '%s' ?"],
   button1 = YesStr,
   button2 = NoStr,
   OnAccept = function()
		 DKPmon.Logging:StartLog(DKPmon.Logging:GetTable().logname)
	      end,
   OnCancel = function() end,
   sound = "levelup2",
   timeout = 0,
   whileDead = 1,
   hideOnEscape = 1
}

StaticPopupDialogs["DKPMON_CONFIRM_STOPLOG"] = {
   text = L["Are you positive that you want to stop your current log?\nA stopped log cannot be resumed."],
   button1 = YesStr,
   button2 = NoStr,
   OnAccept = function()
		 DKPmon.Logging:StopLog()
	      end,
   OnCancel = function() end,
   sound = "levelup2",
   timeout = 0,
   whileDead = 1,
   hideOnEscape = 1
}

StaticPopupDialogs["DKPMON_CONFIRM_DELETELOG"] = {
   text = L["Are you absolutely positive that you want to delete the log named below?\n\n%s\n\nThis operation cannot be reversed!"],
   button1 = YesStr,
   button2 = NoStr,
   OnAccept = nil,
   OnCancel = function() end,
   sound = "levelup2",
   timeout = 0,
   whileDead = 1,
   hideOnEscape = 1
}

StaticPopupDialogs["DKPMON_CONFIRM_DELETEALLLOGS"] = {
   text = L["Are you absolutely positive that you want to delete all of your logs?\nThis is not reversable!"],
   button1 = YesStr,
   button2 = NoStr,
   OnAccept = function()
		 DKPmon.Logging:DeleteAllLogs()
	      end,
   OnCancel = function() end,
   sound = "levelup2",
   timeout = 0,
   whileDead = 1,
   hideOnEscape = 1
}
