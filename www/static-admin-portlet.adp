<if @content:rowcount@ eq 0>
<i>No static elements</i>
</if>
<else>
<ul>
<multiple name="content">
<li> <a href=./static/element?content_id=@content.content_id@>@content.pretty_name@</a>
[<a href=./static/element-delete?content_id=@content.content_id@>delete</a>]
</multiple>
</ul>
</else>
<p>
<a href=./static/element-new?instance_id=@instance_id@>New static element</a>
