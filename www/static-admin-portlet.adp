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
<li> <a href=./static/element?portal_id=@template_portal_id@&content_id=@content.content_id@>@content.pretty_name@</a>
[<a href=./static/element-delete?portal_id=@template_portal_id@&content_id=@content.content_id@>delete</a>]
</multiple>
</ul>
</else>
<p>
<a href=./static/element-new?portal_id=@template_portal_id@>New @element_pretty_name@</a>
