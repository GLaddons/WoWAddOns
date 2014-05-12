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

local Looting = DKPmon.Looting
local L = AceLibrary("AceLocale-2.2"):new("DKPmon")

--[[
OnLootEvent()
Description:
  Called whenever a "LOOT_OPENED" event is fired
  ie: when a corpse is looted.
Input:
  None
Output:
  None
]]
function Looting:OnLootEvent()
   local nadded = 0
   if self:GetBidState() == 0 and GetNumGroupMembers() > 0 then
      local mobname = Bidder:GetFixedUpUnitName("target")
      if mobname == nil then
	 mobname = L["Unknown mob"]
      else
         -- CTRT Compatibility. Non-bosses will be named "Trash Mob"
         local ctrtcompat = DKPmon.Logging:GetTable().ctrtcompat
         if ctrtcompat and (UnitLevel("target") > 0) then
            mobname = "Trash Mob"
         end
      end
      -- Process every item link on the corpse.
      local slot, link, numSlots
      numSlots = GetNumLootItems()
      if numSlots == 0 then return end
      for slot = 1, numSlots, 1 do
	 link = GetLootSlotLink(slot)
	 if link ~= nil then -- Coins come out as a nil link
	    if self:ProcessItemLink(link, string.format("%s", mobname)) then
	       nadded = nadded + 1
	    end
	 end
      end
   end
   if nadded > 0 then self:Show() end
end

--[[
ProcessItemLink
Description:
  Called to try to add the given item to the list of bidable items. Will check if the item's valid, and if so it'll add it
Input:
  link -- string; itemlink of the item
  source -- string; either "Console" (for items entered via 'biditem') or "<mobname>"
Output:
  boolean -- true if the item was added, false otherwise
]]
function Looting:ProcessItemLink(link, source)
   local name, _, quality, _, _,type, subtype, stackcount, _, texture = GetItemInfo(link)
   if name == nil then
      DKPmon:Print(string.format(L["Invalid item link: %s"], link))
      return false
   end
   
   local zone = GetZoneText()
   local iteminfo = { 
      name = name, 
      link = link, 
      class = type, 
      subclass = subtype, 
      quality = quality, 
      colour = DKPmon:rgbToHex(ITEM_QUALITY_COLORS[quality]),
      colourrgb = { r=ITEM_QUALITY_COLORS[quality].r, g=ITEM_QUALITY_COLORS[quality].g, b=ITEM_QUALITY_COLORS[quality].b }, 
      count = stackcount, 
      texture = texture, 
      source = source,
      zone = zone,
      time = date("%m/%d/%y %H:%M:%S")
   }
   local DKP = DKPmon.DKP:Get()
   local allowed, dkpinfo = DKP:GetItemInfo(iteminfo)
   if allowed == nil then return false end -- skip this item

   iteminfo.dkpinfo = dkpinfo
   iteminfo.allowed = allowed
   self:AddItem(iteminfo)
   return true
end