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
    The display logic for the static admin portlet
    
    @author arjun (arjun@openforce)
    @author Ben Adida (ben@openforce)    
    @cvs_id $Id$
} {
    package_id:optional
    template_portal_id:optional
    referer:optional
    return_url:optional
}

if {![exists_and_not_null package_id]} {
    set package_id [dotlrn_community::get_community_id]
}

if {![exists_and_not_null template_portal_id]} {
    set template_portal_id [dotlrn_community::get_portal_id]
}

if {[exists_and_not_null return_url]} {
    set referer $return_url
}

if {![exists_and_not_null referer]} {
    set referer [ad_conn url]
}

set element_pretty_name [ad_parameter -localize static_admin_portlet_element_pretty_name static-portlet]
set element_pretty_plural [ad_parameter -localize static_admin_portlet_element_pretty_plural static-portlet]

ns_log notice "package_id = $package_id"
db_multirow content select_content {
    select content_id,
           pretty_name
    from static_portal_content
    where package_id = :package_id
} {
    set pretty_name [lang::util::localize $pretty_name]
}


set applet_url "[dotlrn_applet::get_url]/[static_portlet::my_package_key]"




