# /packages/static-portlet/tcl/static-portal-content-procs.tcl
ad_library {

The procs for manipulating static portal content. Akin to the "bboard"
package being included in it's own "bboard-portlet" package

Copyright Openforce, Inc.
Licensed under GNU GPL v2 

@author arjun@openforce.net 
@cvs-id $Id$

}

namespace eval static_portal_content {

    ad_proc -public new { 
        {-instance_id:required}
        {-content:required}
        {-pretty_name:required}
    } {
        Calls the pl/sql to create the new content item
    } {
        # Create the content item
        set content_id [db_exec_plsql new_content_item "
        declare
        begin
        :1 := static_portal_content_item.new(
        instance_id => :instance_id,
        content => :content,
        pretty_name => :pretty_name
        );
        end;
        "]
     
        # Ben's style only cause he was editing here and then changed things back
        return $content_id
    }

    ad_proc -public add_to_portal {
        {-content_id:required}
        {-portal_id:required}
    } {
        db_transaction {
            # Generate the element
            set element_id [portal::add_element -pretty_name [get_pretty_name -content_id $content_id] \
                    $portal_id [static_portlet::my_name]]

            # Set the parameter
            portal::set_element_param $element_id content_id $content_id
        }
    }

    ad_proc -public update { 
        {-content_id:required}
        {-content:required}
        {-pretty_name:required}
    } {
        updates the content item
    } {
        return [db_dml update_content_item {
            update static_portal_content set 
            content = :content, pretty_name = :pretty_name 
            where content_id = :content_id
        }]
    }


    ad_proc -public delete { 
        {-content_id:required}
    } {
        deletes the item
    } {
        
        db_dml delete_content_item {
            delete from static_portal_content where content_id = :content_id
        }
    }

    ad_proc -public get_pretty_name { 
        {-content_id:required}
    } {
        Get the pretty_name of the item
    } {
        return [db_string get_pretty_name.select {
            select pretty_name
            from static_portal_content 
            where content_id = :content_id
        }]
    }

    ad_proc -public get_content { 
        {-content_id:required}
    } {
        Get the content of the item
    } {
        return [db_string get_content.select {
            select content
            from static_portal_content 
            where content_id = :content_id
        }]
    }

    ad_proc -public get_instance_id { 
        {-content_id:required}
    } {
        Get the instance_id of the item
    } {
        return [db_string get_instance_id.select {
            select instance_id
            from static_portal_content 
            where content_id = :content_id
        }]
    }

}
