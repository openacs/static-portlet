ad_page_contract {
    create a new static content item

    @author arjun@openforce.net
    @creation-date 2001-12-03
    @version $Id$
} -query {
    {referer "../one-community-admin"}
    portal_id:integer,notnull
} -properties {
    title:onevalue
}

set title "New static element"
set instance_id [ad_conn package_id]

form create new_static_element

element create new_static_element pretty_name \
    -label "Name" \
    -datatype text \
    -widget text \
    -html {size 60}

element create new_static_element content \
    -label "Content" \
    -datatype text \
    -widget textarea \
    -html {rows 5 cols 60 wrap soft}

element create new_static_element portal_id \
    -label "portal_id" \
    -datatype integer \
    -widget hidden \
    -value $portal_id

if {[form is_valid new_static_element]} {
    form get_values new_static_element \
        pretty_name content portal_id

    # insert the new content item
    # ad_return_complaint 1 "$pretty_name, $content, $instance_id, $referer"

    db_transaction {
        set item_id [static_portal_content::new \
                -instance_id $instance_id \
                -content $content \
                -pretty_name $pretty_name]

        static_portal_content::add_to_portal -content_id $item_id -portal_id $portal_id
    }
        
    # redirect and abort
    ad_returnredirect $referer
    ad_script_abort
}
