ad_page_contract {
    delete a static element
    
    @author arjun (arjun@openforce)
    @cvs_id $Id$
} -query {
    {content_id ""}
    {referer "../one-community-admin"}
}  -properties {
    title:onevalue
}


# do the deed
static_portal_content::delete -content_id $content_id

# redirect and abort
ad_returnredirect $referer
ad_script_abort
