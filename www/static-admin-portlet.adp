<if @content:rowcount@ eq 0>
<i>No static elements</i>
</if>
<else>
<ul>
<multiple name="content">
<li> <a href=>foo</a> &nbsp; - &nbsp; <a href=>bar Static Administration</a>
</multiple>
</ul>
</else>
<p>
<a href=static-new>New static element</a>
