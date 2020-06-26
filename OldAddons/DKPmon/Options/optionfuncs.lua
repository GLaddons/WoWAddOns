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

--[[
ParseItemLink(link)
Description:
  Parses an item link for the item's colour and name
Input:
  link: Item link of the item to be parsed.
Output:
  colour, name
    colour = string, hex code of the item's colour
    name = string, name of the item without the '[' & ']'
]]
function DKPmon:ParseItemLink(link)
   local _,_,colour = string.find(link, "|c(.+)|Hitem")
   local _,_,name = string.find(link, "|h%[(.+)%]|h|")
   return colour,name
end

--[[
DKPmon:ParseBidItems(item0, item1, ...)
Description:
  Function to handle the biditem console command.
Input:
  argstring -- string; the text the user typed. Hopefully, it's only item links
Output:
  none
]]
function DKPmon:ParseBidItems(argstring)
   if self.Looting.bidstate ~= 0 then
      self:Print(L["Bidding is open, cannot add more items. Close bidding first."])
      return
   end
   local link
   -- Extract item links
   local nadded = 0
   for link in string.gmatch(argstring, "|c[0-9a-fA-F]+|Hitem[%:%d%-]+|h%[[^%]]+%]|h|r") do
      --self:Print("Item LInk Match")
      if  self.Looting:ProcessItemLink(link, L["Console"]) then
	     nadded = nadded + 1
       --self:Print("Item Added")
      end
   end
   if nadded > 0 then
      --self:Print("Showing")
      self.Looting:Show()
   end
end
