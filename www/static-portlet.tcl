ad_page_contract {
    The display logic for the STATIC portlet
    
    @author arjun (arjun@openforce)
    @author Ben Adida (ben@openforce)    
    @cvs_id $Id$
} 

array set config $cf	

set instance_id $config(instance_id)

db_multirow content_multi select_content {
  select content, pretty_name
  from static_portal_content
  where instance_id = :instance_id
} 
