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
    The display logic for the static admin portlet
    
    @author arjun (arjun@openforce)
    @author Ben Adida (ben@openforce)    
    @cvs_id $Id$
} -properties {
}

array set config $cf	
set package_id $config(package_id)

set element_pretty_name [ad_parameter static_admin_portlet_element_pretty_name static-portlet "Custom Portlet"]
set element_pretty_plural [ad_parameter static_admin_portlet_element_pretty_plural static-portlet "Custom Portlets"]

db_multirow content select_content {
    select content_id,
           pretty_name
    from static_portal_content
    where package_id = :package_id
}

set template_portal_id [dotlrn_community::get_portal_id]
set pacakge_id [dotlrn_community::get_community_id]
set applet_url "[dotlrn_applet::get_url]/[static_portlet::my_package_key]"
set referer [ad_conn url]
