--
--  Copyright (C) 2001, 2002 MIT
--
--  This file is part of dotLRN.
--
--  dotLRN is free software; you can redistribute it and/or modify it under the
--  terms of the GNU General Public License as published by the Free Software
--  Foundation; either version 2 of the License, or (at your option) any later
--  version.
--
--  dotLRN is distributed in the hope that it will be useful, but WITHOUT ANY
--  WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
--  FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more
--  details.
--

--
-- static-core.sql
--
-- arjun@openforce.net
--
-- The core DM and API for static portal content
--
-- $Id$
--
--
-- PostGreSQL port samir@symphinity.com 11 July 2002
--

--
-- Objects
--


create function inline_0()
returns integer as '
begin

   perform acs_object_type__create_type (
        ''static_portal_content'',            -- object_type
        ''Static Content'',                            -- pretty_name
        ''Static Content'',                            -- pretty_plural
            ''acs_object'',                                    -- supertype
        ''static_portal_content'',            -- table_name
        ''content_id'',                                    -- id_column
                null,                                                        -- package_name
                ''f'',                                                    -- abstract_p
                null,                                                        -- type_extension_table
                null                                                        -- name_method
    );
    return 0;
end;' language 'plpgsql';

select inline_0();

drop function inline_0();


--
-- Datamodel
--
create table static_portal_content (
    content_id                  integer
                                                                constraint static_p_c_fk
                                references acs_objects(object_id)
                                constraint static_p_c_pk
                                primary key,
    package_id                  integer
                                not null,
    pretty_name                 varchar(100)
                                constraint static_p_c_pretty_name_nn
                                not null,
    body                        text
);



--
-- API
--

-- content is still a varchar, even though it is being used to put content
-- into body, a clob, because a varchar is what's being passed in from the
-- Tcl script.

create function static_portal_content_item__new (integer, varchar, varchar)
returns integer as '
declare
    p_package_id                    alias for $1;
    p_pretty_name                   alias for $2;
    p_content                       alias for $3;
begin
    return static_portal_content_item__new(
        p_package_id,
        p_pretty_name,
        p_content,
        null,
        null,
        null,
        null,
        null
    );
end;
' language 'plpgsql';

create function static_portal_content_item__new (
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

create  function static_portal_content_item__delete (
    integer        -- content_id    in static_portal_content.content_id%TYPE
)
returns integer    as '
declare
    p_content_id alias for $1;
begin
        delete from static_portal_content where content_id = p_content_id;
        acs_object__delete(p_content_id);
        return 0;
end;' language 'plpgsql';


--
-- perms
--

create function inline_1()
returns integer as '
begin

      perform acs_privilege__create_privilege(''static_portal_create'');
      perform acs_privilege__create_privilege(''static_portal_read'');
      perform acs_privilege__create_privilege(''static_portal_delete'');
      perform acs_privilege__create_privilege(''static_portal_modify'');
      perform acs_privilege__create_privilege(''static_portal_admin'');

      -- set up the admin priv

      perform acs_privilege__add_child(''static_portal_admin'', ''static_portal_create'');
      perform acs_privilege__add_child(''static_portal_admin'', ''static_portal_read'');
      perform acs_privilege__add_child(''static_portal_admin'', ''static_portal_delete'');
      perform acs_privilege__add_child(''static_portal_admin'', ''static_portal_modify'');

      -- bind privileges to global names

      perform acs_privilege__add_child(''create'',''static_portal_create'');
      perform acs_privilege__add_child(''read'',''static_portal_read'');
      perform acs_privilege__add_child(''delete'',''static_portal_delete'');
      perform acs_privilege__add_child(''write'',''static_portal_modify'');
      perform acs_privilege__add_child(''admin'',''static_portal_admin'');

    return 0;
end;' language 'plpgsql';

select inline_1();

drop function inline_1();

