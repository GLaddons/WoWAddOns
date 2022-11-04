CT_RaidTracker_ItemOptions_selected = nil;

CT_RaidTracker_ItemOptions_ScrollFrameTemplate = {
	bgFile = "Interface\\DialogFrame\\UI-DialogBox-Background",
	edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border",
	tile = true,
	tileSize = 16,
	edgeSize = 16,
	insets = { left = 5, right = 5, top = 5, bottom =5 },
}

CT_RaidTracker_ItemOptions_EditFrameTemplate = {
	bgFile = "Interface\\DialogFrame\\UI-DialogBox-Background",
	edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border",
	tile = true,
	tileSize = 16,
	edgeSize = 16,
	insets = { left = 5, right = 5, top = 5, bottom =5 },
}

function CT_RaidTracker_ItemOptions_ScrollBar_Update()
	table.sort(CT_RaidTracker_ItemOptions, function(a1, a2) return a1["id"] < a2["id"]; end);
	local line;
	local lineplusoffset;
	local maxlines = getn(CT_RaidTracker_ItemOptions);
	local text;
  FauxScrollFrame_Update(CT_RaidTracker_ItemOptions_ScrollBar, maxlines, 24, 14);
  for line=1, 24 do
  	local thisline = getglobal("CT_RaidTracker_ItemOptions_Entry"..line);
  	--print("CT_RaidTracker_ItemOptions_Entry"..line)
    lineplusoffset = line + FauxScrollFrame_GetOffset(CT_RaidTracker_ItemOptions_ScrollBar);
    if lineplusoffset <= maxlines then
    	local nameGIF, linkGIF, qualityGIF, LevelGIF, minLevelGIF, classGIF, subclassGIF, maxStackGIF, invtypeGIV, iconGIF = GetItemInfo(CT_RaidTracker_ItemOptions[lineplusoffset]["id"]);
    	if(nameGIF) then
    		CT_RaidTracker_ItemOptions[lineplusoffset]["name"] = nameGIF;
    		CT_RaidTracker_ItemOptions[lineplusoffset]["quality"] = qualityGIF;
    		--print (CT_RaidTracker_ItemOptions[lineplusoffset]["name"])
    		--print (CT_RaidTracker_ItemOptions[lineplusoffset]["quality"])
    	end
    	if(CT_RaidTracker_ItemOptions[lineplusoffset]["name"]) then
    		local _, _, _, color = GetItemQualityColor(CT_RaidTracker_ItemOptions[lineplusoffset]["quality"]);
    		text = "|c" .. color .. "" .. CT_RaidTracker_ItemOptions[lineplusoffset]["name"] .. "|r";
    		--print (text)
    	else
    		text = "Unknown (ID: "..CT_RaidTracker_ItemOptions[lineplusoffset]["id"]..")";
    	end
    	thisline.id = lineplusoffset;
    	thisline.itemid = CT_RaidTracker_ItemOptions[lineplusoffset]["id"];
			thisline:SetText(text);
			thisline:Show();
			if(CT_RaidTracker_ItemOptions_selected == lineplusoffset) then
				getglobal("CT_RaidTracker_ItemOptions_Entry"..line.."MouseOver"):Show();
			else
				getglobal("CT_RaidTracker_ItemOptions_Entry"..line.."MouseOver"):Hide();
			end
    else
      thisline:Hide();
      getglobal("CT_RaidTracker_ItemOptions_Entry"..line.."MouseOver"):Hide();
    end
  end
end

function CT_RaidTracker_ItemOptions_SetFrame(id)
	CT_RaidTracker_ItemOptions_EditFrame.id = id;
	CT_RaidTracker_ItemOptions_EditFrame:Hide();
	local itemname;
	if(CT_RaidTracker_ItemOptions[id]["name"]) then
		local _, _, _, color = GetItemQualityColor(CT_RaidTracker_ItemOptions[id]["quality"]);
    itemname = "|c" .. color .. "" .. CT_RaidTracker_ItemOptions[id]["name"] .. "|r";
	else
		itemname = "Unknown (ID: "..CT_RaidTracker_ItemOptions[id]["id"]..")";
	end
	CT_RaidTracker_ItemOptions_EditFrame_Item:SetText(itemname);
	CT_RaidTracker_ItemOptions_EditFrame:Show();
end

function CT_RaidTracker_ItemOptions_Delete(id)
	table.remove(CT_RaidTracker_ItemOptions, id);
	if(CT_RaidTracker_ItemOptions_selected) then
		if(CT_RaidTracker_ItemOptions_selected == id) then
			CT_RaidTracker_ItemOptions_selected = nil;
		elseif(CT_RaidTracker_ItemOptions_selected > id) then
			CT_RaidTracker_ItemOptions_selected = CT_RaidTracker_ItemOptions_selected - 1;
		end
	end
	CT_RaidTracker_ItemOptions_EditFrame:Hide();
	CT_RaidTracker_ItemOptions_ScrollBar_Update();
end

function CT_RaidTracker_ItemOptions_Save(self)
	local id = self:GetParent().id;
	if(CT_RaidTracker_ItemOptions_EditFrame_TrackAlways:GetChecked()) then
		CT_RaidTracker_ItemOptions[id]["status"] = 1;
	elseif(CT_RaidTracker_ItemOptions_EditFrame_TrackNever:GetChecked()) then
		CT_RaidTracker_ItemOptions[id]["status"] = 0;
	else
		CT_RaidTracker_ItemOptions[id]["status"] = nil;
	end
	if(CT_RaidTracker_ItemOptions_EditFrame_GroupAlways:GetChecked()) then
		CT_RaidTracker_ItemOptions[id]["group"] = 1;
	elseif(CT_RaidTracker_ItemOptions_EditFrame_GroupNever:GetChecked()) then
		CT_RaidTracker_ItemOptions[id]["group"] = 0;
	else
		CT_RaidTracker_ItemOptions[id]["group"] = nil;
	end
	if(CT_RaidTracker_ItemOptions_EditFrame_CostsGrabbingAlways:GetChecked()) then
		CT_RaidTracker_ItemOptions[id]["costsgrabbing"] = 1;
	elseif(CT_RaidTracker_ItemOptions_EditFrame_CostsGrabbingNever:GetChecked()) then
		CT_RaidTracker_ItemOptions[id]["costsgrabbing"] = 0;
	else
		CT_RaidTracker_ItemOptions[id]["costsgrabbing"] = nil;
	end
	if(CT_RaidTracker_ItemOptions_EditFrame_AskCostsAlways:GetChecked()) then
		CT_RaidTracker_ItemOptions[id]["askcosts"] = 1;
	elseif(CT_RaidTracker_ItemOptions_EditFrame_AskCostsNever:GetChecked()) then
		CT_RaidTracker_ItemOptions[id]["askcosts"] = 0;
	else
		CT_RaidTracker_ItemOptions[id]["askcosts"] = nil;
	end
	CT_RaidTracker_ItemOptions_EditFrame:Hide();
end