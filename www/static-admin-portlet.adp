<if @content:rowcount@ eq 0>
<i>No @element_pretty_plural@</i>
</if>
<else>
<ul>
<multiple name="content">
<li> <a href=./static/element?portal_id=@template_portal_id@&content_id=@content.content_id@>@content.pretty_name@</a>
[<a href=./static/element-delete?portal_id=@template_portal_id@&content_id=@content.content_id@>delete</a>]
</multiple>
</ul>
</else>
<p>
<a href=./static/element-new?portal_id=@template_portal_id@>New @element_pretty_name@</a>
