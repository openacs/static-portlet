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

ad_page_contract {
    create a new static content item

    @author arjun@openforce.net
    @creation-date 2001-12-03
    @version $Id$
} -query {
    referer:notnull
    portal_id:integer,notnull
    package_id:integer,notnull
} -properties {
    title:onevalue
}

set element_pretty_name [ad_parameter static_admin_portlet_element_pretty_name static-portlet "Custom Portlet"]

set title "New $element_pretty_name"

#these are set for display and instructions.
set community_id $package_id

set portal_name [portal::get_name $portal_id]

form create new_static_element

element create new_static_element pretty_name \
    -label "Name" \
    -datatype text \
    -widget text \
    -html {size 60}

element create new_static_element content \
    -label "Content" \
    -datatype text \
    -widget textarea \
    -html {rows 15 cols 80 wrap soft}

element create new_static_element portal_id \
    -label "portal_id" \
    -datatype integer \
    -widget hidden \
    -value $portal_id

element create new_static_element referer \
    -label "referer" \
    -datatype text \
    -widget hidden \
    -value $referer

element create new_static_element package_id \
    -label "package_id" \
    -datatype text \
    -widget hidden \
    -value $package_id

if {[form is_valid new_static_element]} {
    form get_values new_static_element \
        pretty_name content portal_id referer package_id

    db_transaction {
        set item_id [static_portal_content::new \
                         -package_id $package_id  \
                         -content $content \
                         -pretty_name $pretty_name
        ]

        static_portal_content::add_to_portal \
            -portal_id $portal_id \
            -package_id $package_id \
            -content_id $item_id
    }
        
    # redirect and abort
    ad_returnredirect $referer
    ad_script_abort
}











