<%

    #
    #  Copyright (C) 2001, 2002 OpenForce, Inc.
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

<if @content:rowcount@ eq 0>
<i>No @element_pretty_plural@</i>
</if>
<else>
<ul>
<multiple name="content">
<li> <a href=@applet_url@/element?portal_id=@template_portal_id@&content_id=@content.content_id@&referer=@referer@>@content.pretty_name@</a>
<!-- aks disallowing deletion static portlets for now, since they can't add them as well
  [<a href=@applet_url@/element-delete?portal_id=@template_portal_id@&content_id=@content.content_id@&referer=@referer@>delete</a>]
 -->
</multiple>
</ul>
</else>
<p>
<!-- aks disallowing new static portlets for now - there some weirdness in new-portal
  <a href=@applet_url@/element-new?portal_id=@template_portal_id@&referer=@referer@>New @element_pretty_name@</a>
 -->
