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

ad_library {

    Procedures to supports static portlets

    @author arjun@openforce.net 
    @cvs-id $Id$
}

namespace eval static_portlet {
    
    ad_proc -private get_my_name {
    } {
	return "static_portlet"
    }
    
    ad_proc -public get_pretty_name {
    } {
	return ""
    }

    ad_proc -private my_package_key {
    } {
        return "static-portlet"
    }

    ad_proc -public link {
    } {
	return ""
    }
    
    ad_proc -public add_self_to_page { 
	portal_id 
	instance_id 
    } {
	Adds a static PE to the given page
    } {
        # there is no aggregation, so use:
        set element_id [portal::add_element \
                -portal_id $portal_id \
                -portlet_name [get_my_name]
        ]

        # Set the instace of "static-portlet" that this PE will know
        portal::set_element_param $element_id instance_id $instance_id

	return $element_id
    }
    
    ad_proc -public remove_self_from_page { 
	portal_id 
	element_id 
    } {
	Removes static PE from the given page 
    } {
        # This is easy since there's one and only one instace_id
        portal::remove_element $element_id
    }

    ad_proc -public show { 
	cf 
    } {
    } {
        
        portal::show_proc_helper \
                -package_key [my_package_key] \
                -config_list $cf \
                -template_src "static-portlet"
    }   
}
 

