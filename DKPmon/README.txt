-----------------------------------------------------------------------------
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
-----------------------------------------------------------------------------

1) Customizing DKPmon
 There is some initial setup required before your guild can use DKPmon. This
setup is in the form of providing information on item costs, number of pools,
etc. Please see the "Using DKPmon" section of the web site for more 
information.

2) Reporting Bugs
 There are a few ways to report bugs for this addon.
   a) Make a post in the wowace.com forums thread for DKPmon & Bidder.
   b) Send me an email.
 
 When reporting bugs, please make your bug report as detailed as possible.
Ideally, your report will contain steps to reliably reproduce the bug and
the full text of the error message that you received. Also, include your
SavedVariables files for this addon and any DKP System custom files that you
are using.

3) Feature Requests
 I have put a lot of effort into making this addon as extendable as possible by
external addons. If you have a cool feature that cannot be done via an 
external addon, then send me an email or make a post in the wowace forums
with information on your feature request.
 When writing up your feature request, treat it as though you are writing up
a research/work proposal. Include motivation on why this feature is 
needed/wanted, as many details on the feature as you can include, and
what the benefits of the feature are. Requests that just say "you should do X"
are likely to be ignored. Remember, you're asking me to devote my time to 
something that you want; you need to motivate me to do so.
 The absolute best way to request a feature is to code it up yourself, and to 
send me a diff with the latest code release that I've done. If the feature is
well written, and useful, I'll include it in my release of the addon.

4) Writing your own DKP System addon module
 The easiest way to go about this is to look at the three DKP system addon
modules that I have already made available, and copy what you can.
 All DKP systems must have both a DKPmon and Bidder plugin.
 DKPmon plugins must implement all of the functions in the DKPmon_DKP_Interface
class defined in DKPSystems/baseclass.lua of the DKPmon addon.
 Bidder plugins must implement all of the functions in the Bidder_DKP_Interface
class defined in DKPSystems/baseclass.lua of the Bidder addon.