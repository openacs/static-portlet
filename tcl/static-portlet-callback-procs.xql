<?xml version="1.0"?>
<queryset>

<fullquery name="callback::datamanager::move_static::impl::datamanager.update_static_portal_content">
<querytext>
        update static_portal_content 
	set package_id = :selected_community
	where content_id = :object_id

</querytext>
</fullquery>

<fullquery name="callback::datamanager::move_static::impl::datamanager.update_portal_element_map">
<querytext>
        update portal_element_map
    set page_id=:new_page_id
    where page_id=:old_page_id and pretty_name=(select pretty_name from static_portal_content where content_id=:object_id);
</querytext>
</fullquery>

</queryset>
