<?xml version="1.0"?>

<queryset>

    <fullquery name="get_content_element">
        <querytext>
            select body as content, pretty_name
            from static_portal_content
            where content_id = :content_id
        </querytext>
    </fullquery>

</queryset>
