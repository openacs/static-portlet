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
    delete a static element
    
    @author arjun (arjun@openforce)
    @cvs_id $Id$
} -query {
    {content_id ""}
    {referer "../one-community-admin"}
    portal_id:integer,notnull
}  -properties {
    title:onevalue
}

set ds_name [static_portlet::my_name]
set pretty_name [static_portal_content::get_pretty_name -content_id $content_id]

# THIS NEEDS TO BE GENERALIZED (FIXME - ben)
# FIXME : this might not be unique
set element_id [db_string select_element_id "
select portal_element_map.element_id from portal_element_map, portal_pages
where portal_pages.portal_id= :portal_id
and portal_pages.page_id = portal_element_map.page_id
and portal_element_map.pretty_name= :pretty_name"]

db_transaction {
    # Remove element
    portal::remove_element $element_id

    # do the deed
    static_portal_content::delete -content_id $content_id
}

# redirect and abort
ad_returnredirect $referer
ad_script_abort
