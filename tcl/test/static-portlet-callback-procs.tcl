ad_library {
    Automated tests for static-portlet-callbacks.

    @author Luis de la Fuente (lfuente@it.uc3m.es)
    @creation-date 18 November 2005
}

aa_register_case static_move {
    Test the cabability of moving static-portlet
} {    

    aa_run_with_teardown \
        -rollback \
        -test_code {
            
            #Create origin and destiny communities
            set origin_club_key [dotlrn_club::new -pretty_name [ad_generate_random_string]]
            set destiny_club_key [dotlrn_club::new -pretty_name [ad_generate_random_string]]

            set static_id [static_portal_content::new  -package_id $origin_club_key  -content "foo" -pretty_name "foobar"]

            #is the forum at the origin?
            set orig_success_p [db_string orig_success_p {
                select 1 from static_portal_content where content_id=:static_id and package_id=:origin_club_key  
            } -default "0"]
            aa_equals "new is first at origin" $orig_success_p 1

            #move the static
            callback -catch datamanager::move_static -object_id $static_id -selected_community $destiny_club_key -self_community $origin_club_key

            #is the forum at the origin?
            set orig_success_p [db_string orig_success_p {
                select 0 from static_portal_content where content_id=:static_id and package_id=:origin_club_key  
            } -default "1"]
            aa_equals "new is not at the origin after moving" $orig_success_p 1

            #is the forum at the origin?
            set orig_success_p [db_string orig_success_p {
                select 1 from static_portal_content where content_id=:static_id and package_id=:destiny_club_key  
            } -default "0"]
            aa_equals "new is moved succesfully" $orig_success_p 1

        }
}


aa_register_case static_copy {
    Test the cabability of coping static-portlet
} {    

    aa_run_with_teardown \
        -rollback \
        -test_code {
            
            #Create origin and destiny communities
            set origin_club_key [dotlrn_club::new -pretty_name [ad_generate_random_string]]
            set destiny_club_key [dotlrn_club::new -pretty_name [ad_generate_random_string]]

            set static_id [static_portal_content::new  -package_id $origin_club_key  -content "foo" -pretty_name "foobar"]

            #is the forum at the origin?
            set orig_success_p [db_string orig_success_p {
                select 1 from static_portal_content where content_id=:static_id and package_id=:origin_club_key  
            } -default "0"]
            aa_equals "new is first at origin" $orig_success_p 1

            #move the static

            set new_static [callback -catch datamanager::copy_static -object_id $static_id -selected_community $destiny_club_key ]
            #is the forum at the origin?
            set orig_success_p [db_string orig_success_p {
                select 1 from static_portal_content where content_id=:static_id and package_id=:origin_club_key  
            } -default "0"]
            aa_equals "new is correctly at the origin after copying" $orig_success_p 1

            #is the forum at the origin?
            set orig_success_p [db_string orig_success_p {
                select 1 from static_portal_content where content_id=:new_static and package_id=:destiny_club_key  
            } -default "0"]
            aa_equals "new is copied succesfully" $orig_success_p 1

        }
}

