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

    Procedures to support the static ADMIN portlet

    Copyright Openforce, Inc.
    Licensed under GNU GPL v2

    @author arjun@openforce.net
    @cvs-id $Id$
}

namespace eval static_admin_portlet {

    ad_proc -private get_my_name {
    } {
	return "static_admin_portlet"
    }

    ad_proc -public get_pretty_name {
    } {
        return [parameter::get_from_package_key -package_key [my_package_key] -parameter static_admin_portlet_pretty_name]
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
	{-portal_id:required}
	{-package_id:required}
    } {
	Adds a static admin PE to the given portal
    } {
        # we don't care if there are other instaces of the
        # static portlet in this portal since this PE only has one
        # and only one instace_id. i.e. There is no aggregation
        # unlike bboard-portlet

        # there is only one static admin portlet per portal so use:
        set element_id [portal::add_element \
            -portal_id $portal_id \
            -portlet_name [get_my_name]
        ]

        # Set the instace of "static" that this PE will know
        portal::set_element_param $element_id package_id $package_id

	return $element_id
    }

    ad_proc -public remove_self_from_page {
	{-portal_id:required}
    } {
	Removes static PE from the given page
    } {
        # This is easy since there's one and only one instace_id
        portal::remove_element \
            -portal_id $portal_id \
            -portlet_name [get_my_name]
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

}
