# /packages/dotlrn-static/tcl/static-admin-portlet-procs.tcl
ad_library {

Procedures to support the static ADMIN portlet

Copyright Openforce, Inc.
Licensed under GNU GPL v2 

@author arjun@openforce.net 
@cvs-id $Id$

}

namespace eval static_admin_portlet {
    
    ad_proc -private my_name {
    } {
	return "static_admin_portlet"
    }
    
    ad_proc -public get_pretty_name {
    } {
	return [ad_parameter static_admin_portlet_pretty_name static-portlet "Custom Portlet Administration"]
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
	Adds a static PE to the given page with the instance key being
	opaque data in the portal configuration.
    } {
        # we don't care if there are other instaces of the
        # static portlet in this portal since this PE only has one
        # and only one instace_id. i.e. There is no aggregation
        # unlike bboard-portlet

        # Tell portal to add this element to the page
        set element_id [portal::add_element $portal_id [my_name]]

        # Set the instace of "static" that this PE will know
        portal::set_element_param $element_id instance_id $instance_id

	return $element_id
    }
    
    ad_proc -public show { 
	cf 
    } {
	Display the PE
    } {
        portal::show_proc_helper \
                -package_key [my_package_key] \
                -config_list $cf \
                -template_src "static-admin-portlet"
    }   

    ad_proc -public edit { 
	element_id
    } {
	 Display the PE's edit page
    } {
	return ""
    }

    ad_proc -public remove_self_from_page { 
	portal_id 
	instance_id 
    } {
	Removes static PE from the given page 
    } {
        # This is easy since there's one and only one instace_id
        portal::remove_element $element_id
    }

    ad_proc -public make_self_available { 
	portal_id 
    } {
	Wrapper for the portal:: proc
	
	@param portal_id
    } {
	portal::make_datasource_available \
		$portal_id [portal::get_datasource_id [my_name]]
    }

    ad_proc -public make_self_unavailable { 
	portal_id 
    } {
	Wrapper for the portal:: proc
	
	@param portal_id
    } {
	portal::make_datasource_unavailable \
		$portal_id [portal::get_datasource_id [my_name]]
    }
}
 

