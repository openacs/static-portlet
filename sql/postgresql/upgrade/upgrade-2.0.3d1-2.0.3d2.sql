alter table static_portal_content add body text;
update static_portal_content set body = content;
alter table static_portal_content drop column content;

create or replace function static_portal_content_item__new (
    integer,                        -- package_id in static_portal_content.package_id%TYPE default null,
    varchar,                        -- pretty_name in static_portal_content.pretty_name%TYPE default null,
    varchar,                        -- content in static_portal_content.content%TYPE default null,
    varchar,                        -- object_type in acs_objects.object_type%TYPE default [static_portal_content],
    timestamptz,                    -- creation_date in acs_objects.creation_date%TYPE default sysdate,
    integer,                        -- creation_user in acs_objects.creation_user%TYPE default null,
    varchar,                        -- creation_ip in acs_objects.creation_ip%TYPE default null,
    integer                         -- context_id in acs_objects.context_id%TYPE default null
)
returns integer as '
declare
    p_package_id                    alias for $1;
    p_pretty_name                   alias for $2;
    p_content                       alias for $3;
    p_object_type                   alias for $4;
    p_creation_date                 alias for $5;
    p_creation_user                 alias for $6;
    p_creation_ip                   alias for $7;
    p_context_id                    alias for $8;
    v_content_id                    static_portal_content.content_id%TYPE;
    v_object_type                   varchar;
begin
    if p_object_type is null then
        v_object_type := ''static_portal_content'';
    else
        v_object_type := p_object_type;
    end if;

    v_content_id := acs_object__new(
        null,
        v_object_type,
        p_creation_date,
        p_creation_user,
        p_creation_ip,
        p_context_id
    );

    insert
    into static_portal_content
    (content_id, package_id, pretty_name, body)
    values
    (v_content_id, p_package_id, p_pretty_name, p_content);

    return v_content_id;
end;' language 'plpgsql';
