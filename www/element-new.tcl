ad_page_contract {
    create a new static content item

    @author arjun@openforce.net
    @creation-date 2001-12-03
    @version $Id$
} -query {
    {referer "../one-community-admin"}
    {instance_id ""}
} -properties {
    title:onevalue
}

set title "New static element"

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

element create new_static_element instance_id \
    -label "instance_id" \
    -datatype integer \
    -widget hidden \
    -value $instance_id

if {[form is_valid new_static_element]} {
    form get_values new_static_element \
        pretty_name content instance_id

    # insert the new content item
    # ad_return_complaint 1 "$pretty_name, $content, $instance_id, $referer"

    set item_id [static_portal_content::new \
            -instance_id $instance_id \
            -content $content \
            -pretty_name $pretty_name]

    # redirect and abort
    ad_returnredirect $referer
    ad_script_abort
}
