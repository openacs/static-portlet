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

ad_page_contract {
    edit a static element
    
    @author arjun (arjun@openforce)
    @cvs_id $Id$
} -query {
    {content_id ""}
    referer:notnull
    portal_id:integer,notnull
}  -properties {
    title:onevalue
}

set title "Edit content element"
set element_pretty_name [ad_parameter static_admin_portlet_element_pretty_name static-portlet]

db_1row get_content_element {
    select content, pretty_name
    from static_portal_content
    where content_id = :content_id
}

form create static_element

element create static_element pretty_name \
    -label "Name" \
    -datatype text \
    -widget text \
    -html {size 60} \
    -value $pretty_name

element create static_element content \
    -label "Content" \
    -datatype text \
    -widget textarea \
    -html {rows 15 cols 80 wrap soft} \
    -value $content

element create static_element content_id \
    -label "content_id" \
    -datatype integer \
    -widget hidden \
    -value $content_id

element create static_element portal_id \
    -label "portal_id" \
    -datatype integer \
    -widget hidden \
    -value $portal_id

element create static_element referer \
    -label "referer" \
    -datatype text \
    -widget hidden \
    -value $referer

if {[form is_valid static_element]} {
    form get_values static_element \
        pretty_name content content_id portal_id referer
    
    static_portal_content::update \
        -portal_id $portal_id \
        -content_id $content_id \
        -pretty_name $pretty_name \
        -content $content
    
    ad_returnredirect $referer
    ad_script_abort
}
