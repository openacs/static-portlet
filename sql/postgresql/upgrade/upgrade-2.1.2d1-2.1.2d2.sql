-- 
-- 
-- 
-- @author Victor Guerra (guerra@galileo.edu)
-- @creation-date 2005-07-07
-- @arch-tag: 42606216-8bd1-43d1-9e86-b7ac723080c9
-- @cvs-id $Id$
--

-- altering static_portal_content in order to support 
-- defining different format type for the content of the static portlet

alter table static_portal_content add column body text;
alter table static_portal_content add column format varchar(30);
alter table static_portal_content alter column format set default 'text/html';

update static_portal_content set format = 'text/html';
	
alter table static_portal_content add constraint static_p_c_format_in check ( format in ('text/enhanced', 'text/plain', 'text/fixed-width', 'text/html'));


-- updating data
update static_portal_content
set format = 'text/enhanced',
    body = substring(body from 2 for (length(body) - 16))
where substring(body from (length(body)-12) for 13) = 'text/enhanced';

update static_portal_content
set format = 'text/plain',
    body = substring(body from 2 for (length(body) - 13))
where substring(body from (length(body)-9) for 10) = 'text/plain';

update static_portal_content
set format = 'text/plain',
    body = substring(body from 2 for (length(body) - 19))
where substring(body from (length(body)-15) for 16) = 'text/fixed-width';

update static_portal_content 
set format = 'text/html',
    body = substring(body from 2 for (length(body) - 12))
where substring(body from (length(body)-8) for 9) = 'text/html';

-- API modifications

drop function static_portal_content_item__new (integer, varchar, varchar);
create function static_portal_content_item__new (integer, varchar, varchar, varchar)
returns integer as '
declare
    p_package_id                    alias for $1;
    p_pretty_name                   alias for $2;
    p_content                       alias for $3;
    p_format			    alias for $4;
begin
    return static_portal_content_item__new(
        p_package_id,
        p_pretty_name,
        p_content,
	p_format,
        null,
        null,
        null,
        null,
        null
    );
end;
' language 'plpgsql';

drop function static_portal_content_item__new (integer,varchar,varchar,varchar,timestamptz,integer,varchar,integer);
create function static_portal_content_item__new (
    integer,                        -- package_id in static_portal_content.package_id%TYPE default null,
    varchar,                        -- pretty_name in static_portal_content.pretty_name%TYPE default null,
    varchar,                        -- content in static_portal_content.content%TYPE default null,
    varchar,                        -- format in static_portal_content.format%TYPE default text/html,
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
    p_format			    alias for $4;
    p_object_type                   alias for $5;
    p_creation_date                 alias for $6;
    p_creation_user                 alias for $7;
    p_creation_ip                   alias for $8;
    p_context_id                    alias for $9;
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
    (content_id, package_id, pretty_name, body, format)
    values
    (v_content_id, p_package_id, p_pretty_name, p_content, p_format);

    return v_content_id;
end;' language 'plpgsql';
