ad_page_contract {
    The display logic for the static admin portlet
    
    @author arjun (arjun@openforce)
    @author Ben Adida (ben@openforce)    
    @cvs_id $Id$
} -properties {
    
}

array set config $cf	

set instance_id $config(instance_id)

set element_pretty_name \
        [ad_parameter static_admin_portlet_element_pretty_name]
set element_pretty_plural \
        [ad_parameter static_admin_portlet_element_pretty_plural]


db_multirow content select_content "
select content_id, pretty_name
from static_portal_content
where instance_id = :instance_id"

set template_portal_id [dotlrn_community::get_portal_template_id [dotlrn_community::get_community_id]]
# set url [dotlrn_community::get_url_from_package_id -package_id $instance_id]
