<?xml version="1.0"?>

<queryset>
<rdbms><type>postgresql</type><version>7.1</version></rdbms>

<fullquery name="new_content_item">
   <querytext>
        begin
        select static_portal_content_item__new(
        :package_id,
        :content,
        :pretty_name
        );
        end;
   </querytext>
</fullquery>

</queryset>
