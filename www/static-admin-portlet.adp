<%

    #
    #  Copyright (C) 2001, 2002 MIT
    #
    #  This file is part of dotLRN.
    #
    #  dotLRN is free software; you can redistribute it and/or modify it under the
    #  terms of the GNU General Public License as published by the Free Software
    #  Foundation; either version 2 of the License, or (at your option) any later
    #  version.
    #
    #  dotLRN is distributed in the hope that it will be useful, but WITHOUT ANY
    #  WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
    #  FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more
    #  details.
    #

%>

<ul>
<multiple name="content">
  <li>
    <a href="@applet_url@/element?portal_id=@template_portal_id@&content_id=@content.content_id@&referer=@referer@">@content.pretty_name@</a>
  </li>
</multiple>
  <br>
  <li>
    <a href="@applet_url@/element-new?package_id=@package_id@&portal_id=@template_portal_id@&referer=@referer@">#static-portlet.new_static_admin_portlet#</a>
  </li>
</ul>

