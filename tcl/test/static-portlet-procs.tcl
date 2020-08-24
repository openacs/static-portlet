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
