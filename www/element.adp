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

<big><strong>Editing @element_pretty_name@ @pretty_name@</strong></big>

<P>
<P>

[<a href=element-delete?content_id=@content_id@&referer=@referer@&portal_id=@portal_id@><strong>Delete @element_pretty_name@ @pretty_name@</strong></a>]

<P>

<strong>Note</strong>: You can use plain text or HTML in the Content area.

<p>

<formtemplate id="static_element"></formtemplate>
