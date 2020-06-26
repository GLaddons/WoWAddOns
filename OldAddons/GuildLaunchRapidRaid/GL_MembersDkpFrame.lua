function MyModScrollBar_Update()
  local line; -- 1 through 5 of our window to scroll
  local lineplusoffset; -- an index into our data calculated from the scroll offset
  local player_value = "";
  local number_index = {};
  local counter = 1;
    
  -- loop through the elements, really the purpose of this is to get the total and to get a numerically indexed array  
  sorted_vars = table.ordered()
  for k,v in pairs(GL_DKPValues["current_dkp_data"]) do
    sorted_vars[k] = v;
  end

  for k,index, v in orderedPairs(sorted_vars) do
    number_index[counter] = {};
    number_index[counter]["name"] = index;
    number_index[counter]["earned"] = v["earned"];
    number_index[counter]["spent"] = v["spent"];
    if (GL_DKPValues["epgp"] == 1) then
        number_index[counter]["current"] = v["epgp_pr_base"];
    else
        number_index[counter]["current"] = v["current"];
    end
    
    -- calculate 30 day percentage
    if (v["last30"] and v["guildlast30"] and v["last30"] ~= nil and v["guildlast30"] ~= nil and v["guildlast30"] ~= 0 and v["last30"] ~= 0) then
        last30 = round((v["last30"] / v["guildlast30"]) * 100, 2);
        last30 = last30.."%";
    else
        last30 = "0%";
    end
    
    -- calculate 60 day percentage/g 
    if (v["last60"] and v["guildlast60"] and v["last60"] ~= nil and v["guildlast60"] ~= nil and v["guildlast60"] ~= 0 and v["last60"] ~= 0) then
        last60 = round((v["last60"] / v["guildlast60"]) * 100, 2);
        last60= last60.."%";    
    else
        last60="0%";
    end
    
    number_index[counter]["last30"] = last30;
    number_index[counter]["last60"] = last60;
    counter = counter + 1;
  end
  
  -- now that we have the total number lets update our scroll frame
  FauxScrollFrame_Update(MyModScrollBar,counter-1,20,16,nil,nil,nil,nil,nil,nil);
  
  -- debug
  --local z = 1;
  --for k, v in pairs(number_index) do
  -- DEFAULT_CHAT_FRAME:AddMessage(z.."--"..k, 1, 0.5, 0);
  -- z = z + 1;
  --end
  
  -- set up the headers as appropriate
  if (GL_DKPValues["epgp"] == 1) then
    getglobal("EarnedHeader"):SetText("Effort");
    getglobal("SpentHeader"):SetText("Gear");
    getglobal("CurrentHeader"):SetText("Priority");
  end
  -- the color of the row
  local color = "bdb76b";
  
  --table.sort(number_index);
  
  -- output the rows
  for line=1,20 do
    lineplusoffset = line + FauxScrollFrame_GetOffset(MyModScrollBar);
    if lineplusoffset < counter then
        -- set up the values
      getglobal("CharacterName"..line.."_Text"):SetText("|cff"..color..string.upper(strsub(number_index[lineplusoffset].name, 1, 1))..strsub(number_index[lineplusoffset].name, 2).."|r");
      getglobal("EarnedDKP"..line.."_Text"):SetText("|cff"..color..number_index[lineplusoffset].earned.."|r");  
      getglobal("SpentDKP"..line.."_Text"):SetText("|cff"..color..number_index[lineplusoffset].spent.."|r");  
      getglobal("CurrentDKP"..line.."_Text"):SetText("|cff"..color..number_index[lineplusoffset].current.."|r");  
      getglobal("Attendance30"..line.."_Text"):SetText("|cff"..color..number_index[lineplusoffset].last30.."|r");  
      getglobal("Attendance60"..line.."_Text"):SetText("|cff"..color..number_index[lineplusoffset].last60.."|r");  
      -- show the values
      getglobal("CharacterName"..line):Show();
      getglobal("EarnedDKP"..line):Show();
      getglobal("SpentDKP"..line):Show();
      getglobal("CurrentDKP"..line):Show();
      getglobal("Attendance30"..line):Show();
      getglobal("Attendance60"..line):Show();
      
      -- twiddle the color
      if (color == "bdb76b") then
        color = "ffa500";
      else
        color = "bdb76b";
      end
    else
      -- hide the values
      getglobal("CharacterName"..line):Hide();
      getglobal("EarnedDKP"..line):Hide();
      getglobal("SpentDKP"..line):Hide();
      getglobal("CurrentDKP"..line):Hide();
      getglobal("Attendance30"..line):Hide();
      getglobal("Attendance60"..line):Hide();
    end
  end
end

function round(n, precision)
  local m = 10^(precision or 0)
  return floor(m*n + 0.5)/m
end

function table.ordered(fcomp)
  local newmetatable = {}
  
  -- sort func
  newmetatable.fcomp = fcomp

  -- sorted subtable
  newmetatable.sorted = {}

  -- behavior on new index
  function newmetatable.__newindex(t, key, value)
    if type(key) == "string" then
      local fcomp = getmetatable(t).fcomp
      local tsorted = getmetatable(t).sorted
      table.binsert(tsorted, key , fcomp)
      rawset(t, key, value)
    end
  end

  -- behaviour on indexing
  function newmetatable.__index(t, key)
    if key == "n" then
      return table.getn( getmetatable(t).sorted )
    end
    local realkey = getmetatable(t).sorted[key]
    if realkey then
      return realkey, rawget(t, realkey)
    end
  end

  local newtable = {}

  -- set metatable
  return setmetatable(newtable, newmetatable)
end 

function table.binsert(t, value, fcomp)
  -- Initialise Compare function
  local fcomp = fcomp or function( a, b ) return a < b end

  --  Initialise Numbers
  local iStart, iEnd, iMid, iState =  1, table.getn( t ), 1, 0

  -- Get Insertposition
  while iStart <= iEnd do
    -- calculate middle
    iMid = math.floor( ( iStart + iEnd )/2 )

    -- compare
    if fcomp( value , t[iMid] ) then
      iEnd = iMid - 1
      iState = 0
    else
      iStart = iMid + 1
      iState = 1
    end
  end

  local pos = iMid+iState
  table.insert( t, pos, value )
  return pos
end

-- Iterate in ordered form
-- returns 3 values i, index, value
-- ( i = numerical index, index = tableindex, value = t[index] )
function orderedPairs(t)
  return orderedNext, t
end
function orderedNext(t, i)
  i = i or 0
  i = i + 1
  local index = getmetatable(t).sorted[i]
  if index then
    return i, index, t[index]
  end
end


