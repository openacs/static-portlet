<if @content_multi:rowcount@ ne 0>
  <multiple name="content_multi">
   <strong>@content_multi.pretty_name@</strong>
   <br>
   @content_multi.content@
    <if @content_multi:rowcount@ gt 1>
      <if @content_multi.rownum@ lt @content_multi:rowcount@>
        <hr>
      </if>
    </if>
  </multiple>
</if>

