--DEFAULT_CHAT_FRAME:AddMessage(arg2, 1, 0.5, 0);
local recursions = {}

function GL_FilterChats(frame, event, arg1)
    -- this filters out the gldkp chats from being seen by the user
    --pprint(arg1.."<--")
    --pprint(strsub(arg1,1,4))
    --pprint("$$$-->"..strsub(arg1,1,4) == "glrr")
    if arg1 == "glrr" or strsub(arg1,1,4) == "glrr" then
        --pprint("true status")
       return true;
    else
        --pprint("false status")
        return false;
    end
end

function GL_FilterOutgoingChats(frame, event, arg1, arg2)
    -- this filters out the gldkp chats from being seen by the user, unless it is sending to itself
    --pprint("-->"..strsub(arg1,1,5).."-->"..arg2);
    if ((strsub(arg1,1,5) == "glrr:") and (UnitName("player") ~= arg2)) then
        --pprint("true OUT")
        return true
    else
        --pprint("false OUT")
        return false
    end
    return false;
end

function GL_ShowDKPDataFrame()
    if (GL_MembersDkpFrame:IsShown() ) then
        GL_MembersDkpFrame:Hide();
    else
        MyModScrollBar_Update();
        GL_MembersDkpFrame:Show();
    end
end

function  GL_MembersDKP_Frame_Onshow(self)
    --
end

function GLRapidRaid_SlashCommand(msg)
	local _, _, command, args = string.find(msg, "(%w+)%s?(.*)");
	if(command) then
		command = strlower(command);
	end

    if(command == "show") then
        GL_ShowDKPDataFrame();
    elseif(command == "help" or command == nil) then
        GL_Print("Guild Launch Rapid Raid Help", 1, 1, 0);
        GL_Print("/glrr show - Shows the current DKP", 1, 1, 0);
        GL_Print("Commands for Others", 1, 1, 0);
        GL_Print("'/t "..UnitName("player").." glrr' - returns the BASIC DKP for the sender", 1, 1, 0);
        GL_Print("'/t "..UnitName("player").." glrr [PlayerName]' - returns the BASIC DKP for the given player", 1, 1, 0);
        GL_Print("'/t "..UnitName("player").." glrr detailed' - returns the DETAILED DKP for the sender", 1, 1, 0);
        GL_Print("'/t "..UnitName("player").." glrr [PlayerName] detailed' - returns the DETAILED DKP for the given player", 1, 1, 0);
    end;
end

function GuildLaunchRapidRaid_OnEvent(self, event, arg1, author)
    -- this code will take a whisper of gldkp and return DKP information
    if(event == "CHAT_MSG_WHISPER") then 
        msg = string.lower(arg1);
        local args = { };
        for word in string.gmatch(msg, "[^%s]+") do
            table.insert(args, word);
        end
                
        if(args[1] ~= nil and args[1] == "glrr") then 
            --DEFAULT_CHAT_FRAME:AddMessage(author, 1, 0.5, 0);
            SendChatMessage("glrr: "..GL_OutputDKP(author, args), "WHISPER", nil, author);
            return;
        end
        
        -- dump out for the rest of this code, as this is the only whisper code
        return;
    elseif (event == "PLAYER_ENTERING_WORLD") then
        DEFAULT_CHAT_FRAME:AddMessage("bobo", 1, 0.5, 0);
    end
end

function GL_Print(msg, r, g, b)
    DEFAULT_CHAT_FRAME:AddMessage(msg, r, g, b);
end

function GL_OutputDKP(sender, args)
	local retVal = "";
    
    if (args[2] and args[2] == "help") then
            retVal = "'/t "..UnitName("player").."' glrr - returns the BASIC DKP for the sender";
    else
        if (GL_DKPValues ~= nil) then
            local target_player = "";
            local detailed_info = false;
            local total_title = "current DKP";
            local earned_title = "earned";
            local spent_title = "spent";
            
            
            -- figure out the target player
            if (args[2] == nil or args[2] == "detailed") then
                target_player = string.lower(sender);
                if (args[2] and args[2] == "detailed") then
                    detailed_info = true;
                end
            else
                if (args[3] and args[3] == "detailed") then
                    detailed_info = true;
                end
                target_player = args[2];
            end
            
            -- if it's epgp then do this
            if (GL_DKPValues["epgp"] == 1) then
                total_title = "priority";
                earned_title = "effort";
                spent_title = "gear";       
            end
            
            -- build the return value
            if (GL_DKPValues["current_dkp_data"][target_player] and GL_DKPValues["current_dkp_data"][target_player] ~= nil) then
                if (args[3] and args[3] == "detailed") then
                    retVal = retVal.."Detailed Results for "..target_player..":";
                    retVal = retVal.." "..total_title..": "..GL_DKPValues["current_dkp_data"][target_player]["current"];
                    retVal = retVal.." "..spent_title..": "..GL_DKPValues["current_dkp_data"][target_player]["spent"];
                    retVal = retVal.." "..earned_title..": "..GL_DKPValues["current_dkp_data"][target_player]["earned"];
                    retVal = retVal.." last 30: "..GL_DKPValues["current_dkp_data"][target_player]["last30"];
                    retVal = retVal.." last 60: "..GL_DKPValues["current_dkp_data"][target_player]["last60"];
                    if (GL_DKPValues["current_dkp_data"][target_player]["epgp_gp_base"] ~= "NOT APPLICABLE" and GL_DKPValues["epgp"] == 1) then
                        retVal = retVal.." "..earned_title.." w/ base: "..GL_DKPValues["current_dkp_data"][target_player]["epgp_gp_base"];
                    end
                    if (GL_DKPValues["current_dkp_data"][target_player]["epgp_pr_base"] ~= "NOT APPLICABLE" and GL_DKPValues["epgp"] == 1) then
                        retVal = retVal.." "..total_title.." w/ base: -->"..GL_DKPValues["current_dkp_data"][target_player]["epgp_pr_base"].."<--";
                    end
                else
                    retVal = retVal.."Results for "..target_player..":";
                    if (GL_DKPValues["epgp"] == 1) then            
                        retVal = retVal.." "..total_title..": -->"..GL_DKPValues["current_dkp_data"][target_player]["epgp_pr_base"].."<--";
                    else
                        retVal = retVal.." "..total_title..": -->"..GL_DKPValues["current_dkp_data"][target_player]["current"].."<--";
                    end
                end
            else
                retVal = "No DKP Data Is Available for "..target_player;
            end
                
        else
            retVal = "There is not data currently loaded.";
        end
    end
    
	return retVal;
end

local mod_frame = CreateFrame("Frame","GuildLaunchRapidRaid");
mod_frame:SetScript("OnEvent", GuildLaunchRapidRaid_OnEvent);
mod_frame:RegisterEvent("CHAT_MSG_WHISPER");

ChatFrame_AddMessageEventFilter("CHAT_MSG_WHISPER", GL_FilterChats);
ChatFrame_AddMessageEventFilter("CHAT_MSG_WHISPER_INFORM",GL_FilterOutgoingChats);

SLASH_GLRAPIDRAID1 = "/glrapidraid";
SLASH_GLRAPIDRAID2 = "/glrr";

SlashCmdList["GLRAPIDRAID"] = GLRapidRaid_SlashCommand;

local function better_toString(data, depth)
    if type(data) == "string" then
        return ("%q"):format(data)
    elseif type(data) == "wstring" then
        return ("L%q"):format(WStringToString(data))
    elseif type(data) ~= "table" then
        return ("%s"):format(tostring(data))
    else
        if recursions[data] then
            return "{<recursive table>}"
        end
        recursions[data] = true
        if next(data) == nil then
            return "{}"
        elseif next(data, next(data)) == nil then
            return "{ [" .. better_toString(next(data), depth) .. "] = " .. better_toString(select(2, next(data)), depth) .. " }"
        else
            local t = {}
            t[#t+1] = "{\n"
            local keys = {}
            for k in pairs(data) do
                keys[#keys+1] = k
            end
            --table.sort(keys, mysort)
            for _, k in ipairs(keys) do
                local v = data[k]
                for i = 1, depth do
                    t[#t+1] = "    "
                end
                t[#t+1] = "["
                t[#t+1] = better_toString(k, depth+1)
                t[#t+1] = "] = "
                t[#t+1] = better_toString(v, depth+1)
                t[#t+1] = ",\n"
            end
            
            for i = 1, depth do
                t[#t+1] = "    "
            end
            t[#t+1] = "}"
            return table.concat(t)
        end
    end
end

function pprint(...)
    local n = select('#', ...)
    local t = {n, ': '}
    for i = 1, n do
        if i > 1 then
            t[#t+1] = ", "
        end
        t[#t+1] = better_toString((select(i, ...)), 0)
    end
    for k in pairs(recursions) do
        recursions[k] = nil
    end
    print(table.concat(t))
end

local function mysort(alpha, bravo)
    if type(alpha) ~= type(bravo) then
        return type(alpha) < type(bravo)
    end
    if alpha == bravo then
        return false
    end
    if type(alpha) == "string" or type(alpha) == "wstring" then
        return alpha:lower() < bravo:lower()
    end
    if type(alpha) == "number" then
        return alpha < bravo
    end
    return false
end