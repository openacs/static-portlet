ad_page_contract {
    The display logic for the STATIC portlet
    
    @author arjun (arjun@openforce)
    @author Ben Adida (ben@openforce)    
    @cvs_id $Id$
} 

array set config $cf	

# aks FIXME testing

set query  "
select content
from dotlrn_static_content
where instance_id = :instance_id)"

# aks - maybe a list, i forget
set list_of_instance_ids $config(instance_id)
