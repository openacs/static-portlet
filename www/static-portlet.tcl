ad_page_contract {
    The display logic for the STATIC portlet
    
    @author arjun (arjun@openforce)
    @author Ben Adida (ben@openforce)    
    @cvs_id $Id$
} 

array set config $cf	

# one piece of content only per portlet
set content_id $config(content_id)

if {[catch {set success_p [db_0or1row select_content {
  select content, pretty_name
  from static_portal_content
  where content_id = :content_id
}]} errmsg]} {
    set success_p 0
}
