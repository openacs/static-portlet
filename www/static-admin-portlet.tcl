ad_page_contract {
    The display logic for the static admin portlet
    
    @author arjun (arjun@openforce)
    @author Ben Adida (ben@openforce)    
    @cvs_id $Id$
} -properties {
    
}

array set config $cf	

set instance_id $config(instance_id)

# aks - i forget if this is a list, so just keep this stuff here  
#
#if {[llength $list_of_instance_ids] > 1} {
#    # We have a problem!
#    return -code error "There should be only one instance of bboard for admin purposes"
#}
#
#set instance_id [lindex $list_of_instance_ids 0]
#

db_multirow content select_content "
select content_id, short_name
from dotlrn_static_content
where instance_id = :instance_id"

# set url [dotlrn_community::get_url_from_package_id -package_id $instance_id]
