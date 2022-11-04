function CT_RaidTracker_OptionsFrame_OnShow()
    -- auto config = 1 tab 1
    -- zone
    CT_RaidTrackerOptionsFrameTabPage2AutoZoneCB:SetChecked(CT_RaidTracker_Options["AutoZone"]);
    CT_RaidTrackerOptionsFrameTabPage2NewRaidOnNewZoneCB:SetChecked(CT_RaidTracker_Options["NewRaidOnNewZone"]);
    CT_RaidTrackerOptionsFrameTabPage2AutoCreateRaidCB:SetChecked(CT_RaidTracker_Options["AutoRaidCreation"]);
    CT_RaidTrackerOptionsFrameTabPage2LogGroupCB:SetChecked(CT_RaidTracker_Options["LogGroup"]);
    CT_RaidTrackerOptionsFrameTabPage2AutoGroupCB:SetChecked(CT_RaidTracker_Options["AutoGroup"]);
    CT_RaidTrackerOptionsFrameTabPage2LogBattlefieldCB:SetChecked(CT_RaidTracker_Options["LogBattlefield"]);

    -- boss

    CT_RaidTrackerOptionsFrameTabPage3AskWipeCB:SetChecked(CT_RaidTracker_Options["Wipe"]);
    CT_RaidTrackerOptionsFrameTabPage3AskWipeSlider:SetValue(CT_RaidTracker_Options["WipePercent"]);
    CT_RaidTrackerOptionsFrameTabPage3AskNextBossCB:SetChecked(CT_RaidTracker_Options["NextBoss"]);
    CT_RaidTrackerOptionsFrameTabPage3SaveExtendedPlayerInfoCB:SetChecked(CT_RaidTracker_Options["SaveExtendedPlayerInfo"]);
    CT_RaidTrackerOptionsFrameTabPage3AutoBossSlider:SetValue(CT_RaidTracker_Options["AutoBoss"]);
    CT_RaidTrackerOptionsFrameTabPage3AutoBossChangeMinTimeSlider:SetValue(CT_RaidTracker_Options["AutoBossChangeMinTime"]);
    CT_RaidTrackerOptionsFrameTabPage3LogAttendeesSlider:SetValue(CT_RaidTracker_Options["LogAttendees"]);

    -- items
    CT_RaidTrackerOptionsFrameTabPage4MinQualitySlider:SetValue(CT_RaidTracker_Options["MinQuality"]);
    CT_RaidTrackerOptionsFrameTabPage4AskCostSlider:SetValue(CT_RaidTracker_Options["AskCost"]);
    CT_RaidTrackerOptionsFrameTabPage4GetDKPValueSlider:SetValue(CT_RaidTracker_Options["GetDkpValue"]);
    CT_RaidTrackerOptionsFrameTabPage4GroupItemsSlider:SetValue(CT_RaidTracker_Options["GroupItems"]);
    CT_RaidTrackerOptionsFrameTabPage4SaveTooltipsCB:SetChecked(CT_RaidTracker_Options["SaveTooltips"]);
    --oberan added
    CT_RaidTrackerOptionsFrameTabPage4AutoSetEPGPCost:SetChecked(CT_RaidTracker_Options["AutoSetEPGPCost"]);
    CT_RaidTrackerOptionsFrameTabPage4BonusLoot:SetChecked(CT_RaidTracker_Options["BonusLoot"]);

    -- ATTENDANCE
    CT_RaidTrackerOptionsFrameTabPage8EnableListme:SetChecked(CT_RaidTracker_Options["ListMeEnabled"]);
    CT_RaidTrackerOptionsFrameTabPage8WaitlistAttendanceType:SetValue(CT_RaidTracker_Options["WaitlistAttendanceType"]);

    -- DKPMon
    -- DKPmon Logging
    CT_RaidTrackerOptionsFrameTabPage5DKPmonLoggingMode:SetChecked(CT_RaidTracker_Options["DKPmonLoggingMode"]);

    -- Miscellaneous

    CT_RaidTrackerOptionsFrameTabPage6TimeSyncCB:SetChecked(CT_RaidTracker_Options["TimeSync"]);
    CT_RaidTrackerOptionsFrameTabPage6TimeZoneSlider:SetValue(CT_RaidTracker_Options["Timezone"]);
    CT_RaidTrackerOptionsFrameTabPage6Use24hFormat:SetChecked(CT_RaidTracker_Options["24hFormat"]);
    CT_RaidTrackerOptionsFrameTabPage6MaxLevelSlider:SetValue(CT_RaidTracker_Options["MaxLevel"]);
    CT_RaidTrackerOptionsFrameTabPage6ExportFormatSlider:SetValue(CT_RaidTracker_Options["ExportFormat"]);
    CT_RaidTrackerOptionsFrameTabPage6GuildSnapshotCB:SetChecked(CT_RaidTracker_Options["GuildSnapshot"]);

    local config_help = CT_RaidTracker_Options["ShowConfigHelp"];
    local mod_frame = getglobal("CT_RaidTrackerOptionsFrame");
    local toggle_help_button = getglobal("CT_RaidTrackerOptionsFrameToggleHelpButton");

    if (config_help == 0) then
        toggle_help_button:SetText("?: Off");
        mod_frame:SetHeight(250);

        -- set the help header
        local helpHeader = getglobal("CT_RaidTrackerOptionsFrameHelpHeader");
        helpHeader:Hide();

        -- show the text
        local helpString = getglobal("CT_RaidTrackerOptionsFrameHelpString");
        helpString:Hide();
    end
end

function CT_RaidTracker_OptionsFrame_Save()

    CT_RaidTracker_Options["MinQuality"] = CT_RaidTrackerOptionsFrameTabPage4MinQualitySlider:GetValue();
    CT_RaidTracker_Options["AskCost"] = CT_RaidTrackerOptionsFrameTabPage4AskCostSlider:GetValue();
    CT_RaidTracker_Options["GetDkpValue"] = CT_RaidTrackerOptionsFrameTabPage4GetDKPValueSlider:GetValue();
    if(CT_RaidTrackerOptionsFrameTabPage2AutoCreateRaidCB:GetChecked() == true) then
        CT_RaidTracker_Options["AutoRaidCreation"] = true;
    else
        CT_RaidTracker_Options["AutoRaidCreation"] = false;
    end
    if(CT_RaidTrackerOptionsFrameTabPage2LogGroupCB:GetChecked() == true) then
        CT_RaidTracker_Options["LogGroup"] = true;
    else
        CT_RaidTracker_Options["LogGroup"] = false;
    end
    if(CT_RaidTrackerOptionsFrameTabPage2AutoGroupCB:GetChecked() == true) then
        CT_RaidTracker_Options["AutoGroup"] = true;
    else
        CT_RaidTracker_Options["AutoGroup"] = false;
    end
    if(CT_RaidTrackerOptionsFrameTabPage2LogBattlefieldCB:GetChecked() == true) then
        CT_RaidTracker_Options["LogBattlefield"] = true;
    else
        CT_RaidTracker_Options["LogBattlefield"] = false;
    end
    if(CT_RaidTrackerOptionsFrameTabPage3AskWipeCB:GetChecked() == true) then
        CT_RaidTracker_Options["Wipe"] = true;
    else
        CT_RaidTracker_Options["Wipe"] = false;
    end
    CT_RaidTracker_Options["WipePercent"] = CT_RaidTrackerOptionsFrameTabPage3AskWipeSlider:GetValue();
    if(CT_RaidTrackerOptionsFrameTabPage3AskNextBossCB:GetChecked() == true) then
        CT_RaidTracker_Options["NextBoss"] = true;
    else
        CT_RaidTracker_Options["NextBoss"] = false;
    end
    CT_RaidTracker_Options["GroupItems"] = CT_RaidTrackerOptionsFrameTabPage4GroupItemsSlider:GetValue();
    if(CT_RaidTrackerOptionsFrameTabPage2AutoZoneCB:GetChecked() == true) then
        CT_RaidTracker_Options["AutoZone"] = true;
    else
        CT_RaidTracker_Options["AutoZone"] = false;
    end
    if(CT_RaidTrackerOptionsFrameTabPage2NewRaidOnNewZoneCB:GetChecked() == true) then
        CT_RaidTracker_Options["NewRaidOnNewZone"] = true;
    else
        CT_RaidTracker_Options["NewRaidOnNewZone"] = false;
    end
    if(CT_RaidTrackerOptionsFrameTabPage3SaveExtendedPlayerInfoCB:GetChecked() == true) then
        CT_RaidTracker_Options["SaveExtendedPlayerInfo"] = true;
    else
        CT_RaidTracker_Options["SaveExtendedPlayerInfo"] = false;
    end
    if(CT_RaidTrackerOptionsFrameTabPage4SaveTooltipsCB:GetChecked() == true) then
        CT_RaidTracker_Options["SaveTooltips"] = true;
    else
        CT_RaidTracker_Options["SaveTooltips"] = false;
    end
    CT_RaidTracker_Options["AutoBoss"] = CT_RaidTrackerOptionsFrameTabPage3AutoBossSlider:GetValue();
    if(CT_RaidTracker_Options["AutoBossChangeMinTime"] > 20 or CT_RaidTracker_Options["AutoBossChangeMinTime"] < 0) then
        CT_RaidTracker_Options["AutoBossChangeMinTime"] = 10;
    end
    CT_RaidTracker_Options["AutoBossChangeMinTime"] = CT_RaidTrackerOptionsFrameTabPage3AutoBossChangeMinTimeSlider:GetValue();
    CT_RaidTracker_Options["LogAttendees"] = CT_RaidTrackerOptionsFrameTabPage3LogAttendeesSlider:GetValue();
    if(CT_RaidTrackerOptionsFrameTabPage6TimeSyncCB:GetChecked() == true) then
        CT_RaidTracker_Options["TimeSync"] = true;
    else
        CT_RaidTracker_Options["TimeSync"] = false;
    end
    if(CT_RaidTrackerOptionsFrameTabPage6Use24hFormat:GetChecked() == true) then
        CT_RaidTracker_Options["24hFormat"] = true;
    else
        CT_RaidTracker_Options["24hFormat"] = false;
    end
    CT_RaidTracker_Options["Timezone"] = CT_RaidTrackerOptionsFrameTabPage6TimeZoneSlider:GetValue();
    CT_RaidTracker_GetGameTimeOffset();
    CT_RaidTracker_Options["MaxLevel"] = CT_RaidTrackerOptionsFrameTabPage6MaxLevelSlider:GetValue();
    if(CT_RaidTrackerOptionsFrameTabPage6GuildSnapshotCB:GetChecked() == true) then
        CT_RaidTracker_Options["GuildSnapshot"] = true;
    else
        CT_RaidTracker_Options["GuildSnapshot"] = false;
    end
    CT_RaidTracker_Options["ExportFormat"] = CT_RaidTrackerOptionsFrameTabPage6ExportFormatSlider:GetValue();
    --oberan added
    if(CT_RaidTrackerOptionsFrameTabPage4AutoSetEPGPCost:GetChecked() == true) then
    	CT_RaidTracker_Options["AutoSetEPGPCost"] = true;
    else
    	CT_RaidTracker_Options["AutoSetEPGPCost"] = false;
    end
    if(CT_RaidTrackerOptionsFrameTabPage5DKPmonLoggingMode:GetChecked() == true) then
        CT_RaidTracker_Options["DKPmonLoggingMode"] = true;
    else
        CT_RaidTracker_Options["DKPmonLoggingMode"] = false;
    end
    -- ATTENDANCE
    if(CT_RaidTrackerOptionsFrameTabPage8EnableListme:GetChecked() == true) then
        CT_RaidTracker_Options["ListMeEnabled"] = true;
    else
        CT_RaidTracker_Options["ListMeEnabled"] = false;
    end
    if(CT_RaidTrackerOptionsFrameTabPage4BonusLoot:GetChecked() == true) then
        CT_RaidTracker_Options["BonusLoot"] = true;
    else
        CT_RaidTracker_Options["BonusLoot"] = false;
    end
    CT_RaidTracker_Options["WaitlistAttendanceType"] = CT_RaidTrackerOptionsFrameTabPage8WaitlistAttendanceType:GetValue();
end

function CT_RaidTracker_OptionsFrame_TabClick(name)
    local buttonID = string.sub(name, strlen(name));
    local buttonNum = buttonID + 0;

    maxTabs = 8
    for numTab = 1,maxTabs do
        local currentTab = getglobal("CT_RaidTrackerOptionsFrameTabPage" .. numTab);
        if (numTab == buttonNum) then
            PanelTemplates_SetTab(CT_RaidTrackerOptionsFrame, buttonNum);
            currentTab:Show();
        else
            currentTab:Hide();
        end
    end

    CT_RaidTracker_OptionsFrame_ShowTabHelp(buttonNum);
end


function CT_RaidTracker_OptionsFrame_ShowItemHelp(itemName)

    local tab_text = "";
    local frameName = "CT_RaidTrackerOptionsFrame";

    if (itemName == frameName .. "TabPage2AutoZoneCBHelp") then
        tab_text = [[
            |cff40bbffAuto Zone|r

            Whether to set the zone automatically.

            We recommend turning this option on since it will set the zone of the log file
            to the zone you are in when you start the raid. This setting is not required
            to function with Guild Launch imports.

            |cffff8000Recommend:|r On

            |cffff8000Import:|r Optional
        ]];
    elseif (itemName == frameName ..  "TabPage2NewRaidOnNewZoneCBHelp") then
        tab_text = [[
            |cff40bbffCreate New Raid on New Zone|r

            Creates a new Raid when zone changes.

            This setting is optional and will not effect Guild Launch imports. If you turn
            this setting on then a new raid will be created when your zone changes. If you
            are running multiple instances and want to import them seperately you may want
            to turn this option on.

            |cffff8000Recommend:|r Off

            |cffff8000Import:|r Optional
        ]];
    elseif (itemName == frameName ..  "TabPage2AutoCreateRaidCBHelp") then
        tab_text = [[
            |cff40bbffAuto Create Raid|r

            Automatically starts a raid when you convert your group to a Raid.

            This option has no effect on Guild Launch imports. It will generally help you
            though by making sure you always have a raid started when you join
            a Raid Group.

            |cffff8000Recommend:|r On

            |cffff8000Import:|r Optional
        ]];
    elseif (itemName == frameName ..  "TabPage2LogGroupCBHelp") then
        tab_text = [[
            |cff40bbffLog Groups|r

            Allows Raid Tracker to track groups.

            If you want to track 5 man instance runs then this option must be turned on to
            allow the Raid Tracker to track 5 man groups. However, bosses for 5 man runs
            typically aren't in the mod so the boss kills will not be tracked.

            This option has no effect on Guild Launch imports.

            |cffff8000NOTE:|r Ragefire Chasm is currently set as a test instance. You can
            run this instance as a 5 man and it will import and the bosses will be tracked.

            |cffff8000Recommend:|r Depends

            |cffff8000Import:|r Optional
        ]];
    elseif (itemName == frameName ..  "TabPage2AutoGroupCBHelp") then
        tab_text = [[
            |cff40bbffAuto Create Groups|r

            Automatically starts a new tracking log when you join a group. This setting
            is typically not used since most people do not track every instance they run
            even if they option track groups turned on.

            This option has no effect on Guild Launch imports.

            |cffff8000Recommend:|r Off

            |cffff8000Import:|r Optional
        ]];
    elseif (itemName == frameName ..  "TabPage2LogBattlefieldCBHelp") then
        tab_text = [[
            |cff40bbffLog Battlefields|r

            Whether to log Battlefield info.

            This option has no effect on Guild Launch imports.

            |cffff8000Recommend:|r Off

            |cffff8000Import:|r Optional
        ]];
    --- TAB 3 Help Buttons
    elseif (itemName == frameName ..  "TabPage3AskWipeCBHelp") then
        tab_text = [[
             |cff40bbffAsk for Wipe|r

             Whether to show the 'Is This A Wipe?' Dialog when the mod detects a wipe
             based on your percentage entered.

             This option will record wipe events in the log and the import if you say
             that it is a wipe in the dialog.

             |cffff8000Recommend:|r User Preference

             |cffff8000Import:|r Optional
        ]];
    elseif (itemName == frameName ..  "TabPage3AskWipeSliderHelp") then
        tab_text = [[
            |cff40bbffPercent to Ask for Wipe|r

            If the option or Ask for Wipe is enabled then at this percentage of raid health
            the Ask for Wipe dialog will appear.

            If the Ask for Wipe option is not enabled this slider has no effect.

            This option has not effect on Guild Launch imports.

            |cffff8000Recommend:|r Off

            |cffff8000Import:|r Optional
        ]];
    elseif (itemName == frameName ..  "TabPage3AskNextBossCBHelp") then
        tab_text = [[
            |cff40bbffAsk for Next Boss|r

            Whether to ask what the next boss is. This option gives the Raid Tracker a hint
            about the next boss you intend to kill is. It has no effect on the
            Raid Tracking.

            This option has no effect on Guild Launch imports.

            |cffff8000Recommend:|r Off

            |cffff8000Import:|r Optional
        ]];
    elseif (itemName == frameName ..  "TabPage3SaveExtendedPlayerInfoCBHelp") then
        tab_text = [[
            |cff40bbffSave Player Extended Info|r

            Whether to save additional info about players in the log.

            This option is critical to Guild Launch imports since it allows for the creation
            of characters not on your roster during the import process.

            |cffff8000Recommend:|r On

            |cffff8000Import:|r Critical
        ]];
    elseif (itemName == frameName ..  "TabPage3AutoBossSliderHelp") then
        tab_text = [[
            |cff40bbffAuto Boss|r

            The method of boss detection used.

            This option is critical for Guild Launch imports. Technically any value
            but "Off" is acceptable. In practice we've found that the best setting
            is "On boss kill".

            |cffff8000Recommend:|r On boss kill

            |cffff8000Import:|r Any but 'Off'
        ]];
    elseif (itemName == frameName ..  "TabPage3AutoBossChangeMinTimeSliderHelp") then
        tab_text = [[
            |cff40bbffAuto Boss Cooldown Time|r

            This option sets the period of time after the boss kill that all items
            received by raid members will be attributed to the boss that was killed.
            The purpose of this option is to account for long loot times and to allow
            for the killing of trash mobs or adds right after a boss kill without
            changing the current boss that items are assigned to. We recommend a long
            time be set such as 10 minutes. If your guild takes a long
            time to assign loot you can make it even higher (Up to 20 minutes).

            The only downside of this is that sometimes a trash mob kill's loot will be
            assigned to a boss. This is a rare event however since it requires a trackable
            drop on a trash mob directly after a boss kill. You should be aware of the
            possibility though.

            |cffff8000Recommend:|r 10+

            |cffff8000Import:|r Important
        ]];
    elseif (itemName == frameName ..  "TabPage3LogAttendeesSliderHelp") then
        tab_text = [[
            |cff40bbffLog Attendees|r

            This option determines whether to log attendees when a boss is killed. This
            setting should be set to the same value as the Auto Boss setting.

            This option must be set to a value other than "Off" for Guild Launch imports
            to work correctly. We recommend it be set to "On boss kill".

            |cffff8000Recommend:|r On boss kill

            |cffff8000Import:|r Critical
        ]];
    -- TAB 4 Help Buttons
    elseif (itemName == frameName ..  "TabPage4MinQualitySliderHelp") then
        tab_text = [[
            |cff40bbffMin item quality to log|r

            The minimum quality of item to record in the logs.

            This option will not effect Guild Launch imports directly. However, if you tell
            the mod not to track blue items then blue items will not be imported.

            |cffff8000Recommend:|r User Preference - Rare is Default

            |cffff8000Import:|r Conditional
        ]];
    elseif (itemName == frameName ..  "TabPage4AskCostSliderHelp") then
        tab_text = [[
            |cff40bbffMin Item quality to ask cost for|r

            The Minimum quality of items to show the cost dialog for. If this option is on
            then a window will appear allowing you to enter the DKP value of the item.

            If you enter a DKP value of an item into this dialog it will be imported as the
            amount of DKP spent by the person who received the item. This option does not
            have to be on for imports to work.

            |cffff8000Recommend:|r User Preference - Rare is Default

            |cffff8000Import:|r Provides More Info
        ]];
    elseif (itemName == frameName ..  "TabPage4GetDKPValueSliderHelp") then
        tab_text = [[
            |cff40bbffMin Item Quality to get cost for|r

            The minimum item quality to retrieve previously recorded cost for. If this option
            and the Ask Cost option is enabled then when the dialog appears the last recorded
            value of that item will be provided. This option does not have to be enabled and
            is only useful if you also have the Ask Cost option enabled.

            This option will have no effect on Guild Launch imports, but it can reduce the
            data entry when tracking a raid.

            |cffff8000Recommend:|r User Preference - Rare is Default

            |cffff8000Import:|r Ease of Use
        ]];
    elseif (itemName == frameName ..  "TabPage4GroupItemsSliderHelp") then
        tab_text = [[
            |cff40bbffMax Item Quality to Group|r

            The maximum quality of item to log as a stack. This option will log a stack of
            items as one entry if a stack is received by a player and the item quality is
            less than that entered.

            This option has no effect on Guild Launch imports.

            |cffff8000Recommend:|r User Preference - Rare is Default

            |cffff8000Import:|r Any
        ]];
    elseif (itemName == frameName ..  "TabPage4SaveTooltipsCBHelp") then
        tab_text = [[
            |cff40bbffSave Item Tooltip|r

            Whether to save item tooltip info in the log.

            This option will have no effect on Guild Launch imports. It will make the file
            size of the log larger though.

            |cffff8000Recommend:|r Off

            |cffff8000Import:|r Optional
        ]];
    elseif (itemName == frameName ..  "TabPage4AutoSetEPGPCostHelp") then
        tab_text = [[
            |cff40bbffAuto Set EPGP Costs|r

            Whether to prefill the costs dialog with the EPGP value. If this option is on and
            you have the Ask Cost dialog enabled then the EPGP value of the item will be
            prefilled in the dialog.

            This option is *only* needed if you are running an EPGP style DKP system.

            This option has no direct effect on Guild Launch imports.

            |cffff8000Recommend:|r Off for Regular DKP, On for EPGP

            |cffff8000Import:|r Any
        ]];
        elseif (itemName == frameName ..  "TabPage4BonusLootHelp") then
        tab_text = [[
            |cff40bbffBonus Loot Tracking|r

            Whether to track bonus loot or not.

            On will track bonus loot recieved and attribute the bonus loot to its corresponding
            boss with no distinction between traditional loot and bonus loot. Off will simply
            ignore bonus loot.

            |cffff8000Recommend:|r Depends on your preference.

            |cffff8000Import:|r Optional.
        ]];
    -- TAB 5 Help Info
    elseif (itemName == frameName ..  "TabPage5DKPmonLoggingModeHelp") then
        tab_text = [[
            |cff40bbffEnable DKPmon Logging|r

            This option will place the Raid Tracker in DKPmon logging mode. In this mode no
            bosses or items will be automatically tracked. This option should *only* be
            enabled if you are running DKPmonand are using the DKPmon Bidding and
            DKPmon Award windows to manage Bidding and DKP Awards for boss kills.

            If you enable this option and are not running DKPmon and using it properly
            then *no* item and boss kill info will be tracked.

            DKPmon usage with Raid Tracker and Rapid Raid is not required.

            This option does not directly effect Guild Launch imports but if not used properly
            with DKPmon then it may keep items and bosses from being tracked.

            |cffff8000Recommend:|r On when Using DKPmon

            |cffff8000Import:|r Must be off if not using DKPmon
        ]];
    -- TAB 6 Help Info
    elseif (itemName == frameName ..  "TabPage6TimeSyncCBHelp") then
        tab_text = [[
            |cff40bbffUse Server Time|r

            Whether to use server or local time for event times.

            This option will effect the times recorded in Guild Launch imports.

            |cffff8000Recommend:|r Off

            |cffff8000Import:|r Any
        ]];
    elseif (itemName == frameName ..  "TabPage6TimeZoneSliderHelp") then
        tab_text = [[
            |cff40bbffTimezone|r

            The number of hours to adjust the recorded time by.

            This option will effect the times recorded in Guild Launch imports.

            |cffff8000Recommend:|r 0
            |cffff8000Import:|r Any
        ]];
    elseif (itemName == frameName ..  "TabPage6Use24hFormatHelp") then
        tab_text = [[
            |cff40bbffUse 24hr time format|r

            Whether to display times in 24hr format

            |cffff8000Recommend:|r User Preference

            |cffff8000Import:|r Any
        ]];
    elseif (itemName == frameName ..  "TabPage6MaxLevelSliderHelp") then
        tab_text = [[
            |cff40bbffMax Level|r

            This is unused.

            |cffff8000Recommend:|r 70

            |cffff8000Import:|r Any
        ]];
    elseif (itemName == frameName ..  "TabPage6GuildSnapshotCBHelp") then
        tab_text = [[
            |cff40bbffLog Guild Roster on Bosskill|r

            This option will log all guild members logged in as attending a boss kill.
            This setting is not used very much.

            We don't recommend turning this option on unless you truly need to have all
            logged in guild members logged as attending every boss kill. Theoretically it
            could be used for 'Standby' purposes but since any logged in guild member
            will be tracked it's often not specific enough to be useful.

            |cffff8000Recommend:|r Off

            |cffff8000Import:|r Any
        ]];
    elseif (itemName == frameName ..  "TabPage6ExportFormatSliderHelp") then
        tab_text = [[
            |cff40bbffExport Format|r

            The format of the XML to export the Log in.

            This is possibly the most important option for Guild Launch imports. Only the
            Guild Launch format works with Guild Launch imports.

            |cffff8000Recommend:|r Guild Launch

            |cffff8000Import:|r Critical
        ]];
    elseif (itemName == frameName ..  "TabPage8EnableListmeHelp") then
        tab_text = [[
            |cff40bbffEnable Listme Whisper|r

            The 'Listme' Functionality allows a guild member to message you with
            "/w <Raid Leader> listme" and to be added to the waitlist of the current raid.
            This setting will allow you to disable this functionality. You can turn it off
            and on to allow raiders to waitlist themselves at certain times and not at
            others.

            |cffff8000Recommend:|r On

            |cffff8000Import:|r Any
        ]];
    elseif (itemName == frameName ..  "TabPage8WaitlistAttendanceTypeHelp") then
        tab_text = [[
            |cff40bbffWaitlist Attendance Type|r

            This options indicates whether Waitlisted players are added to the Boss
            Kill event or as a seperate event called 'Event Name - Waitlist'. This would
            allow you to assign different DKP values to the Boss kill and those players
            on the waitlist or to assign DKP to one and none to the other for tracking
            purposes.

            |cffff8000Recommend:|r Any

            |cffff8000Import:|r Any
        ]];
    end

    -- show the text
    local helpString = getglobal("CT_RaidTrackerOptionsFrameHelpString");
    helpString:SetText(tab_text);
    --helpString:SetText(itemName);
end

function CT_RaidTracker_OptionsFrame_HideItemHelp()
    local tab_text = "";
    tab_text = [[
            |cff40bbffHover over an item's help button for specific help|r
        ]];

    -- show the text
    local helpString = getglobal("CT_RaidTrackerOptionsFrameHelpString");
    helpString:SetText(tab_text);
end

function CT_RaidTracker_OptionsFrame_ShowTabHelp(buttonNum)
    local tab_text = "";
    local help_header_text = "Help On This Tab";
    local extended_help_string = "";
    local mod_frame = getglobal("CT_RaidTrackerOptionsFrame");

    if (CT_RaidTracker_Options["ShowConfigHelp"] == 0) then
        mod_frame:SetHeight(250);
    else
        mod_frame:SetHeight(450);
    end

    CT_RaidTrackerOptionsFrameToggleHelpButton:Show();

    if (buttonNum == 1) then
        tab_text = [[
            |cff40bbffStandalone|r
                Use these settings if you are running Raid Tracker only.

            |cff40bbffDKPmon Integration|r
                If you are using DKPmon to track in-game DKP then use these settings.

            |cff40bbffCustom|r
                For usage with Guild Launch the 3 buttons above will setup the mod for proper
                functioning. If you would like to customize
                the operation further use the tabs below.
            ]];
    elseif (buttonNum == 2) then
        tab_text = [[
            |cff40bbffHover over an item's help button for specific help|r
        ]];
    elseif (buttonNum == 3) then
        tab_text = [[
            |cff40bbffHover over an item's help button for specific help|r
        ]];
    elseif (buttonNum == 4) then
        tab_text = [[
            |cff40bbffHover over an item's help button for specific help|r
        ]];
    elseif (buttonNum == 5) then
        tab_text = [[
            |cff40bbffHover over an item's help button for specific help|r
        ]];
    elseif (buttonNum == 6) then
        tab_text = [[
            |cff40bbffHover over an item's help button for specific help|r
        ]];
    elseif (buttonNum == 8) then
        tab_text = [[
            |cff40bbffHover over an item's help button for specific help|r
        ]];
    else
        tab_text = "";
        help_header_text = "";
        CT_RaidTrackerOptionsFrameToggleHelpButton:Hide();
        mod_frame:SetHeight(450);
    end

    if (buttonNum == 7) then
        extended_help_string =[[
         |cff40bbffCritical Settings:|r

         Guild Launch imports rely on 3 critical settings to work properly:

         |cffff8000Auto Boss|r set to |cffff8000'On boss kill'|r (Boss Tab)
         |cffff8000Log Attendess|r set to |cffff8000'On Boss kill'|r (Boss Tab)
         |cffff8000Export Format|t set to |cffff8000'Guild Launch'|r (Misc. Tab)

         If you have those settings configured in the manner indicated then your raids
         will log and the mod will track items and boss kills automatically.

         |cff40bbffOptional settings:|r

         EPGP

         If you are running an EPGP system you may want to enable the
         'Auto set epgp costs' setting on the Item tab.

         DKPmon

         If you are running the Guild Launch DKPmon and have enabled it to log to
         Raid Tracker then you should enable the 'Enabled DKPmon Logging' setting
         on the DKPmon Tab.

         |cff40bbffMore Support:|r

         When making a support request the more info you can provide the better. The
         type of DKP you are running, what instance you are running, specific charater
         names, the settings you have set and their values, and whether you are running
         DKPmon are all useful info.

         Guild Launch Support Forms: http://support.guildlaunch.com/

         We have a Rapid Raid help forums with videos and FAQs about Rapid Raid usage
         and Raid Tracker usage.
        ]];
    end

    -- set the extended help string
    local extended_help_text = getglobal("CT_RaidTrackerOptionsFrameExtendedHelpString");
    extended_help_text:SetText(extended_help_string);

    -- set the help header
    local helpHeader = getglobal("CT_RaidTrackerOptionsFrameHelpHeader");
    helpHeader:SetText(help_header_text);

    -- show the text
    local helpString = getglobal("CT_RaidTrackerOptionsFrameHelpString");
    helpString:SetText(tab_text);
end


function CT_RaidTracker_OptionsFrame_ToggleHelp()
    local config_help = CT_RaidTracker_Options["ShowConfigHelp"];
    local toggle_help_button = getglobal("CT_RaidTrackerOptionsFrameToggleHelpButton");
    local mod_frame = getglobal("CT_RaidTrackerOptionsFrame");

    --CT_RaidTracker_Print("Stat:" .. config_help, 1, 1, 0);

    if (config_help == "" or config_help == 1) then
        toggle_help_button:SetText("?: Off");
        CT_RaidTracker_Options["ShowConfigHelp"] = 0;
        mod_frame:SetHeight(250);

        -- set the help header
        local helpHeader = getglobal("CT_RaidTrackerOptionsFrameHelpHeader");
        helpHeader:Hide();

        -- show the text
        local helpString = getglobal("CT_RaidTrackerOptionsFrameHelpString");
        helpString:Hide();
    else
        toggle_help_button:SetText("?: On");
        CT_RaidTracker_Options["ShowConfigHelp"] = 1;
        mod_frame:SetHeight(450);

        -- set the help header
        local helpHeader = getglobal("CT_RaidTrackerOptionsFrameHelpHeader");
        helpHeader:Show();

        -- show the text
        local helpString = getglobal("CT_RaidTrackerOptionsFrameHelpString");
        helpString:Show();
    end
end