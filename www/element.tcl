ad_page_contract {
    edit a static element
    
    @author arjun (arjun@openforce)
    @cvs_id $Id$
} -query {
    {content_id ""}
    {referer "../one-community-admin"}
    portal_id:integer,notnull
}  -properties {
    title:onevalue
}

set title "Edit content element"

db_1row get_content_element {
    select content, pretty_name
    from static_portal_content
    where content_id = :content_id
}

form create static_element

element create static_element pretty_name \
    -label "Name" \
    -datatype text \
    -widget text \
    -html {size 60} \
    -value $pretty_name

element create static_element content \
    -label "Content" \
    -datatype text \
    -widget textarea \
    -html {rows 15 cols 80 wrap soft} \
    -value $content

element create static_element content_id \
    -label "content_id" \
    -datatype integer \
    -widget hidden \
    -value $content_id

element create static_element portal_id \
    -label "portal_id" \
    -datatype integer \
    -widget hidden \
    -value $portal_id

if {[form is_valid static_element]} {
    form get_values static_element \
        pretty_name content content_id portal_id
    
    db_transaction {
        static_portal_content::update \
                -content_id $content_id \
                -pretty_name $pretty_name \
                -content $content
        
        # Must update portal element title
        # db_dml update_element_pretty_name "update portal_element_map set pretty_name= :pretty_name where element_id= :element_id"
    }

    # redirect and abort
    ad_returnredirect $referer
    ad_script_abort
}
