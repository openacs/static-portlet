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

<master>
<property name="title">@title@</property>

<p>
<blockquote>
#static-portlet.Back_to# <a href=@referer@>@portal_name@</a>
<br>
<br>

<if @new_p@>
<big><strong>#static-portlet.Create_a_new#</strong></big>
</if>
<else>
<big><strong>#static-portlet.lt_Editing_element_prett#</strong></big>
</else>

<P>
<P>

<if @new_p@ eq 0>
[<a href=element-delete?content_id=@content_id@&referer=@referer@&portal_id=@portal_id@><strong>#static-portlet.lt_Delete_element_pretty#</strong></a>]

<P>

#static-portlet.lt_strongNotestrong_You_#

</if>
<else>
#static-portlet.Use_this_form#

<P>

#static-portlet.lt_strongNotestrong_You_#
<p>
</else>
<p>

<formtemplate id="static_element"></formtemplate>

<p>
#static-portlet.You_may_upload#
<p>

<formtemplate id="static_file"></formtemplate>


