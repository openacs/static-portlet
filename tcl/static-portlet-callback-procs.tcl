ad_library {
    Navigation callbacks.

    @author Luis de la Fuente <lfuente@it.uc3m.es>
    @creation-date 2005-07-13
}


ad_proc -public -callback datamanager::move_static -impl datamanager {
     -object_id:required
     -self_community
     -selected_community:required
} {
    Move an static portlet to another class or community
} {
if {[info exist self_community] == 0} { 
    set community_id [dotlrn_community::get_community_id] 
} else {set community_id $self_community}

set old_portal_id [dotlrn_community::get_portal_id -community_id $community_id]
set old_page_id [portal::get_page_id  -portal_id $old_portal_id]
    
set new_portal_id [dotlrn_community::get_portal_id -community_id $selected_community]
set new_page_id [portal::get_page_id  -portal_id $new_portal_id]

    db_transaction {
        db_dml update_static_portal_content {}
        db_dml update_portal_element_map {}
    } on_error {
        ad_return_error "Error:" "The error was: $errmsg"
    }
}

ad_proc -public -callback datamanager::copy_static -impl datamanager {
     -object_id:required
     -selected_community:required
} {
    Copy an static portlet to another class or community
} {
#set the parameters
    set portal_id [dotlrn_community::get_portal_id -community_id $selected_community]
    db_1row get_static_portlet_data {}
    
#create the object    
    db_transaction {
       
        set item_id [static_portal_content::new \
                         -package_id $selected_community  \
                         -content $content \
                         -pretty_name $pretty_name
        ]

        set old_element_id [static_portal_content::add_to_portal \
				-portal_id $portal_id \
				-package_id $selected_community \
				-content_id $item_id]
    } on_error {
        ad_return_error "Error:" "The error was: $errmsg"
    }
    return $item_id
}
