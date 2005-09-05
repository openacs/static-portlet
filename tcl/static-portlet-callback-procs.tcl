ad_library {
    Navigation callbacks.

    @author Luis de la Fuente <lfuente@it.uc3m.es>
    @creation-date 2005-07-13
}


ad_proc -public -callback datamanager::move_static -impl datamanager {
     -object_id:required
     -selected_community:required
} {
    Move an static portlet to another class or community
} {

set community_id [dotlrn_community::get_community_id] 

set old_portal_id [dotlrn_community::get_portal_id -community_id $community_id]
set old_page_id [portal::get_page_id  -portal_id $old_portal_id]
    
set new_portal_id [dotlrn_community::get_portal_id -community_id $selected_community]
set new_page_id [portal::get_page_id  -portal_id $new_portal_id]

db_dml update_static_portal_content {}
db_dml update_portal_element_map {}
}

