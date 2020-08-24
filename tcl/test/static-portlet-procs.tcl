ad_library {
    Automated tests for the static-portlet package.

    @author Héctor Romojaro <hector.romojaro@gmail.com>
    @creation-date 2020-08-19
    @cvs-id $Id$
}

aa_register_case -procs {
        static_admin_portlet::link
        static_portlet::link
        static_portlet::get_pretty_name
    } -cats {
        api
        production_safe
    } static_portlet_links_names {
        Test diverse link and name procs.
} {
    aa_equals "Static admin portlet link"   "[static_admin_portlet::link]" ""
    aa_equals "Static portlet link"         "[static_portlet::link]" ""
    aa_equals "Static portlet pretty name"  "[static_portlet::get_pretty_name]" ""
}


aa_register_case -procs {
        static_portal_content::new
        static_portal_content::get_content
        static_portal_content::get_pretty_name
        static_portal_content::get_package_id
        static_portal_content::get_content_format
        static_portal_content::add_to_portal
        static_portal_content::update
        static_portal_content::remove_all_from_portal
        static_portal_content::delete
    } -cats {
        api
    } static_portal_content__procs {
        Test diverse static_portal_content procs.
} {
    aa_run_with_teardown -rollback -test_code {
        #
        # Create the new content item 'foo'.
        #
        # As this is running in a transaction, it should be cleaned up
        # automatically.
        #
        set content "Just a test"
        set content_package_id 0
        set content_pretty_name "foo"
        set content_format "text/html"
        set content_id [static_portal_content::new \
                            -package_id $content_package_id \
                            -content $content \
                            -pretty_name $content_pretty_name \
                            -format $content_format]
        #
        # Check if the creation was successful
        #
        set exists_p [db_0or1row foo {
            select * from static_portal_content where content_id=:content_id
        }]
        aa_true "Creation successful (content_id: $content_id)" "$exists_p"
        if {$exists_p} {
            #
            # Check the content
            #
            aa_equals "Check content" "[static_portal_content::get_content -content_id $content_id]" "$content"
            #
            # Check the pretty name
            #
            aa_equals "Check pretty name" "[static_portal_content::get_pretty_name -content_id $content_id]" "$content_pretty_name"
            #
            # Check the package id
            #
            aa_equals "Check package id" "[static_portal_content::get_package_id -content_id $content_id]" "$content_package_id"
            #
            # Check the content format
            #
            aa_equals "Check content format" "[static_portal_content::get_content_format -content_id $content_id]" "$content_format"
            #
            # Create test user
            #
            set portal_user_id [db_nextval acs_object_id_seq]
            set user_info [acs::test::user::create -user_id $portal_user_id]
            #
            # Create portal
            #
            set portal_id [portal::create $portal_user_id]
            set portal_exists_p [db_0or1row foo {
                select * from portals where portal_id=:portal_id
            }]
            if {$portal_exists_p} {
                aa_log "Portal created (portal_id: $portal_id)"
                #
                # Add to portal
                #
                set element_id [static_portal_content::add_to_portal \
                                    -portal_id $portal_id \
                                    -package_id $content_package_id \
                                    -content_id $content_id]
                set element_pretty_name [db_string element {
                    select pretty_name
                      from portal_element_map
                     where element_id=:element_id
                }]
                aa_equals "Element added to portal" "$element_pretty_name" "$content_pretty_name"
                #
                # Update
                #
                set new_content "Just a test"
                set new_content_pretty_name "bar"
                set new_content_format "text/plain"
                static_portal_content::update \
                                -portal_id $portal_id \
                                -content_id $content_id\
                                -content $new_content \
                                -pretty_name $new_content_pretty_name\
                                -format $new_content_format
                aa_log "Element updated"
                aa_equals "Check new content" "[static_portal_content::get_content -content_id $content_id]" "$new_content"
                aa_equals "Check new pretty name" "[static_portal_content::get_pretty_name -content_id $content_id]" "$new_content_pretty_name"
                aa_equals "Check new content format" "[static_portal_content::get_content_format -content_id $content_id]" "$new_content_format"
                #
                # Removal from portal
                #
                static_portal_content::remove_all_from_portal -portal_id $portal_id
                set portal_elements [db_string elements {
                    select count(1)
                    from portal_element_map pem,
                         portal_pages pp
                   where pp.portal_id = :portal_id
                     and pp.page_id = pem.page_id
                }]
                aa_equals "Number of portal elements after removal" "$portal_elements" "0"
            } else {
                aa_error "Portal creation failed"
            }
            #
            # Delete
            #
            static_portal_content::delete -content_id $content_id
            aa_false "Deletion successful" "[db_0or1row foo {select * from static_portal_content where content_id=:content_id}]"
        } else {
            aa_error "Creation failed"
        }
    }
}


# Local variables:
#    mode: tcl
#    tcl-indent-level: 4
#    indent-tabs-mode: nil
# End:
