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
    edit a static element
    
    @author arjun (arjun@openforce)
    @cvs_id $Id$
} -query {
    content_id:optional
    referer:notnull
    portal_id:integer,notnull
    {package_id:integer ""}
}  -properties {
    title:onevalue
}

set element_pretty_name [parameter::get -localize -parameter static_admin_portlet_element_pretty_name]
if { ![exists_and_not_null content_id] || [ad_form_new_p -key content_id] } {
  set title "[_ static-portlet.New] $element_pretty_name"
  set new_p 1
} else {
  set title "[_ static-portlet.Edit] $element_pretty_name"
  set new_p 0
}

set community_id $package_id
set portal_name [portal::get_name $portal_id]

ad_form -name static_element -form {
    content_id:key
    {pretty_name:text(text)     {label "[_ static-portlet.Name]"} {html {size 60}}}
    {content:text(textarea)     {label "[_ static-portlet.Content]"} {html {rows 15 cols 80 wrap soft}}}
    {portal_id:text(hidden)     {value $portal_id}}
    {package_id:text(hidden)    {value $package_id}}
    {referer:text(hidden)       {value $referer}}
} -new_data {
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
} -edit_request {
  db_1row get_content_element ""
  ad_set_form_values pretty_name
} -edit_data {
    db_transaction {
        static_portal_content::update \
                -portal_id $portal_id \
                -content_id $content_id \
                -pretty_name $pretty_name \
                -content $content
    }

    # redirect and abort
    ad_returnredirect $referer
    ad_script_abort
}


ad_form -name static_file -html {enctype multipart/form-data} -form {
    content_id:key
    {pretty_name:text(text)     {label "[_ static-portlet.Name]"} {html {size 60}}}
    {upload_file:file           {label "[_ static-portlet.File]"}}
    {portal_id:text(hidden)     {value $portal_id}}
    {package_id:text(hidden)    {value $package_id}}
    {referer:text(hidden)       {value $referer}}
} -new_data {
    set filename [template::util::file::get_property filename $upload_file]
    set tmp_filename [template::util::file::get_property tmp_filename $upload_file]
    set mime_type [template::util::file::get_property mime_type $upload_file]
    if { [string equal -length 4 "text" $mime_type] || [string length $mime_type] == 0 } {
      # it's a text file, we can do something with this
      set fd [open $tmp_filename "r"]
      set content [read $fd]
      close $fd
    } else {
      # they probably wanted to attach this file, but we can't do that.
      set content [_ static-portlet.Binary_file_uploaded]
    }

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
} -edit_request {
  db_1row get_content_element ""
  ad_set_form_values pretty_name
} -edit_data {
    set filename [template::util::file::get_property filename $upload_file]
    set tmp_filename [template::util::file::get_property tmp_filename $upload_file]
    set mime_type [template::util::file::get_property mime_type $upload_file]
    if { [string equal -length 4 "text" $mime_type] || [string length $mime_type] == 0 } {
      # it's a text file, we can do something with this
      set fd [open $tmp_filename "r"]
      set content [read $fd]
      close $fd
    } else {
      # they probably wanted to attach this file, but we can't do that.
      set content [_ static-portlet.Binary_file_uploaded]
    }
    db_transaction {
        static_portal_content::update \
                -portal_id $portal_id \
                -content_id $content_id \
                -pretty_name $pretty_name \
                -content $content
    }

    # redirect and abort
    ad_returnredirect $referer
    ad_script_abort
}
