--
--  Copyright (C) 2001, 2002 OpenForce, Inc.
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
-- Datamodel
--
create table static_portal_content (
    content_id                  constraint static_p_c_fk
                                references acs_objects(object_id)
                                constraint static_p_c_pk
                                primary key,
    instance_id                 integer
                                not null,
    pretty_name                 varchar2(100) 
                                constraint static_p_c_pretty_name_nn
                                not null,                            
    content                     varchar2(4000)
);


--
-- Objects
--
begin
    acs_object_type.create_type (
        supertype => 'acs_object',
        object_type => 'static_portal_content',
        pretty_name => 'Static Content',
        pretty_plural => 'Static Content',
        table_name => 'static_portal_content',
        id_column => 'content_id'
    );
end;
/
show errors

--
-- API
-- 

create or replace package static_portal_content_item 
as
    function new (
        instance_id     in static_portal_content.instance_id%TYPE default null,
        pretty_name     in static_portal_content.pretty_name%TYPE default null,
        content         in static_portal_content.content%TYPE default null,
        object_type     in acs_objects.object_type%TYPE default 'static_portal_content',
        creation_date   in acs_objects.creation_date%TYPE default sysdate,
        creation_user   in acs_objects.creation_user%TYPE default null,
        creation_ip     in acs_objects.creation_ip%TYPE default null,
        context_id      in acs_objects.context_id%TYPE default null
    ) return acs_objects.object_id%TYPE;

    procedure delete (
        content_id      in static_portal_content.content_id%TYPE
    );

end static_portal_content_item;
/ 
show errors

create or replace package body static_portal_content_item
as
    function new (
        instance_id     in static_portal_content.instance_id%TYPE default null,
        pretty_name     in static_portal_content.pretty_name%TYPE default null,
        content         in static_portal_content.content%TYPE default null,
        object_type     in acs_objects.object_type%TYPE default 'static_portal_content',
        creation_date   in acs_objects.creation_date%TYPE default sysdate,
        creation_user   in acs_objects.creation_user%TYPE default null,
        creation_ip     in acs_objects.creation_ip%TYPE default null,
        context_id      in acs_objects.context_id%TYPE default null
    ) return acs_objects.object_id%TYPE
    is
        v_content_id static_portal_content.content_id%TYPE;
    begin
        v_content_id := acs_object.new (
            object_type => object_type,
            creation_date => creation_date,
            creation_user => creation_user,
            creation_ip => creation_ip,
            context_id => context_id
	);

        insert into static_portal_content
        (content_id, instance_id, pretty_name, content)
        values
        (v_content_id, new.instance_id, new.pretty_name, new.content);

        return v_content_id;        
    end new;

    procedure delete (
        content_id    in static_portal_content.content_id%TYPE
    )        
    is
    begin 
        delete from static_portal_content where content_id = content_id;

        acs_object.delete(content_id);
    end delete;

end static_portal_content_item;
/
show errors

--
-- perms
--

begin 
      acs_privilege.create_privilege('static_portal_create');
      acs_privilege.create_privilege('static_portal_read');
      acs_privilege.create_privilege('static_portal_delete');
      acs_privilege.create_privilege('static_portal_modify');
      acs_privilege.create_privilege('static_portal_admin');

      -- set up the admin priv

      acs_privilege.add_child('static_portal_admin', 'static_portal_create');
      acs_privilege.add_child('static_portal_admin', 'static_portal_read');
      acs_privilege.add_child('static_portal_admin', 'static_portal_delete');
      acs_privilege.add_child('static_portal_admin', 'static_portal_modify');

      -- bind privileges to global names

      acs_privilege.add_child('create','static_portal_create');
      acs_privilege.add_child('read','static_portal_read');
      acs_privilege.add_child('delete','static_portal_delete');
      acs_privilege.add_child('write','static_portal_modify');
      acs_privilege.add_child('admin','static_portal_admin');  
end;
/
