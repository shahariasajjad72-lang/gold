--
-- PostgreSQL database dump
--

\restrict fXXhp7TSKEKRjJdfNtwNG4qfzdf8zPaLVU21CqpZvKtmGFxc8gOFrUnCDqBnamN

-- Dumped from database version 17.6
-- Dumped by pg_dump version 17.9 (Debian 17.9-1.pgdg13+1)

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET transaction_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: auth; Type: SCHEMA; Schema: -; Owner: supabase_admin
--

CREATE SCHEMA auth;


ALTER SCHEMA auth OWNER TO supabase_admin;

--
-- Name: extensions; Type: SCHEMA; Schema: -; Owner: postgres
--

CREATE SCHEMA extensions;


ALTER SCHEMA extensions OWNER TO postgres;

--
-- Name: graphql; Type: SCHEMA; Schema: -; Owner: supabase_admin
--

CREATE SCHEMA graphql;


ALTER SCHEMA graphql OWNER TO supabase_admin;

--
-- Name: graphql_public; Type: SCHEMA; Schema: -; Owner: supabase_admin
--

CREATE SCHEMA graphql_public;


ALTER SCHEMA graphql_public OWNER TO supabase_admin;

--
-- Name: pgbouncer; Type: SCHEMA; Schema: -; Owner: pgbouncer
--

CREATE SCHEMA pgbouncer;


ALTER SCHEMA pgbouncer OWNER TO pgbouncer;

--
-- Name: realtime; Type: SCHEMA; Schema: -; Owner: supabase_admin
--

CREATE SCHEMA realtime;


ALTER SCHEMA realtime OWNER TO supabase_admin;

--
-- Name: storage; Type: SCHEMA; Schema: -; Owner: supabase_admin
--

CREATE SCHEMA storage;


ALTER SCHEMA storage OWNER TO supabase_admin;

--
-- Name: vault; Type: SCHEMA; Schema: -; Owner: supabase_admin
--

CREATE SCHEMA vault;


ALTER SCHEMA vault OWNER TO supabase_admin;

--
-- Name: pg_graphql; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS pg_graphql WITH SCHEMA graphql;


--
-- Name: EXTENSION pg_graphql; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION pg_graphql IS 'pg_graphql: GraphQL support';


--
-- Name: pg_stat_statements; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS pg_stat_statements WITH SCHEMA extensions;


--
-- Name: EXTENSION pg_stat_statements; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION pg_stat_statements IS 'track planning and execution statistics of all SQL statements executed';


--
-- Name: pgcrypto; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS pgcrypto WITH SCHEMA extensions;


--
-- Name: EXTENSION pgcrypto; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION pgcrypto IS 'cryptographic functions';


--
-- Name: supabase_vault; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS supabase_vault WITH SCHEMA vault;


--
-- Name: EXTENSION supabase_vault; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION supabase_vault IS 'Supabase Vault Extension';


--
-- Name: uuid-ossp; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS "uuid-ossp" WITH SCHEMA extensions;


--
-- Name: EXTENSION "uuid-ossp"; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION "uuid-ossp" IS 'generate universally unique identifiers (UUIDs)';


--
-- Name: aal_level; Type: TYPE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TYPE auth.aal_level AS ENUM (
    'aal1',
    'aal2',
    'aal3'
);


ALTER TYPE auth.aal_level OWNER TO supabase_auth_admin;

--
-- Name: code_challenge_method; Type: TYPE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TYPE auth.code_challenge_method AS ENUM (
    's256',
    'plain'
);


ALTER TYPE auth.code_challenge_method OWNER TO supabase_auth_admin;

--
-- Name: factor_status; Type: TYPE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TYPE auth.factor_status AS ENUM (
    'unverified',
    'verified'
);


ALTER TYPE auth.factor_status OWNER TO supabase_auth_admin;

--
-- Name: factor_type; Type: TYPE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TYPE auth.factor_type AS ENUM (
    'totp',
    'webauthn',
    'phone'
);


ALTER TYPE auth.factor_type OWNER TO supabase_auth_admin;

--
-- Name: oauth_authorization_status; Type: TYPE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TYPE auth.oauth_authorization_status AS ENUM (
    'pending',
    'approved',
    'denied',
    'expired'
);


ALTER TYPE auth.oauth_authorization_status OWNER TO supabase_auth_admin;

--
-- Name: oauth_client_type; Type: TYPE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TYPE auth.oauth_client_type AS ENUM (
    'public',
    'confidential'
);


ALTER TYPE auth.oauth_client_type OWNER TO supabase_auth_admin;

--
-- Name: oauth_registration_type; Type: TYPE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TYPE auth.oauth_registration_type AS ENUM (
    'dynamic',
    'manual'
);


ALTER TYPE auth.oauth_registration_type OWNER TO supabase_auth_admin;

--
-- Name: oauth_response_type; Type: TYPE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TYPE auth.oauth_response_type AS ENUM (
    'code'
);


ALTER TYPE auth.oauth_response_type OWNER TO supabase_auth_admin;

--
-- Name: one_time_token_type; Type: TYPE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TYPE auth.one_time_token_type AS ENUM (
    'confirmation_token',
    'reauthentication_token',
    'recovery_token',
    'email_change_token_new',
    'email_change_token_current',
    'phone_change_token'
);


ALTER TYPE auth.one_time_token_type OWNER TO supabase_auth_admin;

--
-- Name: action; Type: TYPE; Schema: realtime; Owner: supabase_admin
--

CREATE TYPE realtime.action AS ENUM (
    'INSERT',
    'UPDATE',
    'DELETE',
    'TRUNCATE',
    'ERROR'
);


ALTER TYPE realtime.action OWNER TO supabase_admin;

--
-- Name: equality_op; Type: TYPE; Schema: realtime; Owner: supabase_admin
--

CREATE TYPE realtime.equality_op AS ENUM (
    'eq',
    'neq',
    'lt',
    'lte',
    'gt',
    'gte',
    'in'
);


ALTER TYPE realtime.equality_op OWNER TO supabase_admin;

--
-- Name: user_defined_filter; Type: TYPE; Schema: realtime; Owner: supabase_admin
--

CREATE TYPE realtime.user_defined_filter AS (
	column_name text,
	op realtime.equality_op,
	value text
);


ALTER TYPE realtime.user_defined_filter OWNER TO supabase_admin;

--
-- Name: wal_column; Type: TYPE; Schema: realtime; Owner: supabase_admin
--

CREATE TYPE realtime.wal_column AS (
	name text,
	type_name text,
	type_oid oid,
	value jsonb,
	is_pkey boolean,
	is_selectable boolean
);


ALTER TYPE realtime.wal_column OWNER TO supabase_admin;

--
-- Name: wal_rls; Type: TYPE; Schema: realtime; Owner: supabase_admin
--

CREATE TYPE realtime.wal_rls AS (
	wal jsonb,
	is_rls_enabled boolean,
	subscription_ids uuid[],
	errors text[]
);


ALTER TYPE realtime.wal_rls OWNER TO supabase_admin;

--
-- Name: buckettype; Type: TYPE; Schema: storage; Owner: supabase_storage_admin
--

CREATE TYPE storage.buckettype AS ENUM (
    'STANDARD',
    'ANALYTICS',
    'VECTOR'
);


ALTER TYPE storage.buckettype OWNER TO supabase_storage_admin;

--
-- Name: email(); Type: FUNCTION; Schema: auth; Owner: supabase_auth_admin
--

CREATE FUNCTION auth.email() RETURNS text
    LANGUAGE sql STABLE
    AS $$
  select 
  coalesce(
    nullif(current_setting('request.jwt.claim.email', true), ''),
    (nullif(current_setting('request.jwt.claims', true), '')::jsonb ->> 'email')
  )::text
$$;


ALTER FUNCTION auth.email() OWNER TO supabase_auth_admin;

--
-- Name: FUNCTION email(); Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON FUNCTION auth.email() IS 'Deprecated. Use auth.jwt() -> ''email'' instead.';


--
-- Name: jwt(); Type: FUNCTION; Schema: auth; Owner: supabase_auth_admin
--

CREATE FUNCTION auth.jwt() RETURNS jsonb
    LANGUAGE sql STABLE
    AS $$
  select 
    coalesce(
        nullif(current_setting('request.jwt.claim', true), ''),
        nullif(current_setting('request.jwt.claims', true), '')
    )::jsonb
$$;


ALTER FUNCTION auth.jwt() OWNER TO supabase_auth_admin;

--
-- Name: role(); Type: FUNCTION; Schema: auth; Owner: supabase_auth_admin
--

CREATE FUNCTION auth.role() RETURNS text
    LANGUAGE sql STABLE
    AS $$
  select 
  coalesce(
    nullif(current_setting('request.jwt.claim.role', true), ''),
    (nullif(current_setting('request.jwt.claims', true), '')::jsonb ->> 'role')
  )::text
$$;


ALTER FUNCTION auth.role() OWNER TO supabase_auth_admin;

--
-- Name: FUNCTION role(); Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON FUNCTION auth.role() IS 'Deprecated. Use auth.jwt() -> ''role'' instead.';


--
-- Name: uid(); Type: FUNCTION; Schema: auth; Owner: supabase_auth_admin
--

CREATE FUNCTION auth.uid() RETURNS uuid
    LANGUAGE sql STABLE
    AS $$
  select 
  coalesce(
    nullif(current_setting('request.jwt.claim.sub', true), ''),
    (nullif(current_setting('request.jwt.claims', true), '')::jsonb ->> 'sub')
  )::uuid
$$;


ALTER FUNCTION auth.uid() OWNER TO supabase_auth_admin;

--
-- Name: FUNCTION uid(); Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON FUNCTION auth.uid() IS 'Deprecated. Use auth.jwt() -> ''sub'' instead.';


--
-- Name: grant_pg_cron_access(); Type: FUNCTION; Schema: extensions; Owner: supabase_admin
--

CREATE FUNCTION extensions.grant_pg_cron_access() RETURNS event_trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
  IF EXISTS (
    SELECT
    FROM pg_event_trigger_ddl_commands() AS ev
    JOIN pg_extension AS ext
    ON ev.objid = ext.oid
    WHERE ext.extname = 'pg_cron'
  )
  THEN
    grant usage on schema cron to postgres with grant option;

    alter default privileges in schema cron grant all on tables to postgres with grant option;
    alter default privileges in schema cron grant all on functions to postgres with grant option;
    alter default privileges in schema cron grant all on sequences to postgres with grant option;

    alter default privileges for user supabase_admin in schema cron grant all
        on sequences to postgres with grant option;
    alter default privileges for user supabase_admin in schema cron grant all
        on tables to postgres with grant option;
    alter default privileges for user supabase_admin in schema cron grant all
        on functions to postgres with grant option;

    grant all privileges on all tables in schema cron to postgres with grant option;
    revoke all on table cron.job from postgres;
    grant select on table cron.job to postgres with grant option;
  END IF;
END;
$$;


ALTER FUNCTION extensions.grant_pg_cron_access() OWNER TO supabase_admin;

--
-- Name: FUNCTION grant_pg_cron_access(); Type: COMMENT; Schema: extensions; Owner: supabase_admin
--

COMMENT ON FUNCTION extensions.grant_pg_cron_access() IS 'Grants access to pg_cron';


--
-- Name: grant_pg_graphql_access(); Type: FUNCTION; Schema: extensions; Owner: supabase_admin
--

CREATE FUNCTION extensions.grant_pg_graphql_access() RETURNS event_trigger
    LANGUAGE plpgsql
    AS $_$
DECLARE
    func_is_graphql_resolve bool;
BEGIN
    func_is_graphql_resolve = (
        SELECT n.proname = 'resolve'
        FROM pg_event_trigger_ddl_commands() AS ev
        LEFT JOIN pg_catalog.pg_proc AS n
        ON ev.objid = n.oid
    );

    IF func_is_graphql_resolve
    THEN
        -- Update public wrapper to pass all arguments through to the pg_graphql resolve func
        DROP FUNCTION IF EXISTS graphql_public.graphql;
        create or replace function graphql_public.graphql(
            "operationName" text default null,
            query text default null,
            variables jsonb default null,
            extensions jsonb default null
        )
            returns jsonb
            language sql
        as $$
            select graphql.resolve(
                query := query,
                variables := coalesce(variables, '{}'),
                "operationName" := "operationName",
                extensions := extensions
            );
        $$;

        -- This hook executes when `graphql.resolve` is created. That is not necessarily the last
        -- function in the extension so we need to grant permissions on existing entities AND
        -- update default permissions to any others that are created after `graphql.resolve`
        grant usage on schema graphql to postgres, anon, authenticated, service_role;
        grant select on all tables in schema graphql to postgres, anon, authenticated, service_role;
        grant execute on all functions in schema graphql to postgres, anon, authenticated, service_role;
        grant all on all sequences in schema graphql to postgres, anon, authenticated, service_role;
        alter default privileges in schema graphql grant all on tables to postgres, anon, authenticated, service_role;
        alter default privileges in schema graphql grant all on functions to postgres, anon, authenticated, service_role;
        alter default privileges in schema graphql grant all on sequences to postgres, anon, authenticated, service_role;

        -- Allow postgres role to allow granting usage on graphql and graphql_public schemas to custom roles
        grant usage on schema graphql_public to postgres with grant option;
        grant usage on schema graphql to postgres with grant option;
    END IF;

END;
$_$;


ALTER FUNCTION extensions.grant_pg_graphql_access() OWNER TO supabase_admin;

--
-- Name: FUNCTION grant_pg_graphql_access(); Type: COMMENT; Schema: extensions; Owner: supabase_admin
--

COMMENT ON FUNCTION extensions.grant_pg_graphql_access() IS 'Grants access to pg_graphql';


--
-- Name: grant_pg_net_access(); Type: FUNCTION; Schema: extensions; Owner: supabase_admin
--

CREATE FUNCTION extensions.grant_pg_net_access() RETURNS event_trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
  IF EXISTS (
    SELECT 1
    FROM pg_event_trigger_ddl_commands() AS ev
    JOIN pg_extension AS ext
    ON ev.objid = ext.oid
    WHERE ext.extname = 'pg_net'
  )
  THEN
    IF NOT EXISTS (
      SELECT 1
      FROM pg_roles
      WHERE rolname = 'supabase_functions_admin'
    )
    THEN
      CREATE USER supabase_functions_admin NOINHERIT CREATEROLE LOGIN NOREPLICATION;
    END IF;

    GRANT USAGE ON SCHEMA net TO supabase_functions_admin, postgres, anon, authenticated, service_role;

    IF EXISTS (
      SELECT FROM pg_extension
      WHERE extname = 'pg_net'
      -- all versions in use on existing projects as of 2025-02-20
      -- version 0.12.0 onwards don't need these applied
      AND extversion IN ('0.2', '0.6', '0.7', '0.7.1', '0.8', '0.10.0', '0.11.0')
    ) THEN
      ALTER function net.http_get(url text, params jsonb, headers jsonb, timeout_milliseconds integer) SECURITY DEFINER;
      ALTER function net.http_post(url text, body jsonb, params jsonb, headers jsonb, timeout_milliseconds integer) SECURITY DEFINER;

      ALTER function net.http_get(url text, params jsonb, headers jsonb, timeout_milliseconds integer) SET search_path = net;
      ALTER function net.http_post(url text, body jsonb, params jsonb, headers jsonb, timeout_milliseconds integer) SET search_path = net;

      REVOKE ALL ON FUNCTION net.http_get(url text, params jsonb, headers jsonb, timeout_milliseconds integer) FROM PUBLIC;
      REVOKE ALL ON FUNCTION net.http_post(url text, body jsonb, params jsonb, headers jsonb, timeout_milliseconds integer) FROM PUBLIC;

      GRANT EXECUTE ON FUNCTION net.http_get(url text, params jsonb, headers jsonb, timeout_milliseconds integer) TO supabase_functions_admin, postgres, anon, authenticated, service_role;
      GRANT EXECUTE ON FUNCTION net.http_post(url text, body jsonb, params jsonb, headers jsonb, timeout_milliseconds integer) TO supabase_functions_admin, postgres, anon, authenticated, service_role;
    END IF;
  END IF;
END;
$$;


ALTER FUNCTION extensions.grant_pg_net_access() OWNER TO supabase_admin;

--
-- Name: FUNCTION grant_pg_net_access(); Type: COMMENT; Schema: extensions; Owner: supabase_admin
--

COMMENT ON FUNCTION extensions.grant_pg_net_access() IS 'Grants access to pg_net';


--
-- Name: pgrst_ddl_watch(); Type: FUNCTION; Schema: extensions; Owner: supabase_admin
--

CREATE FUNCTION extensions.pgrst_ddl_watch() RETURNS event_trigger
    LANGUAGE plpgsql
    AS $$
DECLARE
  cmd record;
BEGIN
  FOR cmd IN SELECT * FROM pg_event_trigger_ddl_commands()
  LOOP
    IF cmd.command_tag IN (
      'CREATE SCHEMA', 'ALTER SCHEMA'
    , 'CREATE TABLE', 'CREATE TABLE AS', 'SELECT INTO', 'ALTER TABLE'
    , 'CREATE FOREIGN TABLE', 'ALTER FOREIGN TABLE'
    , 'CREATE VIEW', 'ALTER VIEW'
    , 'CREATE MATERIALIZED VIEW', 'ALTER MATERIALIZED VIEW'
    , 'CREATE FUNCTION', 'ALTER FUNCTION'
    , 'CREATE TRIGGER'
    , 'CREATE TYPE', 'ALTER TYPE'
    , 'CREATE RULE'
    , 'COMMENT'
    )
    -- don't notify in case of CREATE TEMP table or other objects created on pg_temp
    AND cmd.schema_name is distinct from 'pg_temp'
    THEN
      NOTIFY pgrst, 'reload schema';
    END IF;
  END LOOP;
END; $$;


ALTER FUNCTION extensions.pgrst_ddl_watch() OWNER TO supabase_admin;

--
-- Name: pgrst_drop_watch(); Type: FUNCTION; Schema: extensions; Owner: supabase_admin
--

CREATE FUNCTION extensions.pgrst_drop_watch() RETURNS event_trigger
    LANGUAGE plpgsql
    AS $$
DECLARE
  obj record;
BEGIN
  FOR obj IN SELECT * FROM pg_event_trigger_dropped_objects()
  LOOP
    IF obj.object_type IN (
      'schema'
    , 'table'
    , 'foreign table'
    , 'view'
    , 'materialized view'
    , 'function'
    , 'trigger'
    , 'type'
    , 'rule'
    )
    AND obj.is_temporary IS false -- no pg_temp objects
    THEN
      NOTIFY pgrst, 'reload schema';
    END IF;
  END LOOP;
END; $$;


ALTER FUNCTION extensions.pgrst_drop_watch() OWNER TO supabase_admin;

--
-- Name: set_graphql_placeholder(); Type: FUNCTION; Schema: extensions; Owner: supabase_admin
--

CREATE FUNCTION extensions.set_graphql_placeholder() RETURNS event_trigger
    LANGUAGE plpgsql
    AS $_$
    DECLARE
    graphql_is_dropped bool;
    BEGIN
    graphql_is_dropped = (
        SELECT ev.schema_name = 'graphql_public'
        FROM pg_event_trigger_dropped_objects() AS ev
        WHERE ev.schema_name = 'graphql_public'
    );

    IF graphql_is_dropped
    THEN
        create or replace function graphql_public.graphql(
            "operationName" text default null,
            query text default null,
            variables jsonb default null,
            extensions jsonb default null
        )
            returns jsonb
            language plpgsql
        as $$
            DECLARE
                server_version float;
            BEGIN
                server_version = (SELECT (SPLIT_PART((select version()), ' ', 2))::float);

                IF server_version >= 14 THEN
                    RETURN jsonb_build_object(
                        'errors', jsonb_build_array(
                            jsonb_build_object(
                                'message', 'pg_graphql extension is not enabled.'
                            )
                        )
                    );
                ELSE
                    RETURN jsonb_build_object(
                        'errors', jsonb_build_array(
                            jsonb_build_object(
                                'message', 'pg_graphql is only available on projects running Postgres 14 onwards.'
                            )
                        )
                    );
                END IF;
            END;
        $$;
    END IF;

    END;
$_$;


ALTER FUNCTION extensions.set_graphql_placeholder() OWNER TO supabase_admin;

--
-- Name: FUNCTION set_graphql_placeholder(); Type: COMMENT; Schema: extensions; Owner: supabase_admin
--

COMMENT ON FUNCTION extensions.set_graphql_placeholder() IS 'Reintroduces placeholder function for graphql_public.graphql';


--
-- Name: get_auth(text); Type: FUNCTION; Schema: pgbouncer; Owner: supabase_admin
--

CREATE FUNCTION pgbouncer.get_auth(p_usename text) RETURNS TABLE(username text, password text)
    LANGUAGE plpgsql SECURITY DEFINER
    SET search_path TO ''
    AS $_$
  BEGIN
      RAISE DEBUG 'PgBouncer auth request: %', p_usename;

      RETURN QUERY
      SELECT
          rolname::text,
          CASE WHEN rolvaliduntil < now()
              THEN null
              ELSE rolpassword::text
          END
      FROM pg_authid
      WHERE rolname=$1 and rolcanlogin;
  END;
  $_$;


ALTER FUNCTION pgbouncer.get_auth(p_usename text) OWNER TO supabase_admin;

--
-- Name: rls_auto_enable(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.rls_auto_enable() RETURNS event_trigger
    LANGUAGE plpgsql SECURITY DEFINER
    SET search_path TO 'pg_catalog'
    AS $$
DECLARE
  cmd record;
BEGIN
  FOR cmd IN
    SELECT *
    FROM pg_event_trigger_ddl_commands()
    WHERE command_tag IN ('CREATE TABLE', 'CREATE TABLE AS', 'SELECT INTO')
      AND object_type IN ('table','partitioned table')
  LOOP
     IF cmd.schema_name IS NOT NULL AND cmd.schema_name IN ('public') AND cmd.schema_name NOT IN ('pg_catalog','information_schema') AND cmd.schema_name NOT LIKE 'pg_toast%' AND cmd.schema_name NOT LIKE 'pg_temp%' THEN
      BEGIN
        EXECUTE format('alter table if exists %s enable row level security', cmd.object_identity);
        RAISE LOG 'rls_auto_enable: enabled RLS on %', cmd.object_identity;
      EXCEPTION
        WHEN OTHERS THEN
          RAISE LOG 'rls_auto_enable: failed to enable RLS on %', cmd.object_identity;
      END;
     ELSE
        RAISE LOG 'rls_auto_enable: skip % (either system schema or not in enforced list: %.)', cmd.object_identity, cmd.schema_name;
     END IF;
  END LOOP;
END;
$$;


ALTER FUNCTION public.rls_auto_enable() OWNER TO postgres;

--
-- Name: apply_rls(jsonb, integer); Type: FUNCTION; Schema: realtime; Owner: supabase_admin
--

CREATE FUNCTION realtime.apply_rls(wal jsonb, max_record_bytes integer DEFAULT (1024 * 1024)) RETURNS SETOF realtime.wal_rls
    LANGUAGE plpgsql
    AS $$
declare
-- Regclass of the table e.g. public.notes
entity_ regclass = (quote_ident(wal ->> 'schema') || '.' || quote_ident(wal ->> 'table'))::regclass;

-- I, U, D, T: insert, update ...
action realtime.action = (
    case wal ->> 'action'
        when 'I' then 'INSERT'
        when 'U' then 'UPDATE'
        when 'D' then 'DELETE'
        else 'ERROR'
    end
);

-- Is row level security enabled for the table
is_rls_enabled bool = relrowsecurity from pg_class where oid = entity_;

subscriptions realtime.subscription[] = array_agg(subs)
    from
        realtime.subscription subs
    where
        subs.entity = entity_
        -- Filter by action early - only get subscriptions interested in this action
        -- action_filter column can be: '*' (all), 'INSERT', 'UPDATE', or 'DELETE'
        and (subs.action_filter = '*' or subs.action_filter = action::text);

-- Subscription vars
roles regrole[] = array_agg(distinct us.claims_role::text)
    from
        unnest(subscriptions) us;

working_role regrole;
claimed_role regrole;
claims jsonb;

subscription_id uuid;
subscription_has_access bool;
visible_to_subscription_ids uuid[] = '{}';

-- structured info for wal's columns
columns realtime.wal_column[];
-- previous identity values for update/delete
old_columns realtime.wal_column[];

error_record_exceeds_max_size boolean = octet_length(wal::text) > max_record_bytes;

-- Primary jsonb output for record
output jsonb;

begin
perform set_config('role', null, true);

columns =
    array_agg(
        (
            x->>'name',
            x->>'type',
            x->>'typeoid',
            realtime.cast(
                (x->'value') #>> '{}',
                coalesce(
                    (x->>'typeoid')::regtype, -- null when wal2json version <= 2.4
                    (x->>'type')::regtype
                )
            ),
            (pks ->> 'name') is not null,
            true
        )::realtime.wal_column
    )
    from
        jsonb_array_elements(wal -> 'columns') x
        left join jsonb_array_elements(wal -> 'pk') pks
            on (x ->> 'name') = (pks ->> 'name');

old_columns =
    array_agg(
        (
            x->>'name',
            x->>'type',
            x->>'typeoid',
            realtime.cast(
                (x->'value') #>> '{}',
                coalesce(
                    (x->>'typeoid')::regtype, -- null when wal2json version <= 2.4
                    (x->>'type')::regtype
                )
            ),
            (pks ->> 'name') is not null,
            true
        )::realtime.wal_column
    )
    from
        jsonb_array_elements(wal -> 'identity') x
        left join jsonb_array_elements(wal -> 'pk') pks
            on (x ->> 'name') = (pks ->> 'name');

for working_role in select * from unnest(roles) loop

    -- Update `is_selectable` for columns and old_columns
    columns =
        array_agg(
            (
                c.name,
                c.type_name,
                c.type_oid,
                c.value,
                c.is_pkey,
                pg_catalog.has_column_privilege(working_role, entity_, c.name, 'SELECT')
            )::realtime.wal_column
        )
        from
            unnest(columns) c;

    old_columns =
            array_agg(
                (
                    c.name,
                    c.type_name,
                    c.type_oid,
                    c.value,
                    c.is_pkey,
                    pg_catalog.has_column_privilege(working_role, entity_, c.name, 'SELECT')
                )::realtime.wal_column
            )
            from
                unnest(old_columns) c;

    if action <> 'DELETE' and count(1) = 0 from unnest(columns) c where c.is_pkey then
        return next (
            jsonb_build_object(
                'schema', wal ->> 'schema',
                'table', wal ->> 'table',
                'type', action
            ),
            is_rls_enabled,
            -- subscriptions is already filtered by entity
            (select array_agg(s.subscription_id) from unnest(subscriptions) as s where claims_role = working_role),
            array['Error 400: Bad Request, no primary key']
        )::realtime.wal_rls;

    -- The claims role does not have SELECT permission to the primary key of entity
    elsif action <> 'DELETE' and sum(c.is_selectable::int) <> count(1) from unnest(columns) c where c.is_pkey then
        return next (
            jsonb_build_object(
                'schema', wal ->> 'schema',
                'table', wal ->> 'table',
                'type', action
            ),
            is_rls_enabled,
            (select array_agg(s.subscription_id) from unnest(subscriptions) as s where claims_role = working_role),
            array['Error 401: Unauthorized']
        )::realtime.wal_rls;

    else
        output = jsonb_build_object(
            'schema', wal ->> 'schema',
            'table', wal ->> 'table',
            'type', action,
            'commit_timestamp', to_char(
                ((wal ->> 'timestamp')::timestamptz at time zone 'utc'),
                'YYYY-MM-DD"T"HH24:MI:SS.MS"Z"'
            ),
            'columns', (
                select
                    jsonb_agg(
                        jsonb_build_object(
                            'name', pa.attname,
                            'type', pt.typname
                        )
                        order by pa.attnum asc
                    )
                from
                    pg_attribute pa
                    join pg_type pt
                        on pa.atttypid = pt.oid
                where
                    attrelid = entity_
                    and attnum > 0
                    and pg_catalog.has_column_privilege(working_role, entity_, pa.attname, 'SELECT')
            )
        )
        -- Add "record" key for insert and update
        || case
            when action in ('INSERT', 'UPDATE') then
                jsonb_build_object(
                    'record',
                    (
                        select
                            jsonb_object_agg(
                                -- if unchanged toast, get column name and value from old record
                                coalesce((c).name, (oc).name),
                                case
                                    when (c).name is null then (oc).value
                                    else (c).value
                                end
                            )
                        from
                            unnest(columns) c
                            full outer join unnest(old_columns) oc
                                on (c).name = (oc).name
                        where
                            coalesce((c).is_selectable, (oc).is_selectable)
                            and ( not error_record_exceeds_max_size or (octet_length((c).value::text) <= 64))
                    )
                )
            else '{}'::jsonb
        end
        -- Add "old_record" key for update and delete
        || case
            when action = 'UPDATE' then
                jsonb_build_object(
                        'old_record',
                        (
                            select jsonb_object_agg((c).name, (c).value)
                            from unnest(old_columns) c
                            where
                                (c).is_selectable
                                and ( not error_record_exceeds_max_size or (octet_length((c).value::text) <= 64))
                        )
                    )
            when action = 'DELETE' then
                jsonb_build_object(
                    'old_record',
                    (
                        select jsonb_object_agg((c).name, (c).value)
                        from unnest(old_columns) c
                        where
                            (c).is_selectable
                            and ( not error_record_exceeds_max_size or (octet_length((c).value::text) <= 64))
                            and ( not is_rls_enabled or (c).is_pkey ) -- if RLS enabled, we can't secure deletes so filter to pkey
                    )
                )
            else '{}'::jsonb
        end;

        -- Create the prepared statement
        if is_rls_enabled and action <> 'DELETE' then
            if (select 1 from pg_prepared_statements where name = 'walrus_rls_stmt' limit 1) > 0 then
                deallocate walrus_rls_stmt;
            end if;
            execute realtime.build_prepared_statement_sql('walrus_rls_stmt', entity_, columns);
        end if;

        visible_to_subscription_ids = '{}';

        for subscription_id, claims in (
                select
                    subs.subscription_id,
                    subs.claims
                from
                    unnest(subscriptions) subs
                where
                    subs.entity = entity_
                    and subs.claims_role = working_role
                    and (
                        realtime.is_visible_through_filters(columns, subs.filters)
                        or (
                          action = 'DELETE'
                          and realtime.is_visible_through_filters(old_columns, subs.filters)
                        )
                    )
        ) loop

            if not is_rls_enabled or action = 'DELETE' then
                visible_to_subscription_ids = visible_to_subscription_ids || subscription_id;
            else
                -- Check if RLS allows the role to see the record
                perform
                    -- Trim leading and trailing quotes from working_role because set_config
                    -- doesn't recognize the role as valid if they are included
                    set_config('role', trim(both '"' from working_role::text), true),
                    set_config('request.jwt.claims', claims::text, true);

                execute 'execute walrus_rls_stmt' into subscription_has_access;

                if subscription_has_access then
                    visible_to_subscription_ids = visible_to_subscription_ids || subscription_id;
                end if;
            end if;
        end loop;

        perform set_config('role', null, true);

        return next (
            output,
            is_rls_enabled,
            visible_to_subscription_ids,
            case
                when error_record_exceeds_max_size then array['Error 413: Payload Too Large']
                else '{}'
            end
        )::realtime.wal_rls;

    end if;
end loop;

perform set_config('role', null, true);
end;
$$;


ALTER FUNCTION realtime.apply_rls(wal jsonb, max_record_bytes integer) OWNER TO supabase_admin;

--
-- Name: broadcast_changes(text, text, text, text, text, record, record, text); Type: FUNCTION; Schema: realtime; Owner: supabase_admin
--

CREATE FUNCTION realtime.broadcast_changes(topic_name text, event_name text, operation text, table_name text, table_schema text, new record, old record, level text DEFAULT 'ROW'::text) RETURNS void
    LANGUAGE plpgsql
    AS $$
DECLARE
    -- Declare a variable to hold the JSONB representation of the row
    row_data jsonb := '{}'::jsonb;
BEGIN
    IF level = 'STATEMENT' THEN
        RAISE EXCEPTION 'function can only be triggered for each row, not for each statement';
    END IF;
    -- Check the operation type and handle accordingly
    IF operation = 'INSERT' OR operation = 'UPDATE' OR operation = 'DELETE' THEN
        row_data := jsonb_build_object('old_record', OLD, 'record', NEW, 'operation', operation, 'table', table_name, 'schema', table_schema);
        PERFORM realtime.send (row_data, event_name, topic_name);
    ELSE
        RAISE EXCEPTION 'Unexpected operation type: %', operation;
    END IF;
EXCEPTION
    WHEN OTHERS THEN
        RAISE EXCEPTION 'Failed to process the row: %', SQLERRM;
END;

$$;


ALTER FUNCTION realtime.broadcast_changes(topic_name text, event_name text, operation text, table_name text, table_schema text, new record, old record, level text) OWNER TO supabase_admin;

--
-- Name: build_prepared_statement_sql(text, regclass, realtime.wal_column[]); Type: FUNCTION; Schema: realtime; Owner: supabase_admin
--

CREATE FUNCTION realtime.build_prepared_statement_sql(prepared_statement_name text, entity regclass, columns realtime.wal_column[]) RETURNS text
    LANGUAGE sql
    AS $$
      /*
      Builds a sql string that, if executed, creates a prepared statement to
      tests retrive a row from *entity* by its primary key columns.
      Example
          select realtime.build_prepared_statement_sql('public.notes', '{"id"}'::text[], '{"bigint"}'::text[])
      */
          select
      'prepare ' || prepared_statement_name || ' as
          select
              exists(
                  select
                      1
                  from
                      ' || entity || '
                  where
                      ' || string_agg(quote_ident(pkc.name) || '=' || quote_nullable(pkc.value #>> '{}') , ' and ') || '
              )'
          from
              unnest(columns) pkc
          where
              pkc.is_pkey
          group by
              entity
      $$;


ALTER FUNCTION realtime.build_prepared_statement_sql(prepared_statement_name text, entity regclass, columns realtime.wal_column[]) OWNER TO supabase_admin;

--
-- Name: cast(text, regtype); Type: FUNCTION; Schema: realtime; Owner: supabase_admin
--

CREATE FUNCTION realtime."cast"(val text, type_ regtype) RETURNS jsonb
    LANGUAGE plpgsql IMMUTABLE
    AS $$
declare
  res jsonb;
begin
  if type_::text = 'bytea' then
    return to_jsonb(val);
  end if;
  execute format('select to_jsonb(%L::'|| type_::text || ')', val) into res;
  return res;
end
$$;


ALTER FUNCTION realtime."cast"(val text, type_ regtype) OWNER TO supabase_admin;

--
-- Name: check_equality_op(realtime.equality_op, regtype, text, text); Type: FUNCTION; Schema: realtime; Owner: supabase_admin
--

CREATE FUNCTION realtime.check_equality_op(op realtime.equality_op, type_ regtype, val_1 text, val_2 text) RETURNS boolean
    LANGUAGE plpgsql IMMUTABLE
    AS $$
      /*
      Casts *val_1* and *val_2* as type *type_* and check the *op* condition for truthiness
      */
      declare
          op_symbol text = (
              case
                  when op = 'eq' then '='
                  when op = 'neq' then '!='
                  when op = 'lt' then '<'
                  when op = 'lte' then '<='
                  when op = 'gt' then '>'
                  when op = 'gte' then '>='
                  when op = 'in' then '= any'
                  else 'UNKNOWN OP'
              end
          );
          res boolean;
      begin
          execute format(
              'select %L::'|| type_::text || ' ' || op_symbol
              || ' ( %L::'
              || (
                  case
                      when op = 'in' then type_::text || '[]'
                      else type_::text end
              )
              || ')', val_1, val_2) into res;
          return res;
      end;
      $$;


ALTER FUNCTION realtime.check_equality_op(op realtime.equality_op, type_ regtype, val_1 text, val_2 text) OWNER TO supabase_admin;

--
-- Name: is_visible_through_filters(realtime.wal_column[], realtime.user_defined_filter[]); Type: FUNCTION; Schema: realtime; Owner: supabase_admin
--

CREATE FUNCTION realtime.is_visible_through_filters(columns realtime.wal_column[], filters realtime.user_defined_filter[]) RETURNS boolean
    LANGUAGE sql IMMUTABLE
    AS $_$
    /*
    Should the record be visible (true) or filtered out (false) after *filters* are applied
    */
        select
            -- Default to allowed when no filters present
            $2 is null -- no filters. this should not happen because subscriptions has a default
            or array_length($2, 1) is null -- array length of an empty array is null
            or bool_and(
                coalesce(
                    realtime.check_equality_op(
                        op:=f.op,
                        type_:=coalesce(
                            col.type_oid::regtype, -- null when wal2json version <= 2.4
                            col.type_name::regtype
                        ),
                        -- cast jsonb to text
                        val_1:=col.value #>> '{}',
                        val_2:=f.value
                    ),
                    false -- if null, filter does not match
                )
            )
        from
            unnest(filters) f
            join unnest(columns) col
                on f.column_name = col.name;
    $_$;


ALTER FUNCTION realtime.is_visible_through_filters(columns realtime.wal_column[], filters realtime.user_defined_filter[]) OWNER TO supabase_admin;

--
-- Name: list_changes(name, name, integer, integer); Type: FUNCTION; Schema: realtime; Owner: supabase_admin
--

CREATE FUNCTION realtime.list_changes(publication name, slot_name name, max_changes integer, max_record_bytes integer) RETURNS TABLE(wal jsonb, is_rls_enabled boolean, subscription_ids uuid[], errors text[], slot_changes_count bigint)
    LANGUAGE sql
    SET log_min_messages TO 'fatal'
    AS $$
  WITH pub AS (
    SELECT
      concat_ws(
        ',',
        CASE WHEN bool_or(pubinsert) THEN 'insert' ELSE NULL END,
        CASE WHEN bool_or(pubupdate) THEN 'update' ELSE NULL END,
        CASE WHEN bool_or(pubdelete) THEN 'delete' ELSE NULL END
      ) AS w2j_actions,
      coalesce(
        string_agg(
          realtime.quote_wal2json(format('%I.%I', schemaname, tablename)::regclass),
          ','
        ) filter (WHERE ppt.tablename IS NOT NULL AND ppt.tablename NOT LIKE '% %'),
        ''
      ) AS w2j_add_tables
    FROM pg_publication pp
    LEFT JOIN pg_publication_tables ppt ON pp.pubname = ppt.pubname
    WHERE pp.pubname = publication
    GROUP BY pp.pubname
    LIMIT 1
  ),
  -- MATERIALIZED ensures pg_logical_slot_get_changes is called exactly once
  w2j AS MATERIALIZED (
    SELECT x.*, pub.w2j_add_tables
    FROM pub,
         pg_logical_slot_get_changes(
           slot_name, null, max_changes,
           'include-pk', 'true',
           'include-transaction', 'false',
           'include-timestamp', 'true',
           'include-type-oids', 'true',
           'format-version', '2',
           'actions', pub.w2j_actions,
           'add-tables', pub.w2j_add_tables
         ) x
  ),
  -- Count raw slot entries before apply_rls/subscription filter
  slot_count AS (
    SELECT count(*)::bigint AS cnt
    FROM w2j
    WHERE w2j.w2j_add_tables <> ''
  ),
  -- Apply RLS and filter as before
  rls_filtered AS (
    SELECT xyz.wal, xyz.is_rls_enabled, xyz.subscription_ids, xyz.errors
    FROM w2j,
         realtime.apply_rls(
           wal := w2j.data::jsonb,
           max_record_bytes := max_record_bytes
         ) xyz(wal, is_rls_enabled, subscription_ids, errors)
    WHERE w2j.w2j_add_tables <> ''
      AND xyz.subscription_ids[1] IS NOT NULL
  )
  -- Real rows with slot count attached
  SELECT rf.wal, rf.is_rls_enabled, rf.subscription_ids, rf.errors, sc.cnt
  FROM rls_filtered rf, slot_count sc

  UNION ALL

  -- Sentinel row: always returned when no real rows exist so Elixir can
  -- always read slot_changes_count. Identified by wal IS NULL.
  SELECT null, null, null, null, sc.cnt
  FROM slot_count sc
  WHERE NOT EXISTS (SELECT 1 FROM rls_filtered)
$$;


ALTER FUNCTION realtime.list_changes(publication name, slot_name name, max_changes integer, max_record_bytes integer) OWNER TO supabase_admin;

--
-- Name: quote_wal2json(regclass); Type: FUNCTION; Schema: realtime; Owner: supabase_admin
--

CREATE FUNCTION realtime.quote_wal2json(entity regclass) RETURNS text
    LANGUAGE sql IMMUTABLE STRICT
    AS $$
      select
        (
          select string_agg('' || ch,'')
          from unnest(string_to_array(nsp.nspname::text, null)) with ordinality x(ch, idx)
          where
            not (x.idx = 1 and x.ch = '"')
            and not (
              x.idx = array_length(string_to_array(nsp.nspname::text, null), 1)
              and x.ch = '"'
            )
        )
        || '.'
        || (
          select string_agg('' || ch,'')
          from unnest(string_to_array(pc.relname::text, null)) with ordinality x(ch, idx)
          where
            not (x.idx = 1 and x.ch = '"')
            and not (
              x.idx = array_length(string_to_array(nsp.nspname::text, null), 1)
              and x.ch = '"'
            )
          )
      from
        pg_class pc
        join pg_namespace nsp
          on pc.relnamespace = nsp.oid
      where
        pc.oid = entity
    $$;


ALTER FUNCTION realtime.quote_wal2json(entity regclass) OWNER TO supabase_admin;

--
-- Name: send(jsonb, text, text, boolean); Type: FUNCTION; Schema: realtime; Owner: supabase_admin
--

CREATE FUNCTION realtime.send(payload jsonb, event text, topic text, private boolean DEFAULT true) RETURNS void
    LANGUAGE plpgsql
    AS $$
DECLARE
  generated_id uuid;
  final_payload jsonb;
BEGIN
  BEGIN
    -- Generate a new UUID for the id
    generated_id := gen_random_uuid();

    -- Check if payload has an 'id' key, if not, add the generated UUID
    IF payload ? 'id' THEN
      final_payload := payload;
    ELSE
      final_payload := jsonb_set(payload, '{id}', to_jsonb(generated_id));
    END IF;

    -- Set the topic configuration
    EXECUTE format('SET LOCAL realtime.topic TO %L', topic);

    -- Attempt to insert the message
    INSERT INTO realtime.messages (id, payload, event, topic, private, extension)
    VALUES (generated_id, final_payload, event, topic, private, 'broadcast');
  EXCEPTION
    WHEN OTHERS THEN
      -- Capture and notify the error
      RAISE WARNING 'ErrorSendingBroadcastMessage: %', SQLERRM;
  END;
END;
$$;


ALTER FUNCTION realtime.send(payload jsonb, event text, topic text, private boolean) OWNER TO supabase_admin;

--
-- Name: subscription_check_filters(); Type: FUNCTION; Schema: realtime; Owner: supabase_admin
--

CREATE FUNCTION realtime.subscription_check_filters() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
    /*
    Validates that the user defined filters for a subscription:
    - refer to valid columns that the claimed role may access
    - values are coercable to the correct column type
    */
    declare
        col_names text[] = coalesce(
                array_agg(c.column_name order by c.ordinal_position),
                '{}'::text[]
            )
            from
                information_schema.columns c
            where
                format('%I.%I', c.table_schema, c.table_name)::regclass = new.entity
                and pg_catalog.has_column_privilege(
                    (new.claims ->> 'role'),
                    format('%I.%I', c.table_schema, c.table_name)::regclass,
                    c.column_name,
                    'SELECT'
                );
        filter realtime.user_defined_filter;
        col_type regtype;

        in_val jsonb;
    begin
        for filter in select * from unnest(new.filters) loop
            -- Filtered column is valid
            if not filter.column_name = any(col_names) then
                raise exception 'invalid column for filter %', filter.column_name;
            end if;

            -- Type is sanitized and safe for string interpolation
            col_type = (
                select atttypid::regtype
                from pg_catalog.pg_attribute
                where attrelid = new.entity
                      and attname = filter.column_name
            );
            if col_type is null then
                raise exception 'failed to lookup type for column %', filter.column_name;
            end if;

            -- Set maximum number of entries for in filter
            if filter.op = 'in'::realtime.equality_op then
                in_val = realtime.cast(filter.value, (col_type::text || '[]')::regtype);
                if coalesce(jsonb_array_length(in_val), 0) > 100 then
                    raise exception 'too many values for `in` filter. Maximum 100';
                end if;
            else
                -- raises an exception if value is not coercable to type
                perform realtime.cast(filter.value, col_type);
            end if;

        end loop;

        -- Apply consistent order to filters so the unique constraint on
        -- (subscription_id, entity, filters) can't be tricked by a different filter order
        new.filters = coalesce(
            array_agg(f order by f.column_name, f.op, f.value),
            '{}'
        ) from unnest(new.filters) f;

        return new;
    end;
    $$;


ALTER FUNCTION realtime.subscription_check_filters() OWNER TO supabase_admin;

--
-- Name: to_regrole(text); Type: FUNCTION; Schema: realtime; Owner: supabase_admin
--

CREATE FUNCTION realtime.to_regrole(role_name text) RETURNS regrole
    LANGUAGE sql IMMUTABLE
    AS $$ select role_name::regrole $$;


ALTER FUNCTION realtime.to_regrole(role_name text) OWNER TO supabase_admin;

--
-- Name: topic(); Type: FUNCTION; Schema: realtime; Owner: supabase_realtime_admin
--

CREATE FUNCTION realtime.topic() RETURNS text
    LANGUAGE sql STABLE
    AS $$
select nullif(current_setting('realtime.topic', true), '')::text;
$$;


ALTER FUNCTION realtime.topic() OWNER TO supabase_realtime_admin;

--
-- Name: allow_any_operation(text[]); Type: FUNCTION; Schema: storage; Owner: supabase_storage_admin
--

CREATE FUNCTION storage.allow_any_operation(expected_operations text[]) RETURNS boolean
    LANGUAGE sql STABLE
    AS $$
  WITH current_operation AS (
    SELECT storage.operation() AS raw_operation
  ),
  normalized AS (
    SELECT CASE
      WHEN raw_operation LIKE 'storage.%' THEN substr(raw_operation, 9)
      ELSE raw_operation
    END AS current_operation
    FROM current_operation
  )
  SELECT EXISTS (
    SELECT 1
    FROM normalized n
    CROSS JOIN LATERAL unnest(expected_operations) AS expected_operation
    WHERE expected_operation IS NOT NULL
      AND expected_operation <> ''
      AND n.current_operation = CASE
        WHEN expected_operation LIKE 'storage.%' THEN substr(expected_operation, 9)
        ELSE expected_operation
      END
  );
$$;


ALTER FUNCTION storage.allow_any_operation(expected_operations text[]) OWNER TO supabase_storage_admin;

--
-- Name: allow_only_operation(text); Type: FUNCTION; Schema: storage; Owner: supabase_storage_admin
--

CREATE FUNCTION storage.allow_only_operation(expected_operation text) RETURNS boolean
    LANGUAGE sql STABLE
    AS $$
  WITH current_operation AS (
    SELECT storage.operation() AS raw_operation
  ),
  normalized AS (
    SELECT
      CASE
        WHEN raw_operation LIKE 'storage.%' THEN substr(raw_operation, 9)
        ELSE raw_operation
      END AS current_operation,
      CASE
        WHEN expected_operation LIKE 'storage.%' THEN substr(expected_operation, 9)
        ELSE expected_operation
      END AS requested_operation
    FROM current_operation
  )
  SELECT CASE
    WHEN requested_operation IS NULL OR requested_operation = '' THEN FALSE
    ELSE COALESCE(current_operation = requested_operation, FALSE)
  END
  FROM normalized;
$$;


ALTER FUNCTION storage.allow_only_operation(expected_operation text) OWNER TO supabase_storage_admin;

--
-- Name: can_insert_object(text, text, uuid, jsonb); Type: FUNCTION; Schema: storage; Owner: supabase_storage_admin
--

CREATE FUNCTION storage.can_insert_object(bucketid text, name text, owner uuid, metadata jsonb) RETURNS void
    LANGUAGE plpgsql
    AS $$
BEGIN
  INSERT INTO "storage"."objects" ("bucket_id", "name", "owner", "metadata") VALUES (bucketid, name, owner, metadata);
  -- hack to rollback the successful insert
  RAISE sqlstate 'PT200' using
  message = 'ROLLBACK',
  detail = 'rollback successful insert';
END
$$;


ALTER FUNCTION storage.can_insert_object(bucketid text, name text, owner uuid, metadata jsonb) OWNER TO supabase_storage_admin;

--
-- Name: enforce_bucket_name_length(); Type: FUNCTION; Schema: storage; Owner: supabase_storage_admin
--

CREATE FUNCTION storage.enforce_bucket_name_length() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
begin
    if length(new.name) > 100 then
        raise exception 'bucket name "%" is too long (% characters). Max is 100.', new.name, length(new.name);
    end if;
    return new;
end;
$$;


ALTER FUNCTION storage.enforce_bucket_name_length() OWNER TO supabase_storage_admin;

--
-- Name: extension(text); Type: FUNCTION; Schema: storage; Owner: supabase_storage_admin
--

CREATE FUNCTION storage.extension(name text) RETURNS text
    LANGUAGE plpgsql
    AS $$
DECLARE
_parts text[];
_filename text;
BEGIN
	select string_to_array(name, '/') into _parts;
	select _parts[array_length(_parts,1)] into _filename;
	-- @todo return the last part instead of 2
	return reverse(split_part(reverse(_filename), '.', 1));
END
$$;


ALTER FUNCTION storage.extension(name text) OWNER TO supabase_storage_admin;

--
-- Name: filename(text); Type: FUNCTION; Schema: storage; Owner: supabase_storage_admin
--

CREATE FUNCTION storage.filename(name text) RETURNS text
    LANGUAGE plpgsql
    AS $$
DECLARE
_parts text[];
BEGIN
	select string_to_array(name, '/') into _parts;
	return _parts[array_length(_parts,1)];
END
$$;


ALTER FUNCTION storage.filename(name text) OWNER TO supabase_storage_admin;

--
-- Name: foldername(text); Type: FUNCTION; Schema: storage; Owner: supabase_storage_admin
--

CREATE FUNCTION storage.foldername(name text) RETURNS text[]
    LANGUAGE plpgsql
    AS $$
DECLARE
_parts text[];
BEGIN
	select string_to_array(name, '/') into _parts;
	return _parts[1:array_length(_parts,1)-1];
END
$$;


ALTER FUNCTION storage.foldername(name text) OWNER TO supabase_storage_admin;

--
-- Name: get_common_prefix(text, text, text); Type: FUNCTION; Schema: storage; Owner: supabase_storage_admin
--

CREATE FUNCTION storage.get_common_prefix(p_key text, p_prefix text, p_delimiter text) RETURNS text
    LANGUAGE sql IMMUTABLE
    AS $$
SELECT CASE
    WHEN position(p_delimiter IN substring(p_key FROM length(p_prefix) + 1)) > 0
    THEN left(p_key, length(p_prefix) + position(p_delimiter IN substring(p_key FROM length(p_prefix) + 1)))
    ELSE NULL
END;
$$;


ALTER FUNCTION storage.get_common_prefix(p_key text, p_prefix text, p_delimiter text) OWNER TO supabase_storage_admin;

--
-- Name: get_size_by_bucket(); Type: FUNCTION; Schema: storage; Owner: supabase_storage_admin
--

CREATE FUNCTION storage.get_size_by_bucket() RETURNS TABLE(size bigint, bucket_id text)
    LANGUAGE plpgsql
    AS $$
BEGIN
    return query
        select sum((metadata->>'size')::int) as size, obj.bucket_id
        from "storage".objects as obj
        group by obj.bucket_id;
END
$$;


ALTER FUNCTION storage.get_size_by_bucket() OWNER TO supabase_storage_admin;

--
-- Name: list_multipart_uploads_with_delimiter(text, text, text, integer, text, text); Type: FUNCTION; Schema: storage; Owner: supabase_storage_admin
--

CREATE FUNCTION storage.list_multipart_uploads_with_delimiter(bucket_id text, prefix_param text, delimiter_param text, max_keys integer DEFAULT 100, next_key_token text DEFAULT ''::text, next_upload_token text DEFAULT ''::text) RETURNS TABLE(key text, id text, created_at timestamp with time zone)
    LANGUAGE plpgsql
    AS $_$
BEGIN
    RETURN QUERY EXECUTE
        'SELECT DISTINCT ON(key COLLATE "C") * from (
            SELECT
                CASE
                    WHEN position($2 IN substring(key from length($1) + 1)) > 0 THEN
                        substring(key from 1 for length($1) + position($2 IN substring(key from length($1) + 1)))
                    ELSE
                        key
                END AS key, id, created_at
            FROM
                storage.s3_multipart_uploads
            WHERE
                bucket_id = $5 AND
                key ILIKE $1 || ''%'' AND
                CASE
                    WHEN $4 != '''' AND $6 = '''' THEN
                        CASE
                            WHEN position($2 IN substring(key from length($1) + 1)) > 0 THEN
                                substring(key from 1 for length($1) + position($2 IN substring(key from length($1) + 1))) COLLATE "C" > $4
                            ELSE
                                key COLLATE "C" > $4
                            END
                    ELSE
                        true
                END AND
                CASE
                    WHEN $6 != '''' THEN
                        id COLLATE "C" > $6
                    ELSE
                        true
                    END
            ORDER BY
                key COLLATE "C" ASC, created_at ASC) as e order by key COLLATE "C" LIMIT $3'
        USING prefix_param, delimiter_param, max_keys, next_key_token, bucket_id, next_upload_token;
END;
$_$;


ALTER FUNCTION storage.list_multipart_uploads_with_delimiter(bucket_id text, prefix_param text, delimiter_param text, max_keys integer, next_key_token text, next_upload_token text) OWNER TO supabase_storage_admin;

--
-- Name: list_objects_with_delimiter(text, text, text, integer, text, text, text); Type: FUNCTION; Schema: storage; Owner: supabase_storage_admin
--

CREATE FUNCTION storage.list_objects_with_delimiter(_bucket_id text, prefix_param text, delimiter_param text, max_keys integer DEFAULT 100, start_after text DEFAULT ''::text, next_token text DEFAULT ''::text, sort_order text DEFAULT 'asc'::text) RETURNS TABLE(name text, id uuid, metadata jsonb, updated_at timestamp with time zone, created_at timestamp with time zone, last_accessed_at timestamp with time zone)
    LANGUAGE plpgsql STABLE
    AS $_$
DECLARE
    v_peek_name TEXT;
    v_current RECORD;
    v_common_prefix TEXT;

    -- Configuration
    v_is_asc BOOLEAN;
    v_prefix TEXT;
    v_start TEXT;
    v_upper_bound TEXT;
    v_file_batch_size INT;

    -- Seek state
    v_next_seek TEXT;
    v_count INT := 0;

    -- Dynamic SQL for batch query only
    v_batch_query TEXT;

BEGIN
    -- ========================================================================
    -- INITIALIZATION
    -- ========================================================================
    v_is_asc := lower(coalesce(sort_order, 'asc')) = 'asc';
    v_prefix := coalesce(prefix_param, '');
    v_start := CASE WHEN coalesce(next_token, '') <> '' THEN next_token ELSE coalesce(start_after, '') END;
    v_file_batch_size := LEAST(GREATEST(max_keys * 2, 100), 1000);

    -- Calculate upper bound for prefix filtering (bytewise, using COLLATE "C")
    IF v_prefix = '' THEN
        v_upper_bound := NULL;
    ELSIF right(v_prefix, 1) = delimiter_param THEN
        v_upper_bound := left(v_prefix, -1) || chr(ascii(delimiter_param) + 1);
    ELSE
        v_upper_bound := left(v_prefix, -1) || chr(ascii(right(v_prefix, 1)) + 1);
    END IF;

    -- Build batch query (dynamic SQL - called infrequently, amortized over many rows)
    IF v_is_asc THEN
        IF v_upper_bound IS NOT NULL THEN
            v_batch_query := 'SELECT o.name, o.id, o.updated_at, o.created_at, o.last_accessed_at, o.metadata ' ||
                'FROM storage.objects o WHERE o.bucket_id = $1 AND o.name COLLATE "C" >= $2 ' ||
                'AND o.name COLLATE "C" < $3 ORDER BY o.name COLLATE "C" ASC LIMIT $4';
        ELSE
            v_batch_query := 'SELECT o.name, o.id, o.updated_at, o.created_at, o.last_accessed_at, o.metadata ' ||
                'FROM storage.objects o WHERE o.bucket_id = $1 AND o.name COLLATE "C" >= $2 ' ||
                'ORDER BY o.name COLLATE "C" ASC LIMIT $4';
        END IF;
    ELSE
        IF v_upper_bound IS NOT NULL THEN
            v_batch_query := 'SELECT o.name, o.id, o.updated_at, o.created_at, o.last_accessed_at, o.metadata ' ||
                'FROM storage.objects o WHERE o.bucket_id = $1 AND o.name COLLATE "C" < $2 ' ||
                'AND o.name COLLATE "C" >= $3 ORDER BY o.name COLLATE "C" DESC LIMIT $4';
        ELSE
            v_batch_query := 'SELECT o.name, o.id, o.updated_at, o.created_at, o.last_accessed_at, o.metadata ' ||
                'FROM storage.objects o WHERE o.bucket_id = $1 AND o.name COLLATE "C" < $2 ' ||
                'ORDER BY o.name COLLATE "C" DESC LIMIT $4';
        END IF;
    END IF;

    -- ========================================================================
    -- SEEK INITIALIZATION: Determine starting position
    -- ========================================================================
    IF v_start = '' THEN
        IF v_is_asc THEN
            v_next_seek := v_prefix;
        ELSE
            -- DESC without cursor: find the last item in range
            IF v_upper_bound IS NOT NULL THEN
                SELECT o.name INTO v_next_seek FROM storage.objects o
                WHERE o.bucket_id = _bucket_id AND o.name COLLATE "C" >= v_prefix AND o.name COLLATE "C" < v_upper_bound
                ORDER BY o.name COLLATE "C" DESC LIMIT 1;
            ELSIF v_prefix <> '' THEN
                SELECT o.name INTO v_next_seek FROM storage.objects o
                WHERE o.bucket_id = _bucket_id AND o.name COLLATE "C" >= v_prefix
                ORDER BY o.name COLLATE "C" DESC LIMIT 1;
            ELSE
                SELECT o.name INTO v_next_seek FROM storage.objects o
                WHERE o.bucket_id = _bucket_id
                ORDER BY o.name COLLATE "C" DESC LIMIT 1;
            END IF;

            IF v_next_seek IS NOT NULL THEN
                v_next_seek := v_next_seek || delimiter_param;
            ELSE
                RETURN;
            END IF;
        END IF;
    ELSE
        -- Cursor provided: determine if it refers to a folder or leaf
        IF EXISTS (
            SELECT 1 FROM storage.objects o
            WHERE o.bucket_id = _bucket_id
              AND o.name COLLATE "C" LIKE v_start || delimiter_param || '%'
            LIMIT 1
        ) THEN
            -- Cursor refers to a folder
            IF v_is_asc THEN
                v_next_seek := v_start || chr(ascii(delimiter_param) + 1);
            ELSE
                v_next_seek := v_start || delimiter_param;
            END IF;
        ELSE
            -- Cursor refers to a leaf object
            IF v_is_asc THEN
                v_next_seek := v_start || delimiter_param;
            ELSE
                v_next_seek := v_start;
            END IF;
        END IF;
    END IF;

    -- ========================================================================
    -- MAIN LOOP: Hybrid peek-then-batch algorithm
    -- Uses STATIC SQL for peek (hot path) and DYNAMIC SQL for batch
    -- ========================================================================
    LOOP
        EXIT WHEN v_count >= max_keys;

        -- STEP 1: PEEK using STATIC SQL (plan cached, very fast)
        IF v_is_asc THEN
            IF v_upper_bound IS NOT NULL THEN
                SELECT o.name INTO v_peek_name FROM storage.objects o
                WHERE o.bucket_id = _bucket_id AND o.name COLLATE "C" >= v_next_seek AND o.name COLLATE "C" < v_upper_bound
                ORDER BY o.name COLLATE "C" ASC LIMIT 1;
            ELSE
                SELECT o.name INTO v_peek_name FROM storage.objects o
                WHERE o.bucket_id = _bucket_id AND o.name COLLATE "C" >= v_next_seek
                ORDER BY o.name COLLATE "C" ASC LIMIT 1;
            END IF;
        ELSE
            IF v_upper_bound IS NOT NULL THEN
                SELECT o.name INTO v_peek_name FROM storage.objects o
                WHERE o.bucket_id = _bucket_id AND o.name COLLATE "C" < v_next_seek AND o.name COLLATE "C" >= v_prefix
                ORDER BY o.name COLLATE "C" DESC LIMIT 1;
            ELSIF v_prefix <> '' THEN
                SELECT o.name INTO v_peek_name FROM storage.objects o
                WHERE o.bucket_id = _bucket_id AND o.name COLLATE "C" < v_next_seek AND o.name COLLATE "C" >= v_prefix
                ORDER BY o.name COLLATE "C" DESC LIMIT 1;
            ELSE
                SELECT o.name INTO v_peek_name FROM storage.objects o
                WHERE o.bucket_id = _bucket_id AND o.name COLLATE "C" < v_next_seek
                ORDER BY o.name COLLATE "C" DESC LIMIT 1;
            END IF;
        END IF;

        EXIT WHEN v_peek_name IS NULL;

        -- STEP 2: Check if this is a FOLDER or FILE
        v_common_prefix := storage.get_common_prefix(v_peek_name, v_prefix, delimiter_param);

        IF v_common_prefix IS NOT NULL THEN
            -- FOLDER: Emit and skip to next folder (no heap access needed)
            name := rtrim(v_common_prefix, delimiter_param);
            id := NULL;
            updated_at := NULL;
            created_at := NULL;
            last_accessed_at := NULL;
            metadata := NULL;
            RETURN NEXT;
            v_count := v_count + 1;

            -- Advance seek past the folder range
            IF v_is_asc THEN
                v_next_seek := left(v_common_prefix, -1) || chr(ascii(delimiter_param) + 1);
            ELSE
                v_next_seek := v_common_prefix;
            END IF;
        ELSE
            -- FILE: Batch fetch using DYNAMIC SQL (overhead amortized over many rows)
            -- For ASC: upper_bound is the exclusive upper limit (< condition)
            -- For DESC: prefix is the inclusive lower limit (>= condition)
            FOR v_current IN EXECUTE v_batch_query USING _bucket_id, v_next_seek,
                CASE WHEN v_is_asc THEN COALESCE(v_upper_bound, v_prefix) ELSE v_prefix END, v_file_batch_size
            LOOP
                v_common_prefix := storage.get_common_prefix(v_current.name, v_prefix, delimiter_param);

                IF v_common_prefix IS NOT NULL THEN
                    -- Hit a folder: exit batch, let peek handle it
                    v_next_seek := v_current.name;
                    EXIT;
                END IF;

                -- Emit file
                name := v_current.name;
                id := v_current.id;
                updated_at := v_current.updated_at;
                created_at := v_current.created_at;
                last_accessed_at := v_current.last_accessed_at;
                metadata := v_current.metadata;
                RETURN NEXT;
                v_count := v_count + 1;

                -- Advance seek past this file
                IF v_is_asc THEN
                    v_next_seek := v_current.name || delimiter_param;
                ELSE
                    v_next_seek := v_current.name;
                END IF;

                EXIT WHEN v_count >= max_keys;
            END LOOP;
        END IF;
    END LOOP;
END;
$_$;


ALTER FUNCTION storage.list_objects_with_delimiter(_bucket_id text, prefix_param text, delimiter_param text, max_keys integer, start_after text, next_token text, sort_order text) OWNER TO supabase_storage_admin;

--
-- Name: operation(); Type: FUNCTION; Schema: storage; Owner: supabase_storage_admin
--

CREATE FUNCTION storage.operation() RETURNS text
    LANGUAGE plpgsql STABLE
    AS $$
BEGIN
    RETURN current_setting('storage.operation', true);
END;
$$;


ALTER FUNCTION storage.operation() OWNER TO supabase_storage_admin;

--
-- Name: protect_delete(); Type: FUNCTION; Schema: storage; Owner: supabase_storage_admin
--

CREATE FUNCTION storage.protect_delete() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
    -- Check if storage.allow_delete_query is set to 'true'
    IF COALESCE(current_setting('storage.allow_delete_query', true), 'false') != 'true' THEN
        RAISE EXCEPTION 'Direct deletion from storage tables is not allowed. Use the Storage API instead.'
            USING HINT = 'This prevents accidental data loss from orphaned objects.',
                  ERRCODE = '42501';
    END IF;
    RETURN NULL;
END;
$$;


ALTER FUNCTION storage.protect_delete() OWNER TO supabase_storage_admin;

--
-- Name: search(text, text, integer, integer, integer, text, text, text); Type: FUNCTION; Schema: storage; Owner: supabase_storage_admin
--

CREATE FUNCTION storage.search(prefix text, bucketname text, limits integer DEFAULT 100, levels integer DEFAULT 1, offsets integer DEFAULT 0, search text DEFAULT ''::text, sortcolumn text DEFAULT 'name'::text, sortorder text DEFAULT 'asc'::text) RETURNS TABLE(name text, id uuid, updated_at timestamp with time zone, created_at timestamp with time zone, last_accessed_at timestamp with time zone, metadata jsonb)
    LANGUAGE plpgsql STABLE
    AS $_$
DECLARE
    v_peek_name TEXT;
    v_current RECORD;
    v_common_prefix TEXT;
    v_delimiter CONSTANT TEXT := '/';

    -- Configuration
    v_limit INT;
    v_prefix TEXT;
    v_prefix_lower TEXT;
    v_is_asc BOOLEAN;
    v_order_by TEXT;
    v_sort_order TEXT;
    v_upper_bound TEXT;
    v_file_batch_size INT;

    -- Dynamic SQL for batch query only
    v_batch_query TEXT;

    -- Seek state
    v_next_seek TEXT;
    v_count INT := 0;
    v_skipped INT := 0;
BEGIN
    -- ========================================================================
    -- INITIALIZATION
    -- ========================================================================
    v_limit := LEAST(coalesce(limits, 100), 1500);
    v_prefix := coalesce(prefix, '') || coalesce(search, '');
    v_prefix_lower := lower(v_prefix);
    v_is_asc := lower(coalesce(sortorder, 'asc')) = 'asc';
    v_file_batch_size := LEAST(GREATEST(v_limit * 2, 100), 1000);

    -- Validate sort column
    CASE lower(coalesce(sortcolumn, 'name'))
        WHEN 'name' THEN v_order_by := 'name';
        WHEN 'updated_at' THEN v_order_by := 'updated_at';
        WHEN 'created_at' THEN v_order_by := 'created_at';
        WHEN 'last_accessed_at' THEN v_order_by := 'last_accessed_at';
        ELSE v_order_by := 'name';
    END CASE;

    v_sort_order := CASE WHEN v_is_asc THEN 'asc' ELSE 'desc' END;

    -- ========================================================================
    -- NON-NAME SORTING: Use path_tokens approach (unchanged)
    -- ========================================================================
    IF v_order_by != 'name' THEN
        RETURN QUERY EXECUTE format(
            $sql$
            WITH folders AS (
                SELECT path_tokens[$1] AS folder
                FROM storage.objects
                WHERE objects.name ILIKE $2 || '%%'
                  AND bucket_id = $3
                  AND array_length(objects.path_tokens, 1) <> $1
                GROUP BY folder
                ORDER BY folder %s
            )
            (SELECT folder AS "name",
                   NULL::uuid AS id,
                   NULL::timestamptz AS updated_at,
                   NULL::timestamptz AS created_at,
                   NULL::timestamptz AS last_accessed_at,
                   NULL::jsonb AS metadata FROM folders)
            UNION ALL
            (SELECT path_tokens[$1] AS "name",
                   id, updated_at, created_at, last_accessed_at, metadata
             FROM storage.objects
             WHERE objects.name ILIKE $2 || '%%'
               AND bucket_id = $3
               AND array_length(objects.path_tokens, 1) = $1
             ORDER BY %I %s)
            LIMIT $4 OFFSET $5
            $sql$, v_sort_order, v_order_by, v_sort_order
        ) USING levels, v_prefix, bucketname, v_limit, offsets;
        RETURN;
    END IF;

    -- ========================================================================
    -- NAME SORTING: Hybrid skip-scan with batch optimization
    -- ========================================================================

    -- Calculate upper bound for prefix filtering
    IF v_prefix_lower = '' THEN
        v_upper_bound := NULL;
    ELSIF right(v_prefix_lower, 1) = v_delimiter THEN
        v_upper_bound := left(v_prefix_lower, -1) || chr(ascii(v_delimiter) + 1);
    ELSE
        v_upper_bound := left(v_prefix_lower, -1) || chr(ascii(right(v_prefix_lower, 1)) + 1);
    END IF;

    -- Build batch query (dynamic SQL - called infrequently, amortized over many rows)
    IF v_is_asc THEN
        IF v_upper_bound IS NOT NULL THEN
            v_batch_query := 'SELECT o.name, o.id, o.updated_at, o.created_at, o.last_accessed_at, o.metadata ' ||
                'FROM storage.objects o WHERE o.bucket_id = $1 AND lower(o.name) COLLATE "C" >= $2 ' ||
                'AND lower(o.name) COLLATE "C" < $3 ORDER BY lower(o.name) COLLATE "C" ASC LIMIT $4';
        ELSE
            v_batch_query := 'SELECT o.name, o.id, o.updated_at, o.created_at, o.last_accessed_at, o.metadata ' ||
                'FROM storage.objects o WHERE o.bucket_id = $1 AND lower(o.name) COLLATE "C" >= $2 ' ||
                'ORDER BY lower(o.name) COLLATE "C" ASC LIMIT $4';
        END IF;
    ELSE
        IF v_upper_bound IS NOT NULL THEN
            v_batch_query := 'SELECT o.name, o.id, o.updated_at, o.created_at, o.last_accessed_at, o.metadata ' ||
                'FROM storage.objects o WHERE o.bucket_id = $1 AND lower(o.name) COLLATE "C" < $2 ' ||
                'AND lower(o.name) COLLATE "C" >= $3 ORDER BY lower(o.name) COLLATE "C" DESC LIMIT $4';
        ELSE
            v_batch_query := 'SELECT o.name, o.id, o.updated_at, o.created_at, o.last_accessed_at, o.metadata ' ||
                'FROM storage.objects o WHERE o.bucket_id = $1 AND lower(o.name) COLLATE "C" < $2 ' ||
                'ORDER BY lower(o.name) COLLATE "C" DESC LIMIT $4';
        END IF;
    END IF;

    -- Initialize seek position
    IF v_is_asc THEN
        v_next_seek := v_prefix_lower;
    ELSE
        -- DESC: find the last item in range first (static SQL)
        IF v_upper_bound IS NOT NULL THEN
            SELECT o.name INTO v_peek_name FROM storage.objects o
            WHERE o.bucket_id = bucketname AND lower(o.name) COLLATE "C" >= v_prefix_lower AND lower(o.name) COLLATE "C" < v_upper_bound
            ORDER BY lower(o.name) COLLATE "C" DESC LIMIT 1;
        ELSIF v_prefix_lower <> '' THEN
            SELECT o.name INTO v_peek_name FROM storage.objects o
            WHERE o.bucket_id = bucketname AND lower(o.name) COLLATE "C" >= v_prefix_lower
            ORDER BY lower(o.name) COLLATE "C" DESC LIMIT 1;
        ELSE
            SELECT o.name INTO v_peek_name FROM storage.objects o
            WHERE o.bucket_id = bucketname
            ORDER BY lower(o.name) COLLATE "C" DESC LIMIT 1;
        END IF;

        IF v_peek_name IS NOT NULL THEN
            v_next_seek := lower(v_peek_name) || v_delimiter;
        ELSE
            RETURN;
        END IF;
    END IF;

    -- ========================================================================
    -- MAIN LOOP: Hybrid peek-then-batch algorithm
    -- Uses STATIC SQL for peek (hot path) and DYNAMIC SQL for batch
    -- ========================================================================
    LOOP
        EXIT WHEN v_count >= v_limit;

        -- STEP 1: PEEK using STATIC SQL (plan cached, very fast)
        IF v_is_asc THEN
            IF v_upper_bound IS NOT NULL THEN
                SELECT o.name INTO v_peek_name FROM storage.objects o
                WHERE o.bucket_id = bucketname AND lower(o.name) COLLATE "C" >= v_next_seek AND lower(o.name) COLLATE "C" < v_upper_bound
                ORDER BY lower(o.name) COLLATE "C" ASC LIMIT 1;
            ELSE
                SELECT o.name INTO v_peek_name FROM storage.objects o
                WHERE o.bucket_id = bucketname AND lower(o.name) COLLATE "C" >= v_next_seek
                ORDER BY lower(o.name) COLLATE "C" ASC LIMIT 1;
            END IF;
        ELSE
            IF v_upper_bound IS NOT NULL THEN
                SELECT o.name INTO v_peek_name FROM storage.objects o
                WHERE o.bucket_id = bucketname AND lower(o.name) COLLATE "C" < v_next_seek AND lower(o.name) COLLATE "C" >= v_prefix_lower
                ORDER BY lower(o.name) COLLATE "C" DESC LIMIT 1;
            ELSIF v_prefix_lower <> '' THEN
                SELECT o.name INTO v_peek_name FROM storage.objects o
                WHERE o.bucket_id = bucketname AND lower(o.name) COLLATE "C" < v_next_seek AND lower(o.name) COLLATE "C" >= v_prefix_lower
                ORDER BY lower(o.name) COLLATE "C" DESC LIMIT 1;
            ELSE
                SELECT o.name INTO v_peek_name FROM storage.objects o
                WHERE o.bucket_id = bucketname AND lower(o.name) COLLATE "C" < v_next_seek
                ORDER BY lower(o.name) COLLATE "C" DESC LIMIT 1;
            END IF;
        END IF;

        EXIT WHEN v_peek_name IS NULL;

        -- STEP 2: Check if this is a FOLDER or FILE
        v_common_prefix := storage.get_common_prefix(lower(v_peek_name), v_prefix_lower, v_delimiter);

        IF v_common_prefix IS NOT NULL THEN
            -- FOLDER: Handle offset, emit if needed, skip to next folder
            IF v_skipped < offsets THEN
                v_skipped := v_skipped + 1;
            ELSE
                name := split_part(rtrim(storage.get_common_prefix(v_peek_name, v_prefix, v_delimiter), v_delimiter), v_delimiter, levels);
                id := NULL;
                updated_at := NULL;
                created_at := NULL;
                last_accessed_at := NULL;
                metadata := NULL;
                RETURN NEXT;
                v_count := v_count + 1;
            END IF;

            -- Advance seek past the folder range
            IF v_is_asc THEN
                v_next_seek := lower(left(v_common_prefix, -1)) || chr(ascii(v_delimiter) + 1);
            ELSE
                v_next_seek := lower(v_common_prefix);
            END IF;
        ELSE
            -- FILE: Batch fetch using DYNAMIC SQL (overhead amortized over many rows)
            -- For ASC: upper_bound is the exclusive upper limit (< condition)
            -- For DESC: prefix_lower is the inclusive lower limit (>= condition)
            FOR v_current IN EXECUTE v_batch_query
                USING bucketname, v_next_seek,
                    CASE WHEN v_is_asc THEN COALESCE(v_upper_bound, v_prefix_lower) ELSE v_prefix_lower END, v_file_batch_size
            LOOP
                v_common_prefix := storage.get_common_prefix(lower(v_current.name), v_prefix_lower, v_delimiter);

                IF v_common_prefix IS NOT NULL THEN
                    -- Hit a folder: exit batch, let peek handle it
                    v_next_seek := lower(v_current.name);
                    EXIT;
                END IF;

                -- Handle offset skipping
                IF v_skipped < offsets THEN
                    v_skipped := v_skipped + 1;
                ELSE
                    -- Emit file
                    name := split_part(v_current.name, v_delimiter, levels);
                    id := v_current.id;
                    updated_at := v_current.updated_at;
                    created_at := v_current.created_at;
                    last_accessed_at := v_current.last_accessed_at;
                    metadata := v_current.metadata;
                    RETURN NEXT;
                    v_count := v_count + 1;
                END IF;

                -- Advance seek past this file
                IF v_is_asc THEN
                    v_next_seek := lower(v_current.name) || v_delimiter;
                ELSE
                    v_next_seek := lower(v_current.name);
                END IF;

                EXIT WHEN v_count >= v_limit;
            END LOOP;
        END IF;
    END LOOP;
END;
$_$;


ALTER FUNCTION storage.search(prefix text, bucketname text, limits integer, levels integer, offsets integer, search text, sortcolumn text, sortorder text) OWNER TO supabase_storage_admin;

--
-- Name: search_by_timestamp(text, text, integer, integer, text, text, text, text); Type: FUNCTION; Schema: storage; Owner: supabase_storage_admin
--

CREATE FUNCTION storage.search_by_timestamp(p_prefix text, p_bucket_id text, p_limit integer, p_level integer, p_start_after text, p_sort_order text, p_sort_column text, p_sort_column_after text) RETURNS TABLE(key text, name text, id uuid, updated_at timestamp with time zone, created_at timestamp with time zone, last_accessed_at timestamp with time zone, metadata jsonb)
    LANGUAGE plpgsql STABLE
    AS $_$
DECLARE
    v_cursor_op text;
    v_query text;
    v_prefix text;
BEGIN
    v_prefix := coalesce(p_prefix, '');

    IF p_sort_order = 'asc' THEN
        v_cursor_op := '>';
    ELSE
        v_cursor_op := '<';
    END IF;

    v_query := format($sql$
        WITH raw_objects AS (
            SELECT
                o.name AS obj_name,
                o.id AS obj_id,
                o.updated_at AS obj_updated_at,
                o.created_at AS obj_created_at,
                o.last_accessed_at AS obj_last_accessed_at,
                o.metadata AS obj_metadata,
                storage.get_common_prefix(o.name, $1, '/') AS common_prefix
            FROM storage.objects o
            WHERE o.bucket_id = $2
              AND o.name COLLATE "C" LIKE $1 || '%%'
        ),
        -- Aggregate common prefixes (folders)
        -- Both created_at and updated_at use MIN(obj_created_at) to match the old prefixes table behavior
        aggregated_prefixes AS (
            SELECT
                rtrim(common_prefix, '/') AS name,
                NULL::uuid AS id,
                MIN(obj_created_at) AS updated_at,
                MIN(obj_created_at) AS created_at,
                NULL::timestamptz AS last_accessed_at,
                NULL::jsonb AS metadata,
                TRUE AS is_prefix
            FROM raw_objects
            WHERE common_prefix IS NOT NULL
            GROUP BY common_prefix
        ),
        leaf_objects AS (
            SELECT
                obj_name AS name,
                obj_id AS id,
                obj_updated_at AS updated_at,
                obj_created_at AS created_at,
                obj_last_accessed_at AS last_accessed_at,
                obj_metadata AS metadata,
                FALSE AS is_prefix
            FROM raw_objects
            WHERE common_prefix IS NULL
        ),
        combined AS (
            SELECT * FROM aggregated_prefixes
            UNION ALL
            SELECT * FROM leaf_objects
        ),
        filtered AS (
            SELECT *
            FROM combined
            WHERE (
                $5 = ''
                OR ROW(
                    date_trunc('milliseconds', %I),
                    name COLLATE "C"
                ) %s ROW(
                    COALESCE(NULLIF($6, '')::timestamptz, 'epoch'::timestamptz),
                    $5
                )
            )
        )
        SELECT
            split_part(name, '/', $3) AS key,
            name,
            id,
            updated_at,
            created_at,
            last_accessed_at,
            metadata
        FROM filtered
        ORDER BY
            COALESCE(date_trunc('milliseconds', %I), 'epoch'::timestamptz) %s,
            name COLLATE "C" %s
        LIMIT $4
    $sql$,
        p_sort_column,
        v_cursor_op,
        p_sort_column,
        p_sort_order,
        p_sort_order
    );

    RETURN QUERY EXECUTE v_query
    USING v_prefix, p_bucket_id, p_level, p_limit, p_start_after, p_sort_column_after;
END;
$_$;


ALTER FUNCTION storage.search_by_timestamp(p_prefix text, p_bucket_id text, p_limit integer, p_level integer, p_start_after text, p_sort_order text, p_sort_column text, p_sort_column_after text) OWNER TO supabase_storage_admin;

--
-- Name: search_v2(text, text, integer, integer, text, text, text, text); Type: FUNCTION; Schema: storage; Owner: supabase_storage_admin
--

CREATE FUNCTION storage.search_v2(prefix text, bucket_name text, limits integer DEFAULT 100, levels integer DEFAULT 1, start_after text DEFAULT ''::text, sort_order text DEFAULT 'asc'::text, sort_column text DEFAULT 'name'::text, sort_column_after text DEFAULT ''::text) RETURNS TABLE(key text, name text, id uuid, updated_at timestamp with time zone, created_at timestamp with time zone, last_accessed_at timestamp with time zone, metadata jsonb)
    LANGUAGE plpgsql STABLE
    AS $$
DECLARE
    v_sort_col text;
    v_sort_ord text;
    v_limit int;
BEGIN
    -- Cap limit to maximum of 1500 records
    v_limit := LEAST(coalesce(limits, 100), 1500);

    -- Validate and normalize sort_order
    v_sort_ord := lower(coalesce(sort_order, 'asc'));
    IF v_sort_ord NOT IN ('asc', 'desc') THEN
        v_sort_ord := 'asc';
    END IF;

    -- Validate and normalize sort_column
    v_sort_col := lower(coalesce(sort_column, 'name'));
    IF v_sort_col NOT IN ('name', 'updated_at', 'created_at') THEN
        v_sort_col := 'name';
    END IF;

    -- Route to appropriate implementation
    IF v_sort_col = 'name' THEN
        -- Use list_objects_with_delimiter for name sorting (most efficient: O(k * log n))
        RETURN QUERY
        SELECT
            split_part(l.name, '/', levels) AS key,
            l.name AS name,
            l.id,
            l.updated_at,
            l.created_at,
            l.last_accessed_at,
            l.metadata
        FROM storage.list_objects_with_delimiter(
            bucket_name,
            coalesce(prefix, ''),
            '/',
            v_limit,
            start_after,
            '',
            v_sort_ord
        ) l;
    ELSE
        -- Use aggregation approach for timestamp sorting
        -- Not efficient for large datasets but supports correct pagination
        RETURN QUERY SELECT * FROM storage.search_by_timestamp(
            prefix, bucket_name, v_limit, levels, start_after,
            v_sort_ord, v_sort_col, sort_column_after
        );
    END IF;
END;
$$;


ALTER FUNCTION storage.search_v2(prefix text, bucket_name text, limits integer, levels integer, start_after text, sort_order text, sort_column text, sort_column_after text) OWNER TO supabase_storage_admin;

--
-- Name: update_updated_at_column(); Type: FUNCTION; Schema: storage; Owner: supabase_storage_admin
--

CREATE FUNCTION storage.update_updated_at_column() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
    NEW.updated_at = now();
    RETURN NEW; 
END;
$$;


ALTER FUNCTION storage.update_updated_at_column() OWNER TO supabase_storage_admin;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: audit_log_entries; Type: TABLE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TABLE auth.audit_log_entries (
    instance_id uuid,
    id uuid NOT NULL,
    payload json,
    created_at timestamp with time zone,
    ip_address character varying(64) DEFAULT ''::character varying NOT NULL
);


ALTER TABLE auth.audit_log_entries OWNER TO supabase_auth_admin;

--
-- Name: TABLE audit_log_entries; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON TABLE auth.audit_log_entries IS 'Auth: Audit trail for user actions.';


--
-- Name: custom_oauth_providers; Type: TABLE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TABLE auth.custom_oauth_providers (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    provider_type text NOT NULL,
    identifier text NOT NULL,
    name text NOT NULL,
    client_id text NOT NULL,
    client_secret text NOT NULL,
    acceptable_client_ids text[] DEFAULT '{}'::text[] NOT NULL,
    scopes text[] DEFAULT '{}'::text[] NOT NULL,
    pkce_enabled boolean DEFAULT true NOT NULL,
    attribute_mapping jsonb DEFAULT '{}'::jsonb NOT NULL,
    authorization_params jsonb DEFAULT '{}'::jsonb NOT NULL,
    enabled boolean DEFAULT true NOT NULL,
    email_optional boolean DEFAULT false NOT NULL,
    issuer text,
    discovery_url text,
    skip_nonce_check boolean DEFAULT false NOT NULL,
    cached_discovery jsonb,
    discovery_cached_at timestamp with time zone,
    authorization_url text,
    token_url text,
    userinfo_url text,
    jwks_uri text,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL,
    CONSTRAINT custom_oauth_providers_authorization_url_https CHECK (((authorization_url IS NULL) OR (authorization_url ~~ 'https://%'::text))),
    CONSTRAINT custom_oauth_providers_authorization_url_length CHECK (((authorization_url IS NULL) OR (char_length(authorization_url) <= 2048))),
    CONSTRAINT custom_oauth_providers_client_id_length CHECK (((char_length(client_id) >= 1) AND (char_length(client_id) <= 512))),
    CONSTRAINT custom_oauth_providers_discovery_url_length CHECK (((discovery_url IS NULL) OR (char_length(discovery_url) <= 2048))),
    CONSTRAINT custom_oauth_providers_identifier_format CHECK ((identifier ~ '^[a-z0-9][a-z0-9:-]{0,48}[a-z0-9]$'::text)),
    CONSTRAINT custom_oauth_providers_issuer_length CHECK (((issuer IS NULL) OR ((char_length(issuer) >= 1) AND (char_length(issuer) <= 2048)))),
    CONSTRAINT custom_oauth_providers_jwks_uri_https CHECK (((jwks_uri IS NULL) OR (jwks_uri ~~ 'https://%'::text))),
    CONSTRAINT custom_oauth_providers_jwks_uri_length CHECK (((jwks_uri IS NULL) OR (char_length(jwks_uri) <= 2048))),
    CONSTRAINT custom_oauth_providers_name_length CHECK (((char_length(name) >= 1) AND (char_length(name) <= 100))),
    CONSTRAINT custom_oauth_providers_oauth2_requires_endpoints CHECK (((provider_type <> 'oauth2'::text) OR ((authorization_url IS NOT NULL) AND (token_url IS NOT NULL) AND (userinfo_url IS NOT NULL)))),
    CONSTRAINT custom_oauth_providers_oidc_discovery_url_https CHECK (((provider_type <> 'oidc'::text) OR (discovery_url IS NULL) OR (discovery_url ~~ 'https://%'::text))),
    CONSTRAINT custom_oauth_providers_oidc_issuer_https CHECK (((provider_type <> 'oidc'::text) OR (issuer IS NULL) OR (issuer ~~ 'https://%'::text))),
    CONSTRAINT custom_oauth_providers_oidc_requires_issuer CHECK (((provider_type <> 'oidc'::text) OR (issuer IS NOT NULL))),
    CONSTRAINT custom_oauth_providers_provider_type_check CHECK ((provider_type = ANY (ARRAY['oauth2'::text, 'oidc'::text]))),
    CONSTRAINT custom_oauth_providers_token_url_https CHECK (((token_url IS NULL) OR (token_url ~~ 'https://%'::text))),
    CONSTRAINT custom_oauth_providers_token_url_length CHECK (((token_url IS NULL) OR (char_length(token_url) <= 2048))),
    CONSTRAINT custom_oauth_providers_userinfo_url_https CHECK (((userinfo_url IS NULL) OR (userinfo_url ~~ 'https://%'::text))),
    CONSTRAINT custom_oauth_providers_userinfo_url_length CHECK (((userinfo_url IS NULL) OR (char_length(userinfo_url) <= 2048)))
);


ALTER TABLE auth.custom_oauth_providers OWNER TO supabase_auth_admin;

--
-- Name: flow_state; Type: TABLE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TABLE auth.flow_state (
    id uuid NOT NULL,
    user_id uuid,
    auth_code text,
    code_challenge_method auth.code_challenge_method,
    code_challenge text,
    provider_type text NOT NULL,
    provider_access_token text,
    provider_refresh_token text,
    created_at timestamp with time zone,
    updated_at timestamp with time zone,
    authentication_method text NOT NULL,
    auth_code_issued_at timestamp with time zone,
    invite_token text,
    referrer text,
    oauth_client_state_id uuid,
    linking_target_id uuid,
    email_optional boolean DEFAULT false NOT NULL
);


ALTER TABLE auth.flow_state OWNER TO supabase_auth_admin;

--
-- Name: TABLE flow_state; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON TABLE auth.flow_state IS 'Stores metadata for all OAuth/SSO login flows';


--
-- Name: identities; Type: TABLE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TABLE auth.identities (
    provider_id text NOT NULL,
    user_id uuid NOT NULL,
    identity_data jsonb NOT NULL,
    provider text NOT NULL,
    last_sign_in_at timestamp with time zone,
    created_at timestamp with time zone,
    updated_at timestamp with time zone,
    email text GENERATED ALWAYS AS (lower((identity_data ->> 'email'::text))) STORED,
    id uuid DEFAULT gen_random_uuid() NOT NULL
);


ALTER TABLE auth.identities OWNER TO supabase_auth_admin;

--
-- Name: TABLE identities; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON TABLE auth.identities IS 'Auth: Stores identities associated to a user.';


--
-- Name: COLUMN identities.email; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON COLUMN auth.identities.email IS 'Auth: Email is a generated column that references the optional email property in the identity_data';


--
-- Name: instances; Type: TABLE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TABLE auth.instances (
    id uuid NOT NULL,
    uuid uuid,
    raw_base_config text,
    created_at timestamp with time zone,
    updated_at timestamp with time zone
);


ALTER TABLE auth.instances OWNER TO supabase_auth_admin;

--
-- Name: TABLE instances; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON TABLE auth.instances IS 'Auth: Manages users across multiple sites.';


--
-- Name: mfa_amr_claims; Type: TABLE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TABLE auth.mfa_amr_claims (
    session_id uuid NOT NULL,
    created_at timestamp with time zone NOT NULL,
    updated_at timestamp with time zone NOT NULL,
    authentication_method text NOT NULL,
    id uuid NOT NULL
);


ALTER TABLE auth.mfa_amr_claims OWNER TO supabase_auth_admin;

--
-- Name: TABLE mfa_amr_claims; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON TABLE auth.mfa_amr_claims IS 'auth: stores authenticator method reference claims for multi factor authentication';


--
-- Name: mfa_challenges; Type: TABLE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TABLE auth.mfa_challenges (
    id uuid NOT NULL,
    factor_id uuid NOT NULL,
    created_at timestamp with time zone NOT NULL,
    verified_at timestamp with time zone,
    ip_address inet NOT NULL,
    otp_code text,
    web_authn_session_data jsonb
);


ALTER TABLE auth.mfa_challenges OWNER TO supabase_auth_admin;

--
-- Name: TABLE mfa_challenges; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON TABLE auth.mfa_challenges IS 'auth: stores metadata about challenge requests made';


--
-- Name: mfa_factors; Type: TABLE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TABLE auth.mfa_factors (
    id uuid NOT NULL,
    user_id uuid NOT NULL,
    friendly_name text,
    factor_type auth.factor_type NOT NULL,
    status auth.factor_status NOT NULL,
    created_at timestamp with time zone NOT NULL,
    updated_at timestamp with time zone NOT NULL,
    secret text,
    phone text,
    last_challenged_at timestamp with time zone,
    web_authn_credential jsonb,
    web_authn_aaguid uuid,
    last_webauthn_challenge_data jsonb
);


ALTER TABLE auth.mfa_factors OWNER TO supabase_auth_admin;

--
-- Name: TABLE mfa_factors; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON TABLE auth.mfa_factors IS 'auth: stores metadata about factors';


--
-- Name: COLUMN mfa_factors.last_webauthn_challenge_data; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON COLUMN auth.mfa_factors.last_webauthn_challenge_data IS 'Stores the latest WebAuthn challenge data including attestation/assertion for customer verification';


--
-- Name: oauth_authorizations; Type: TABLE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TABLE auth.oauth_authorizations (
    id uuid NOT NULL,
    authorization_id text NOT NULL,
    client_id uuid NOT NULL,
    user_id uuid,
    redirect_uri text NOT NULL,
    scope text NOT NULL,
    state text,
    resource text,
    code_challenge text,
    code_challenge_method auth.code_challenge_method,
    response_type auth.oauth_response_type DEFAULT 'code'::auth.oauth_response_type NOT NULL,
    status auth.oauth_authorization_status DEFAULT 'pending'::auth.oauth_authorization_status NOT NULL,
    authorization_code text,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    expires_at timestamp with time zone DEFAULT (now() + '00:03:00'::interval) NOT NULL,
    approved_at timestamp with time zone,
    nonce text,
    CONSTRAINT oauth_authorizations_authorization_code_length CHECK ((char_length(authorization_code) <= 255)),
    CONSTRAINT oauth_authorizations_code_challenge_length CHECK ((char_length(code_challenge) <= 128)),
    CONSTRAINT oauth_authorizations_expires_at_future CHECK ((expires_at > created_at)),
    CONSTRAINT oauth_authorizations_nonce_length CHECK ((char_length(nonce) <= 255)),
    CONSTRAINT oauth_authorizations_redirect_uri_length CHECK ((char_length(redirect_uri) <= 2048)),
    CONSTRAINT oauth_authorizations_resource_length CHECK ((char_length(resource) <= 2048)),
    CONSTRAINT oauth_authorizations_scope_length CHECK ((char_length(scope) <= 4096)),
    CONSTRAINT oauth_authorizations_state_length CHECK ((char_length(state) <= 4096))
);


ALTER TABLE auth.oauth_authorizations OWNER TO supabase_auth_admin;

--
-- Name: oauth_client_states; Type: TABLE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TABLE auth.oauth_client_states (
    id uuid NOT NULL,
    provider_type text NOT NULL,
    code_verifier text,
    created_at timestamp with time zone NOT NULL
);


ALTER TABLE auth.oauth_client_states OWNER TO supabase_auth_admin;

--
-- Name: TABLE oauth_client_states; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON TABLE auth.oauth_client_states IS 'Stores OAuth states for third-party provider authentication flows where Supabase acts as the OAuth client.';


--
-- Name: oauth_clients; Type: TABLE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TABLE auth.oauth_clients (
    id uuid NOT NULL,
    client_secret_hash text,
    registration_type auth.oauth_registration_type NOT NULL,
    redirect_uris text NOT NULL,
    grant_types text NOT NULL,
    client_name text,
    client_uri text,
    logo_uri text,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL,
    deleted_at timestamp with time zone,
    client_type auth.oauth_client_type DEFAULT 'confidential'::auth.oauth_client_type NOT NULL,
    token_endpoint_auth_method text NOT NULL,
    CONSTRAINT oauth_clients_client_name_length CHECK ((char_length(client_name) <= 1024)),
    CONSTRAINT oauth_clients_client_uri_length CHECK ((char_length(client_uri) <= 2048)),
    CONSTRAINT oauth_clients_logo_uri_length CHECK ((char_length(logo_uri) <= 2048)),
    CONSTRAINT oauth_clients_token_endpoint_auth_method_check CHECK ((token_endpoint_auth_method = ANY (ARRAY['client_secret_basic'::text, 'client_secret_post'::text, 'none'::text])))
);


ALTER TABLE auth.oauth_clients OWNER TO supabase_auth_admin;

--
-- Name: oauth_consents; Type: TABLE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TABLE auth.oauth_consents (
    id uuid NOT NULL,
    user_id uuid NOT NULL,
    client_id uuid NOT NULL,
    scopes text NOT NULL,
    granted_at timestamp with time zone DEFAULT now() NOT NULL,
    revoked_at timestamp with time zone,
    CONSTRAINT oauth_consents_revoked_after_granted CHECK (((revoked_at IS NULL) OR (revoked_at >= granted_at))),
    CONSTRAINT oauth_consents_scopes_length CHECK ((char_length(scopes) <= 2048)),
    CONSTRAINT oauth_consents_scopes_not_empty CHECK ((char_length(TRIM(BOTH FROM scopes)) > 0))
);


ALTER TABLE auth.oauth_consents OWNER TO supabase_auth_admin;

--
-- Name: one_time_tokens; Type: TABLE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TABLE auth.one_time_tokens (
    id uuid NOT NULL,
    user_id uuid NOT NULL,
    token_type auth.one_time_token_type NOT NULL,
    token_hash text NOT NULL,
    relates_to text NOT NULL,
    created_at timestamp without time zone DEFAULT now() NOT NULL,
    updated_at timestamp without time zone DEFAULT now() NOT NULL,
    CONSTRAINT one_time_tokens_token_hash_check CHECK ((char_length(token_hash) > 0))
);


ALTER TABLE auth.one_time_tokens OWNER TO supabase_auth_admin;

--
-- Name: refresh_tokens; Type: TABLE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TABLE auth.refresh_tokens (
    instance_id uuid,
    id bigint NOT NULL,
    token character varying(255),
    user_id character varying(255),
    revoked boolean,
    created_at timestamp with time zone,
    updated_at timestamp with time zone,
    parent character varying(255),
    session_id uuid
);


ALTER TABLE auth.refresh_tokens OWNER TO supabase_auth_admin;

--
-- Name: TABLE refresh_tokens; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON TABLE auth.refresh_tokens IS 'Auth: Store of tokens used to refresh JWT tokens once they expire.';


--
-- Name: refresh_tokens_id_seq; Type: SEQUENCE; Schema: auth; Owner: supabase_auth_admin
--

CREATE SEQUENCE auth.refresh_tokens_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE auth.refresh_tokens_id_seq OWNER TO supabase_auth_admin;

--
-- Name: refresh_tokens_id_seq; Type: SEQUENCE OWNED BY; Schema: auth; Owner: supabase_auth_admin
--

ALTER SEQUENCE auth.refresh_tokens_id_seq OWNED BY auth.refresh_tokens.id;


--
-- Name: saml_providers; Type: TABLE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TABLE auth.saml_providers (
    id uuid NOT NULL,
    sso_provider_id uuid NOT NULL,
    entity_id text NOT NULL,
    metadata_xml text NOT NULL,
    metadata_url text,
    attribute_mapping jsonb,
    created_at timestamp with time zone,
    updated_at timestamp with time zone,
    name_id_format text,
    CONSTRAINT "entity_id not empty" CHECK ((char_length(entity_id) > 0)),
    CONSTRAINT "metadata_url not empty" CHECK (((metadata_url = NULL::text) OR (char_length(metadata_url) > 0))),
    CONSTRAINT "metadata_xml not empty" CHECK ((char_length(metadata_xml) > 0))
);


ALTER TABLE auth.saml_providers OWNER TO supabase_auth_admin;

--
-- Name: TABLE saml_providers; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON TABLE auth.saml_providers IS 'Auth: Manages SAML Identity Provider connections.';


--
-- Name: saml_relay_states; Type: TABLE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TABLE auth.saml_relay_states (
    id uuid NOT NULL,
    sso_provider_id uuid NOT NULL,
    request_id text NOT NULL,
    for_email text,
    redirect_to text,
    created_at timestamp with time zone,
    updated_at timestamp with time zone,
    flow_state_id uuid,
    CONSTRAINT "request_id not empty" CHECK ((char_length(request_id) > 0))
);


ALTER TABLE auth.saml_relay_states OWNER TO supabase_auth_admin;

--
-- Name: TABLE saml_relay_states; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON TABLE auth.saml_relay_states IS 'Auth: Contains SAML Relay State information for each Service Provider initiated login.';


--
-- Name: schema_migrations; Type: TABLE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TABLE auth.schema_migrations (
    version character varying(255) NOT NULL
);


ALTER TABLE auth.schema_migrations OWNER TO supabase_auth_admin;

--
-- Name: TABLE schema_migrations; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON TABLE auth.schema_migrations IS 'Auth: Manages updates to the auth system.';


--
-- Name: sessions; Type: TABLE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TABLE auth.sessions (
    id uuid NOT NULL,
    user_id uuid NOT NULL,
    created_at timestamp with time zone,
    updated_at timestamp with time zone,
    factor_id uuid,
    aal auth.aal_level,
    not_after timestamp with time zone,
    refreshed_at timestamp without time zone,
    user_agent text,
    ip inet,
    tag text,
    oauth_client_id uuid,
    refresh_token_hmac_key text,
    refresh_token_counter bigint,
    scopes text,
    CONSTRAINT sessions_scopes_length CHECK ((char_length(scopes) <= 4096))
);


ALTER TABLE auth.sessions OWNER TO supabase_auth_admin;

--
-- Name: TABLE sessions; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON TABLE auth.sessions IS 'Auth: Stores session data associated to a user.';


--
-- Name: COLUMN sessions.not_after; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON COLUMN auth.sessions.not_after IS 'Auth: Not after is a nullable column that contains a timestamp after which the session should be regarded as expired.';


--
-- Name: COLUMN sessions.refresh_token_hmac_key; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON COLUMN auth.sessions.refresh_token_hmac_key IS 'Holds a HMAC-SHA256 key used to sign refresh tokens for this session.';


--
-- Name: COLUMN sessions.refresh_token_counter; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON COLUMN auth.sessions.refresh_token_counter IS 'Holds the ID (counter) of the last issued refresh token.';


--
-- Name: sso_domains; Type: TABLE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TABLE auth.sso_domains (
    id uuid NOT NULL,
    sso_provider_id uuid NOT NULL,
    domain text NOT NULL,
    created_at timestamp with time zone,
    updated_at timestamp with time zone,
    CONSTRAINT "domain not empty" CHECK ((char_length(domain) > 0))
);


ALTER TABLE auth.sso_domains OWNER TO supabase_auth_admin;

--
-- Name: TABLE sso_domains; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON TABLE auth.sso_domains IS 'Auth: Manages SSO email address domain mapping to an SSO Identity Provider.';


--
-- Name: sso_providers; Type: TABLE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TABLE auth.sso_providers (
    id uuid NOT NULL,
    resource_id text,
    created_at timestamp with time zone,
    updated_at timestamp with time zone,
    disabled boolean,
    CONSTRAINT "resource_id not empty" CHECK (((resource_id = NULL::text) OR (char_length(resource_id) > 0)))
);


ALTER TABLE auth.sso_providers OWNER TO supabase_auth_admin;

--
-- Name: TABLE sso_providers; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON TABLE auth.sso_providers IS 'Auth: Manages SSO identity provider information; see saml_providers for SAML.';


--
-- Name: COLUMN sso_providers.resource_id; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON COLUMN auth.sso_providers.resource_id IS 'Auth: Uniquely identifies a SSO provider according to a user-chosen resource ID (case insensitive), useful in infrastructure as code.';


--
-- Name: users; Type: TABLE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TABLE auth.users (
    instance_id uuid,
    id uuid NOT NULL,
    aud character varying(255),
    role character varying(255),
    email character varying(255),
    encrypted_password character varying(255),
    email_confirmed_at timestamp with time zone,
    invited_at timestamp with time zone,
    confirmation_token character varying(255),
    confirmation_sent_at timestamp with time zone,
    recovery_token character varying(255),
    recovery_sent_at timestamp with time zone,
    email_change_token_new character varying(255),
    email_change character varying(255),
    email_change_sent_at timestamp with time zone,
    last_sign_in_at timestamp with time zone,
    raw_app_meta_data jsonb,
    raw_user_meta_data jsonb,
    is_super_admin boolean,
    created_at timestamp with time zone,
    updated_at timestamp with time zone,
    phone text DEFAULT NULL::character varying,
    phone_confirmed_at timestamp with time zone,
    phone_change text DEFAULT ''::character varying,
    phone_change_token character varying(255) DEFAULT ''::character varying,
    phone_change_sent_at timestamp with time zone,
    confirmed_at timestamp with time zone GENERATED ALWAYS AS (LEAST(email_confirmed_at, phone_confirmed_at)) STORED,
    email_change_token_current character varying(255) DEFAULT ''::character varying,
    email_change_confirm_status smallint DEFAULT 0,
    banned_until timestamp with time zone,
    reauthentication_token character varying(255) DEFAULT ''::character varying,
    reauthentication_sent_at timestamp with time zone,
    is_sso_user boolean DEFAULT false NOT NULL,
    deleted_at timestamp with time zone,
    is_anonymous boolean DEFAULT false NOT NULL,
    CONSTRAINT users_email_change_confirm_status_check CHECK (((email_change_confirm_status >= 0) AND (email_change_confirm_status <= 2)))
);


ALTER TABLE auth.users OWNER TO supabase_auth_admin;

--
-- Name: TABLE users; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON TABLE auth.users IS 'Auth: Stores user login data within a secure schema.';


--
-- Name: COLUMN users.is_sso_user; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON COLUMN auth.users.is_sso_user IS 'Auth: Set this column to true when the account comes from SSO. These accounts can have duplicate emails.';


--
-- Name: webauthn_challenges; Type: TABLE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TABLE auth.webauthn_challenges (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    user_id uuid,
    challenge_type text NOT NULL,
    session_data jsonb NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    expires_at timestamp with time zone NOT NULL,
    CONSTRAINT webauthn_challenges_challenge_type_check CHECK ((challenge_type = ANY (ARRAY['signup'::text, 'registration'::text, 'authentication'::text])))
);


ALTER TABLE auth.webauthn_challenges OWNER TO supabase_auth_admin;

--
-- Name: webauthn_credentials; Type: TABLE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TABLE auth.webauthn_credentials (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    user_id uuid NOT NULL,
    credential_id bytea NOT NULL,
    public_key bytea NOT NULL,
    attestation_type text DEFAULT ''::text NOT NULL,
    aaguid uuid,
    sign_count bigint DEFAULT 0 NOT NULL,
    transports jsonb DEFAULT '[]'::jsonb NOT NULL,
    backup_eligible boolean DEFAULT false NOT NULL,
    backed_up boolean DEFAULT false NOT NULL,
    friendly_name text DEFAULT ''::text NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL,
    last_used_at timestamp with time zone
);


ALTER TABLE auth.webauthn_credentials OWNER TO supabase_auth_admin;

--
-- Name: global_banks; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.global_banks (
    id integer NOT NULL,
    category text NOT NULL,
    initial_balance integer DEFAULT 0,
    created_at timestamp with time zone DEFAULT now()
);


ALTER TABLE public.global_banks OWNER TO postgres;

--
-- Name: global_banks_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.global_banks_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.global_banks_id_seq OWNER TO postgres;

--
-- Name: global_banks_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.global_banks_id_seq OWNED BY public.global_banks.id;


--
-- Name: month_balances; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.month_balances (
    id integer NOT NULL,
    month_id integer NOT NULL,
    category text NOT NULL,
    opening_amount integer DEFAULT 0,
    closing_amount integer DEFAULT 0,
    created_at timestamp with time zone DEFAULT now()
);


ALTER TABLE public.month_balances OWNER TO postgres;

--
-- Name: month_balances_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.month_balances_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.month_balances_id_seq OWNER TO postgres;

--
-- Name: month_balances_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.month_balances_id_seq OWNED BY public.month_balances.id;


--
-- Name: months; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.months (
    id integer NOT NULL,
    name text NOT NULL,
    year integer NOT NULL,
    income integer DEFAULT 0,
    costing integer DEFAULT 0,
    opening_balance integer DEFAULT 0,
    created_at timestamp without time zone DEFAULT now(),
    net_balance integer DEFAULT 0
);


ALTER TABLE public.months OWNER TO postgres;

--
-- Name: months_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.months_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.months_id_seq OWNER TO postgres;

--
-- Name: months_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.months_id_seq OWNED BY public.months.id;


--
-- Name: transactions; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.transactions (
    id integer NOT NULL,
    month_id integer NOT NULL,
    type text NOT NULL,
    category text NOT NULL,
    date timestamp without time zone DEFAULT now() NOT NULL,
    description text,
    amount integer DEFAULT 0 NOT NULL,
    weight numeric(10,2) DEFAULT '0'::numeric,
    created_at timestamp without time zone DEFAULT now()
);


ALTER TABLE public.transactions OWNER TO postgres;

--
-- Name: transactions_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.transactions_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.transactions_id_seq OWNER TO postgres;

--
-- Name: transactions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.transactions_id_seq OWNED BY public.transactions.id;


--
-- Name: messages; Type: TABLE; Schema: realtime; Owner: supabase_realtime_admin
--

CREATE TABLE realtime.messages (
    topic text NOT NULL,
    extension text NOT NULL,
    payload jsonb,
    event text,
    private boolean DEFAULT false,
    updated_at timestamp without time zone DEFAULT now() NOT NULL,
    inserted_at timestamp without time zone DEFAULT now() NOT NULL,
    id uuid DEFAULT gen_random_uuid() NOT NULL
)
PARTITION BY RANGE (inserted_at);


ALTER TABLE realtime.messages OWNER TO supabase_realtime_admin;

--
-- Name: schema_migrations; Type: TABLE; Schema: realtime; Owner: supabase_admin
--

CREATE TABLE realtime.schema_migrations (
    version bigint NOT NULL,
    inserted_at timestamp(0) without time zone
);


ALTER TABLE realtime.schema_migrations OWNER TO supabase_admin;

--
-- Name: subscription; Type: TABLE; Schema: realtime; Owner: supabase_admin
--

CREATE TABLE realtime.subscription (
    id bigint NOT NULL,
    subscription_id uuid NOT NULL,
    entity regclass NOT NULL,
    filters realtime.user_defined_filter[] DEFAULT '{}'::realtime.user_defined_filter[] NOT NULL,
    claims jsonb NOT NULL,
    claims_role regrole GENERATED ALWAYS AS (realtime.to_regrole((claims ->> 'role'::text))) STORED NOT NULL,
    created_at timestamp without time zone DEFAULT timezone('utc'::text, now()) NOT NULL,
    action_filter text DEFAULT '*'::text,
    CONSTRAINT subscription_action_filter_check CHECK ((action_filter = ANY (ARRAY['*'::text, 'INSERT'::text, 'UPDATE'::text, 'DELETE'::text])))
);


ALTER TABLE realtime.subscription OWNER TO supabase_admin;

--
-- Name: subscription_id_seq; Type: SEQUENCE; Schema: realtime; Owner: supabase_admin
--

ALTER TABLE realtime.subscription ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME realtime.subscription_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: buckets; Type: TABLE; Schema: storage; Owner: supabase_storage_admin
--

CREATE TABLE storage.buckets (
    id text NOT NULL,
    name text NOT NULL,
    owner uuid,
    created_at timestamp with time zone DEFAULT now(),
    updated_at timestamp with time zone DEFAULT now(),
    public boolean DEFAULT false,
    avif_autodetection boolean DEFAULT false,
    file_size_limit bigint,
    allowed_mime_types text[],
    owner_id text,
    type storage.buckettype DEFAULT 'STANDARD'::storage.buckettype NOT NULL
);


ALTER TABLE storage.buckets OWNER TO supabase_storage_admin;

--
-- Name: COLUMN buckets.owner; Type: COMMENT; Schema: storage; Owner: supabase_storage_admin
--

COMMENT ON COLUMN storage.buckets.owner IS 'Field is deprecated, use owner_id instead';


--
-- Name: buckets_analytics; Type: TABLE; Schema: storage; Owner: supabase_storage_admin
--

CREATE TABLE storage.buckets_analytics (
    name text NOT NULL,
    type storage.buckettype DEFAULT 'ANALYTICS'::storage.buckettype NOT NULL,
    format text DEFAULT 'ICEBERG'::text NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL,
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    deleted_at timestamp with time zone
);


ALTER TABLE storage.buckets_analytics OWNER TO supabase_storage_admin;

--
-- Name: buckets_vectors; Type: TABLE; Schema: storage; Owner: supabase_storage_admin
--

CREATE TABLE storage.buckets_vectors (
    id text NOT NULL,
    type storage.buckettype DEFAULT 'VECTOR'::storage.buckettype NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL
);


ALTER TABLE storage.buckets_vectors OWNER TO supabase_storage_admin;

--
-- Name: migrations; Type: TABLE; Schema: storage; Owner: supabase_storage_admin
--

CREATE TABLE storage.migrations (
    id integer NOT NULL,
    name character varying(100) NOT NULL,
    hash character varying(40) NOT NULL,
    executed_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE storage.migrations OWNER TO supabase_storage_admin;

--
-- Name: objects; Type: TABLE; Schema: storage; Owner: supabase_storage_admin
--

CREATE TABLE storage.objects (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    bucket_id text,
    name text,
    owner uuid,
    created_at timestamp with time zone DEFAULT now(),
    updated_at timestamp with time zone DEFAULT now(),
    last_accessed_at timestamp with time zone DEFAULT now(),
    metadata jsonb,
    path_tokens text[] GENERATED ALWAYS AS (string_to_array(name, '/'::text)) STORED,
    version text,
    owner_id text,
    user_metadata jsonb
);


ALTER TABLE storage.objects OWNER TO supabase_storage_admin;

--
-- Name: COLUMN objects.owner; Type: COMMENT; Schema: storage; Owner: supabase_storage_admin
--

COMMENT ON COLUMN storage.objects.owner IS 'Field is deprecated, use owner_id instead';


--
-- Name: s3_multipart_uploads; Type: TABLE; Schema: storage; Owner: supabase_storage_admin
--

CREATE TABLE storage.s3_multipart_uploads (
    id text NOT NULL,
    in_progress_size bigint DEFAULT 0 NOT NULL,
    upload_signature text NOT NULL,
    bucket_id text NOT NULL,
    key text NOT NULL COLLATE pg_catalog."C",
    version text NOT NULL,
    owner_id text,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    user_metadata jsonb,
    metadata jsonb
);


ALTER TABLE storage.s3_multipart_uploads OWNER TO supabase_storage_admin;

--
-- Name: s3_multipart_uploads_parts; Type: TABLE; Schema: storage; Owner: supabase_storage_admin
--

CREATE TABLE storage.s3_multipart_uploads_parts (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    upload_id text NOT NULL,
    size bigint DEFAULT 0 NOT NULL,
    part_number integer NOT NULL,
    bucket_id text NOT NULL,
    key text NOT NULL COLLATE pg_catalog."C",
    etag text NOT NULL,
    owner_id text,
    version text NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL
);


ALTER TABLE storage.s3_multipart_uploads_parts OWNER TO supabase_storage_admin;

--
-- Name: vector_indexes; Type: TABLE; Schema: storage; Owner: supabase_storage_admin
--

CREATE TABLE storage.vector_indexes (
    id text DEFAULT gen_random_uuid() NOT NULL,
    name text NOT NULL COLLATE pg_catalog."C",
    bucket_id text NOT NULL,
    data_type text NOT NULL,
    dimension integer NOT NULL,
    distance_metric text NOT NULL,
    metadata_configuration jsonb,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL
);


ALTER TABLE storage.vector_indexes OWNER TO supabase_storage_admin;

--
-- Name: refresh_tokens id; Type: DEFAULT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.refresh_tokens ALTER COLUMN id SET DEFAULT nextval('auth.refresh_tokens_id_seq'::regclass);


--
-- Name: global_banks id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.global_banks ALTER COLUMN id SET DEFAULT nextval('public.global_banks_id_seq'::regclass);


--
-- Name: month_balances id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.month_balances ALTER COLUMN id SET DEFAULT nextval('public.month_balances_id_seq'::regclass);


--
-- Name: months id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.months ALTER COLUMN id SET DEFAULT nextval('public.months_id_seq'::regclass);


--
-- Name: transactions id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.transactions ALTER COLUMN id SET DEFAULT nextval('public.transactions_id_seq'::regclass);


--
-- Data for Name: audit_log_entries; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY auth.audit_log_entries (instance_id, id, payload, created_at, ip_address) FROM stdin;
\.


--
-- Data for Name: custom_oauth_providers; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY auth.custom_oauth_providers (id, provider_type, identifier, name, client_id, client_secret, acceptable_client_ids, scopes, pkce_enabled, attribute_mapping, authorization_params, enabled, email_optional, issuer, discovery_url, skip_nonce_check, cached_discovery, discovery_cached_at, authorization_url, token_url, userinfo_url, jwks_uri, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: flow_state; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY auth.flow_state (id, user_id, auth_code, code_challenge_method, code_challenge, provider_type, provider_access_token, provider_refresh_token, created_at, updated_at, authentication_method, auth_code_issued_at, invite_token, referrer, oauth_client_state_id, linking_target_id, email_optional) FROM stdin;
\.


--
-- Data for Name: identities; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY auth.identities (provider_id, user_id, identity_data, provider, last_sign_in_at, created_at, updated_at, id) FROM stdin;
\.


--
-- Data for Name: instances; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY auth.instances (id, uuid, raw_base_config, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: mfa_amr_claims; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY auth.mfa_amr_claims (session_id, created_at, updated_at, authentication_method, id) FROM stdin;
\.


--
-- Data for Name: mfa_challenges; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY auth.mfa_challenges (id, factor_id, created_at, verified_at, ip_address, otp_code, web_authn_session_data) FROM stdin;
\.


--
-- Data for Name: mfa_factors; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY auth.mfa_factors (id, user_id, friendly_name, factor_type, status, created_at, updated_at, secret, phone, last_challenged_at, web_authn_credential, web_authn_aaguid, last_webauthn_challenge_data) FROM stdin;
\.


--
-- Data for Name: oauth_authorizations; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY auth.oauth_authorizations (id, authorization_id, client_id, user_id, redirect_uri, scope, state, resource, code_challenge, code_challenge_method, response_type, status, authorization_code, created_at, expires_at, approved_at, nonce) FROM stdin;
\.


--
-- Data for Name: oauth_client_states; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY auth.oauth_client_states (id, provider_type, code_verifier, created_at) FROM stdin;
\.


--
-- Data for Name: oauth_clients; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY auth.oauth_clients (id, client_secret_hash, registration_type, redirect_uris, grant_types, client_name, client_uri, logo_uri, created_at, updated_at, deleted_at, client_type, token_endpoint_auth_method) FROM stdin;
\.


--
-- Data for Name: oauth_consents; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY auth.oauth_consents (id, user_id, client_id, scopes, granted_at, revoked_at) FROM stdin;
\.


--
-- Data for Name: one_time_tokens; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY auth.one_time_tokens (id, user_id, token_type, token_hash, relates_to, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: refresh_tokens; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY auth.refresh_tokens (instance_id, id, token, user_id, revoked, created_at, updated_at, parent, session_id) FROM stdin;
\.


--
-- Data for Name: saml_providers; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY auth.saml_providers (id, sso_provider_id, entity_id, metadata_xml, metadata_url, attribute_mapping, created_at, updated_at, name_id_format) FROM stdin;
\.


--
-- Data for Name: saml_relay_states; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY auth.saml_relay_states (id, sso_provider_id, request_id, for_email, redirect_to, created_at, updated_at, flow_state_id) FROM stdin;
\.


--
-- Data for Name: schema_migrations; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY auth.schema_migrations (version) FROM stdin;
20171026211738
20171026211808
20171026211834
20180103212743
20180108183307
20180119214651
20180125194653
00
20210710035447
20210722035447
20210730183235
20210909172000
20210927181326
20211122151130
20211124214934
20211202183645
20220114185221
20220114185340
20220224000811
20220323170000
20220429102000
20220531120530
20220614074223
20220811173540
20221003041349
20221003041400
20221011041400
20221020193600
20221021073300
20221021082433
20221027105023
20221114143122
20221114143410
20221125140132
20221208132122
20221215195500
20221215195800
20221215195900
20230116124310
20230116124412
20230131181311
20230322519590
20230402418590
20230411005111
20230508135423
20230523124323
20230818113222
20230914180801
20231027141322
20231114161723
20231117164230
20240115144230
20240214120130
20240306115329
20240314092811
20240427152123
20240612123726
20240729123726
20240802193726
20240806073726
20241009103726
20250717082212
20250731150234
20250804100000
20250901200500
20250903112500
20250904133000
20250925093508
20251007112900
20251104100000
20251111201300
20251201000000
20260115000000
20260121000000
20260219120000
20260302000000
\.


--
-- Data for Name: sessions; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY auth.sessions (id, user_id, created_at, updated_at, factor_id, aal, not_after, refreshed_at, user_agent, ip, tag, oauth_client_id, refresh_token_hmac_key, refresh_token_counter, scopes) FROM stdin;
\.


--
-- Data for Name: sso_domains; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY auth.sso_domains (id, sso_provider_id, domain, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: sso_providers; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY auth.sso_providers (id, resource_id, created_at, updated_at, disabled) FROM stdin;
\.


--
-- Data for Name: users; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY auth.users (instance_id, id, aud, role, email, encrypted_password, email_confirmed_at, invited_at, confirmation_token, confirmation_sent_at, recovery_token, recovery_sent_at, email_change_token_new, email_change, email_change_sent_at, last_sign_in_at, raw_app_meta_data, raw_user_meta_data, is_super_admin, created_at, updated_at, phone, phone_confirmed_at, phone_change, phone_change_token, phone_change_sent_at, email_change_token_current, email_change_confirm_status, banned_until, reauthentication_token, reauthentication_sent_at, is_sso_user, deleted_at, is_anonymous) FROM stdin;
\.


--
-- Data for Name: webauthn_challenges; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY auth.webauthn_challenges (id, user_id, challenge_type, session_data, created_at, expires_at) FROM stdin;
\.


--
-- Data for Name: webauthn_credentials; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY auth.webauthn_credentials (id, user_id, credential_id, public_key, attestation_type, aaguid, sign_count, transports, backup_eligible, backed_up, friendly_name, created_at, updated_at, last_used_at) FROM stdin;
\.


--
-- Data for Name: global_banks; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.global_banks (id, category, initial_balance, created_at) FROM stdin;
1	আল - আরাফা ইসলামী ব্যাংক (শেখের বাজার)	5634410	2026-04-19 13:20:35.998451+00
2	আল - আরাফা ইসলামী ব্যাংক (নবাবপুর শাখা)	184706	2026-04-19 13:22:48.607349+00
3	প্রভিডেন্ট ফান্ড (আল - আরাফা ইসলামী ব্যাংক) শেখের বাজার	188076	2026-04-19 13:23:26.187514+00
4	ওয়েলফেয়ার ফান্ড (আল - আরাফা ইসলামী ব্যাংক) শেখের বাজার	220267	2026-04-19 13:23:59.46635+00
5	প্রিমিয়ার ব্যাংক	112990	2026-04-19 13:24:26.501875+00
6	ঢাকা ব্যাংক	54369	2026-04-19 13:24:55.43107+00
\.


--
-- Data for Name: month_balances; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.month_balances (id, month_id, category, opening_amount, closing_amount, created_at) FROM stdin;
\.


--
-- Data for Name: months; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.months (id, name, year, income, costing, opening_balance, created_at, net_balance) FROM stdin;
2	February	2026	2352880	2708650	1217531	2026-04-16 01:01:18.411509	861761
3	March	2026	3600995	3599025	861761	2026-04-16 16:47:35.14493	863731
1	January	2026	4633905	4163160	746790	2026-04-15 04:24:56.80233	1217535
\.


--
-- Data for Name: transactions; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.transactions (id, month_id, type, category, date, description, amount, weight, created_at) FROM stdin;
3	2	income	হলমার্ক হতে প্রাপ্ত আয়	2026-02-01 00:00:00	হলমার্ক হতে প্রাপ্ত আয়	15120	869.00	2026-04-16 01:20:26.537005
5	2	income	স্বর্ণ পাকাইকরন হতে আয়	2026-02-01 00:00:00	স্বর্ণ পাকাইকরন বিল	10400	1222.51	2026-04-16 01:21:45.546306
6	2	costing	পরিচালক, অথিতি, ও স্টাফ আপ্যায়নের বিবরণ (February-2026)	2026-02-01 00:00:00	স্টাফ টিফিন 	1300	0.00	2026-04-16 01:23:03.227142
7	2	costing	বিবিধ খরচের বিবরণ (February-2026)	2026-02-01 00:00:00	বাট্টা (৫,১০,২০,৫০)	150	0.00	2026-04-16 01:23:28.284063
8	2	costing	যাতায়াত সংক্রান্ত খরচের বিবরণ (February-2026)	2026-02-01 00:00:00	 (নদীর ওপার ও কারখানা)	900	0.00	2026-04-16 01:24:54.006247
9	2	costing	পরিচালক, অথিতি, ও স্টাফ আপ্যায়নের বিবরণ (February-2026)	2026-02-01 00:00:00	48 পিস পানি	500	0.00	2026-04-16 01:27:01.375159
10	2	costing	পরিচালক, অথিতি, ও স্টাফ আপ্যায়নের বিবরণ (February-2026)	2026-02-01 00:00:00	 2 জন পুলিশ 	300	0.00	2026-04-16 01:27:29.872168
11	2	costing	বিবিধ খরচের বিবরণ (February-2026)	2026-02-01 00:00:00	তৃতীয় লিঙ্গ	100	0.00	2026-04-16 01:27:54.384165
12	2	income	এক্সরে হতে প্রাপ্ত আয়	2026-02-02 00:00:00	এক্সরে হতে প্রাপ্ত আয়	27650	221.00	2026-04-16 01:28:37.859781
13	2	income	হলমার্ক হতে প্রাপ্ত আয়	2026-02-02 00:00:00	হলমার্ক হতে প্রাপ্ত আয়	13000	779.00	2026-04-16 01:29:03.306808
14	2	income	মেলটিং হতে প্রাপ্ত আয়	2026-02-02 00:00:00	মেলটিং হতে প্রাপ্ত আয়	21049	113.00	2026-04-16 01:29:55.422024
15	2	income	স্বর্ণ পাকাইকরন হতে আয়	2026-02-02 00:00:00	স্বর্ণ পাকাইকরন বিল	3610	227.79	2026-04-16 01:30:40.769128
16	2	income	ওয়েল্ডিং হতে প্রাপ্ত আয়	2026-02-02 00:00:00	ওয়েল্ডিং হতে প্রাপ্ত আয়	4600	227.79	2026-04-16 09:30:52.501941
17	2	costing	পরিচালক, অথিতি, ও স্টাফ আপ্যায়নের বিবরণ (February-2026)	2026-02-02 00:00:00	স্টাফ টিফিন	1350	0.00	2026-04-16 09:37:50.157356
18	2	costing	বিবিধ খরচের বিবরণ (February-2026)	2026-02-02 00:00:00	পাথ 	330	0.00	2026-04-16 09:38:24.019553
19	2	costing	মাসিক বেতন প্রদান (স্টাফ ক্লিনার) (February-2026)	2026-02-02 00:00:00	মাসিক বেতন প্রদান রিফাত	15000	0.00	2026-04-16 09:41:30.804573
20	2	costing	মাসিক বেতন প্রদান (স্টাফ ক্লিনার) (February-2026)	2026-02-02 00:00:00	মাসিক বেতন প্রদান প্রিয় কুমার 2026	10000	0.00	2026-04-16 09:42:09.126331
21	2	costing	মাসিক বেতন প্রদান (স্টাফ ক্লিনার) (February-2026)	2026-02-02 00:00:00	মাসিক বেতন প্রদান তুলি রানী জানুয়ারি 2026	3500	0.00	2026-04-16 09:42:45.342276
22	2	costing	মাসিক বেতন প্রদান (স্টাফ ক্লিনার) (February-2026)	2026-02-02 00:00:00	মাসিক বেতন প্রদান কেয়া দাস জানুয়ারি 2026	3500	0.00	2026-04-16 09:43:13.690294
23	2	costing	মাসিক বেতন প্রদান (স্টাফ ক্লিনার) (February-2026)	2026-02-02 00:00:00	মাসিক বেতন প্রদান (স্টাফ ক্লিনার) মিন্টু জানুয়ারি 2026	9000	0.00	2026-04-16 09:43:37.768637
2	2	income	এক্সরে হতে প্রাপ্ত আয়	2026-02-01 00:00:00	এক্সরে হতে প্রাপ্ত আয়	32050	252.00	2026-04-16 01:19:42.30653
33	2	costing	ভুল ডেটা এন্ট্রি ও ডিসকাউন্ট (February-2026)	2026-02-03 00:00:00	রাইটিং বিল মিস্টেক	510	0.00	2026-04-16 09:57:07.550698
4	2	income	মেলটিং হতে প্রাপ্ত আয়	2026-02-01 00:00:00	মেলটিং হতে প্রাপ্ত আয়	21188	17.00	2026-04-16 01:20:56.160698
24	2	income	ওয়েল্ডিং হতে প্রাপ্ত আয়	2026-02-01 00:00:00	ওয়েল্ডিং হতে প্রাপ্ত আয়	4500	17.00	2026-04-16 09:49:29.972991
25	2	income	এক্সরে হতে প্রাপ্ত আয়	2026-02-03 00:00:00	এক্সরে হতে প্রাপ্ত আয়	34800	283.00	2026-04-16 09:53:11.287112
26	2	income	হলমার্ক হতে প্রাপ্ত আয়	2026-02-03 00:00:00	হলমার্ক হতে প্রাপ্ত আয়	30550	1573.00	2026-04-16 09:53:39.594915
27	2	income	ওয়েল্ডিং হতে প্রাপ্ত আয়	2026-02-03 00:00:00	ওয়েল্ডিং হতে প্রাপ্ত আয়	4200	18.00	2026-04-16 09:54:02.983632
29	2	costing	পরিচালক, অথিতি, ও স্টাফ আপ্যায়নের বিবরণ (February-2026)	2026-02-03 00:00:00	স্টাফ টিফিন	1300	0.00	2026-04-16 09:55:17.472112
30	2	costing	যাতায়াত সংক্রান্ত খরচের বিবরণ (February-2026)	2026-02-03 00:00:00	জিকে বিল ( কেরিয়ার)	250	0.00	2026-04-16 09:55:59.317182
31	2	costing	বিভিন্ন প্রকার বিল প্রদানের বিবরণ (February-2026)	2026-02-03 00:00:00	ডিস বিল	400	0.00	2026-04-16 09:56:18.102411
32	2	costing	বিবিধ খরচের বিবরণ (February-2026)	2026-02-03 00:00:00	বাট্টা (৫,১০,২০,৫০)	150	0.00	2026-04-16 09:56:37.128464
34	2	costing	রিফাইনিং প্রজেক্ট বিবিধ খরচ (February-2026)	2026-02-03 00:00:00	ভাড়া এডভান্সড প্রশান্ত	100000	0.00	2026-04-16 09:57:55.662109
35	2	income	মেলটিং হতে প্রাপ্ত আয়	2026-02-03 00:00:00	মেলটিং হতে প্রাপ্ত আয়	19452	140.00	2026-04-16 09:59:05.291669
36	2	income	স্বর্ণ পাকাইকরন হতে আয়	2026-02-03 00:00:00	স্বর্ণ পাকাইকরন বিল	2200	178.73	2026-04-16 10:00:04.427803
37	2	income	এক্সরে হতে প্রাপ্ত আয়	2026-02-05 00:00:00	এক্সরে হতে প্রাপ্ত আয়	48450	384.00	2026-04-16 10:04:28.961136
38	2	income	হলমার্ক হতে প্রাপ্ত আয়	2026-02-05 00:00:00	হলমার্ক হতে প্রাপ্ত আয়	23784	1572.00	2026-04-16 10:04:54.977734
39	2	income	মেলটিং হতে প্রাপ্ত আয়	2026-02-05 00:00:00	মেলটিং হতে প্রাপ্ত আয়	29176	144.00	2026-04-16 10:05:38.748307
40	2	income	ওয়েল্ডিং হতে প্রাপ্ত আয়	2026-02-05 00:00:00	ওয়েল্ডিং হতে প্রাপ্ত আয়	6300	20.00	2026-04-16 10:06:00.725726
41	2	income	স্বর্ণ পাকাইকরন হতে আয়	2026-02-05 00:00:00	স্বর্ণ পাকাইকরন বিল	1300	73.67	2026-04-16 10:06:26.53756
42	2	income	পরিচালকগনের লোণ ফেরত	2026-02-05 00:00:00	লোন ফেরত জানুয়ারি 2026	300000	0.00	2026-04-16 10:06:59.719755
43	2	costing	পরিচালক, অথিতি, ও স্টাফ আপ্যায়নের বিবরণ (February-2026)	2026-02-05 00:00:00	স্টাফ টিফিন	1350	0.00	2026-04-16 10:07:33.622699
44	2	costing	পরিচালক মাসিক সম্মানী প্রদান (February-2026)	2026-02-05 00:00:00	কাজী সিরাজুল ইসলাম	100000	0.00	2026-04-16 10:08:03.939279
45	2	costing	পরিচালক মাসিক সম্মানী প্রদান (February-2026)	2026-02-05 00:00:00	জনাব গঙ্গাচরণ মালাকার	90000	0.00	2026-04-16 10:08:16.317817
46	2	costing	পরিচালক মাসিক সম্মানী প্রদান (February-2026)	2026-02-05 00:00:00	জনাব ডা. দিলীপ কুমার রায়	100000	0.00	2026-04-16 10:08:32.305497
47	2	costing	পরিচালক মাসিক সম্মানী প্রদান (February-2026)	2026-02-05 00:00:00	জনাব এনামুল হক খান	190000	0.00	2026-04-16 10:08:53.605554
48	2	costing	পরিচালক মাসিক সম্মানী প্রদান (February-2026)	2026-02-05 00:00:00	জনাব মিজানুর রহমান	90000	0.00	2026-04-16 10:09:12.209776
49	2	costing	পরিচালক মাসিক সম্মানী প্রদান (February-2026)	2026-02-05 00:00:00	জনাব রঞ্জিত ঘোষ	90000	0.00	2026-04-16 10:09:20.925598
50	2	costing	পরিচালক মাসিক সম্মানী প্রদান (February-2026)	2026-02-05 00:00:00	জনাব বাবুল মিয়া	90000	0.00	2026-04-16 10:09:34.440793
51	2	costing	পরিচালক মাসিক সম্মানী প্রদান (February-2026)	2026-02-05 00:00:00	জনাব আবুল খায়ের সিকদার	90000	0.00	2026-04-16 10:09:51.640355
52	2	costing	পরিচালক মাসিক সম্মানী প্রদান (February-2026)	2026-02-05 00:00:00	জনাব ভোলানাথ ঘোষ	90000	0.00	2026-04-16 10:10:04.29452
53	2	costing	কাঁচামাল ও বিভিন্ন এসিড ক্রয় (February-2026)	2026-02-05 00:00:00	মেলটিং পেপার 1 লাখ পিস বাবু	165000	0.00	2026-04-16 10:11:41.062449
54	2	costing	পরিচালক, অথিতি, ও স্টাফ আপ্যায়নের বিবরণ (February-2026)	2026-02-05 00:00:00	অতিথি আপ্যায়ন জিকে	1000	0.00	2026-04-16 10:11:56.047559
55	2	costing	যাতায়াত সংক্রান্ত খরচের বিবরণ (February-2026)	2026-02-05 00:00:00	বায়তুল মোকারম	200	0.00	2026-04-16 10:12:21.44818
56	2	costing	বিভিন্ন প্রকার বিল প্রদানের বিবরণ (February-2026)	2026-02-05 00:00:00	ইন্টারনেট বিল জানুয়ারি 2026	3350	0.00	2026-04-16 10:12:57.508268
57	2	costing	রিফাইনিং প্রজেক্ট বিবিধ খরচ (February-2026)	2026-02-05 00:00:00	এসি ক্রয়	6800	0.00	2026-04-16 10:13:19.482962
59	2	income	হলমার্ক হতে প্রাপ্ত আয়	2026-02-06 00:00:00	হলমার্ক হতে প্রাপ্ত আয়	2660	133.00	2026-04-16 10:31:04.981113
60	2	income	ওয়েল্ডিং হতে প্রাপ্ত আয়	2026-02-06 00:00:00	ওয়েল্ডিং হতে প্রাপ্ত আয়	400	1.00	2026-04-16 10:31:21.923217
61	2	income	মেলটিং হতে প্রাপ্ত আয়	2026-02-06 00:00:00	মেলটিং হতে প্রাপ্ত আয়	1919	8.00	2026-04-16 10:31:56.875846
72	2	income	ওয়েল্ডিং হতে প্রাপ্ত আয়	2026-02-08 00:00:00	ওয়েল্ডিং হতে প্রাপ্ত আয়	5500	15.00	2026-04-16 10:42:09.068574
58	2	income	এক্সরে হতে প্রাপ্ত আয়	2026-02-06 00:00:00	এক্সরে হতে প্রাপ্ত আয়	3450	25.00	2026-04-16 10:30:36.51415
64	2	income	মেলটিং হতে প্রাপ্ত আয়	2026-02-07 00:00:00	মেলটিং হতে প্রাপ্ত আয়	25051	149.00	2026-04-16 10:34:09.603662
65	2	income	ওয়েল্ডিং হতে প্রাপ্ত আয়	2026-02-07 00:00:00	ওয়েল্ডিং হতে প্রাপ্ত আয়	8200	18.00	2026-04-16 10:34:31.415408
63	2	income	হলমার্ক হতে প্রাপ্ত আয়	2026-02-07 00:00:00	হলমার্ক হতে প্রাপ্ত আয়	13280	667.00	2026-04-16 10:33:21.09446
62	2	income	এক্সরে হতে প্রাপ্ত আয়	2026-02-07 00:00:00	এক্সরে হতে প্রাপ্ত আয়	40400	321.00	2026-04-16 10:32:59.697854
66	2	costing	পরিচালক, অথিতি, ও স্টাফ আপ্যায়নের বিবরণ (February-2026)	2026-02-07 00:00:00	স্টাফ টিফিন	1300	0.00	2026-04-16 10:35:57.828499
67	2	costing	বিদুৎ বিল বিবরণ (February-2026)	2026-02-07 00:00:00	পুরাতন মিটার	20000	0.00	2026-04-16 10:36:32.603086
68	2	costing	রিফাইনিং প্রজেক্ট বিবিধ খরচ (February-2026)	2026-02-07 00:00:00	রিফাইনিং প্রজেক্ট বিবিধ খরচ (February-2026)	17100	0.00	2026-04-16 10:36:51.125
69	2	income	এক্সরে হতে প্রাপ্ত আয়	2026-02-08 00:00:00	এক্সরে হতে প্রাপ্ত আয়	36000	281.00	2026-04-16 10:40:47.412342
70	2	income	হলমার্ক হতে প্রাপ্ত আয়	2026-02-08 00:00:00	হলমার্ক হতে প্রাপ্ত আয়	30733	1654.00	2026-04-16 10:41:16.040304
71	2	income	মেলটিং হতে প্রাপ্ত আয়	2026-02-08 00:00:00	মেলটিং হতে প্রাপ্ত আয়	30185	151.00	2026-04-16 10:41:49.489627
73	2	income	ডাস্ট বিক্রয় হতে আয়	2026-02-08 00:00:00	নেহারা জানুয়ারি 2026	100000	0.00	2026-04-16 10:44:10.083182
74	2	costing	পরিচালক, অথিতি, ও স্টাফ আপ্যায়নের বিবরণ (February-2026)	2026-02-08 00:00:00	স্টাফ টিফিন	1600	0.00	2026-04-16 10:44:49.052287
75	2	costing	বিদুৎ বিল বিবরণ (February-2026)	2026-02-08 00:00:00	নতুন মিটার	10000	0.00	2026-04-16 10:45:05.731533
76	2	costing	বিবিধ খরচের বিবরণ (February-2026)	2026-02-08 00:00:00	বাট্টা (৫,১০,২০,৫০)	150	0.00	2026-04-16 10:45:26.728761
77	2	costing	মাসিক বেতন প্রদান (স্টাফ ক্লিনার) (February-2026)	2026-02-08 00:00:00	সুবর্ণা ফেব্রুয়ারি 26	5060	0.00	2026-04-16 10:46:18.394447
78	2	costing	বিভিন্ন প্রকার বিল প্রদানের বিবরণ (February-2026)	2026-02-08 00:00:00	সিসি টিভি বিল জানুয়ারি 2026	1000	0.00	2026-04-16 10:46:44.776453
79	2	costing	বিভিন্ন প্রকার বিল প্রদানের বিবরণ (February-2026)	2026-02-08 00:00:00	সফ্টওয়ার মেইনটেইন চার্জ বাবু	4000	0.00	2026-04-16 10:47:25.225064
80	2	costing	রিফাইনিং প্রজেক্ট বিবিধ খরচ (February-2026)	2026-02-08 00:00:00	সিলিন্ডার গ্যাস 1 পিচ বোতল সহ	4600	0.00	2026-04-16 10:48:00.140241
81	2	income	স্বর্ণ পাকাইকরন হতে আয়	2026-02-08 00:00:00	স্বর্ণ পাকাইকরন বিল	1750	103.11	2026-04-16 10:49:30.532974
82	2	income	এক্সরে হতে প্রাপ্ত আয়	2026-02-09 00:00:00	এক্সরে হতে প্রাপ্ত আয়	31950	250.00	2026-04-16 10:50:11.255945
83	2	income	হলমার্ক হতে প্রাপ্ত আয়	2026-02-09 00:00:00	হলমার্ক হতে প্রাপ্ত আয়	12865	657.00	2026-04-16 10:50:38.967803
84	2	income	মেলটিং হতে প্রাপ্ত আয়	2026-02-09 00:00:00	মেলটিং হতে প্রাপ্ত আয়	23413	130.00	2026-04-16 10:51:06.597402
85	2	income	ওয়েল্ডিং হতে প্রাপ্ত আয়	2026-02-09 00:00:00	ওয়েল্ডিং হতে প্রাপ্ত আয়	3200	7.00	2026-04-16 10:52:10.843038
86	2	income	স্বর্ণ পাকাইকরন হতে আয়	2026-02-09 00:00:00	স্বর্ণ পাকাইকরন বিল	2170	148.88	2026-04-16 10:52:38.593928
87	2	costing	পরিচালক, অথিতি, ও স্টাফ আপ্যায়নের বিবরণ (February-2026)	2026-02-09 00:00:00	স্টাফ টিফিন	1350	0.00	2026-04-16 10:53:06.679196
88	2	costing	স্টাফ লোন প্রদান এর বিবরণ (February-2026)	2026-02-09 00:00:00	স্যালারি লোন	240000	0.00	2026-04-16 10:53:54.303334
89	2	costing	বিবিধ খরচের বিবরণ (February-2026)	2026-02-09 00:00:00	বাট্টা (৫,১০,২০,৫০)	360	0.00	2026-04-16 10:54:20.630228
90	2	costing	যাতায়াত সংক্রান্ত খরচের বিবরণ (February-2026)	2026-02-09 00:00:00	লিটন	200	0.00	2026-04-16 10:55:07.816639
91	2	costing	বিবিধ খরচের বিবরণ (February-2026)	2026-02-09 00:00:00	তৃতীয় লিঙ্গ	100	0.00	2026-04-16 10:55:21.595882
92	2	costing	বিবিধ খরচের বিবরণ (February-2026)	2026-02-09 00:00:00	কফি কাপ	900	0.00	2026-04-16 10:55:40.006676
93	2	costing	বিবিধ খরচের বিবরণ (February-2026)	2026-02-09 00:00:00	স্কেচ মেশিন মেরামত	900	0.00	2026-04-16 10:56:00.072722
94	2	costing	বিবিধ খরচের বিবরণ (February-2026)	2026-02-09 00:00:00	পার্সেল জিকে	250	0.00	2026-04-16 10:56:19.785452
95	2	income	এক্সরে হতে প্রাপ্ত আয়	2026-02-10 00:00:00	এক্সরে হতে প্রাপ্ত আয়	24600	202.00	2026-04-16 10:57:04.172789
96	2	income	হলমার্ক হতে প্রাপ্ত আয়	2026-02-10 00:00:00	হলমার্ক হতে প্রাপ্ত আয়	14900	674.00	2026-04-16 10:57:29.627281
97	2	income	মেলটিং হতে প্রাপ্ত আয়	2026-02-10 00:00:00	মেলটিং হতে প্রাপ্ত আয়	9955	78.00	2026-04-16 10:57:59.99368
98	2	income	ওয়েল্ডিং হতে প্রাপ্ত আয়	2026-02-10 00:00:00	ওয়েল্ডিং হতে প্রাপ্ত আয়	4800	20.00	2026-04-16 10:58:20.727156
99	2	income	স্বর্ণ পাকাইকরন হতে আয়	2026-02-10 00:00:00	স্বর্ণ পাকাইকরন বিল	1200	70.43	2026-04-16 10:58:40.078513
100	2	costing	পরিচালক, অথিতি, ও স্টাফ আপ্যায়নের বিবরণ (February-2026)	2026-02-10 00:00:00	স্টাফ টিফিন	1300	0.00	2026-04-16 10:59:04.258174
101	2	costing	স্টেশনারি ও পি.পি.ই খরচের বিবরণ (February-2026)	2026-02-10 00:00:00	টিস্যু, ভীম, আইরফ্রেশ, সার্ফ এক্সেল	10730	0.00	2026-04-16 11:00:14.339847
102	2	costing	স্টেশনারি ও পি.পি.ই খরচের বিবরণ (February-2026)	2026-02-10 00:00:00	টোনার 4 পিচ	5600	0.00	2026-04-16 11:00:47.865752
103	2	costing	স্টেশনারি ও পি.পি.ই খরচের বিবরণ (February-2026)	2026-02-10 00:00:00	রিবন 24 পিচ	9120	0.00	2026-04-16 11:01:10.80097
104	2	costing	স্টেশনারি ও পি.পি.ই খরচের বিবরণ (February-2026)	2026-02-10 00:00:00	প্রিন্টার কালি 20 পিচ	7000	0.00	2026-04-16 11:01:38.753244
105	2	costing	বাইতুল মোকারাম অফিস খরচ (February-2026)	2026-02-10 00:00:00	ভ্যাট জানুয়ারি 2026	4050	0.00	2026-04-16 11:02:45.645453
106	2	costing	রিফাইনিং প্রজেক্ট বিবিধ খরচ (February-2026)	2026-02-10 00:00:00	ভ্যাট	2080	0.00	2026-04-16 11:05:16.226989
107	2	costing	বিবিধ খরচের বিবরণ (February-2026)	2026-02-10 00:00:00	বাংলা গোল্ড জানুয়ারি ভ্যাট 2026	38070	0.00	2026-04-16 11:06:30.173746
108	2	costing	বিবিধ খরচের বিবরণ (February-2026)	2026-02-10 00:00:00	গণেশ জানুয়ারি 2026	7000	0.00	2026-04-16 11:06:58.029967
109	2	income	এক্সরে হতে প্রাপ্ত আয়	2026-02-14 00:00:00	এক্সরে হতে প্রাপ্ত আয়	14300	114.00	2026-04-16 11:07:46.735315
110	2	income	হলমার্ক হতে প্রাপ্ত আয়	2026-02-14 00:00:00	হলমার্ক হতে প্রাপ্ত আয়	5930	294.00	2026-04-16 11:08:28.811233
111	2	income	মেলটিং হতে প্রাপ্ত আয়	2026-02-14 00:00:00	মেলটিং হতে প্রাপ্ত আয়	10791	8465.53	2026-04-16 11:08:58.533325
112	2	income	ওয়েল্ডিং হতে প্রাপ্ত আয়	2026-02-14 00:00:00	ওয়েল্ডিং হতে প্রাপ্ত আয়	6200	5.00	2026-04-16 11:09:13.493578
113	2	costing	পরিচালক, অথিতি, ও স্টাফ আপ্যায়নের বিবরণ (February-2026)	2026-02-14 00:00:00	স্টাফ টিফিন	900	0.00	2026-04-16 11:09:25.413209
114	2	income	এক্সরে হতে প্রাপ্ত আয়	2026-02-15 00:00:00	এক্সরে হতে প্রাপ্ত আয়	33950	265.00	2026-04-16 15:10:46.440576
115	2	income	হলমার্ক হতে প্রাপ্ত আয়	2026-02-15 00:00:00	হলমার্ক হতে প্রাপ্ত আয়	18220	1342.00	2026-04-16 15:11:15.917593
116	2	income	মেলটিং হতে প্রাপ্ত আয়	2026-02-15 00:00:00	মেলটিং হতে প্রাপ্ত আয়	24809	111.00	2026-04-16 15:11:37.350148
117	2	income	ওয়েল্ডিং হতে প্রাপ্ত আয়	2026-02-15 00:00:00	ওয়েল্ডিং হতে প্রাপ্ত আয়	4300	14.00	2026-04-16 15:12:14.97488
118	2	income	স্বর্ণ পাকাইকরন হতে আয়	2026-02-15 00:00:00	স্বর্ণ পাকাইকরন বিল	3750	367.52	2026-04-16 15:13:02.898422
119	2	costing	পরিচালক, অথিতি, ও স্টাফ আপ্যায়নের বিবরণ (February-2026)	2026-02-15 00:00:00	স্টাফ টিফিন	1250	0.00	2026-04-16 15:14:18.961785
120	2	costing	যাতায়াত সংক্রান্ত খরচের বিবরণ (February-2026)	2026-02-15 00:00:00	যাতায়াত - মাসুদ	200	0.00	2026-04-16 15:14:38.159947
121	2	costing	বিবিধ খরচের বিবরণ (February-2026)	2026-02-15 00:00:00	চেয়ার 1 পিচ	5600	0.00	2026-04-16 15:15:11.915872
122	2	costing	বিবিধ খরচের বিবরণ (February-2026)	2026-02-15 00:00:00	তৃতীয় লিঙ্গ	100	0.00	2026-04-16 15:15:23.230195
123	2	costing	বিবিধ খরচের বিবরণ (February-2026)	2026-02-15 00:00:00	নক্ষত্র টাওয়ার জানুয়ারি 2026	13130	0.00	2026-04-16 15:16:49.345308
124	2	costing	বিবিধ খরচের বিবরণ (February-2026)	2026-02-15 00:00:00	তেল	200	0.00	2026-04-16 15:17:03.951095
125	2	costing	বিবিধ খরচের বিবরণ (February-2026)	2026-02-15 00:00:00	বাট্টা (৫,১০,২০,৫০)	150	0.00	2026-04-16 15:17:18.131218
126	2	costing	বিবিধ খরচের বিবরণ (February-2026)	2026-02-15 00:00:00	চন্দি পাকা 1 ভরি	4500	0.00	2026-04-16 15:17:53.579165
127	2	costing	বিবিধ খরচের বিবরণ (February-2026)	2026-02-15 00:00:00	রাজু রাজেশরী বাকি আছে আর 381,280 টাকা	300000	0.00	2026-04-16 15:19:06.973653
128	2	income	এক্সরে হতে প্রাপ্ত আয়	2026-02-16 00:00:00	এক্সরে হতে প্রাপ্ত আয়	39300	314.00	2026-04-16 15:19:49.31497
129	2	income	হলমার্ক হতে প্রাপ্ত আয়	2026-02-16 00:00:00	হলমার্ক হতে প্রাপ্ত আয়	10545	383.00	2026-04-16 15:20:38.950347
130	2	income	মেলটিং হতে প্রাপ্ত আয়	2026-02-16 00:00:00	মেলটিং হতে প্রাপ্ত আয়	22160	128.00	2026-04-16 15:21:02.935125
131	2	income	ওয়েল্ডিং হতে প্রাপ্ত আয়	2026-02-16 00:00:00	ওয়েল্ডিং হতে প্রাপ্ত আয়	3000	13.00	2026-04-16 15:21:19.521938
132	2	income	স্বর্ণ পাকাইকরন হতে আয়	2026-02-16 00:00:00	স্বর্ণ পাকাইকরন বিল	1500	108.84	2026-04-16 15:21:44.40984
133	2	costing	পরিচালক, অথিতি, ও স্টাফ আপ্যায়নের বিবরণ (February-2026)	2026-02-16 00:00:00	স্টাফ টিফিন	1300	0.00	2026-04-16 15:22:13.194345
134	2	costing	যাতায়াত সংক্রান্ত খরচের বিবরণ (February-2026)	2026-02-16 00:00:00	নারায়ণ	260	0.00	2026-04-16 15:22:40.403261
135	2	costing	বিবিধ খরচের বিবরণ (February-2026)	2026-02-16 00:00:00	পাথ	300	0.00	2026-04-16 15:23:03.972945
136	2	costing	বিবিধ খরচের বিবরণ (February-2026)	2026-02-16 00:00:00	বাট্টা (৫,১০,২০,৫০)	80	0.00	2026-04-16 15:23:13.462421
137	2	income	এক্সরে হতে প্রাপ্ত আয়	2026-02-17 00:00:00	এক্সরে হতে প্রাপ্ত আয়	40650	317.00	2026-04-16 15:24:23.298868
138	2	income	হলমার্ক হতে প্রাপ্ত আয়	2026-02-17 00:00:00	হলমার্ক হতে প্রাপ্ত আয়	10625	550.00	2026-04-16 15:24:59.648576
139	2	income	মেলটিং হতে প্রাপ্ত আয়	2026-02-17 00:00:00	মেলটিং হতে প্রাপ্ত আয়	22710	132.00	2026-04-16 15:25:32.11243
140	2	income	স্বর্ণ পাকাইকরন হতে আয়	2026-02-17 00:00:00	স্বর্ণ পাকাইকরন বিল	3140	425.34	2026-04-16 15:26:00.208558
141	2	costing	পরিচালক, অথিতি, ও স্টাফ আপ্যায়নের বিবরণ (February-2026)	2026-02-17 00:00:00	স্টাফ টিফিন	1300	0.00	2026-04-16 15:26:36.160362
142	2	costing	বিদুৎ বিল বিবরণ (February-2026)	2026-02-17 00:00:00	নতুন ও পুরনো মিটার	30000	0.00	2026-04-16 15:27:27.985403
143	2	costing	বিবিধ খরচের বিবরণ (February-2026)	2026-02-17 00:00:00	2 আনা পাকা স্বর্ণ (প্রধান) শাখা	29380	0.00	2026-04-16 15:28:54.805592
144	2	costing	বিবিধ খরচের বিবরণ (February-2026)	2026-02-17 00:00:00	বাট্টা (৫,১০,২০,৫০)	100	0.00	2026-04-16 15:29:03.590939
145	2	costing	মাসিক বেতন প্রদান (স্টাফ ক্লিনার) (February-2026)	2026-02-17 00:00:00	সুবর্ণা জানুয়ারি 2026	7500	0.00	2026-04-16 15:29:38.915646
146	2	income	ওয়েল্ডিং হতে প্রাপ্ত আয়	2026-02-17 00:00:00	ওয়েল্ডিং হতে প্রাপ্ত আয়	4200	13.00	2026-04-16 15:30:30.057945
147	2	income	এক্সরে হতে প্রাপ্ত আয়	2026-02-18 00:00:00	এক্সরে হতে প্রাপ্ত আয়	35150	290.00	2026-04-16 15:32:05.167999
148	2	income	হলমার্ক হতে প্রাপ্ত আয়	2026-02-18 00:00:00	হলমার্ক হতে প্রাপ্ত আয়	15460	848.00	2026-04-16 15:32:30.642913
149	2	income	মেলটিং হতে প্রাপ্ত আয়	2026-02-18 00:00:00	মেলটিং হতে প্রাপ্ত আয়	21524	141.00	2026-04-16 15:33:09.052527
150	2	income	ওয়েল্ডিং হতে প্রাপ্ত আয়	2026-02-18 00:00:00	ওয়েল্ডিং হতে প্রাপ্ত আয়	3000	14.00	2026-04-16 15:33:28.158903
151	2	income	ওয়েল্ডিং হতে প্রাপ্ত আয়	2026-02-18 00:00:00	ওয়েল্ডিং হতে প্রাপ্ত আয়	2000	124.46	2026-04-16 15:33:43.846618
152	2	costing	পরিচালক, অথিতি, ও স্টাফ আপ্যায়নের বিবরণ (February-2026)	2026-02-18 00:00:00	স্টাফ টিফিন	1350	0.00	2026-04-16 15:34:06.679701
153	2	costing	যাতায়াত সংক্রান্ত খরচের বিবরণ (February-2026)	2026-02-18 00:00:00	যাতায়াত দীপ	200	0.00	2026-04-16 15:34:29.84354
154	2	costing	বিবিধ খরচের বিবরণ (February-2026)	2026-02-18 00:00:00	মিটার মেরামত পুরাতন 	2800	0.00	2026-04-16 15:35:27.486463
155	2	costing	ভুল ডেটা এন্ট্রি ও ডিসকাউন্ট (February-2026)	2026-02-18 00:00:00	রাইটিং বিল মিস্টেক	620	0.00	2026-04-16 15:35:51.467543
156	2	costing	বিবিধ খরচের বিবরণ (February-2026)	2026-02-18 00:00:00	বাট্টা (৫,১০,২০,৫০)	150	0.00	2026-04-16 15:36:06.485543
157	2	costing	পরিচালক, অথিতি, ও স্টাফ আপ্যায়নের বিবরণ (February-2026)	2026-02-18 00:00:00	48 পিস পানি	500	0.00	2026-04-16 15:36:35.261769
158	2	income	এক্সরে হতে প্রাপ্ত আয়	2026-02-19 00:00:00	এক্সরে হতে প্রাপ্ত আয়	36500	285.00	2026-04-16 15:37:38.376441
159	2	income	হলমার্ক হতে প্রাপ্ত আয়	2026-02-19 00:00:00	হলমার্ক হতে প্রাপ্ত আয়	13940	846.00	2026-04-16 15:38:05.005539
160	2	income	মেলটিং হতে প্রাপ্ত আয়	2026-02-19 00:00:00	মেলটিং হতে প্রাপ্ত আয়	27926	137.00	2026-04-16 15:38:29.850989
161	2	income	ওয়েল্ডিং হতে প্রাপ্ত আয়	2026-02-19 00:00:00	ওয়েল্ডিং হতে প্রাপ্ত আয়	5900	16.00	2026-04-16 15:39:06.698197
162	2	income	বিবিধ আয়	2026-02-19 00:00:00	স্টাফ লোন ফেরত	240000	0.00	2026-04-16 15:40:00.131808
163	2	income	স্বর্ণ পাকাইকরন হতে আয়	2026-02-19 00:00:00	স্বর্ণ পাকাইকরন বিল	400	27.36	2026-04-16 15:40:21.586339
164	2	costing	পরিচালক, অথিতি, ও স্টাফ আপ্যায়নের বিবরণ (February-2026)	2026-02-19 00:00:00	ইফতার 	3000	0.00	2026-04-16 15:43:04.453744
166	2	costing	ব্যাংক এ যাবতীয় জমা (February-2026)	2026-02-19 00:00:00	প্রভিডেন্ট ফান্ড জানুয়ারি 2026	24050	0.00	2026-04-16 15:44:16.906092
167	2	costing	ব্যাংক এ যাবতীয় জমা (February-2026)	2026-02-19 00:00:00	ওয়েলফেয়ার ফান্ড জানুয়ারি 2026	16250	0.00	2026-04-16 15:44:45.972609
169	2	costing	বিবিধ খরচের বিবরণ (February-2026)	2026-02-19 00:00:00	বাজুস চাঁদা ফেব্রুয়ারি 2026	1000	0.00	2026-04-16 15:46:07.663024
170	2	income	এক্সরে হতে প্রাপ্ত আয়	2026-02-20 00:00:00	এক্সরে হতে প্রাপ্ত আয়	1900	14.00	2026-04-16 15:52:13.141021
171	2	income	হলমার্ক হতে প্রাপ্ত আয়	2026-02-20 00:00:00	হলমার্ক হতে প্রাপ্ত আয়	2400	159.00	2026-04-16 15:52:51.710543
172	2	income	মেলটিং হতে প্রাপ্ত আয়	2026-02-20 00:00:00	মেলটিং হতে প্রাপ্ত আয়	869	5.00	2026-04-16 15:53:20.140563
168	2	costing	বিবিধ খরচের বিবরণ (February-2026)	2026-02-19 00:00:00	তৃতীয় লিঙ্গ	200	0.00	2026-04-16 15:45:09.520016
165	2	costing	ব্যাংক এ যাবতীয় জমা (February-2026)	2026-02-19 00:00:00	নবাবপুর শাখা	100000	0.00	2026-04-16 15:43:45.462571
173	2	income	এক্সরে হতে প্রাপ্ত আয়	2026-02-22 00:00:00	এক্সরে হতে প্রাপ্ত আয়	52400	416.00	2026-04-16 15:59:37.455962
174	2	income	হলমার্ক হতে প্রাপ্ত আয়	2026-02-22 00:00:00	হলমার্ক হতে প্রাপ্ত আয়	24405	1344.00	2026-04-16 16:00:02.31274
175	2	income	মেলটিং হতে প্রাপ্ত আয়	2026-02-22 00:00:00	মেলটিং হতে প্রাপ্ত আয়	36138	178.00	2026-04-16 16:00:46.678946
176	2	income	ওয়েল্ডিং হতে প্রাপ্ত আয়	2026-02-22 00:00:00	ওয়েল্ডিং হতে প্রাপ্ত আয়	5300	19.00	2026-04-16 16:01:12.067903
177	2	income	স্বর্ণ পাকাইকরন হতে আয়	2026-02-22 00:00:00	স্বর্ণ পাকাইকরন বিল	3950	377.32	2026-04-16 16:01:54.33588
178	2	costing	পরিচালক, অথিতি, ও স্টাফ আপ্যায়নের বিবরণ (February-2026)	2026-02-22 00:00:00	ইফতার	3000	0.00	2026-04-16 16:02:14.97291
179	2	costing	বিবিধ খরচের বিবরণ (February-2026)	2026-02-22 00:00:00	বাট্টা (৫,১০,২০,৫০)	150	0.00	2026-04-16 16:02:26.418477
180	2	costing	ভুল ডেটা এন্ট্রি ও ডিসকাউন্ট (February-2026)	2026-02-22 00:00:00	রাইটিং বিল মিস্টেক	1020	0.00	2026-04-16 16:02:45.53452
181	2	costing	রিফাইনিং প্রজেক্ট বিবিধ খরচ (February-2026)	2026-02-22 00:00:00	সার্ভিস চার্জ ফেব্রুয়ারি 2026	5100	0.00	2026-04-16 16:03:09.39089
182	2	income	এক্সরে হতে প্রাপ্ত আয়	2026-02-23 00:00:00	এক্সরে হতে প্রাপ্ত আয়	52100	422.00	2026-04-16 16:04:04.89764
183	2	income	হলমার্ক হতে প্রাপ্ত আয়	2026-02-23 00:00:00	হলমার্ক হতে প্রাপ্ত আয়	14070	756.00	2026-04-16 16:04:58.736574
184	2	income	মেলটিং হতে প্রাপ্ত আয়	2026-02-23 00:00:00	মেলটিং হতে প্রাপ্ত আয়	27396	142.00	2026-04-16 16:05:35.625156
185	2	income	ওয়েল্ডিং হতে প্রাপ্ত আয়	2026-02-23 00:00:00	ওয়েল্ডিং হতে প্রাপ্ত আয়	1900	7.00	2026-04-16 16:05:55.414428
186	2	costing	পরিচালক, অথিতি, ও স্টাফ আপ্যায়নের বিবরণ (February-2026)	2026-02-23 00:00:00	ইফতার	3000	0.00	2026-04-16 16:06:14.966177
187	2	costing	বিবিধ খরচের বিবরণ (February-2026)	2026-02-23 00:00:00	বাট্টা (৫,১০,২০,৫০)	270	0.00	2026-04-16 16:06:28.356165
188	2	costing	বিবিধ খরচের বিবরণ (February-2026)	2026-02-23 00:00:00	পাথ	300	0.00	2026-04-16 16:07:04.213074
189	2	costing	বাইতুল মোকারাম অফিস খরচ (February-2026)	2026-02-23 00:00:00	বায়তুল মোকারম এর এসি সার্ভিস ও কাম্প্রাসের মেরামত	34000	0.00	2026-04-16 16:08:13.521791
190	2	costing	বিবিধ খরচের বিবরণ (February-2026)	2026-02-23 00:00:00	পানির মিটার মেরামত	3000	0.00	2026-04-16 16:08:55.113976
191	2	costing	বিবিধ খরচের বিবরণ (February-2026)	2026-02-23 00:00:00	রাজু রাজেসরী ফুল পেমেন্ট	381280	0.00	2026-04-16 16:10:08.566519
192	2	income	এক্সরে হতে প্রাপ্ত আয়	2026-02-24 00:00:00	এক্সরে হতে প্রাপ্ত আয়	44950	350.00	2026-04-16 16:10:48.99323
193	2	income	হলমার্ক হতে প্রাপ্ত আয়	2026-02-24 00:00:00	হলমার্ক হতে প্রাপ্ত আয়	11800	578.00	2026-04-16 16:11:25.026627
194	2	income	মেলটিং হতে প্রাপ্ত আয়	2026-02-24 00:00:00	মেলটিং হতে প্রাপ্ত আয়	28986	152.00	2026-04-16 16:12:05.076064
195	2	income	স্বর্ণ পাকাইকরন হতে আয়	2026-02-24 00:00:00	স্বর্ণ পাকাইকরন বিল	3650	262.64	2026-04-16 16:12:31.172752
196	2	costing	পরিচালক, অথিতি, ও স্টাফ আপ্যায়নের বিবরণ (February-2026)	2026-02-24 00:00:00	ইফতার	3000	0.00	2026-04-16 16:12:57.345828
197	2	costing	বিবিধ খরচের বিবরণ (February-2026)	2026-02-24 00:00:00	বাট্টা (৫,১০,২০,৫০)	150	0.00	2026-04-16 16:13:12.838262
198	2	costing	বিবিধ খরচের বিবরণ (February-2026)	2026-02-24 00:00:00	তৃতীয় লিঙ্গ	200	0.00	2026-04-16 16:13:22.670575
199	2	costing	রিফাইনিং প্রজেক্ট বিবিধ খরচ (February-2026)	2026-02-24 00:00:00	নাইট্রিক এসিড 6 গ্যালন	14700	0.00	2026-04-16 16:14:53.708589
200	2	income	ওয়েল্ডিং হতে প্রাপ্ত আয়	2026-02-24 00:00:00	ওয়েল্ডিং হতে প্রাপ্ত আয়	7400	22.00	2026-04-16 16:15:49.235886
201	2	income	এক্সরে হতে প্রাপ্ত আয়	2026-02-25 00:00:00	এক্সরে হতে প্রাপ্ত আয়	45100	360.00	2026-04-16 16:17:00.48848
202	2	income	হলমার্ক হতে প্রাপ্ত আয়	2026-02-25 00:00:00	হলমার্ক হতে প্রাপ্ত আয়	11930	668.00	2026-04-16 16:17:25.495453
203	2	income	মেলটিং হতে প্রাপ্ত আয়	2026-02-25 00:00:00	মেলটিং হতে প্রাপ্ত আয়	27708	142.00	2026-04-16 16:17:47.523671
204	2	income	ওয়েল্ডিং হতে প্রাপ্ত আয়	2026-02-25 00:00:00	ওয়েল্ডিং হতে প্রাপ্ত আয়	300	2.00	2026-04-16 16:18:58.802627
205	2	income	স্বর্ণ পাকাইকরন হতে আয়	2026-02-25 00:00:00	স্বর্ণ পাকাইকরন বিল	400	39.29	2026-04-16 16:19:19.463636
206	2	costing	পরিচালক, অথিতি, ও স্টাফ আপ্যায়নের বিবরণ (February-2026)	2026-02-25 00:00:00	ইফতার	3000	0.00	2026-04-16 16:19:36.555947
207	2	costing	বিবিধ খরচের বিবরণ (February-2026)	2026-02-25 00:00:00	উৎস কর প্রধান ফেব্রুয়ারি 2025	11000	0.00	2026-04-16 16:20:26.254029
208	2	costing	বিবিধ খরচের বিবরণ (February-2026)	2026-02-25 00:00:00	বাজুস নতুন সদস্য ফি 	5000	0.00	2026-04-16 16:21:03.310463
209	2	costing	রিফাইনিং প্রজেক্ট বিবিধ খরচ (February-2026)	2026-02-25 00:00:00	লাইট। হাত মোজা 	1900	0.00	2026-04-16 16:21:42.291866
210	2	costing	বিবিধ খরচের বিবরণ (February-2026)	2026-02-25 00:00:00	রেক্সিন হাত মোজা	1800	0.00	2026-04-16 16:22:23.190677
211	2	costing	বিবিধ খরচের বিবরণ (February-2026)	2026-02-25 00:00:00	স্টাফ নিউ একাউন্ট রিফাত + পিউ	2400	0.00	2026-04-16 16:23:12.132756
235	3	income	মেলটিং হতে প্রাপ্ত আয়	2026-03-01 00:00:00	মেলটিং হতে প্রাপ্ত আয়	21454	141.00	2026-04-16 17:07:55.206523
212	2	income	এক্সরে হতে প্রাপ্ত আয়	2026-02-26 00:00:00	এক্সরে হতে প্রাপ্ত আয়	42600	335.00	2026-04-16 16:25:10.901974
213	2	income	হলমার্ক হতে প্রাপ্ত আয়	2026-02-26 00:00:00	হলমার্ক হতে প্রাপ্ত আয়	15990	880.00	2026-04-16 16:26:55.483281
214	2	income	মেলটিং হতে প্রাপ্ত আয়	2026-02-26 00:00:00	মেলটিং হতে প্রাপ্ত আয়	35542	137.00	2026-04-16 16:28:24.143181
215	2	income	ওয়েল্ডিং হতে প্রাপ্ত আয়	2026-02-26 00:00:00	ওয়েল্ডিং হতে প্রাপ্ত আয়	1300	8.00	2026-04-16 16:28:54.361795
216	2	income	স্বর্ণ পাকাইকরন হতে আয়	2026-02-26 00:00:00	স্বর্ণ পাকাইকরন বিল	1000	124.91	2026-04-16 16:29:23.84859
217	2	costing	পরিচালক, অথিতি, ও স্টাফ আপ্যায়নের বিবরণ (February-2026)	2026-02-26 00:00:00	ইফতার	3000	0.00	2026-04-16 16:29:44.493549
218	2	costing	বিবিধ খরচের বিবরণ (February-2026)	2026-02-26 00:00:00	বাট্টা (৫,১০,২০,৫০)	230	0.00	2026-04-16 16:30:00.710261
219	2	income	এক্সরে হতে প্রাপ্ত আয়	2026-02-27 00:00:00	এক্সরে হতে প্রাপ্ত আয়	1650	12.00	2026-04-16 16:31:22.214057
220	2	income	হলমার্ক হতে প্রাপ্ত আয়	2026-02-27 00:00:00	হলমার্ক হতে প্রাপ্ত আয়	2560	126.00	2026-04-16 16:31:42.692589
221	2	income	মেলটিং হতে প্রাপ্ত আয়	2026-02-27 00:00:00	মেলটিং হতে প্রাপ্ত আয়	1474	8.00	2026-04-16 16:32:09.224948
222	2	income	এক্সরে হতে প্রাপ্ত আয়	2026-02-28 00:00:00	এক্সরে হতে প্রাপ্ত আয়	39650	323.00	2026-04-16 16:33:02.108455
223	2	income	হলমার্ক হতে প্রাপ্ত আয়	2026-02-28 00:00:00	হলমার্ক হতে প্রাপ্ত আয়	12520	593.00	2026-04-16 16:33:30.993434
224	2	income	মেলটিং হতে প্রাপ্ত আয়	2026-02-28 00:00:00	মেলটিং হতে প্রাপ্ত আয়	24202	738.00	2026-04-16 16:33:54.339332
225	2	income	ওয়েল্ডিং হতে প্রাপ্ত আয়	2026-02-28 00:00:00	ওয়েল্ডিং হতে প্রাপ্ত আয়	5200	15.00	2026-04-16 16:34:17.524783
226	2	income	স্বর্ণ পাকাইকরন হতে আয়	2026-02-28 00:00:00	স্বর্ণ পাকাইকরন বিল	300	20.58	2026-04-16 16:34:40.686454
227	2	costing	পরিচালক, অথিতি, ও স্টাফ আপ্যায়নের বিবরণ (February-2026)	2026-02-28 00:00:00	ইফতার	3000	0.00	2026-04-16 16:34:55.657832
228	2	costing	বিবিধ খরচের বিবরণ (February-2026)	2026-02-28 00:00:00	বাট্টা (৫,১০,২০,৫০)	120	0.00	2026-04-16 16:35:11.67647
229	2	costing	বিদুৎ বিল বিবরণ (February-2026)	2026-02-28 00:00:00	নতুন ও পুরনো মিটার	30000	0.00	2026-04-16 16:35:29.988983
230	2	costing	বিবিধ খরচের বিবরণ (February-2026)	2026-02-28 00:00:00	তৃতীয় লিঙ্গ	100	0.00	2026-04-16 16:35:45.604844
231	2	costing	ভুল ডেটা এন্ট্রি ও ডিসকাউন্ট (February-2026)	2026-02-28 00:00:00	রাইটিং বিল মিস্টেক	500	0.00	2026-04-16 16:36:08.76633
232	2	costing	রিফাইনিং প্রজেক্ট বিবিধ খরচ (February-2026)	2026-02-28 00:00:00	গ্যাস লাইন মেরামত	1000	0.00	2026-04-16 16:36:37.918973
233	3	income	এক্সরে হতে প্রাপ্ত আয়	2026-03-01 00:00:00	এক্সরে হতে প্রাপ্ত আয়	37500	302.00	2026-04-16 17:07:08.867094
234	3	income	হলমার্ক হতে প্রাপ্ত আয়	2026-03-01 00:00:00	হলমার্ক হতে প্রাপ্ত আয়	13560	773.00	2026-04-16 17:07:29.226683
236	3	income	ওয়েল্ডিং হতে প্রাপ্ত আয়	2026-03-01 00:00:00	ওয়েল্ডিং হতে প্রাপ্ত আয়	3400	13.00	2026-04-16 17:08:17.146342
237	3	income	ওয়েল্ডিং হতে প্রাপ্ত আয়	2026-03-01 00:00:00	ওয়েল্ডিং হতে প্রাপ্ত আয়	1100	101.79	2026-04-16 17:08:39.873755
238	3	income	ডাস্ট বিক্রয় হতে আয়	2026-03-01 00:00:00	ডাস্ট সেল (86.11) 19.10 ক্যারেট ফেব্রুয়ারি 2026	1511946	0.00	2026-04-16 17:10:44.310632
239	3	income	পরিচালকগনের লোণ ফেরত	2026-03-01 00:00:00	পরিচালক লোন ফেরত ফেব্রুয়ারি 2026	300000	0.00	2026-04-16 17:11:33.997616
240	3	costing	পরিচালক, অথিতি, ও স্টাফ আপ্যায়নের বিবরণ (March-2026)	2026-03-01 00:00:00	ইফতার	3000	0.00	2026-04-16 17:11:55.046423
241	3	costing	পরিচালক মাসিক সম্মানী প্রদান (March-2026)	2026-03-01 00:00:00	কাজী সিরাজুল ইসলাম ফেব্রুয়ারি 2026	100000	0.00	2026-04-16 17:12:58.382753
242	3	costing	পরিচালক মাসিক সম্মানী প্রদান (March-2026)	2026-03-01 00:00:00	জনাব গঙ্গাচরণ মালাকার ফেব্রুয়ারি 2026	90000	0.00	2026-04-16 17:13:23.744426
243	3	costing	পরিচালক মাসিক সম্মানী প্রদান (March-2026)	2026-03-01 00:00:00	জনাব ডা. দিলীপ কুমার রায় ফেব্রুয়ারি 2026	100000	0.00	2026-04-16 17:13:48.835721
244	3	costing	পরিচালক মাসিক সম্মানী প্রদান (March-2026)	2026-03-01 00:00:00	জনাব রঞ্জিত ঘোষ	90000	0.00	2026-04-16 17:16:03.705826
245	3	costing	পরিচালক মাসিক সম্মানী প্রদান (March-2026)	2026-03-01 00:00:00	জনাব এনামুল হক খান	190000	0.00	2026-04-16 17:16:23.997087
246	3	costing	পরিচালক মাসিক সম্মানী প্রদান (March-2026)	2026-03-01 00:00:00	জনাব মিজানুর রহমান মানিক	90000	0.00	2026-04-16 17:16:53.464916
247	3	costing	পরিচালক মাসিক সম্মানী প্রদান (March-2026)	2026-03-01 00:00:00	জনাব রঞ্জিত ঘোষ	90000	0.00	2026-04-16 17:17:14.2521
248	3	costing	পরিচালক মাসিক সম্মানী প্রদান (March-2026)	2026-03-01 00:00:00	জনাব আবুল খায়ের সিকদার	90000	0.00	2026-04-16 17:17:58.915521
249	3	costing	পরিচালক মাসিক সম্মানী প্রদান (March-2026)	2026-03-01 00:00:00	জনাব বাবুল মিয়া	90000	0.00	2026-04-16 17:18:14.872233
250	3	costing	যাতায়াত সংক্রান্ত খরচের বিবরণ (March-2026)	2026-03-01 00:00:00	সম্মানী পেরন	200	0.00	2026-04-16 17:18:34.989137
251	3	costing	মাসিক বেতন প্রদান (স্টাফ ক্লিনার) (March-2026)	2026-03-01 00:00:00	রিফাত ফেব্রুয়ারি 2026	15000	0.00	2026-04-16 17:19:59.614724
252	3	costing	মাসিক বেতন প্রদান (স্টাফ ক্লিনার) (March-2026)	2026-03-01 00:00:00	প্রিয় কুমার ফেব্রুয়ারি 2026	10000	0.00	2026-04-16 17:20:22.249575
253	3	costing	মাসিক বেতন প্রদান (স্টাফ ক্লিনার) (March-2026)	2026-03-01 00:00:00	তুলি রানী দাস ফেব্রুয়ারি 2026	15000	0.00	2026-04-16 17:20:44.589134
254	3	costing	মাসিক বেতন প্রদান (স্টাফ ক্লিনার) (March-2026)	2026-03-01 00:00:00	কেয়া দাস ফেব্রুয়ারি 2026	15000	0.00	2026-04-16 17:21:14.853699
255	3	costing	মাসিক বেতন প্রদান (স্টাফ ক্লিনার) (March-2026)	2026-03-01 00:00:00	মিন্টু ফেব্রুয়ারি 2026	9000	0.00	2026-04-16 17:21:44.260845
256	3	costing	বিবিধ খরচের বিবরণ (March-2026)	2026-03-01 00:00:00	ডাস্ট (নদীর ওপার ও কারখানা)	900	0.00	2026-04-16 17:22:10.059066
257	3	costing	বিভিন্ন প্রকার বিল প্রদানের বিবরণ (March-2026)	2026-03-01 00:00:00	সিসি টিভি বিল	1000	0.00	2026-04-16 17:23:56.377479
258	3	costing	রিফাইনিং প্রজেক্ট বিবিধ খরচ (March-2026)	2026-03-01 00:00:00	লেভার কামিকাল উঠানো	3000	0.00	2026-04-16 17:24:35.709123
259	3	income	এক্সরে হতে প্রাপ্ত আয়	2026-03-02 00:00:00	এক্সরে হতে প্রাপ্ত আয়	43900	346.00	2026-04-16 17:25:32.808252
260	3	income	হলমার্ক হতে প্রাপ্ত আয়	2026-03-02 00:00:00	এক্সরে হতে প্রাপ্ত আয়	13540	913.00	2026-04-16 17:26:39.988796
261	3	income	মেলটিং হতে প্রাপ্ত আয়	2026-03-02 00:00:00	মেলটিং হতে প্রাপ্ত আয়	31123	163.00	2026-04-16 17:27:20.215167
263	3	income	ওয়েল্ডিং হতে প্রাপ্ত আয়	2026-03-02 00:00:00	ওয়েল্ডিং হতে প্রাপ্ত আয়	5100	12.00	2026-04-16 17:28:14.991128
264	3	income	স্বর্ণ পাকাইকরন হতে আয়	2026-03-02 00:00:00	স্বর্ণ পাকাইকরন বিল	2500	237.85	2026-04-16 17:28:40.222036
265	3	costing	পরিচালক, অথিতি, ও স্টাফ আপ্যায়নের বিবরণ (March-2026)	2026-03-02 00:00:00	ইফতার	3000	0.00	2026-04-16 17:29:35.621668
266	3	costing	বিবিধ খরচের বিবরণ (March-2026)	2026-03-02 00:00:00	বাট্টা (৫,১০,২০,৫০)	150	0.00	2026-04-16 17:29:53.712465
267	3	costing	বিবিধ খরচের বিবরণ (March-2026)	2026-03-02 00:00:00	তেল	100	0.00	2026-04-16 17:30:05.156998
268	3	costing	বিবিধ খরচের বিবরণ (March-2026)	2026-03-02 00:00:00	ডোনেশন মাদ্রাসা	500	0.00	2026-04-16 17:30:20.264054
269	3	costing	ব্যাংক এ যাবতীয় জমা (March-2026)	2026-03-02 00:00:00	প্রভিডেন্ট ফান্ড ফেব্রুয়ারি 2026	23100	0.00	2026-04-16 17:31:07.80409
270	3	costing	ব্যাংক এ যাবতীয় জমা (March-2026)	2026-03-02 00:00:00	ওয়েলফেয়ার ফান্ড ফেব্রুয়ারি 2026	10760	0.00	2026-04-16 17:31:33.022571
262	3	income	ডাস্ট বিক্রয় হতে আয়	2026-03-02 00:00:00	নেহারা	100000	0.00	2026-04-16 17:27:59.403976
271	3	income	এক্সরে হতে প্রাপ্ত আয়	2026-03-03 00:00:00	এক্সরে হতে প্রাপ্ত আয়	43100	342.00	2026-04-16 17:33:39.097028
272	3	income	হলমার্ক হতে প্রাপ্ত আয়	2026-03-03 00:00:00	হলমার্ক হতে প্রাপ্ত আয়	15490	976.00	2026-04-16 17:34:02.376108
273	3	income	মেলটিং হতে প্রাপ্ত আয়	2026-03-03 00:00:00	মেলটিং হতে প্রাপ্ত আয়	16006	112.00	2026-04-16 17:34:35.585983
274	3	income	ওয়েল্ডিং হতে প্রাপ্ত আয়	2026-03-03 00:00:00	ওয়েল্ডিং হতে প্রাপ্ত আয়	3000	10.00	2026-04-16 17:34:53.366098
275	3	income	স্বর্ণ পাকাইকরন হতে আয়	2026-03-03 00:00:00	স্বর্ণ পাকাইকরন বিল	1700	133.90	2026-04-16 17:35:32.648723
276	3	costing	পরিচালক, অথিতি, ও স্টাফ আপ্যায়নের বিবরণ (March-2026)	2026-03-03 00:00:00	ইফতার	3000	0.00	2026-04-16 17:35:53.497652
277	3	costing	পরিচালক মাসিক সম্মানী প্রদান (March-2026)	2026-03-03 00:00:00	কাজী সিরাজুল ইসলাম ঈদ বোনাস 2026	100000	0.00	2026-04-16 17:36:32.338236
278	3	costing	পরিচালক মাসিক সম্মানী প্রদান (March-2026)	2026-03-03 00:00:00	জনাব গঙ্গাচরণ মালাকার ঈদ বোনাস	100000	0.00	2026-04-16 17:36:48.796831
279	3	costing	পরিচালক মাসিক সম্মানী প্রদান (March-2026)	2026-03-03 00:00:00	জনাব ডা. দিলীপ কুমার রায় ঈদ বোনাস 	100000	0.00	2026-04-16 17:37:08.880825
280	3	costing	পরিচালক মাসিক সম্মানী প্রদান (March-2026)	2026-03-03 00:00:00	জনাব রঞ্জিত ঘোষ	100000	0.00	2026-04-16 17:38:00.84142
281	3	costing	পরিচালক মাসিক সম্মানী প্রদান (March-2026)	2026-03-03 00:00:00	জনাব এনামুল হক খান	200000	0.00	2026-04-16 17:38:17.117047
282	3	costing	পরিচালক মাসিক সম্মানী প্রদান (March-2026)	2026-03-03 00:00:00	জনাব মিজানুর রহমান মানিক	100000	0.00	2026-04-16 17:38:37.234069
283	3	costing	পরিচালক মাসিক সম্মানী প্রদান (March-2026)	2026-03-03 00:00:00	জনাব ভোলানাথ ঘোষ	100000	0.00	2026-04-16 17:38:54.49486
284	3	costing	পরিচালক মাসিক সম্মানী প্রদান (March-2026)	2026-03-03 00:00:00	জনাব আবুল খায়ের সিকদার 	100000	0.00	2026-04-16 17:39:09.659557
285	3	costing	পরিচালক মাসিক সম্মানী প্রদান (March-2026)	2026-03-03 00:00:00	জনাব বাবুল মিয়া	100000	0.00	2026-04-16 17:39:21.307451
286	3	costing	যাতায়াত সংক্রান্ত খরচের বিবরণ (March-2026)	2026-03-03 00:00:00	ইমন রনি	400	0.00	2026-04-16 17:39:49.443761
287	3	costing	বিভিন্ন প্রকার বিল প্রদানের বিবরণ (March-2026)	2026-03-03 00:00:00	ইন্টারনেট বিল	3350	0.00	2026-04-16 17:40:33.345421
288	3	costing	বিভিন্ন প্রকার বিল প্রদানের বিবরণ (March-2026)	2026-03-03 00:00:00	ডিস বিল	400	0.00	2026-04-16 17:41:41.310133
289	3	costing	বিবিধ খরচের বিবরণ (March-2026)	2026-03-03 00:00:00	পুলিশ	5000	0.00	2026-04-16 17:41:59.662027
290	3	costing	বিবিধ খরচের বিবরণ (March-2026)	2026-03-03 00:00:00	ডোনেশন জারুদার	500	0.00	2026-04-16 17:42:18.727764
291	3	income	এক্সরে হতে প্রাপ্ত আয়	2026-03-05 00:00:00	এক্সরে হতে প্রাপ্ত আয়	34850	290.00	2026-04-16 17:44:18.285117
292	3	income	হলমার্ক হতে প্রাপ্ত আয়	2026-03-05 00:00:00	হলমার্ক হতে প্রাপ্ত আয়	17065	845.00	2026-04-16 17:44:46.379497
293	3	income	মেলটিং হতে প্রাপ্ত আয়	2026-03-05 00:00:00	মেলটিং হতে প্রাপ্ত আয়	25028	158.00	2026-04-16 17:45:18.791784
294	3	income	স্বর্ণ পাকাইকরন হতে আয়	2026-03-05 00:00:00	স্বর্ণ পাকাইকরন বিল	4140	371.87	2026-04-16 17:46:02.98225
295	3	costing	পরিচালক, অথিতি, ও স্টাফ আপ্যায়নের বিবরণ (March-2026)	2026-03-05 00:00:00	ইফতার	3000	0.00	2026-04-16 17:46:15.840166
296	3	costing	বিবিধ খরচের বিবরণ (March-2026)	2026-03-05 00:00:00	বাট্টা (৫,১০,২০,৫০)	270	0.00	2026-04-16 17:46:29.141867
297	3	costing	যাতায়াত সংক্রান্ত খরচের বিবরণ (March-2026)	2026-03-05 00:00:00	যাতায়াত - মাসুদ	300	0.00	2026-04-16 17:46:46.38231
298	3	costing	বিবিধ খরচের বিবরণ (March-2026)	2026-03-05 00:00:00	স্কেচ মেশিন 	12000	0.00	2026-04-16 17:47:28.328956
299	3	costing	বিবিধ খরচের বিবরণ (March-2026)	2026-03-05 00:00:00	দরজার লক	500	0.00	2026-04-16 17:47:41.24029
300	3	costing	বিবিধ খরচের বিবরণ (March-2026)	2026-03-05 00:00:00	চিনি	300	0.00	2026-04-16 17:48:27.095366
301	3	costing	পরিচালক মাসিক সম্মানী প্রদান (March-2026)	2026-03-05 00:00:00	জনাব এনামুল হক খান নগদ ক্যাশ	10000	0.00	2026-04-16 17:49:14.234657
302	3	income	ওয়েল্ডিং হতে প্রাপ্ত আয়	2026-03-05 00:00:00	ওয়েল্ডিং হতে প্রাপ্ত আয়	4000	11.00	2026-04-17 03:35:47.388829
303	3	income	এক্সরে হতে প্রাপ্ত আয়	2026-03-06 00:00:00	এক্সরে হতে প্রাপ্ত আয়	4100	29.00	2026-04-17 03:39:01.38922
304	3	income	হলমার্ক হতে প্রাপ্ত আয়	2026-03-06 00:00:00	হলমার্ক হতে প্রাপ্ত আয়	2560	130.00	2026-04-17 03:39:22.767505
305	3	income	মেলটিং হতে প্রাপ্ত আয়	2026-03-06 00:00:00	মেলটিং হতে প্রাপ্ত আয়	1646	9.00	2026-04-17 03:39:39.944242
306	3	income	এক্সরে হতে প্রাপ্ত আয়	2026-03-07 00:00:00	এক্সরে হতে প্রাপ্ত আয়	42300	341.00	2026-04-17 03:41:45.614806
307	3	income	হলমার্ক হতে প্রাপ্ত আয়	2026-03-07 00:00:00	হলমার্ক হতে প্রাপ্ত আয়	16015	1115.00	2026-04-17 03:42:09.247517
308	3	income	মেলটিং হতে প্রাপ্ত আয়	2026-03-07 00:00:00	মেলটিং হতে প্রাপ্ত আয়	36926	185.00	2026-04-17 03:42:46.208321
309	3	income	স্বর্ণ পাকাইকরন হতে আয়	2026-03-07 00:00:00	স্বর্ণ পাকাইকরন বিল	7200	689.16	2026-04-17 03:43:14.437589
310	3	costing	পরিচালক, অথিতি, ও স্টাফ আপ্যায়নের বিবরণ (March-2026)	2026-03-07 00:00:00	ইফতার	3000	0.00	2026-04-17 03:43:42.068676
311	3	costing	যাতায়াত সংক্রান্ত খরচের বিবরণ (March-2026)	2026-03-07 00:00:00	যাতায়াত - মাসুদ	500	0.00	2026-04-17 03:44:04.220735
312	3	costing	বিবিধ খরচের বিবরণ (March-2026)	2026-03-07 00:00:00	তৃতীয় লিঙ্গ	100	0.00	2026-04-17 03:44:15.406503
313	3	costing	বিবিধ খরচের বিবরণ (March-2026)	2026-03-07 00:00:00	নক্ষত্র টাওয়ার ফেব্রুয়ারি সার্ভিস চার্জ	13480	0.00	2026-04-17 03:45:18.55024
314	3	costing	ভুল ডেটা এন্ট্রি ও ডিসকাউন্ট (March-2026)	2026-03-07 00:00:00	ভুল ডেটা এন্ট্রি ও ডিসকাউন্ট (March-2026)	150	0.00	2026-04-17 03:45:31.495696
315	3	costing	বিবিধ খরচের বিবরণ (March-2026)	2026-03-07 00:00:00	ফটোকপি	70	0.00	2026-04-17 03:45:49.155851
316	3	income	ওয়েল্ডিং হতে প্রাপ্ত আয়	2026-03-07 00:00:00	ওয়েল্ডিং হতে প্রাপ্ত আয়	4500	21.00	2026-04-17 03:46:41.506429
597	1	costing	বিদুৎ বিল বিবরণ (January-2026)	2026-01-11 00:00:00	নতুন মিটার	10000	0.00	2026-04-18 07:46:35.203639
317	3	income	ওয়েল্ডিং হতে প্রাপ্ত আয়	2026-03-08 00:00:00	ওয়েল্ডিং হতে প্রাপ্ত আয়	6800	17.00	2026-04-17 03:48:38.052456
318	3	income	এক্সরে হতে প্রাপ্ত আয়	2026-03-08 00:00:00	এক্সরে হতে প্রাপ্ত আয়	38400	303.00	2026-04-17 03:49:43.761095
320	3	income	মেলটিং হতে প্রাপ্ত আয়	2026-03-08 00:00:00	মেলটিং হতে প্রাপ্ত আয়	29391	157.00	2026-04-17 03:50:40.786176
321	3	income	স্বর্ণ পাকাইকরন হতে আয়	2026-03-08 00:00:00	স্বর্ণ পাকাইকরন বিল	1100	76.59	2026-04-17 03:50:59.944121
322	3	costing	পরিচালক, অথিতি, ও স্টাফ আপ্যায়নের বিবরণ (March-2026)	2026-03-08 00:00:00	ইফতার	3000	0.00	2026-04-17 03:51:17.908028
323	3	costing	বিভিন্ন ইলেকট্রিক যন্ত্রাংশ ক্রয় ও মেরামত (March-2026)	2026-03-08 00:00:00	এসি মেরামত তাতি বাজার	20000	0.00	2026-04-17 03:51:52.596818
324	3	costing	বিভিন্ন ইলেকট্রিক যন্ত্রাংশ ক্রয় ও মেরামত (March-2026)	2026-03-08 00:00:00	রাজু রাজেশ্বরী বায়তুল মোকারম লেজার মেশিন ক্রয়	500000	0.00	2026-04-17 03:52:47.774837
319	3	income	হলমার্ক হতে প্রাপ্ত আয়	2026-03-08 00:00:00	হলমার্ক হতে প্রাপ্ত আয়	14550	1030.00	2026-04-17 03:50:19.027177
325	3	income	এক্সরে হতে প্রাপ্ত আয়	2026-03-09 00:00:00	এক্সরে হতে প্রাপ্ত আয়	35400	275.00	2026-04-17 03:54:23.238844
326	3	income	হলমার্ক হতে প্রাপ্ত আয়	2026-03-09 00:00:00	হলমার্ক হতে প্রাপ্ত আয়	13030	701.00	2026-04-17 03:55:06.120257
327	3	income	মেলটিং হতে প্রাপ্ত আয়	2026-03-09 00:00:00	মেলটিং হতে প্রাপ্ত আয়	30361	117.00	2026-04-17 03:55:27.196716
328	3	income	ওয়েল্ডিং হতে প্রাপ্ত আয়	2026-03-09 00:00:00	ওয়েল্ডিং হতে প্রাপ্ত আয়	2300	7.00	2026-04-17 03:55:43.34578
329	3	costing	পরিচালক, অথিতি, ও স্টাফ আপ্যায়নের বিবরণ (March-2026)	2026-03-09 00:00:00	ইফতার	3000	0.00	2026-04-17 03:56:14.857365
330	3	costing	বিভিন্ন প্রকার বিল প্রদানের বিবরণ (March-2026)	2026-03-09 00:00:00	প্রত্রিকা বিল	300	0.00	2026-04-17 03:56:37.577633
331	3	costing	বিদুৎ বিল বিবরণ (March-2026)	2026-03-09 00:00:00	নতুন ও পুরনো মিটার	30000	0.00	2026-04-17 03:56:53.862786
332	3	costing	বিভিন্ন প্রকার বিল প্রদানের বিবরণ (March-2026)	2026-03-09 00:00:00	সফ্টওয়ার মেইনটেইন চার্জ  বাবু মার্চ 2026	4000	0.00	2026-04-17 03:57:46.737198
333	3	costing	বিবিধ খরচের বিবরণ (March-2026)	2026-03-09 00:00:00	বাট্টা (৫,১০,২০,৫০)	200	0.00	2026-04-17 03:58:01.723984
334	3	income	এক্সরে হতে প্রাপ্ত আয়	2026-03-10 00:00:00	এক্সরে হতে প্রাপ্ত আয়	58200	462.00	2026-04-17 03:59:07.968211
335	3	income	হলমার্ক হতে প্রাপ্ত আয়	2026-03-10 00:00:00	হলমার্ক হতে প্রাপ্ত আয়	15045	731.00	2026-04-17 03:59:27.009235
336	3	income	মেলটিং হতে প্রাপ্ত আয়	2026-03-10 00:00:00	মেলটিং হতে প্রাপ্ত আয়	32834	206.00	2026-04-17 03:59:44.191997
337	3	income	ওয়েল্ডিং হতে প্রাপ্ত আয়	2026-03-10 00:00:00	ওয়েল্ডিং হতে প্রাপ্ত আয়	7900	23.00	2026-04-17 04:00:02.111829
338	3	income	স্বর্ণ পাকাইকরন হতে আয়	2026-03-10 00:00:00	স্বর্ণ পাকাইকরন বিল	1750	104.86	2026-04-17 04:00:29.634845
339	3	costing	পরিচালক, অথিতি, ও স্টাফ আপ্যায়নের বিবরণ (March-2026)	2026-03-10 00:00:00	ইফতার	3000	0.00	2026-04-17 04:00:49.173092
340	3	costing	বিবিধ খরচের বিবরণ (March-2026)	2026-03-10 00:00:00	তৃতীয় লিঙ্গ	200	0.00	2026-04-17 04:01:11.00419
341	3	costing	যাতায়াত সংক্রান্ত খরচের বিবরণ (March-2026)	2026-03-10 00:00:00	যাতায়াত - মাসুদ	200	0.00	2026-04-17 04:01:31.038064
342	3	costing	ভুল ডেটা এন্ট্রি ও ডিসকাউন্ট (March-2026)	2026-03-10 00:00:00	রাইটিং বিল মিস্টেক	200	0.00	2026-04-17 04:01:50.349084
343	3	income	এক্সরে হতে প্রাপ্ত আয়	2026-03-11 00:00:00	এক্সরে হতে প্রাপ্ত আয়	42050	327.00	2026-04-17 04:03:07.815211
344	3	income	হলমার্ক হতে প্রাপ্ত আয়	2026-03-11 00:00:00	হলমার্ক হতে প্রাপ্ত আয়	16560	1285.00	2026-04-17 04:03:28.924128
346	3	income	মেলটিং হতে প্রাপ্ত আয়	2026-03-11 00:00:00	মেলটিং হতে প্রাপ্ত আয়	26675	162.00	2026-04-17 04:05:03.027231
347	3	income	ওয়েল্ডিং হতে প্রাপ্ত আয়	2026-03-11 00:00:00	ওয়েল্ডিং হতে প্রাপ্ত আয়	5900	15.00	2026-04-17 04:05:21.424026
348	3	income	স্বর্ণ পাকাইকরন হতে আয়	2026-03-11 00:00:00	স্বর্ণ পাকাইকরন বিল	1270	80.25	2026-04-17 04:05:36.812483
349	3	costing	পরিচালক, অথিতি, ও স্টাফ আপ্যায়নের বিবরণ (March-2026)	2026-03-11 00:00:00	ইফতার	3000	0.00	2026-04-17 04:06:16.419442
351	3	costing	যাতায়াত সংক্রান্ত খরচের বিবরণ (March-2026)	2026-03-11 00:00:00	যাতায়াত - মাসুদ	200	0.00	2026-04-17 04:08:22.112817
352	3	costing	বিবিধ খরচের বিবরণ (March-2026)	2026-03-11 00:00:00	পাথ	300	0.00	2026-04-17 04:08:49.195406
353	3	costing	বিবিধ খরচের বিবরণ (March-2026)	2026-03-11 00:00:00	বাজুস চাঁদা	1000	0.00	2026-04-17 04:09:06.931414
354	3	costing	বিবিধ খরচের বিবরণ (March-2026)	2026-03-11 00:00:00	বাট্টা (৫,১০,২০,৫০)	270	0.00	2026-04-17 04:09:18.507519
350	3	costing	বাইতুল মোকারাম অফিস খরচ (March-2026)	2026-03-11 00:00:00	মেল্টিং পট	85000	0.00	2026-04-17 04:07:33.261356
355	3	income	এক্সরে হতে প্রাপ্ত আয়	2026-03-12 00:00:00	এক্সরে হতে প্রাপ্ত আয়	38600	299.00	2026-04-17 04:11:51.97202
356	3	income	হলমার্ক হতে প্রাপ্ত আয়	2026-03-12 00:00:00	হলমার্ক হতে প্রাপ্ত আয়	21775	947.00	2026-04-17 04:12:26.090275
357	3	income	মেলটিং হতে প্রাপ্ত আয়	2026-03-12 00:00:00	মেলটিং হতে প্রাপ্ত আয়	25462	127.00	2026-04-17 04:12:48.566924
358	3	income	ওয়েল্ডিং হতে প্রাপ্ত আয়	2026-03-12 00:00:00	ওয়েল্ডিং হতে প্রাপ্ত আয়	5100	16.00	2026-04-17 04:13:10.627635
359	3	income	স্বর্ণ পাকাইকরন হতে আয়	2026-03-12 00:00:00	স্বর্ণ পাকাইকরন বিল	1000	61.02	2026-04-17 04:13:26.044766
360	3	costing	পরিচালক, অথিতি, ও স্টাফ আপ্যায়নের বিবরণ (March-2026)	2026-03-12 00:00:00	ইফতার	3000	0.00	2026-04-17 04:13:47.120059
361	3	costing	স্টেশনারি ও পি.পি.ই খরচের বিবরণ (March-2026)	2026-03-12 00:00:00	কাগজ, ফাইল, টিস্যু, এয়ারফ্রেশ, ইত্যাদি	10320	0.00	2026-04-17 04:14:43.323425
362	3	costing	যাতায়াত সংক্রান্ত খরচের বিবরণ (March-2026)	2026-03-12 00:00:00	যাতায়াত - মাসুদ	200	0.00	2026-04-17 04:15:20.720157
363	3	costing	স্টেশনারি ও পি.পি.ই খরচের বিবরণ (March-2026)	2026-03-12 00:00:00	পস পেপার 500 পিচ	30500	0.00	2026-04-17 04:16:31.631824
364	3	costing	স্টেশনারি ও পি.পি.ই খরচের বিবরণ (March-2026)	2026-03-12 00:00:00	রিবন 24 পিচ	9350	0.00	2026-04-17 04:17:07.939752
365	3	costing	স্টেশনারি ও পি.পি.ই খরচের বিবরণ (March-2026)	2026-03-12 00:00:00	প্রিন্টার কালি 20 পিচ	7200	0.00	2026-04-17 04:17:30.957173
366	3	costing	পরিচালক, অথিতি, ও স্টাফ আপ্যায়নের বিবরণ (March-2026)	2026-03-12 00:00:00	48 পিচ পানি	500	0.00	2026-04-17 04:17:53.916601
367	3	costing	বিবিধ খরচের বিবরণ (March-2026)	2026-03-12 00:00:00	29000 হাজার টাকার পরিবর্তন	5300	0.00	2026-04-17 04:19:03.764774
368	3	income	এক্সরে হতে প্রাপ্ত আয়	2026-03-13 00:00:00	এক্সরে হতে প্রাপ্ত আয়	3700	28.00	2026-04-17 04:20:01.688675
369	3	income	হলমার্ক হতে প্রাপ্ত আয়	2026-03-13 00:00:00	হলমার্ক হতে প্রাপ্ত আয়	4320	212.00	2026-04-17 04:20:24.948003
370	3	income	মেলটিং হতে প্রাপ্ত আয়	2026-03-13 00:00:00	মেলটিং হতে প্রাপ্ত আয়	5554	28.00	2026-04-17 04:20:41.20003
371	3	income	এক্সরে হতে প্রাপ্ত আয়	2026-03-14 00:00:00	এক্সরে হতে প্রাপ্ত আয়	36200	289.00	2026-04-17 04:23:29.657917
372	3	income	হলমার্ক হতে প্রাপ্ত আয়	2026-03-14 00:00:00	হলমার্ক হতে প্রাপ্ত আয়	12550	656.00	2026-04-17 04:23:56.270668
373	3	income	মেলটিং হতে প্রাপ্ত আয়	2026-03-14 00:00:00	হলমার্ক হতে প্রাপ্ত আয়	23612	139.00	2026-04-17 04:25:42.602779
374	3	income	ওয়েল্ডিং হতে প্রাপ্ত আয়	2026-03-14 00:00:00	ওয়েল্ডিং হতে প্রাপ্ত আয়	7800	27.00	2026-04-17 04:26:05.389494
375	3	income	স্বর্ণ পাকাইকরন হতে আয়	2026-03-14 00:00:00	স্বর্ণ পাকাইকরন বিল	1050	85.33	2026-04-17 04:26:33.38358
376	3	costing	পরিচালক, অথিতি, ও স্টাফ আপ্যায়নের বিবরণ (March-2026)	2026-03-14 00:00:00	ইফতার	3000	0.00	2026-04-17 04:26:54.223826
377	3	costing	বিবিধ খরচের বিবরণ (March-2026)	2026-03-14 00:00:00	বাট্টা (৫,১০,২০,৫০)	150	0.00	2026-04-17 04:27:07.042367
378	3	income	এক্সরে হতে প্রাপ্ত আয়	2026-03-15 00:00:00	এক্সরে হতে প্রাপ্ত আয়	32850	256.00	2026-04-17 04:39:13.482899
379	3	income	এক্সরে হতে প্রাপ্ত আয়	2026-03-15 00:00:00	এক্সরে হতে প্রাপ্ত আয়	29990	2441.00	2026-04-17 04:39:32.018575
380	3	income	মেলটিং হতে প্রাপ্ত আয়	2026-03-15 00:00:00	মেলটিং হতে প্রাপ্ত আয়	19843	114.00	2026-04-17 04:40:08.208955
381	3	income	ওয়েল্ডিং হতে প্রাপ্ত আয়	2026-03-15 00:00:00	ওয়েল্ডিং হতে প্রাপ্ত আয়	4100	15.00	2026-04-17 04:40:25.044581
382	3	income	স্বর্ণ পাকাইকরন হতে আয়	2026-03-15 00:00:00	স্বর্ণ পাকাইকরন বিল	2250	141.04	2026-04-17 04:40:45.539966
383	3	costing	পরিচালক, অথিতি, ও স্টাফ আপ্যায়নের বিবরণ (March-2026)	2026-03-15 00:00:00	ইফতার	3000	0.00	2026-04-17 04:41:27.901372
384	3	costing	বিবিধ খরচের বিবরণ (March-2026)	2026-03-15 00:00:00	বাট্টা (৫,১০,২০,৫০)	250	0.00	2026-04-17 04:42:02.904139
385	3	costing	যাতায়াত সংক্রান্ত খরচের বিবরণ (March-2026)	2026-03-15 00:00:00	যাতায়াত - মাসুদ	200	0.00	2026-04-17 04:42:16.716807
386	3	costing	বিবিধ খরচের বিবরণ (March-2026)	2026-03-15 00:00:00	তৃতীয় লিঙ্গ	200	0.00	2026-04-17 04:42:35.843192
387	3	costing	বিবিধ খরচের বিবরণ (March-2026)	2026-03-15 00:00:00	তৃতীয় লিঙ্গ ঈদ বোনাস	900	0.00	2026-04-17 04:43:15.387995
388	3	costing	বিদুৎ বিল বিবরণ (March-2026)	2026-03-15 00:00:00	নতুন মিটার	10000	0.00	2026-04-17 04:43:33.689093
389	3	costing	বিবিধ খরচের বিবরণ (March-2026)	2026-03-15 00:00:00	জিকে পার্সেল	400	0.00	2026-04-17 04:43:56.975427
390	3	income	এক্সরে হতে প্রাপ্ত আয়	2026-03-16 00:00:00	এক্সরে হতে প্রাপ্ত আয়	31750	252.00	2026-04-17 04:45:09.772803
392	3	income	মেলটিং হতে প্রাপ্ত আয়	2026-03-16 00:00:00	মেলটিং হতে প্রাপ্ত আয়	25236	127.00	2026-04-17 04:45:58.362295
393	3	income	ওয়েল্ডিং হতে প্রাপ্ত আয়	2026-03-16 00:00:00	ওয়েল্ডিং হতে প্রাপ্ত আয়	5100	17.00	2026-04-17 04:46:16.833912
394	3	income	স্বর্ণ পাকাইকরন হতে আয়	2026-03-16 00:00:00	স্বর্ণ পাকাইকরন বিল	2500	170.63	2026-04-17 04:46:35.972955
396	3	costing	ব্যাংক এ যাবতীয় জমা (March-2026)	2026-03-16 00:00:00	আল আরাফা ব্যাংক শেখের বাজার	600000	0.00	2026-04-17 04:47:53.482447
391	3	income	হলমার্ক হতে প্রাপ্ত আয়	2026-03-16 00:00:00	হলমার্ক হতে প্রাপ্ত আয়	19828	1394.00	2026-04-17 04:45:36.026912
397	3	costing	যাতায়াত সংক্রান্ত খরচের বিবরণ (March-2026)	2026-03-16 00:00:00	যাতায়াত ইমন	100	0.00	2026-04-17 04:48:20.216631
398	3	costing	বিবিধ খরচের বিবরণ (March-2026)	2026-03-16 00:00:00	জরুদারডোনেশন	200	0.00	2026-04-17 04:49:03.122015
399	3	costing	বিবিধ খরচের বিবরণ (March-2026)	2026-03-16 00:00:00	ব্যাংক অ্যাকাউন্ট তুলি নিউ স্টাফ	1200	0.00	2026-04-17 04:49:32.115875
400	3	costing	বিবিধ খরচের বিবরণ (March-2026)	2026-03-16 00:00:00	স্টাফ ব্যাংক অ্যাকাউন্ট কেয়া	1200	0.00	2026-04-17 04:49:58.816414
401	3	costing	মাসিক বেতন প্রদান (স্টাফ ক্লিনার) (March-2026)	2026-03-16 00:00:00	মিন্টু ঈদ বোনাস	9000	0.00	2026-04-17 04:50:24.632814
395	3	costing	পরিচালক, অথিতি, ও স্টাফ আপ্যায়নের বিবরণ (March-2026)	2026-03-16 00:00:00	ইফতার	3000	0.00	2026-04-17 04:46:58.880841
402	3	income	এক্সরে হতে প্রাপ্ত আয়	2026-03-17 00:00:00	এক্সরে হতে প্রাপ্ত আয়	31150	247.00	2026-04-17 04:52:56.616213
404	3	income	মেলটিং হতে প্রাপ্ত আয়	2026-03-17 00:00:00	মেলটিং হতে প্রাপ্ত আয়	24310	118.00	2026-04-17 04:53:46.85876
405	3	income	ওয়েল্ডিং হতে প্রাপ্ত আয়	2026-03-17 00:00:00	ওয়েল্ডিং হতে প্রাপ্ত আয়	3400	17.00	2026-04-17 04:54:04.851414
406	3	income	স্বর্ণ পাকাইকরন হতে আয়	2026-03-17 00:00:00	স্বর্ণ পাকাইকরন বিল	1400	99.93	2026-04-17 04:54:19.42166
407	3	costing	পরিচালক, অথিতি, ও স্টাফ আপ্যায়নের বিবরণ (March-2026)	2026-03-17 00:00:00	ইফতার	3000	0.00	2026-04-17 04:55:32.526286
408	3	costing	বাইতুল মোকারাম অফিস খরচ (March-2026)	2026-03-17 00:00:00	ভ্যাট	4050	0.00	2026-04-17 04:56:02.783073
409	3	costing	রিফাইনিং প্রজেক্ট বিবিধ খরচ (March-2026)	2026-03-17 00:00:00	ভ্যাট	2050	0.00	2026-04-17 04:56:22.085655
410	3	costing	বিবিধ খরচের বিবরণ (March-2026)	2026-03-17 00:00:00	ভ্যাট বাংলা গোল্ড	37010	0.00	2026-04-17 04:57:09.476553
411	3	costing	বিবিধ খরচের বিবরণ (March-2026)	2026-03-17 00:00:00	গণেশ	7000	0.00	2026-04-17 04:57:23.861305
412	3	costing	রিফাইনিং প্রজেক্ট বিবিধ খরচ (March-2026)	2026-03-17 00:00:00	সার্ভিস চার্জ	6090	0.00	2026-04-17 04:57:49.812333
413	3	costing	বিবিধ খরচের বিবরণ (March-2026)	2026-03-17 00:00:00	বাট্টা (৫,১০,২০,৫০)	150	0.00	2026-04-17 04:58:12.740337
414	3	income	এক্সরে হতে প্রাপ্ত আয়	2026-03-18 00:00:00	এক্সরে হতে প্রাপ্ত আয়	27450	218.00	2026-04-17 04:59:26.099272
403	3	income	হলমার্ক হতে প্রাপ্ত আয়	2026-03-17 00:00:00	হলমার্ক হতে প্রাপ্ত আয়	18576	989.00	2026-04-17 04:53:26.920794
418	3	income	মেলটিং হতে প্রাপ্ত আয়	2026-03-18 00:00:00	মেলটিং হতে প্রাপ্ত আয়	15036	89.00	2026-04-17 05:04:07.757808
417	3	income	হলমার্ক হতে প্রাপ্ত আয়	2026-03-18 00:00:00	হলমার্ক হতে প্রাপ্ত আয়	13360	737.00	2026-04-17 05:03:44.510805
419	3	income	ওয়েল্ডিং হতে প্রাপ্ত আয়	2026-03-18 00:00:00	ওয়েল্ডিং হতে প্রাপ্ত আয়	2800	12.00	2026-04-17 05:04:22.824996
420	3	income	স্বর্ণ পাকাইকরন হতে আয়	2026-03-18 00:00:00	স্বর্ণ পাকাইকরন বিল	1940	183.09	2026-04-17 05:04:52.117448
421	3	costing	পরিচালক, অথিতি, ও স্টাফ আপ্যায়নের বিবরণ (March-2026)	2026-03-18 00:00:00	ইফতার	3000	0.00	2026-04-17 05:05:13.936996
424	3	costing	বিবিধ খরচের বিবরণ (March-2026)	2026-03-18 00:00:00	তেল	200	0.00	2026-04-17 05:06:25.33386
425	3	costing	বিবিধ খরচের বিবরণ (March-2026)	2026-03-18 00:00:00	ডোনেশন জারুদর	400	0.00	2026-04-17 05:14:54.09743
431	3	costing	পরিচালক, অথিতি, ও স্টাফ আপ্যায়নের বিবরণ (March-2026)	2026-03-19 00:00:00	ইফতার	3000	0.00	2026-04-17 05:33:43.676623
432	3	costing	স্টেশনারি ও পি.পি.ই খরচের বিবরণ (March-2026)	2026-03-19 00:00:00	পলিশ পেপার 95 কাজী 	15675	0.00	2026-04-17 05:34:24.18835
426	3	income	এক্সরে হতে প্রাপ্ত আয়	2026-03-19 00:00:00	এক্সরে হতে প্রাপ্ত আয়	21000	162.00	2026-04-17 05:26:19.190323
427	3	income	হলমার্ক হতে প্রাপ্ত আয়	2026-03-19 00:00:00	হলমার্ক হতে প্রাপ্ত আয়	10660	525.00	2026-04-17 05:26:37.017171
428	3	income	মেলটিং হতে প্রাপ্ত আয়	2026-03-19 00:00:00	মেলটিং হতে প্রাপ্ত আয়	10431	79.00	2026-04-17 05:32:55.073803
429	3	income	ওয়েল্ডিং হতে প্রাপ্ত আয়	2026-03-19 00:00:00	ওয়েল্ডিং হতে প্রাপ্ত আয়	6800	13.00	2026-04-17 05:33:13.257901
430	3	income	স্বর্ণ পাকাইকরন হতে আয়	2026-03-19 00:00:00	স্বর্ণ পাকাইকরন হতে আয়	200	10.25	2026-04-17 05:33:30.140562
433	3	costing	স্টেশনারি ও পি.পি.ই খরচের বিবরণ (March-2026)	2026-03-19 00:00:00	খালি খাম 8000 পিচ	3100	0.00	2026-04-17 05:34:47.736996
434	3	costing	বিদুৎ বিল বিবরণ (March-2026)	2026-03-19 00:00:00	পুরাতন মিটার	20000	0.00	2026-04-17 05:35:01.552636
435	3	costing	বিবিধ খরচের বিবরণ (March-2026)	2026-03-19 00:00:00	2 জন দাওয়াউন ঈদ বোনাস	1000	0.00	2026-04-17 05:35:29.203985
436	3	income	এক্সরে হতে প্রাপ্ত আয়	2026-03-20 00:00:00	এক্সরে হতে প্রাপ্ত আয়	6150	52.00	2026-04-17 05:36:47.462251
437	3	income	হলমার্ক হতে প্রাপ্ত আয়	2026-03-20 00:00:00	হলমার্ক হতে প্রাপ্ত আয়	5500	270.00	2026-04-17 05:37:11.367252
416	3	income	মেলটিং হতে প্রাপ্ত আয়	2026-03-17 00:00:00	মেলটিং হতে প্রাপ্ত আয়	0	89.00	2026-04-17 05:00:41.191966
438	3	income	ওয়েল্ডিং হতে প্রাপ্ত আয়	2026-03-20 00:00:00	ওয়েল্ডিং হতে প্রাপ্ত আয়	1120	5.00	2026-04-17 05:37:26.26928
439	3	income	মেলটিং হতে প্রাপ্ত আয়	2026-03-20 00:00:00	মেলটিং হতে প্রাপ্ত আয়	1400	11.00	2026-04-17 05:37:57.05473
440	3	income	স্বর্ণ পাকাইকরন হতে আয়	2026-03-20 00:00:00	স্বর্ণ পাকাইকরন বিল	1000	59.96	2026-04-17 05:38:29.958435
441	3	costing	পরিচালক, অথিতি, ও স্টাফ আপ্যায়নের বিবরণ (March-2026)	2026-03-20 00:00:00	ইফতার	3000	0.00	2026-04-17 05:40:04.822551
442	3	costing	মাসিক বেতন প্রদান (স্টাফ ক্লিনার) (March-2026)	2026-03-20 00:00:00	তুলি ঈদ বোনাস	3500	0.00	2026-04-17 05:40:27.373113
443	3	costing	মাসিক বেতন প্রদান (স্টাফ ক্লিনার) (March-2026)	2026-03-20 00:00:00	কেয়া ঈদ বোনাস	3500	0.00	2026-04-17 05:40:40.135749
444	3	costing	মাসিক বেতন প্রদান (স্টাফ ক্লিনার) (March-2026)	2026-03-20 00:00:00	রিফাত ঈদ বোনাস	3500	0.00	2026-04-17 05:40:50.581498
445	3	costing	মাসিক বেতন প্রদান (স্টাফ ক্লিনার) (March-2026)	2026-03-20 00:00:00	প্রিয় ঈদ বোনাস	2500	0.00	2026-04-17 05:41:08.891745
446	3	income	এক্সরে হতে প্রাপ্ত আয়	2026-03-28 00:00:00	এক্সরে হতে প্রাপ্ত আয়	32300	251.00	2026-04-17 05:41:57.398822
447	3	income	হলমার্ক হতে প্রাপ্ত আয়	2026-03-28 00:00:00	হলমার্ক হতে প্রাপ্ত আয়	4080	209.00	2026-04-17 05:42:17.548966
448	3	income	মেলটিং হতে প্রাপ্ত আয়	2026-03-28 00:00:00	মেলটিং হতে প্রাপ্ত আয়	18994	119.00	2026-04-17 05:42:37.491192
449	3	income	ওয়েল্ডিং হতে প্রাপ্ত আয়	2026-03-28 00:00:00	ওয়েল্ডিং হতে প্রাপ্ত আয়	2300	5.00	2026-04-17 05:42:59.725074
450	3	income	স্বর্ণ পাকাইকরন হতে আয়	2026-03-28 00:00:00	স্বর্ণ পাকাইকরন বিল	600	50.02	2026-04-17 05:43:13.852439
451	3	costing	পরিচালক, অথিতি, ও স্টাফ আপ্যায়নের বিবরণ (March-2026)	2026-03-28 00:00:00	স্টাফ টিফিন	1100	0.00	2026-04-17 05:43:32.820278
452	3	income	এক্সরে হতে প্রাপ্ত আয়	2026-03-29 00:00:00	এক্সরে হতে প্রাপ্ত আয়	26350	208.00	2026-04-17 05:45:13.294751
453	3	income	হলমার্ক হতে প্রাপ্ত আয়	2026-03-29 00:00:00	হলমার্ক হতে প্রাপ্ত আয়	3430	206.00	2026-04-17 05:45:29.241242
455	3	income	ওয়েল্ডিং হতে প্রাপ্ত আয়	2026-03-29 00:00:00	ওয়েল্ডিং হতে প্রাপ্ত আয়	4200	10.00	2026-04-17 05:46:19.878948
456	3	income	স্বর্ণ পাকাইকরন হতে আয়	2026-03-29 00:00:00	স্বর্ণ পাকাইকরন বিল	5750	596.64	2026-04-17 05:46:41.892148
457	3	costing	পরিচালক, অথিতি, ও স্টাফ আপ্যায়নের বিবরণ (March-2026)	2026-03-29 00:00:00	স্টাফ টিফিন	1200	0.00	2026-04-17 05:47:13.92121
458	3	costing	বিবিধ খরচের বিবরণ (March-2026)	2026-03-29 00:00:00	তৃতীয় লিঙ্গ	100	0.00	2026-04-17 05:47:28.188476
459	3	costing	বিবিধ খরচের বিবরণ (March-2026)	2026-03-29 00:00:00	কেরোসিন তেল	800	0.00	2026-04-17 05:47:46.076523
460	3	costing	বিবিধ খরচের বিবরণ (March-2026)	2026-03-29 00:00:00	কেবল	350	0.00	2026-04-17 05:48:04.026752
454	3	income	মেলটিং হতে প্রাপ্ত আয়	2026-03-29 00:00:00	মেলটিং হতে প্রাপ্ত আয়	24929	130.00	2026-04-17 05:45:53.495872
461	3	income	এক্সরে হতে প্রাপ্ত আয়	2026-03-30 00:00:00	এক্সরে হতে প্রাপ্ত আয়	29500	234.00	2026-04-17 05:50:46.451705
462	3	income	হলমার্ক হতে প্রাপ্ত আয়	2026-03-30 00:00:00	হলমার্ক হতে প্রাপ্ত আয়	14167	479.00	2026-04-17 05:51:13.946327
463	3	income	মেলটিং হতে প্রাপ্ত আয়	2026-03-30 00:00:00	মেলটিং হতে প্রাপ্ত আয়	31746	162.00	2026-04-17 05:51:38.600845
464	3	income	স্বর্ণ পাকাইকরন হতে আয়	2026-03-30 00:00:00	স্বর্ণ পাকাইকরন বিল	500	68.54	2026-04-17 05:52:05.714071
465	3	costing	পরিচালক, অথিতি, ও স্টাফ আপ্যায়নের বিবরণ (March-2026)	2026-03-30 00:00:00	স্টাফ টিফিন	1200	0.00	2026-04-17 05:52:43.504419
466	3	costing	বিদুৎ বিল বিবরণ (March-2026)	2026-03-30 00:00:00	পুরাতন মিটার	10000	0.00	2026-04-17 05:52:56.604242
467	3	costing	যাতায়াত সংক্রান্ত খরচের বিবরণ (March-2026)	2026-03-30 00:00:00	যাতায়াত - মাসুদ	200	0.00	2026-04-17 05:53:08.385875
468	3	costing	বিবিধ খরচের বিবরণ (March-2026)	2026-03-30 00:00:00	বাট্টা (৫,১০,২০,৫০)	250	0.00	2026-04-17 05:53:27.660672
469	3	costing	বিভিন্ন ইলেকট্রিক যন্ত্রাংশ ক্রয় ও মেরামত (March-2026)	2026-03-30 00:00:00	পিসি মেরামত হল মার্ক	4700	0.00	2026-04-17 05:54:02.297854
470	3	costing	পরিচালক, অথিতি, ও স্টাফ আপ্যায়নের বিবরণ (March-2026)	2026-03-30 00:00:00	জিকে 	360	0.00	2026-04-17 05:54:28.099251
471	3	income	ওয়েল্ডিং হতে প্রাপ্ত আয়	2026-03-30 00:00:00	ওয়েল্ডিং হতে প্রাপ্ত আয়	2800	11.00	2026-04-17 05:55:12.358848
472	3	income	এক্সরে হতে প্রাপ্ত আয়	2026-03-31 00:00:00	এক্সরে হতে প্রাপ্ত আয়	31950	249.00	2026-04-17 06:25:13.929905
473	3	income	হলমার্ক হতে প্রাপ্ত আয়	2026-03-31 00:00:00	হলমার্ক হতে প্রাপ্ত আয়	3260	150.00	2026-04-17 06:25:32.138516
474	3	income	হলমার্ক হতে প্রাপ্ত আয়	2026-03-31 00:00:00	হলমার্ক হতে প্রাপ্ত আয়	25495	144.00	2026-04-17 06:25:52.317413
475	3	income	ওয়েল্ডিং হতে প্রাপ্ত আয়	2026-03-31 00:00:00	ওয়েল্ডিং হতে প্রাপ্ত আয়	1500	8.00	2026-04-17 06:26:09.186304
476	3	income	স্বর্ণ পাকাইকরন হতে আয়	2026-03-31 00:00:00	স্বর্ণ পাকাইকরন বিল	12600	1373.75	2026-04-17 06:26:31.027307
477	3	costing	পরিচালক, অথিতি, ও স্টাফ আপ্যায়নের বিবরণ (March-2026)	2026-03-31 00:00:00	স্টাফ টিফিন	1200	0.00	2026-04-17 06:26:58.513105
478	3	costing	পরিচালক, অথিতি, ও স্টাফ আপ্যায়নের বিবরণ (March-2026)	2026-03-31 00:00:00	পানি	500	0.00	2026-04-17 06:27:23.100479
479	3	costing	যাতায়াত সংক্রান্ত খরচের বিবরণ (March-2026)	2026-03-31 00:00:00	যাতায়াত - মাসুদ	200	0.00	2026-04-17 06:27:39.867345
480	3	costing	রিফাইনিং প্রজেক্ট বিবিধ খরচ (March-2026)	2026-03-31 00:00:00	ইউরিয়া সার	2170	0.00	2026-04-17 06:27:56.570218
481	3	costing	বিবিধ খরচের বিবরণ (March-2026)	2026-03-31 00:00:00	চাঁদি পাকা রুপা 1 ভরি	3700	0.00	2026-04-17 06:28:24.240531
483	1	income	হলমার্ক হতে প্রাপ্ত আয়	2026-01-01 00:00:00	হলমার্ক হতে প্রাপ্ত আয়	16098	1250.00	2026-04-18 05:36:09.841272
484	1	income	মেলটিং হতে প্রাপ্ত আয়	2026-01-01 00:00:00	মেলটিং হতে প্রাপ্ত আয়	25324	132.00	2026-04-18 05:36:32.440886
485	1	income	ওয়েল্ডিং হতে প্রাপ্ত আয়	2026-01-01 00:00:00	ওয়েল্ডিং হতে প্রাপ্ত আয়	4300	13.00	2026-04-18 05:37:19.968635
486	1	income	ডাস্ট বিক্রয় হতে আয়	2026-01-01 00:00:00	ডাস্ট সেল ( 127.69 -গ্রাম) - ক্যারেট	1880000	0.00	2026-04-18 05:38:09.797801
487	1	income	স্বর্ণ পাকাইকরন হতে আয়	2026-01-01 00:00:00	স্বর্ণ পাকাইকরন বিল	700	43.91	2026-04-18 05:38:30.905814
488	1	costing	পরিচালক, অথিতি, ও স্টাফ আপ্যায়নের বিবরণ (January-2026)	2026-01-01 00:00:00	স্টাফ টিফিন	1150	0.00	2026-04-18 05:39:15.192499
489	1	costing	মাসিক বেতন প্রদান (স্টাফ ক্লিনার) (January-2026)	2026-01-01 00:00:00	মাসিক বেতন প্রদান (স্টাফ ক্লিনার) মিন্টু	9000	0.00	2026-04-18 05:40:07.342049
490	1	costing	মাসিক বেতন প্রদান (স্টাফ ক্লিনার) (January-2026)	2026-01-01 00:00:00	নতুন স্টাফ রিফাত	2500	0.00	2026-04-18 05:40:52.344237
491	1	costing	যাতায়াত সংক্রান্ত খরচের বিবরণ (January-2026)	2026-01-01 00:00:00	ব্যাংক, অফিস, বায়তুল মোকারম	200	0.00	2026-04-18 05:44:41.623449
492	1	costing	বিবিধ খরচের বিবরণ (January-2026)	2026-01-01 00:00:00	তৃতীয় লিঙ্গ	100	0.00	2026-04-18 05:44:59.272338
493	1	costing	বিবিধ খরচের বিবরণ (January-2026)	2026-01-01 00:00:00	ডাস্ট (নদীর ওপার ও কারখানা)	900	0.00	2026-04-18 05:45:17.619782
495	1	income	হলমার্ক হতে প্রাপ্ত আয়	2026-01-02 00:00:00	হলমার্ক হতে প্রাপ্ত আয়	2940	147.00	2026-04-18 05:53:02.591089
482	1	income	এক্সরে হতে প্রাপ্ত আয়	2026-01-01 00:00:00	এক্সরে হতে প্রাপ্ত আয়	35200	274.00	2026-04-18 05:35:34.771892
494	1	income	এক্সরে হতে প্রাপ্ত আয়	2026-01-02 00:00:00	এক্সরে হতে প্রাপ্ত আয়	2250	17.00	2026-04-18 05:48:14.103918
496	1	income	মেলটিং হতে প্রাপ্ত আয়	2026-01-02 00:00:00	মেলটিং হতে প্রাপ্ত আয়	904	8.00	2026-04-18 06:00:58.034157
498	1	income	এক্সরে হতে প্রাপ্ত আয়	2026-01-03 00:00:00	এক্সরে হতে প্রাপ্ত আয়	22000	165.00	2026-04-18 06:18:55.534428
499	1	income	হলমার্ক হতে প্রাপ্ত আয়	2026-01-03 00:00:00	হলমার্ক হতে প্রাপ্ত আয়	6910	375.00	2026-04-18 06:19:23.466146
500	1	income	মেলটিং হতে প্রাপ্ত আয়	2026-01-03 00:00:00	মেলটিং হতে প্রাপ্ত আয়	18596	65.00	2026-04-18 06:19:40.01809
501	1	income	ওয়েল্ডিং হতে প্রাপ্ত আয়	2026-01-03 00:00:00	ওয়েল্ডিং হতে প্রাপ্ত আয়	2100	6.00	2026-04-18 06:19:54.881522
502	1	income	পরিচালকগনের লোণ ফেরত	2026-01-03 00:00:00	পরিচালক লোন ফেরত ডিসেম্বর 2025	300000	0.00	2026-04-18 06:20:32.249943
503	1	income	স্বর্ণ পাকাইকরন হতে আয়	2026-01-03 00:00:00	স্বর্ণ পাকাইকরন বিল	600	46.53	2026-04-18 06:20:49.643341
504	1	costing	পরিচালক, অথিতি, ও স্টাফ আপ্যায়নের বিবরণ (January-2026)	2026-01-03 00:00:00	স্টাফ টিফিন	1100	0.00	2026-04-18 06:21:19.255469
505	1	costing	পরিচালক মাসিক সম্মানী প্রদান (January-2026)	2026-01-03 00:00:00	কাজী সিরাজুল ইসলাম	100000	0.00	2026-04-18 06:21:41.001691
506	1	costing	পরিচালক মাসিক সম্মানী প্রদান (January-2026)	2026-01-03 00:00:00	জনাব গঙ্গাচরণ মালাকার	90000	0.00	2026-04-18 06:21:53.177366
507	1	costing	পরিচালক মাসিক সম্মানী প্রদান (January-2026)	2026-01-03 00:00:00	জনাব ডা. দিলীপ কুমার রায়	100000	0.00	2026-04-18 06:22:10.748203
508	1	costing	পরিচালক মাসিক সম্মানী প্রদান (January-2026)	2026-01-03 00:00:00	জনাব রঞ্জিত ঘোষ	90000	0.00	2026-04-18 06:22:24.504733
509	1	costing	পরিচালক মাসিক সম্মানী প্রদান (January-2026)	2026-01-03 00:00:00	জনাব এনামুল হক খান	190000	0.00	2026-04-18 06:22:39.157792
510	1	costing	পরিচালক মাসিক সম্মানী প্রদান (January-2026)	2026-01-03 00:00:00	জনাব মিজানুর রহমান	90000	0.00	2026-04-18 06:22:56.869856
511	1	costing	পরিচালক মাসিক সম্মানী প্রদান (January-2026)	2026-01-03 00:00:00	জনাব ভোলানাথ ঘোষ	90000	0.00	2026-04-18 06:23:33.323372
512	1	costing	পরিচালক মাসিক সম্মানী প্রদান (January-2026)	2026-01-03 00:00:00	জনাব আবুল খায়ের সিকদার	90000	0.00	2026-04-18 06:23:48.643785
513	1	costing	পরিচালক মাসিক সম্মানী প্রদান (January-2026)	2026-01-03 00:00:00	জনাব বাবুল মিয়া	90000	0.00	2026-04-18 06:24:06.417122
514	1	costing	যাতায়াত সংক্রান্ত খরচের বিবরণ (January-2026)	2026-01-03 00:00:00	সম্মানী পেরন	300	0.00	2026-04-18 06:24:34.72633
515	1	income	এক্সরে হতে প্রাপ্ত আয়	2026-01-04 00:00:00	এক্সরে হতে প্রাপ্ত আয়	31250	250.00	2026-04-18 06:25:41.178191
516	1	income	হলমার্ক হতে প্রাপ্ত আয়	2026-01-04 00:00:00	হলমার্ক হতে প্রাপ্ত আয়	8450	479.00	2026-04-18 06:50:05.88349
517	1	income	মেলটিং হতে প্রাপ্ত আয়	2026-01-04 00:00:00	মেলটিং হতে প্রাপ্ত আয়	23900	136.00	2026-04-18 06:50:38.376827
518	1	income	ওয়েল্ডিং হতে প্রাপ্ত আয়	2026-01-04 00:00:00	ওয়েল্ডিং হতে প্রাপ্ত আয়	5800	19.00	2026-04-18 06:51:01.319561
519	1	costing	পরিচালক, অথিতি, ও স্টাফ আপ্যায়নের বিবরণ (January-2026)	2026-01-04 00:00:00	স্টাফ টিফিন	1150	0.00	2026-04-18 06:51:23.513409
523	1	costing	যাতায়াত সংক্রান্ত খরচের বিবরণ (January-2026)	2026-01-04 00:00:00	রনি	100	0.00	2026-04-18 06:54:40.529263
524	1	costing	বিবিধ খরচের বিবরণ (January-2026)	2026-01-04 00:00:00	তেল	100	0.00	2026-04-18 06:54:57.021352
525	1	costing	বিবিধ খরচের বিবরণ (January-2026)	2026-01-04 00:00:00	তৃতীয় লিঙ্গ	100	0.00	2026-04-18 06:55:11.808056
526	1	costing	বিবিধ খরচের বিবরণ (January-2026)	2026-01-04 00:00:00	বাট্টা (৫,১০,২০,৫০)	290	0.00	2026-04-18 06:55:22.157892
527	1	costing	পরিচালক, অথিতি, ও স্টাফ আপ্যায়নের বিবরণ (January-2026)	2026-01-04 00:00:00	জিকে	500	0.00	2026-04-18 06:55:40.235539
528	1	costing	বিভিন্ন প্রকার বিল প্রদানের বিবরণ (January-2026)	2026-01-04 00:00:00	ইন্টারনেট বিল	3350	0.00	2026-04-18 06:56:25.262061
529	1	income	এক্সরে হতে প্রাপ্ত আয়	2026-01-05 00:00:00	এক্সরে হতে প্রাপ্ত আয়	41050	323.00	2026-04-18 07:02:43.266428
530	1	income	হলমার্ক হতে প্রাপ্ত আয়	2026-01-05 00:00:00	হলমার্ক হতে প্রাপ্ত আয়	11390	466.00	2026-04-18 07:03:19.213514
531	1	income	মেলটিং হতে প্রাপ্ত আয়	2026-01-05 00:00:00	মেলটিং হতে প্রাপ্ত আয়	26519	126.00	2026-04-18 07:03:41.234082
532	1	income	ওয়েল্ডিং হতে প্রাপ্ত আয়	2026-01-05 00:00:00	ওয়েল্ডিং হতে প্রাপ্ত আয়	4400	16.00	2026-04-18 07:03:57.179032
533	1	income	ডাস্ট বিক্রয় হতে আয়	2026-01-05 00:00:00	নেহারা 	100000	0.00	2026-04-18 07:04:28.671872
534	1	costing	পরিচালক, অথিতি, ও স্টাফ আপ্যায়নের বিবরণ (January-2026)	2026-01-05 00:00:00	স্টাফ টিফিন	1200	0.00	2026-04-18 07:05:06.632432
535	1	costing	কাঁচামাল ও বিভিন্ন এসিড ক্রয় (January-2026)	2026-01-05 00:00:00	ছোট 500 পিচ ফুল পেমেন্ট মেল্টিং পট	400000	0.00	2026-04-18 07:06:16.817237
536	1	costing	কাঁচামাল ও বিভিন্ন এসিড ক্রয় (January-2026)	2026-01-05 00:00:00	পস পেপার 500 পিচ	30500	0.00	2026-04-18 07:07:14.391862
537	1	costing	বিবিধ খরচের বিবরণ (January-2026)	2026-01-05 00:00:00	কেমিক্যাল থিনার	700	0.00	2026-04-18 07:07:44.596451
538	1	costing	বিবিধ খরচের বিবরণ (January-2026)	2026-01-05 00:00:00	ব্যাটারি 	100	0.00	2026-04-18 07:07:54.584322
539	1	costing	রিফাইনিং প্রজেক্ট বিবিধ খরচ (January-2026)	2026-01-05 00:00:00	ভাড়া	17100	0.00	2026-04-18 07:08:11.541693
540	1	costing	বিভিন্ন প্রকার বিল প্রদানের বিবরণ (January-2026)	2026-01-05 00:00:00	প্রত্রিকা বিল	290	0.00	2026-04-18 07:08:26.167453
541	1	income	এক্সরে হতে প্রাপ্ত আয়	2026-01-06 00:00:00	এক্সরে হতে প্রাপ্ত আয়	43150	337.00	2026-04-18 07:08:54.276694
542	1	income	হলমার্ক হতে প্রাপ্ত আয়	2026-01-06 00:00:00	হলমার্ক হতে প্রাপ্ত আয়	7578	679.00	2026-04-18 07:09:26.238465
543	1	income	মেলটিং হতে প্রাপ্ত আয়	2026-01-06 00:00:00	মেলটিং হতে প্রাপ্ত আয়	28307	148.00	2026-04-18 07:09:49.515587
544	1	income	ওয়েল্ডিং হতে প্রাপ্ত আয়	2026-01-06 00:00:00	ওয়েল্ডিং হতে প্রাপ্ত আয়	4900	18.00	2026-04-18 07:10:57.884538
545	1	income	স্বর্ণ পাকাইকরন হতে আয়	2026-01-06 00:00:00	স্বর্ণ পাকাইকরন বিল	5200	564.24	2026-04-18 07:11:18.811032
546	1	costing	পরিচালক, অথিতি, ও স্টাফ আপ্যায়নের বিবরণ (January-2026)	2026-01-06 00:00:00	স্টাফ টিফিন 	1150	0.00	2026-04-18 07:11:46.585152
547	1	costing	বিবিধ খরচের বিবরণ (January-2026)	2026-01-06 00:00:00	কফি 15 কেজি	9400	0.00	2026-04-18 07:12:21.763455
548	1	costing	বিবিধ খরচের বিবরণ (January-2026)	2026-01-06 00:00:00	রুপা 1 ভরি	3680	0.00	2026-04-18 07:12:40.78605
549	1	income	এক্সরে হতে প্রাপ্ত আয়	2026-01-07 00:00:00	এক্সরে হতে প্রাপ্ত আয়	37450	293.00	2026-04-18 07:13:11.241151
550	1	income	হলমার্ক হতে প্রাপ্ত আয়	2026-01-07 00:00:00	হলমার্ক হতে প্রাপ্ত আয়	16030	790.00	2026-04-18 07:13:34.896714
551	1	income	মেলটিং হতে প্রাপ্ত আয়	2026-01-07 00:00:00	মেলটিং হতে প্রাপ্ত আয়	39219	160.00	2026-04-18 07:15:15.476124
552	1	income	ওয়েল্ডিং হতে প্রাপ্ত আয়	2026-01-07 00:00:00	ওয়েল্ডিং হতে প্রাপ্ত আয়	5700	17.00	2026-04-18 07:15:30.041426
553	1	income	স্বর্ণ পাকাইকরন হতে আয়	2026-01-07 00:00:00	স্বর্ণ পাকাইকরন বিল	700	64.28	2026-04-18 07:15:47.886249
554	1	costing	পরিচালক, অথিতি, ও স্টাফ আপ্যায়নের বিবরণ (January-2026)	2026-01-07 00:00:00	স্টাফ টিফিন	1150	0.00	2026-04-18 07:16:06.775008
555	1	costing	বিভিন্ন ইলেকট্রিক যন্ত্রাংশ ক্রয় ও মেরামত (January-2026)	2026-01-07 00:00:00	আইপিএস মেরামত	45000	0.00	2026-04-18 07:16:36.890186
556	1	costing	পরিচালক, অথিতি, ও স্টাফ আপ্যায়নের বিবরণ (January-2026)	2026-01-07 00:00:00	২৪ পিস পানি	250	0.00	2026-04-18 07:17:02.515038
557	1	costing	বিবিধ খরচের বিবরণ (January-2026)	2026-01-07 00:00:00	পাথ	400	0.00	2026-04-18 07:17:16.081261
558	1	costing	যাতায়াত সংক্রান্ত খরচের বিবরণ (January-2026)	2026-01-07 00:00:00	যাতায়াত - মাসুদ	200	0.00	2026-04-18 07:17:27.379765
559	1	costing	বিবিধ খরচের বিবরণ (January-2026)	2026-01-07 00:00:00	জিকে পার্সেল পাঠানো	250	0.00	2026-04-18 07:17:49.911131
560	1	costing	বিভিন্ন প্রকার বিল প্রদানের বিবরণ (January-2026)	2026-01-07 00:00:00	সিসি টিভি বিল ডিসেম্বর + জানুয়ারি	2000	0.00	2026-04-18 07:18:17.811771
561	1	costing	বিবিধ খরচের বিবরণ (January-2026)	2026-01-07 00:00:00	বাট্টা (৫,১০,২০,৫০)	290	0.00	2026-04-18 07:18:32.22879
562	1	costing	বিভিন্ন প্রকার বিল প্রদানের বিবরণ (January-2026)	2026-01-07 00:00:00	ডিস বিল	400	0.00	2026-04-18 07:18:47.123848
563	1	income	স্বর্ণ পাকাইকরন হতে আয়	2026-01-07 00:00:00	স্বর্ণ পাকাইকরন বিল	600	40.32	2026-04-18 07:30:19.75729
564	1	income	এক্সরে হতে প্রাপ্ত আয়	2026-01-08 00:00:00	এক্সরে হতে প্রাপ্ত আয়	33250	261.00	2026-04-18 07:31:22.665428
565	1	income	হলমার্ক হতে প্রাপ্ত আয়	2026-01-08 00:00:00	হলমার্ক হতে প্রাপ্ত আয়	17050	740.00	2026-04-18 07:31:40.638742
566	1	income	মেলটিং হতে প্রাপ্ত আয়	2026-01-08 00:00:00	মেলটিং হতে প্রাপ্ত আয়	24892	131.00	2026-04-18 07:32:59.656035
567	1	income	ওয়েল্ডিং হতে প্রাপ্ত আয়	2026-01-08 00:00:00	ওয়েল্ডিং হতে প্রাপ্ত আয়	4900	20.00	2026-04-18 07:33:19.019136
568	1	income	স্বর্ণ পাকাইকরন হতে আয়	2026-01-08 00:00:00	স্বর্ণ পাকাইকরন বিল	2050	231.68	2026-04-18 07:33:37.213636
569	1	costing	পরিচালক, অথিতি, ও স্টাফ আপ্যায়নের বিবরণ (January-2026)	2026-01-08 00:00:00	স্টাফ টিফিন	1150	0.00	2026-04-18 07:34:05.094549
570	1	costing	পরিচালক, অথিতি, ও স্টাফ আপ্যায়নের বিবরণ (January-2026)	2026-01-08 00:00:00	গীতাঞ্জলি	200	0.00	2026-04-18 07:34:22.672684
571	1	costing	বিভিন্ন ইলেকট্রিক যন্ত্রাংশ ক্রয় ও মেরামত (January-2026)	2026-01-08 00:00:00	নতুন ওভেন	13400	0.00	2026-04-18 07:34:46.189087
572	1	costing	বিবিধ খরচের বিবরণ (January-2026)	2026-01-08 00:00:00	সার	1550	0.00	2026-04-18 07:35:15.148787
573	1	costing	রিফাইনিং প্রজেক্ট বিবিধ খরচ (January-2026)	2026-01-08 00:00:00	এসিড 	10200	0.00	2026-04-18 07:35:56.549397
574	1	income	এক্সরে হতে প্রাপ্ত আয়	2026-01-09 00:00:00	এক্সরে হতে প্রাপ্ত আয়	2400	18.00	2026-04-18 07:36:23.294294
575	1	income	হলমার্ক হতে প্রাপ্ত আয়	2026-01-09 00:00:00	হলমার্ক হতে প্রাপ্ত আয়	3900	195.00	2026-04-18 07:36:41.451966
576	1	income	ওয়েল্ডিং হতে প্রাপ্ত আয়	2026-01-09 00:00:00	ওয়েল্ডিং হতে প্রাপ্ত আয়	600	2.00	2026-04-18 07:37:00.564957
577	1	income	মেলটিং হতে প্রাপ্ত আয়	2026-01-09 00:00:00	মেলটিং হতে প্রাপ্ত আয়	995	9.00	2026-04-18 07:37:54.768478
578	1	income	এক্সরে হতে প্রাপ্ত আয়	2026-01-10 00:00:00	এক্সরে হতে প্রাপ্ত আয়	41450	326.00	2026-04-18 07:38:54.44262
579	1	income	হলমার্ক হতে প্রাপ্ত আয়	2026-01-10 00:00:00	হলমার্ক হতে প্রাপ্ত আয়	9870	480.00	2026-04-18 07:39:11.320713
580	1	income	মেলটিং হতে প্রাপ্ত আয়	2026-01-10 00:00:00	মেলটিং হতে প্রাপ্ত আয়	29819	161.00	2026-04-18 07:39:34.050687
581	1	income	ওয়েল্ডিং হতে প্রাপ্ত আয়	2026-01-10 00:00:00	ওয়েল্ডিং হতে প্রাপ্ত আয়	2600	10.00	2026-04-18 07:39:51.077157
582	1	income	স্বর্ণ পাকাইকরন হতে আয়	2026-01-10 00:00:00	স্বর্ণ পাকাইকরন বিল	4950	376.99	2026-04-18 07:40:14.697343
583	1	costing	পরিচালক, অথিতি, ও স্টাফ আপ্যায়নের বিবরণ (January-2026)	2026-01-10 00:00:00	স্টাফ টিফিন	1050	0.00	2026-04-18 07:40:33.45684
584	1	costing	যাতায়াত সংক্রান্ত খরচের বিবরণ (January-2026)	2026-01-10 00:00:00	ইমন	200	0.00	2026-04-18 07:40:52.441102
585	1	costing	ভুল ডেটা এন্ট্রি ও ডিসকাউন্ট (January-2026)	2026-01-10 00:00:00	বিল মিস্টেক	220	0.00	2026-04-18 07:41:09.011915
586	1	costing	রিফাইনিং প্রজেক্ট বিবিধ খরচ (January-2026)	2026-01-10 00:00:00	ইউরিয়া সার 50 কেজি 	1800	0.00	2026-04-18 07:41:37.404071
587	1	income	এক্সরে হতে প্রাপ্ত আয়	2026-01-11 00:00:00	এক্সরে হতে প্রাপ্ত আয়	37700	295.00	2026-04-18 07:42:38.102876
588	1	income	হলমার্ক হতে প্রাপ্ত আয়	2026-01-11 00:00:00	হলমার্ক হতে প্রাপ্ত আয়	12185	597.00	2026-04-18 07:42:55.366245
589	1	income	মেলটিং হতে প্রাপ্ত আয়	2026-01-11 00:00:00	মেলটিং হতে প্রাপ্ত আয়	27051	149.00	2026-04-18 07:43:14.540301
590	1	income	ওয়েল্ডিং হতে প্রাপ্ত আয়	2026-01-11 00:00:00	ওয়েল্ডিং হতে প্রাপ্ত আয়	5200	23.00	2026-04-18 07:43:44.504997
591	1	income	স্বর্ণ পাকাইকরন হতে আয়	2026-01-11 00:00:00	স্বর্ণ পাকাইকরন বিল	1200	74.89	2026-04-18 07:44:00.587992
592	1	costing	পরিচালক, অথিতি, ও স্টাফ আপ্যায়নের বিবরণ (January-2026)	2026-01-11 00:00:00	স্টাফ টিফিন	1350	0.00	2026-04-18 07:44:19.096451
594	1	costing	যাতায়াত সংক্রান্ত খরচের বিবরণ (January-2026)	2026-01-11 00:00:00	দীপ 	300	0.00	2026-04-18 07:45:21.367697
595	1	costing	বিভিন্ন ইলেকট্রিক যন্ত্রাংশ ক্রয় ও মেরামত (January-2026)	2026-01-11 00:00:00	কম্পিউটার	15900	0.00	2026-04-18 07:45:51.574911
596	1	costing	বিভিন্ন ইলেকট্রিক যন্ত্রাংশ ক্রয় ও মেরামত (January-2026)	2026-01-11 00:00:00	প্রিন্টার মেরামত	4500	0.00	2026-04-18 07:46:04.693077
598	1	costing	বিবিধ খরচের বিবরণ (January-2026)	2026-01-11 00:00:00	তৃতীয় লিঙ্গ	200	0.00	2026-04-18 07:46:49.529802
599	1	costing	বিবিধ খরচের বিবরণ (January-2026)	2026-01-11 00:00:00	বাট্টা (৫,১০,২০,৫০)	190	0.00	2026-04-18 07:46:57.819145
600	1	income	এক্সরে হতে প্রাপ্ত আয়	2026-01-12 00:00:00	এক্সরে হতে প্রাপ্ত আয়	40900	318.00	2026-04-18 07:47:45.216951
601	1	income	হলমার্ক হতে প্রাপ্ত আয়	2026-01-12 00:00:00	হলমার্ক হতে প্রাপ্ত আয়	10230	1131.00	2026-04-18 07:48:02.457504
602	1	income	মেলটিং হতে প্রাপ্ত আয়	2026-01-12 00:00:00	মেলটিং হতে প্রাপ্ত আয়	23062	135.00	2026-04-18 07:48:24.122181
603	1	income	ওয়েল্ডিং হতে প্রাপ্ত আয়	2026-01-12 00:00:00	ওয়েল্ডিং হতে প্রাপ্ত আয়	3600	9.00	2026-04-18 07:48:38.207205
604	1	costing	পরিচালক, অথিতি, ও স্টাফ আপ্যায়নের বিবরণ (January-2026)	2026-01-12 00:00:00	স্টাফ টিফিন	1150	0.00	2026-04-18 07:48:57.523724
605	1	costing	যাতায়াত সংক্রান্ত খরচের বিবরণ (January-2026)	2026-01-12 00:00:00	যাতায়াত - মাসুদ	200	0.00	2026-04-18 07:49:11.655955
606	1	costing	ভুল ডেটা এন্ট্রি ও ডিসকাউন্ট (January-2026)	2026-01-12 00:00:00	বিল মিস্টেক	200	0.00	2026-04-18 07:49:25.399075
607	1	costing	বিবিধ খরচের বিবরণ (January-2026)	2026-01-12 00:00:00	কফি কাপ 1000 পিচ	900	0.00	2026-04-18 07:49:45.063608
608	1	costing	বিবিধ খরচের বিবরণ (January-2026)	2026-01-12 00:00:00	গাড়ি মেরামত	250	0.00	2026-04-18 07:49:58.971611
609	1	costing	বিবিধ খরচের বিবরণ (January-2026)	2026-01-12 00:00:00	ভ্যাট বাংলা গোল্ড	41000	0.00	2026-04-18 07:50:16.671538
610	1	costing	বাইতুল মোকারাম অফিস খরচ (January-2026)	2026-01-12 00:00:00	বায়তুল মোকারম ভ্যাট	2050	0.00	2026-04-18 07:50:39.623022
611	1	costing	রিফাইনিং প্রজেক্ট বিবিধ খরচ (January-2026)	2026-01-12 00:00:00	ভ্যাট	2050	0.00	2026-04-18 07:50:55.498267
612	1	costing	বিবিধ খরচের বিবরণ (January-2026)	2026-01-12 00:00:00	গণেশ	7000	0.00	2026-04-18 07:51:10.912367
613	1	income	স্বর্ণ পাকাইকরন হতে আয়	2026-01-12 00:00:00	স্বর্ণ পাকাইকরন বিল	6300	740.02	2026-04-18 07:52:01.860425
614	1	income	এক্সরে হতে প্রাপ্ত আয়	2026-01-13 00:00:00	এক্সরে হতে প্রাপ্ত আয়	46450	362.00	2026-04-18 07:53:15.069432
615	1	income	হলমার্ক হতে প্রাপ্ত আয়	2026-01-13 00:00:00	হলমার্ক হতে প্রাপ্ত আয়	19560	763.00	2026-04-18 07:53:32.648233
616	1	income	মেলটিং হতে প্রাপ্ত আয়	2026-01-13 00:00:00	মেলটিং হতে প্রাপ্ত আয়	24737	149.00	2026-04-18 07:54:09.326992
617	1	income	স্বর্ণ পাকাইকরন হতে আয়	2026-01-13 00:00:00	স্বর্ণ পাকাইকরন বিল	1510	128.18	2026-04-18 07:54:59.90876
618	1	costing	পরিচালক, অথিতি, ও স্টাফ আপ্যায়নের বিবরণ (January-2026)	2026-01-13 00:00:00	স্টাফ টিফিন 	1200	0.00	2026-04-18 07:55:23.719973
619	1	costing	যাতায়াত সংক্রান্ত খরচের বিবরণ (January-2026)	2026-01-13 00:00:00	যাতায়াত - মাসুদ	200	0.00	2026-04-18 07:55:36.982944
620	1	costing	যাতায়াত সংক্রান্ত খরচের বিবরণ (January-2026)	2026-01-13 00:00:00	দীপ	400	0.00	2026-04-18 07:56:08.286421
621	1	costing	স্টেশনারি ও পি.পি.ই খরচের বিবরণ (January-2026)	2026-01-13 00:00:00	ভীম, টিস্যু, ইত্যাদি	9430	0.00	2026-04-18 07:56:42.488335
622	1	costing	স্টেশনারি ও পি.পি.ই খরচের বিবরণ (January-2026)	2026-01-13 00:00:00	প্রিন্টার কালি 20 পিচ	7000	0.00	2026-04-18 07:57:06.234066
623	1	costing	স্টেশনারি ও পি.পি.ই খরচের বিবরণ (January-2026)	2026-01-13 00:00:00	রিবন 	9360	0.00	2026-04-18 07:57:26.628519
624	1	costing	বিদুৎ বিল বিবরণ (January-2026)	2026-01-13 00:00:00	পুরাতন মিটার	20000	0.00	2026-04-18 07:58:00.434685
625	1	income	ওয়েল্ডিং হতে প্রাপ্ত আয়	2026-01-13 00:00:00	ওয়েল্ডিং হতে প্রাপ্ত আয়	9400	26.00	2026-04-18 07:58:47.102486
626	1	income	এক্সরে হতে প্রাপ্ত আয়	2026-01-14 00:00:00	এক্সরে হতে প্রাপ্ত আয়	33650	262.00	2026-04-18 08:18:46.789191
627	1	income	হলমার্ক হতে প্রাপ্ত আয়	2026-01-14 00:00:00	হলমার্ক হতে প্রাপ্ত আয়	12960	485.00	2026-04-18 08:19:57.386175
629	1	income	ওয়েল্ডিং হতে প্রাপ্ত আয়	2026-01-14 00:00:00	ওয়েল্ডিং হতে প্রাপ্ত আয়	5400	15.00	2026-04-18 08:23:45.833518
630	1	income	স্বর্ণ পাকাইকরন হতে আয়	2026-01-14 00:00:00	স্বর্ণ পাকাইকরন বিল	1550	93.61	2026-04-18 08:24:01.36833
631	1	costing	পরিচালক, অথিতি, ও স্টাফ আপ্যায়নের বিবরণ (January-2026)	2026-01-14 00:00:00	স্টাফ টিফিন	1150	0.00	2026-04-18 08:24:19.525477
632	1	costing	বিবিধ খরচের বিবরণ (January-2026)	2026-01-14 00:00:00	বাট্টা (৫,১০,২০,৫০)	150	0.00	2026-04-18 08:26:09.07256
633	1	costing	বিভিন্ন ইলেকট্রিক যন্ত্রাংশ ক্রয় ও মেরামত (January-2026)	2026-01-14 00:00:00	কম্পিউটার মেরামত	3000	0.00	2026-04-18 08:26:28.926878
628	1	income	মেলটিং হতে প্রাপ্ত আয়	2026-01-14 00:00:00	মেলটিং হতে প্রাপ্ত আয়	22071	120.00	2026-04-18 08:22:50.299163
634	1	income	এক্সরে হতে প্রাপ্ত আয়	2026-01-15 00:00:00	এক্সরে হতে প্রাপ্ত আয়	38450	306.00	2026-04-18 08:29:16.183128
636	1	income	মেলটিং হতে প্রাপ্ত আয়	2026-01-15 00:00:00	মেলটিং হতে প্রাপ্ত আয়	29026	157.00	2026-04-18 08:33:34.390264
637	1	income	ওয়েল্ডিং হতে প্রাপ্ত আয়	2026-01-15 00:00:00	মেলটিং হতে প্রাপ্ত আয়	5000	14.00	2026-04-18 08:33:56.440528
638	1	income	স্বর্ণ পাকাইকরন হতে আয়	2026-01-15 00:00:00	স্বর্ণ পাকাইকরন বিল	1800	127.56	2026-04-18 08:36:38.428708
639	1	costing	পরিচালক, অথিতি, ও স্টাফ আপ্যায়নের বিবরণ (January-2026)	2026-01-15 00:00:00	স্টাফ টিফিন	1150	0.00	2026-04-18 08:36:58.260203
640	1	costing	বিবিধ খরচের বিবরণ (January-2026)	2026-01-15 00:00:00	বাট্টা (৫,১০,২০,৫০)	160	0.00	2026-04-18 08:37:11.561548
641	1	costing	পরিচালক, অথিতি, ও স্টাফ আপ্যায়নের বিবরণ (January-2026)	2026-01-15 00:00:00	24 পিচ পানি	250	0.00	2026-04-18 08:37:47.682066
671	1	costing	পরিচালক, অথিতি, ও স্টাফ আপ্যায়নের বিবরণ (January-2026)	2026-01-19 00:00:00	স্টাফ স্যালারি	1050	0.00	2026-04-18 09:30:53.978448
635	1	income	হলমার্ক হতে প্রাপ্ত আয়	2026-01-15 00:00:00	হলমার্ক হতে প্রাপ্ত আয়	13670	802.00	2026-04-18 08:33:01.576181
643	1	income	এক্সরে হতে প্রাপ্ত আয়	2026-01-16 00:00:00	এক্সরে হতে প্রাপ্ত আয়	2400	18.00	2026-04-18 08:41:55.772233
644	1	income	হলমার্ক হতে প্রাপ্ত আয়	2026-01-16 00:00:00	হলমার্ক হতে প্রাপ্ত আয়	2940	145.00	2026-04-18 08:42:38.113452
645	1	income	মেলটিং হতে প্রাপ্ত আয়	2026-01-16 00:00:00	মেলটিং হতে প্রাপ্ত আয়	2318	13.00	2026-04-18 08:42:59.85211
647	1	income	এক্সরে হতে প্রাপ্ত আয়	2026-01-17 00:00:00	এক্সরে হতে প্রাপ্ত আয়	45150	359.00	2026-04-18 08:48:19.444464
648	1	income	হলমার্ক হতে প্রাপ্ত আয়	2026-01-17 00:00:00	হলমার্ক হতে প্রাপ্ত আয়	10830	676.00	2026-04-18 08:48:48.708819
649	1	income	মেলটিং হতে প্রাপ্ত আয়	2026-01-17 00:00:00	মেলটিং হতে প্রাপ্ত আয়	31483	139.00	2026-04-18 08:49:33.724168
650	1	income	ওয়েল্ডিং হতে প্রাপ্ত আয়	2026-01-17 00:00:00	ওয়েল্ডিং হতে প্রাপ্ত আয়	6200	16.00	2026-04-18 08:49:54.050221
651	1	income	স্বর্ণ পাকাইকরন হতে আয়	2026-01-17 00:00:00	স্বর্ণ পাকাইকরন বিল	4400	384.07	2026-04-18 08:50:20.287598
652	1	costing	পরিচালক, অথিতি, ও স্টাফ আপ্যায়নের বিবরণ (January-2026)	2026-01-17 00:00:00	স্টাফ টিফিন	1350	0.00	2026-04-18 08:50:53.025475
653	1	costing	বিবিধ খরচের বিবরণ (January-2026)	2026-01-17 00:00:00	বাট্টা (৫,১০,২০,৫০)	150	0.00	2026-04-18 08:51:47.76223
672	1	costing	বিদুৎ বিল বিবরণ (January-2026)	2026-01-19 00:00:00	নতুন মিটার	10000	0.00	2026-04-18 09:31:12.594221
646	1	costing	পরিচালক, অথিতি, ও স্টাফ আপ্যায়নের বিবরণ (January-2026)	2026-01-16 00:00:00	স্টাফ টিফিন	0	0.00	2026-04-18 08:43:57.504004
654	1	income	এক্সরে হতে প্রাপ্ত আয়	2026-01-18 00:00:00	এক্সরে হতে প্রাপ্ত আয়	44950	353.00	2026-04-18 08:56:36.362077
655	1	income	হলমার্ক হতে প্রাপ্ত আয়	2026-01-18 00:00:00	হলমার্ক হতে প্রাপ্ত আয়	17864	658.00	2026-04-18 08:56:59.401737
656	1	income	মেলটিং হতে প্রাপ্ত আয়	2026-01-18 00:00:00	মেলটিং হতে প্রাপ্ত আয়	37240	171.00	2026-04-18 08:57:20.628145
657	1	income	ওয়েল্ডিং হতে প্রাপ্ত আয়	2026-01-18 00:00:00	ওয়েল্ডিং হতে প্রাপ্ত আয়	5800	20.00	2026-04-18 08:57:37.255684
658	1	income	স্বর্ণ পাকাইকরন হতে আয়	2026-01-18 00:00:00	স্বর্ণ পাকাইকরন বিল	4000	397.95	2026-04-18 08:58:00.950641
659	1	costing	পরিচালক, অথিতি, ও স্টাফ আপ্যায়নের বিবরণ (January-2026)	2026-01-18 00:00:00	স্টাফ টিফিন	1100	0.00	2026-04-18 09:16:02.323845
660	1	costing	যাতায়াত সংক্রান্ত খরচের বিবরণ (January-2026)	2026-01-18 00:00:00	ইমন	300	0.00	2026-04-18 09:16:21.157344
661	1	costing	কাঁচামাল ও বিভিন্ন এসিড ক্রয় (January-2026)	2026-01-18 00:00:00	পেপার	10000	0.00	2026-04-18 09:16:59.517719
662	1	costing	বিবিধ খরচের বিবরণ (January-2026)	2026-01-18 00:00:00	তৃতীয় লিঙ্গ	100	0.00	2026-04-18 09:27:01.782231
663	1	costing	বিবিধ খরচের বিবরণ (January-2026)	2026-01-18 00:00:00	সার্ভিস চার্জ	13200	0.00	2026-04-18 09:27:17.583813
664	1	costing	বিবিধ খরচের বিবরণ (January-2026)	2026-01-18 00:00:00	এডভোকেট বাবুল	100000	0.00	2026-04-18 09:27:33.160664
665	1	costing	বিবিধ খরচের বিবরণ (January-2026)	2026-01-18 00:00:00	বাজুজ চাঁদা	1000	0.00	2026-04-18 09:27:55.269284
666	1	income	এক্সরে হতে প্রাপ্ত আয়	2026-01-19 00:00:00	এক্সরে হতে প্রাপ্ত আয়	38000	293.00	2026-04-18 09:28:38.151511
667	1	income	হলমার্ক হতে প্রাপ্ত আয়	2026-01-19 00:00:00	হলমার্ক হতে প্রাপ্ত আয়	8910	423.00	2026-04-18 09:29:01.397726
668	1	income	মেলটিং হতে প্রাপ্ত আয়	2026-01-19 00:00:00	মেলটিং হতে প্রাপ্ত আয়	23882	126.00	2026-04-18 09:29:20.672704
669	1	income	ওয়েল্ডিং হতে প্রাপ্ত আয়	2026-01-19 00:00:00	ওয়েল্ডিং হতে প্রাপ্ত আয়	3800	15.00	2026-04-18 09:30:02.18393
670	1	income	স্বর্ণ পাকাইকরন হতে আয়	2026-01-19 00:00:00	স্বর্ণ পাকাইকরন বিল	3850	419.18	2026-04-18 09:30:35.138068
673	1	costing	বিবিধ খরচের বিবরণ (January-2026)	2026-01-19 00:00:00	বাট্টা (৫,১০,২০,৫০)	80	0.00	2026-04-18 09:31:39.71106
674	1	costing	রিফাইনিং প্রজেক্ট বিবিধ খরচ (January-2026)	2026-01-19 00:00:00	ইলেকট্রিক বিল	30000	0.00	2026-04-18 09:31:57.447874
675	1	income	এক্সরে হতে প্রাপ্ত আয়	2026-01-20 00:00:00	এক্সরে হতে প্রাপ্ত আয়	44050	349.00	2026-04-18 09:32:28.373547
676	1	income	হলমার্ক হতে প্রাপ্ত আয়	2026-01-20 00:00:00	হলমার্ক হতে প্রাপ্ত আয়	15040	708.00	2026-04-18 09:33:01.15631
677	1	income	মেলটিং হতে প্রাপ্ত আয়	2026-01-20 00:00:00	মেলটিং হতে প্রাপ্ত আয়	28512	167.00	2026-04-18 09:33:29.414919
678	1	income	স্বর্ণ পাকাইকরন হতে আয়	2026-01-20 00:00:00	স্বর্ণ পাকাইকরন বিল	3150	195.00	2026-04-18 09:33:51.560457
679	1	income	ওয়েল্ডিং হতে প্রাপ্ত আয়	2026-01-20 00:00:00	ওয়েল্ডিং হতে প্রাপ্ত আয়	3100	13.00	2026-04-18 09:34:05.669335
680	1	costing	পরিচালক, অথিতি, ও স্টাফ আপ্যায়নের বিবরণ (January-2026)	2026-01-20 00:00:00	স্টাফ স্যালারি	1150	0.00	2026-04-18 09:34:22.521451
681	1	costing	বিবিধ খরচের বিবরণ (January-2026)	2026-01-20 00:00:00	রাবার পেন	300	0.00	2026-04-18 09:34:48.73102
682	1	costing	বিবিধ খরচের বিবরণ (January-2026)	2026-01-20 00:00:00	বাট্টা (৫,১০,২০,৫০)	150	0.00	2026-04-18 09:34:56.895026
683	1	costing	যাতায়াত সংক্রান্ত খরচের বিবরণ (January-2026)	2026-01-20 00:00:00	রনি	100	0.00	2026-04-18 09:35:09.825514
684	1	costing	রিফাইনিং প্রজেক্ট বিবিধ খরচ (January-2026)	2026-01-20 00:00:00	সার্ভিস চার্জ	5400	0.00	2026-04-18 09:35:23.02853
685	1	income	এক্সরে হতে প্রাপ্ত আয়	2026-01-21 00:00:00	এক্সরে হতে প্রাপ্ত আয়	40100	309.00	2026-04-18 09:35:52.903673
686	1	income	হলমার্ক হতে প্রাপ্ত আয়	2026-01-21 00:00:00	হলমার্ক হতে প্রাপ্ত আয়	17610	874.00	2026-04-18 09:37:09.736753
687	1	income	মেলটিং হতে প্রাপ্ত আয়	2026-01-21 00:00:00	মেলটিং হতে প্রাপ্ত আয়	25681	746.00	2026-04-18 09:37:28.764672
688	1	income	ওয়েল্ডিং হতে প্রাপ্ত আয়	2026-01-21 00:00:00	ওয়েল্ডিং হতে প্রাপ্ত আয়	6500	23.00	2026-04-18 09:37:43.191606
689	1	income	স্বর্ণ পাকাইকরন হতে আয়	2026-01-21 00:00:00	স্বর্ণ পাকাইকরন বিল	1870	171.84	2026-04-18 09:38:06.938094
690	1	costing	পরিচালক, অথিতি, ও স্টাফ আপ্যায়নের বিবরণ (January-2026)	2026-01-21 00:00:00	স্টাফ টিফিন	1200	0.00	2026-04-18 09:38:30.780977
691	1	costing	বিবিধ খরচের বিবরণ (January-2026)	2026-01-21 00:00:00	বাট্টা (৫,১০,২০,৫০)	60	0.00	2026-04-18 09:38:40.616911
692	1	costing	যাতায়াত সংক্রান্ত খরচের বিবরণ (January-2026)	2026-01-21 00:00:00	ইমন	200	0.00	2026-04-18 09:39:03.91772
693	1	costing	পরিচালক, অথিতি, ও স্টাফ আপ্যায়নের বিবরণ (January-2026)	2026-01-21 00:00:00	ইঞ্জিনিয়ার	400	0.00	2026-04-18 09:39:33.199361
694	1	costing	পরিচালক, অথিতি, ও স্টাফ আপ্যায়নের বিবরণ (January-2026)	2026-01-21 00:00:00	রাজু	200000	0.00	2026-04-18 09:39:48.584195
695	1	costing	পরিচালক, অথিতি, ও স্টাফ আপ্যায়নের বিবরণ (January-2026)	2026-01-21 00:00:00	phone মেরামত	3000	0.00	2026-04-18 09:40:00.155519
696	1	costing	পরিচালক, অথিতি, ও স্টাফ আপ্যায়নের বিবরণ (January-2026)	2026-01-21 00:00:00	সিল	600	0.00	2026-04-18 09:40:13.545301
697	1	income	এক্সরে হতে প্রাপ্ত আয়	2026-01-22 00:00:00	এক্সরে হতে প্রাপ্ত আয়	43050	327.00	2026-04-18 09:40:45.081607
698	1	income	হলমার্ক হতে প্রাপ্ত আয়	2026-01-22 00:00:00	হলমার্ক হতে প্রাপ্ত আয়	12130	675.00	2026-04-18 09:41:05.484096
699	1	income	মেলটিং হতে প্রাপ্ত আয়	2026-01-22 00:00:00	মেলটিং হতে প্রাপ্ত আয়	38091	165.00	2026-04-18 09:41:34.323514
700	1	income	ওয়েল্ডিং হতে প্রাপ্ত আয়	2026-01-22 00:00:00	ওয়েল্ডিং হতে প্রাপ্ত আয়	3600	15.00	2026-04-18 09:41:51.348952
702	1	costing	পরিচালক, অথিতি, ও স্টাফ আপ্যায়নের বিবরণ (January-2026)	2026-01-22 00:00:00	স্টাফ টিফিন	1200	0.00	2026-04-18 09:42:49.223678
701	1	income	স্বর্ণ পাকাইকরন হতে আয়	2026-01-22 00:00:00	স্বর্ণ পাকাইকরন বিল	2780	196.57	2026-04-18 09:42:17.246136
703	1	costing	বিবিধ খরচের বিবরণ (January-2026)	2026-01-22 00:00:00	বাট্টা (৫,১০,২০,৫০)	150	0.00	2026-04-18 09:44:47.861681
704	1	income	এক্সরে হতে প্রাপ্ত আয়	2026-01-23 00:00:00	এক্সরে হতে প্রাপ্ত আয়	4250	32.00	2026-04-18 09:45:11.547143
705	1	income	হলমার্ক হতে প্রাপ্ত আয়	2026-01-23 00:00:00	হলমার্ক হতে প্রাপ্ত আয়	2660	131.00	2026-04-18 09:45:47.510371
706	1	income	মেলটিং হতে প্রাপ্ত আয়	2026-01-23 00:00:00	মেলটিং হতে প্রাপ্ত আয়	1392	12.00	2026-04-18 09:46:07.274298
707	1	income	এক্সরে হতে প্রাপ্ত আয়	2026-01-24 00:00:00	এক্সরে হতে প্রাপ্ত আয়	40800	321.00	2026-04-18 09:46:33.962572
708	1	income	হলমার্ক হতে প্রাপ্ত আয়	2026-01-24 00:00:00	হলমার্ক হতে প্রাপ্ত আয়	9750	617.00	2026-04-18 09:47:03.769425
709	1	income	মেলটিং হতে প্রাপ্ত আয়	2026-01-24 00:00:00	মেলটিং হতে প্রাপ্ত আয়	26453	135.00	2026-04-18 09:47:35.262982
710	1	income	স্বর্ণ পাকাইকরন হতে আয়	2026-01-24 00:00:00	স্বর্ণ পাকাইকরন বিল	1700	102.77	2026-04-18 09:47:51.006893
711	1	costing	পরিচালক, অথিতি, ও স্টাফ আপ্যায়নের বিবরণ (January-2026)	2026-01-24 00:00:00	স্টাফ টিফিন	1450	0.00	2026-04-18 09:48:19.54603
712	1	costing	যাতায়াত সংক্রান্ত খরচের বিবরণ (January-2026)	2026-01-24 00:00:00	যাতায়াত - মাসুদ	200	0.00	2026-04-18 09:48:32.805853
713	1	costing	পরিচালক, অথিতি, ও স্টাফ আপ্যায়নের বিবরণ (January-2026)	2026-01-24 00:00:00	পানি	250	0.00	2026-04-18 09:48:47.015623
714	1	costing	বিবিধ খরচের বিবরণ (January-2026)	2026-01-24 00:00:00	আইডি কার্ড	5000	0.00	2026-04-18 09:49:08.137133
715	1	income	ওয়েল্ডিং হতে প্রাপ্ত আয়	2026-01-24 00:00:00	ওয়েল্ডিং হতে প্রাপ্ত আয়	3400	10.00	2026-04-18 09:49:55.833582
717	1	income	হলমার্ক হতে প্রাপ্ত আয়	2026-01-25 00:00:00	হলমার্ক হতে প্রাপ্ত আয়	19200	1588.00	2026-04-18 09:50:53.05615
718	1	income	মেলটিং হতে প্রাপ্ত আয়	2026-01-25 00:00:00	মেলটিং হতে প্রাপ্ত আয়	34398	142.00	2026-04-18 09:51:22.532822
716	1	income	এক্সরে হতে প্রাপ্ত আয়	2026-01-25 00:00:00	এক্সরে হতে প্রাপ্ত আয়	41750	331.00	2026-04-18 09:50:26.991066
719	1	income	ওয়েল্ডিং হতে প্রাপ্ত আয়	2026-01-25 00:00:00	ওয়েল্ডিং হতে প্রাপ্ত আয়	2200	9.00	2026-04-18 09:53:03.030949
720	1	income	স্বর্ণ পাকাইকরন হতে আয়	2026-01-25 00:00:00	স্বর্ণ পাকাইকরন বিল	1900	151.44	2026-04-18 09:53:17.57931
721	1	costing	পরিচালক, অথিতি, ও স্টাফ আপ্যায়নের বিবরণ (January-2026)	2026-01-25 00:00:00	স্টাফ টিফিন	1300	0.00	2026-04-18 09:53:36.995595
722	1	costing	যাতায়াত সংক্রান্ত খরচের বিবরণ (January-2026)	2026-01-25 00:00:00	রনি	200	0.00	2026-04-18 09:53:48.151816
723	1	costing	বিবিধ খরচের বিবরণ (January-2026)	2026-01-25 00:00:00	বাট্টা (৫,১০,২০,৫০)	160	0.00	2026-04-18 09:53:59.381804
724	1	costing	বিবিধ খরচের বিবরণ (January-2026)	2026-01-25 00:00:00	তেল	100	0.00	2026-04-18 09:54:26.422596
725	1	costing	বিবিধ খরচের বিবরণ (January-2026)	2026-01-25 00:00:00	তৃতীয় লিঙ্গ	100	0.00	2026-04-18 09:54:35.003465
726	1	costing	বিবিধ খরচের বিবরণ (January-2026)	2026-01-25 00:00:00	পাথ	200	0.00	2026-04-18 09:54:44.493494
727	1	income	এক্সরে হতে প্রাপ্ত আয়	2026-01-26 00:00:00	এক্সরে হতে প্রাপ্ত আয়	36950	292.00	2026-04-18 09:56:36.662709
728	1	income	হলমার্ক হতে প্রাপ্ত আয়	2026-01-26 00:00:00	হলমার্ক হতে প্রাপ্ত আয়	13830	866.00	2026-04-18 09:56:56.752223
729	1	income	মেলটিং হতে প্রাপ্ত আয়	2026-01-26 00:00:00	মেলটিং হতে প্রাপ্ত আয়	20720	119.00	2026-04-18 09:57:30.08052
730	1	income	ওয়েল্ডিং হতে প্রাপ্ত আয়	2026-01-26 00:00:00	ওয়েল্ডিং হতে প্রাপ্ত আয়	5400	19.00	2026-04-18 09:57:45.001021
731	1	income	স্বর্ণ পাকাইকরন হতে আয়	2026-01-26 00:00:00	স্বর্ণ পাকাইকরন বিল	7300	64.00	2026-04-18 09:58:10.494045
732	1	costing	পরিচালক, অথিতি, ও স্টাফ আপ্যায়নের বিবরণ (January-2026)	2026-01-26 00:00:00	স্টাফ টিফিন	1300	0.00	2026-04-18 09:58:30.755859
733	1	costing	বিবিধ খরচের বিবরণ (January-2026)	2026-01-26 00:00:00	তৃতীয় লিঙ্গ	100	0.00	2026-04-18 09:58:43.75867
734	1	costing	বিবিধ খরচের বিবরণ (January-2026)	2026-01-26 00:00:00	বাট্টা (৫,১০,২০,৫০)	230	0.00	2026-04-18 09:58:52.078071
735	1	costing	বিদুৎ বিল বিবরণ (January-2026)	2026-01-26 00:00:00	পুরাতন মিটার	20000	0.00	2026-04-18 09:59:17.466793
736	1	income	এক্সরে হতে প্রাপ্ত আয়	2026-01-27 00:00:00	এক্সরে হতে প্রাপ্ত আয়	48960	385.00	2026-04-18 10:00:11.010775
737	1	income	হলমার্ক হতে প্রাপ্ত আয়	2026-01-27 00:00:00	হলমার্ক হতে প্রাপ্ত আয়	16180	909.00	2026-04-18 10:00:29.755052
738	1	income	মেলটিং হতে প্রাপ্ত আয়	2026-01-27 00:00:00	মেলটিং হতে প্রাপ্ত আয়	28868	152.00	2026-04-18 10:00:53.138804
740	1	costing	পরিচালক, অথিতি, ও স্টাফ আপ্যায়নের বিবরণ (January-2026)	2026-01-27 00:00:00	স্টাফ টিফিন	1300	0.00	2026-04-18 10:01:33.680954
741	1	costing	পরিচালক, অথিতি, ও স্টাফ আপ্যায়নের বিবরণ (January-2026)	2026-01-27 00:00:00	জিকে	500	0.00	2026-04-18 10:01:43.146689
742	1	costing	যাতায়াত সংক্রান্ত খরচের বিবরণ (January-2026)	2026-01-27 00:00:00	রনি	100	0.00	2026-04-18 10:01:57.793492
743	1	income	এক্সরে হতে প্রাপ্ত আয়	2026-01-28 00:00:00	এক্সরে হতে প্রাপ্ত আয়	44500	348.00	2026-04-18 10:02:23.789867
744	1	income	হলমার্ক হতে প্রাপ্ত আয়	2026-01-28 00:00:00	হলমার্ক হতে প্রাপ্ত আয়	17455	1217.00	2026-04-18 10:02:47.721695
745	1	income	মেলটিং হতে প্রাপ্ত আয়	2026-01-28 00:00:00	মেলটিং হতে প্রাপ্ত আয়	28285	131.00	2026-04-18 10:03:04.587087
746	1	income	ওয়েল্ডিং হতে প্রাপ্ত আয়	2026-01-28 00:00:00	ওয়েল্ডিং হতে প্রাপ্ত আয়	5000	15.00	2026-04-18 10:03:24.699678
747	1	income	স্বর্ণ পাকাইকরন হতে আয়	2026-01-28 00:00:00	স্বর্ণ পাকাইকরন বিল	800	23.00	2026-04-18 10:03:41.55782
748	1	costing	পরিচালক, অথিতি, ও স্টাফ আপ্যায়নের বিবরণ (January-2026)	2026-01-28 00:00:00	স্টাফ টিফিন	1300	0.00	2026-04-18 10:03:55.893781
749	1	costing	বিবিধ খরচের বিবরণ (January-2026)	2026-01-28 00:00:00	বাট্টা (৫,১০,২০,৫০)	80	0.00	2026-04-18 10:04:07.732176
750	1	costing	যাতায়াত সংক্রান্ত খরচের বিবরণ (January-2026)	2026-01-28 00:00:00	ইমন	200	0.00	2026-04-18 10:04:25.890756
751	1	costing	ভুল ডেটা এন্ট্রি ও ডিসকাউন্ট (January-2026)	2026-01-28 00:00:00	রাইটিং বিল	200	0.00	2026-04-18 10:04:37.446306
739	1	income	ওয়েল্ডিং হতে প্রাপ্ত আয়	2026-01-27 00:00:00	ওয়েল্ডিং হতে প্রাপ্ত আয়	7400	456.43	2026-04-18 10:01:21.234172
752	1	income	স্বর্ণ পাকাইকরন হতে আয়	2026-01-27 00:00:00	স্বর্ণ পাকাইকরন বিল	4700	456.00	2026-04-18 10:06:23.932863
753	1	income	এক্সরে হতে প্রাপ্ত আয়	2026-01-29 00:00:00	এক্সরে হতে প্রাপ্ত আয়	47050	369.00	2026-04-18 10:07:04.440426
754	1	income	হলমার্ক হতে প্রাপ্ত আয়	2026-01-29 00:00:00	হলমার্ক হতে প্রাপ্ত আয়	13050	607.00	2026-04-18 10:07:19.3419
755	1	income	মেলটিং হতে প্রাপ্ত আয়	2026-01-29 00:00:00	মেলটিং হতে প্রাপ্ত আয়	31352	145.00	2026-04-18 10:07:38.039988
756	1	income	ওয়েল্ডিং হতে প্রাপ্ত আয়	2026-01-29 00:00:00	ওয়েল্ডিং হতে প্রাপ্ত আয়	5800	22.00	2026-04-18 10:07:55.926899
757	1	income	স্বর্ণ পাকাইকরন হতে আয়	2026-01-29 00:00:00	স্বর্ণ পাকাইকরন বিল	5950	489.97	2026-04-18 10:08:14.250525
758	1	costing	পরিচালক, অথিতি, ও স্টাফ আপ্যায়নের বিবরণ (January-2026)	2026-01-29 00:00:00	স্টাফ	1300	0.00	2026-04-18 10:08:29.836171
759	1	costing	যাতায়াত সংক্রান্ত খরচের বিবরণ (January-2026)	2026-01-29 00:00:00	যাতায়াত - মাসুদ	300	0.00	2026-04-18 10:08:42.043882
760	1	costing	বিবিধ খরচের বিবরণ (January-2026)	2026-01-29 00:00:00	বাট্টা (৫,১০,২০,৫০)	150	0.00	2026-04-18 10:08:54.821963
761	1	costing	ভুল ডেটা এন্ট্রি ও ডিসকাউন্ট (January-2026)	2026-01-29 00:00:00	রাইটিং বিল	320	0.00	2026-04-18 10:09:07.885154
762	1	costing	বিবিধ খরচের বিবরণ (January-2026)	2026-01-29 00:00:00	4 পিচ ফেন আপস	24100	0.00	2026-04-18 10:09:33.130928
763	1	costing	বিবিধ খরচের বিবরণ (January-2026)	2026-01-29 00:00:00	চাঁদি রুপা 1 	5500	0.00	2026-04-18 10:09:52.062235
764	1	costing	বিবিধ খরচের বিবরণ (January-2026)	2026-01-29 00:00:00	কেরোসিন	650	0.00	2026-04-18 10:10:05.01616
765	1	costing	বিবিধ খরচের বিবরণ (January-2026)	2026-01-29 00:00:00	উৎস কর প্রধান	11000	0.00	2026-04-18 10:10:19.563203
766	1	income	এক্সরে হতে প্রাপ্ত আয়	2026-01-30 00:00:00	এক্সরে হতে প্রাপ্ত আয়	4900	35.00	2026-04-18 10:10:53.615905
767	1	income	হলমার্ক হতে প্রাপ্ত আয়	2026-01-30 00:00:00	হলমার্ক হতে প্রাপ্ত আয়	9160	787.00	2026-04-18 10:11:11.303734
768	1	income	মেলটিং হতে প্রাপ্ত আয়	2026-01-30 00:00:00	মেলটিং হতে প্রাপ্ত আয়	2166	13.00	2026-04-18 10:11:29.198958
769	1	income	এক্সরে হতে প্রাপ্ত আয়	2026-01-31 00:00:00	এক্সরে হতে প্রাপ্ত আয়	37750	297.00	2026-04-18 10:56:43.450865
771	1	income	হলমার্ক হতে প্রাপ্ত আয়	2026-01-31 00:00:00	হলমার্ক হতে প্রাপ্ত আয়	13736	827.00	2026-04-18 10:58:31.788005
772	1	income	মেলটিং হতে প্রাপ্ত আয়	2026-01-31 00:00:00	মেলটিং হতে প্রাপ্ত আয়	24556	125.00	2026-04-18 10:59:08.145675
774	1	income	স্বর্ণ পাকাইকরন হতে আয়	2026-01-31 00:00:00	স্বর্ণ পাকাইকরন বিল	6550	511.21	2026-04-18 11:00:23.657034
775	1	costing	পরিচালক, অথিতি, ও স্টাফ আপ্যায়নের বিবরণ (January-2026)	2026-01-31 00:00:00	স্টাফ টিফিন	1550	0.00	2026-04-18 11:00:59.878884
776	1	costing	যাতায়াত সংক্রান্ত খরচের বিবরণ (January-2026)	2026-01-31 00:00:00	যাতায়াত - মাসুদ	200	0.00	2026-04-18 11:01:15.780253
770	1	income	হলমার্ক হতে প্রাপ্ত আয়	2026-01-31 00:00:00	হলমার্ক হতে প্রাপ্ত আয়	0	827.00	2026-04-18 10:57:09.662694
790	1	costing	আল - আরাফা ইসলামী ব্যাংক (শেখের বাজার)	2026-01-01 00:00:00	কর্মচারী বেতন	429567	0.00	2026-04-20 15:03:37.015645
773	1	income	ওয়েল্ডিং হতে প্রাপ্ত আয়	2026-01-31 00:00:00	ওয়েল্ডিং হতে প্রাপ্ত আয়	5500	125.00	2026-04-18 10:59:32.791406
777	1	costing	বিদুৎ বিল বিবরণ (January-2026)	2026-01-31 00:00:00	পুরাতন মিটার	10000	0.00	2026-04-18 11:06:26.062501
778	1	costing	বিবিধ খরচের বিবরণ (January-2026)	2026-01-31 00:00:00	পাথ	250	0.00	2026-04-18 11:07:59.269169
779	1	costing	বিবিধ খরচের বিবরণ (January-2026)	2026-01-31 00:00:00	বাট্টা (৫,১০,২০,৫০)	140	0.00	2026-04-18 11:08:11.114522
780	1	costing	বিবিধ খরচের বিবরণ (January-2026)	2026-01-31 00:00:00	স্কেচ মেশিন মেরামত	400	0.00	2026-04-18 11:08:33.071948
781	1	costing	বিবিধ খরচের বিবরণ (January-2026)	2026-01-15 00:00:00	এডুজে কম্পিউটার	4000	0.00	2026-04-18 12:07:56.437372
782	3	income	এক্সরে হতে প্রাপ্ত আয়	2026-03-04 00:00:00	এক্সরে হতে প্রাপ্ত আয়	9400	0.00	2026-04-18 12:41:32.181685
783	3	income	হলমার্ক হতে প্রাপ্ত আয়	2026-03-04 00:00:00	হলমার্ক হতে প্রাপ্ত আয়	3480	152.00	2026-04-18 12:42:49.259444
784	3	income	মেলটিং হতে প্রাপ্ত আয়	2026-03-04 00:00:00	মেলটিং হতে প্রাপ্ত আয়	3146	10.00	2026-04-18 12:43:02.997671
785	3	income	ওয়েল্ডিং হতে প্রাপ্ত আয়	2026-03-04 00:00:00	ওয়েল্ডিং হতে প্রাপ্ত আয়	400	2.00	2026-04-18 12:43:14.953203
422	3	costing	যাতায়াত সংক্রান্ত খরচের বিবরণ (March-2026)	2026-03-18 00:00:00	যাতায়াত - মাসুদ	200	0.00	2026-04-17 05:05:29.737427
789	1	income	ওয়েলফেয়ার ফান্ড (আল - আরাফা ইসলামী ব্যাংক) শেখের বাজার	2026-01-04 00:00:00	ক্যাশ জমা	27380	0.00	2026-04-20 14:58:04.4208
786	1	income	প্রভিডেন্ট ফান্ড (আল - আরাফা ইসলামী ব্যাংক) শেখের বাজার	2026-01-04 00:00:00	ক্যাশ ডিপোজিট	24050	0.00	2026-04-20 14:55:33.767411
791	1	income	আল - আরাফা ইসলামী ব্যাংক (শেখের বাজার)	2026-01-04 00:00:00	ক্যাশ জমা	700000	0.00	2026-04-20 15:04:21.307464
792	1	income	আল - আরাফা ইসলামী ব্যাংক (শেখের বাজার)	2026-01-04 00:00:00	ক্যাশ জমা	800000	0.00	2026-04-20 15:04:51.403738
793	1	income	আল - আরাফা ইসলামী ব্যাংক (শেখের বাজার)	2026-01-11 00:00:00	ক্যাশ জমা	500000	0.00	2026-04-20 15:05:14.550691
794	1	costing	আল - আরাফা ইসলামী ব্যাংক (শেখের বাজার)	2026-01-14 00:00:00	clg Dr source BR	200000	0.00	2026-04-20 15:05:48.277326
795	1	costing	আল - আরাফা ইসলামী ব্যাংক (নবাবপুর শাখা)	2026-01-01 00:00:00	স্যালারি	10000	0.00	2026-04-20 15:10:13.044862
796	1	costing	আল - আরাফা ইসলামী ব্যাংক (নবাবপুর শাখা)	2026-01-01 00:00:00	স্যালারি	10000	0.00	2026-04-20 15:10:27.366932
797	1	costing	আল - আরাফা ইসলামী ব্যাংক (নবাবপুর শাখা)	2026-01-01 00:00:00	স্যালারি	10000	0.00	2026-04-20 15:10:36.449234
798	1	costing	আল - আরাফা ইসলামী ব্যাংক (নবাবপুর শাখা)	2026-01-01 00:00:00	স্যালারি	10000	0.00	2026-04-20 15:10:44.744071
799	1	costing	আল - আরাফা ইসলামী ব্যাংক (নবাবপুর শাখা)	2026-01-01 00:00:00	স্যালারি	10000	0.00	2026-04-20 15:10:59.603249
800	1	costing	আল - আরাফা ইসলামী ব্যাংক (নবাবপুর শাখা)	2026-01-01 00:00:00	স্যালারি	10000	0.00	2026-04-20 15:11:12.73717
801	1	costing	আল - আরাফা ইসলামী ব্যাংক (নবাবপুর শাখা)	2026-01-01 00:00:00	স্যালারি	10000	0.00	2026-04-20 15:11:21.394241
802	1	income	আল - আরাফা ইসলামী ব্যাংক (নবাবপুর শাখা)	2026-01-04 00:00:00	বেনিফিট	10000	0.00	2026-04-20 15:11:49.552517
806	1	costing	ব্যাংক এ যাবতীয় জমা (January-2026)	2026-01-04 00:00:00	আল আরাফা ব্যাংক 	1500000	0.00	2026-04-20 18:12:49.291648
807	1	costing	ব্যাংক এ যাবতীয় জমা (January-2026)	2026-01-04 00:00:00	ফান্ড	24050	0.00	2026-04-20 18:13:19.200883
808	1	costing	ব্যাংক এ যাবতীয় জমা (January-2026)	2026-01-04 00:00:00	ফান্ড	27380	0.00	2026-04-20 18:13:49.033891
805	1	costing	ব্যাংক এ যাবতীয় জমা (January-2026)	2026-01-11 00:00:00	আল আরাফা ব্যাংক	500000	0.00	2026-04-20 18:10:49.779367
836	3	costing	স্টাফদের বেতন প্রধান (ব্যাংক) (March-2026)	2026-03-08 00:00:00	ঈদ বোনাস 	481000	0.00	2026-04-21 12:42:11.276722
837	3	income	আল - আরাফা ইসলামী ব্যাংক (শেখের বাজার)	2026-03-16 00:00:00	আল - আরাফা ইসলামী ব্যাংক (শেখের বাজার)	600000	0.00	2026-04-21 12:43:31.771572
838	2	costing	আল - আরাফা ইসলামী ব্যাংক (শেখের বাজার)	2026-02-18 00:00:00	স্টাফ বেতন	433200	0.00	2026-04-21 12:46:08.978032
830	1	costing	পরিচালকগণের সম্মানী প্রদান (ব্যাংক) (January-2026)	2026-01-01 00:00:00	পরিচালকগণের সম্মানী প্রদান (ব্যাংক) (January-2026)	70000	0.00	2026-04-21 04:04:55.011866
831	1	costing	স্টাফদের বেতন প্রধান (ব্যাংক) (January-2026)	2026-01-01 00:00:00	স্টাফদের বেতন প্রধান (ব্যাংক) (January-2026)	429567	0.00	2026-04-21 04:08:20.571608
833	2	costing	পরিচালকগণের সম্মানী প্রদান (ব্যাংক) (February-2026)	2026-04-21 00:00:00	পরিচালকগণের সম্মানী প্রদান (ব্যাংক) (February-2026)	70000	0.00	2026-04-21 05:22:56.340737
834	2	costing	স্টাফদের বেতন প্রধান (ব্যাংক) (February-2026)	2026-04-21 00:00:00	স্টাফদের বেতন প্রধান (ব্যাংক) (February-2026)	428133	0.00	2026-04-21 05:24:47.250317
835	3	costing	স্টাফদের বেতন প্রধান (ব্যাংক) (March-2026)	2026-03-03 00:00:00	স্টাফদের বেতন প্রধান (ব্যাংক) (March-2026)	428133	0.00	2026-04-21 12:41:17.892802
839	3	costing	আল - আরাফা ইসলামী ব্যাংক (শেখের বাজার)	2026-03-03 00:00:00	স্টাফ বেতন 	428133	0.00	2026-04-21 12:48:56.191643
840	3	costing	আল - আরাফা ইসলামী ব্যাংক (শেখের বাজার)	2026-03-08 00:00:00	স্টাফ ঈদ বোনাস	481000	0.00	2026-04-21 12:49:28.78632
841	2	income	প্রভিডেন্ট ফান্ড (আল - আরাফা ইসলামী ব্যাংক) শেখের বাজার	2026-02-19 00:00:00	প্রভিডেন্ট ফান্ড (আল - আরাফা ইসলামী ব্যাংক) শেখের বাজার	24050	0.00	2026-04-21 12:55:06.850577
842	3	income	ওয়েলফেয়ার ফান্ড (আল - আরাফা ইসলামী ব্যাংক) শেখের বাজার	2026-03-02 00:00:00	ক্যাশ জমা	10760	0.00	2026-04-21 12:57:29.793774
843	3	costing	ওয়েলফেয়ার ফান্ড (আল - আরাফা ইসলামী ব্যাংক) শেখের বাজার	2026-03-08 00:00:00	ট্রান্সফারে টু AC 012112004919	20000	0.00	2026-04-21 12:58:42.362784
844	3	income	প্রভিডেন্ট ফান্ড (আল - আরাফা ইসলামী ব্যাংক) শেখের বাজার	2026-03-02 00:00:00	প্রভিডেন্ট ফান্ড (আল - আরাফা ইসলামী ব্যাংক) শেখের বাজার	23100	0.00	2026-04-21 12:59:47.811311
845	2	income	ওয়েলফেয়ার ফান্ড (আল - আরাফা ইসলামী ব্যাংক) শেখের বাজার	2026-02-19 00:00:00	ক্যাশ নেওয়া	16250	0.00	2026-04-21 13:02:26.272488
846	2	costing	আল - আরাফা ইসলামী ব্যাংক (নবাবপুর শাখা)	2026-02-18 00:00:00	পরিচালকদের সম্মানী ব্যাংক এর মাধ্যমে	70000	0.00	2026-04-21 13:07:49.833797
847	2	income	আল - আরাফা ইসলামী ব্যাংক (নবাবপুর শাখা)	2026-02-19 00:00:00	ক্যাশ জমা	100000	0.00	2026-04-21 13:08:17.850596
848	3	costing	আল - আরাফা ইসলামী ব্যাংক (নবাবপুর শাখা)	2026-03-03 00:00:00	পরিচালকদের সম্মানী ব্যাংক এর মাধ্যমে	60000	0.00	2026-04-21 13:09:19.701797
849	3	costing	পরিচালকগণের সম্মানী প্রদান (ব্যাংক) (March-2026)	2026-03-03 00:00:00	পরিচালকগণের সম্মানী প্রদান (ব্যাংক) (March-2026)	60000	0.00	2026-04-21 13:59:55.611041
850	1	costing	ব্যাংক এর মাধ্যমে পেমেন্ট (January-2026)	2026-01-31 23:59:00	ব্যাংকিং ক্লিয়ারিং (clg Dr source BR)	200000	0.00	2026-04-21 21:36:10.434435
851	1	income	ব্যাংক হতে প্রাপ্ত লভ্যাংশ	2026-01-31 23:59:00	মাসের প্রাপ্ত ব্যাংক লভ্যাংশ	10000	0.00	2026-04-21 21:36:10.434435
852	2	costing	ব্যাংক এর আবগারি শুল্ক(February-2026)	2026-02-28 23:59:00	মাসের ব্যাংক চার্জেস ও শুল্ক কর্তন	5067	0.00	2026-04-21 21:36:10.584429
853	3	costing	ব্যাংক এর মাধ্যমে পেমেন্ট (March-2026)	2026-03-31 23:59:00	ফান্ড ট্রান্সফার (AC 012112004919)	20000	0.00	2026-04-21 21:36:10.704403
\.


--
-- Data for Name: schema_migrations; Type: TABLE DATA; Schema: realtime; Owner: supabase_admin
--

COPY realtime.schema_migrations (version, inserted_at) FROM stdin;
20211116024918	2026-04-15 02:25:18
20211116045059	2026-04-15 02:25:19
20211116050929	2026-04-15 02:25:20
20211116051442	2026-04-15 02:25:21
20211116212300	2026-04-15 02:25:21
20211116213355	2026-04-15 02:25:22
20211116213934	2026-04-15 02:25:23
20211116214523	2026-04-15 02:25:24
20211122062447	2026-04-15 02:25:24
20211124070109	2026-04-15 02:25:25
20211202204204	2026-04-15 02:25:26
20211202204605	2026-04-15 02:25:26
20211210212804	2026-04-15 02:25:29
20211228014915	2026-04-15 02:25:29
20220107221237	2026-04-15 02:25:30
20220228202821	2026-04-15 02:25:31
20220312004840	2026-04-15 02:25:31
20220603231003	2026-04-15 02:25:32
20220603232444	2026-04-15 02:25:33
20220615214548	2026-04-15 02:25:34
20220712093339	2026-04-15 02:25:35
20220908172859	2026-04-15 02:25:35
20220916233421	2026-04-15 02:25:36
20230119133233	2026-04-15 02:25:37
20230128025114	2026-04-15 02:25:38
20230128025212	2026-04-15 02:25:38
20230227211149	2026-04-15 02:25:39
20230228184745	2026-04-15 02:25:40
20230308225145	2026-04-15 02:25:40
20230328144023	2026-04-15 02:25:41
20231018144023	2026-04-15 02:25:42
20231204144023	2026-04-15 02:25:43
20231204144024	2026-04-15 02:25:44
20231204144025	2026-04-15 02:25:44
20240108234812	2026-04-15 02:25:45
20240109165339	2026-04-15 02:25:46
20240227174441	2026-04-15 02:25:47
20240311171622	2026-04-15 02:25:48
20240321100241	2026-04-15 02:25:49
20240401105812	2026-04-15 02:25:51
20240418121054	2026-04-15 02:25:52
20240523004032	2026-04-15 02:25:55
20240618124746	2026-04-15 02:25:55
20240801235015	2026-04-15 02:25:56
20240805133720	2026-04-15 02:25:57
20240827160934	2026-04-15 02:25:57
20240919163303	2026-04-15 02:25:58
20240919163305	2026-04-15 02:25:59
20241019105805	2026-04-15 02:26:00
20241030150047	2026-04-15 02:26:02
20241108114728	2026-04-15 02:26:03
20241121104152	2026-04-15 02:26:04
20241130184212	2026-04-15 02:26:05
20241220035512	2026-04-15 02:26:05
20241220123912	2026-04-15 02:26:06
20241224161212	2026-04-15 02:26:07
20250107150512	2026-04-15 02:26:07
20250110162412	2026-04-15 02:26:08
20250123174212	2026-04-15 02:26:09
20250128220012	2026-04-15 02:26:09
20250506224012	2026-04-15 02:26:10
20250523164012	2026-04-15 02:26:11
20250714121412	2026-04-15 02:26:11
20250905041441	2026-04-15 02:26:12
20251103001201	2026-04-15 02:26:13
20251120212548	2026-04-15 02:26:14
20251120215549	2026-04-15 02:26:14
20260218120000	2026-04-15 02:26:15
20260326120000	2026-04-15 02:26:16
\.


--
-- Data for Name: subscription; Type: TABLE DATA; Schema: realtime; Owner: supabase_admin
--

COPY realtime.subscription (id, subscription_id, entity, filters, claims, created_at, action_filter) FROM stdin;
\.


--
-- Data for Name: buckets; Type: TABLE DATA; Schema: storage; Owner: supabase_storage_admin
--

COPY storage.buckets (id, name, owner, created_at, updated_at, public, avif_autodetection, file_size_limit, allowed_mime_types, owner_id, type) FROM stdin;
\.


--
-- Data for Name: buckets_analytics; Type: TABLE DATA; Schema: storage; Owner: supabase_storage_admin
--

COPY storage.buckets_analytics (name, type, format, created_at, updated_at, id, deleted_at) FROM stdin;
\.


--
-- Data for Name: buckets_vectors; Type: TABLE DATA; Schema: storage; Owner: supabase_storage_admin
--

COPY storage.buckets_vectors (id, type, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: migrations; Type: TABLE DATA; Schema: storage; Owner: supabase_storage_admin
--

COPY storage.migrations (id, name, hash, executed_at) FROM stdin;
0	create-migrations-table	e18db593bcde2aca2a408c4d1100f6abba2195df	2026-04-15 02:25:05.468963
1	initialmigration	6ab16121fbaa08bbd11b712d05f358f9b555d777	2026-04-15 02:25:05.561149
2	storage-schema	f6a1fa2c93cbcd16d4e487b362e45fca157a8dbd	2026-04-15 02:25:05.577155
3	pathtoken-column	2cb1b0004b817b29d5b0a971af16bafeede4b70d	2026-04-15 02:25:05.630569
4	add-migrations-rls	427c5b63fe1c5937495d9c635c263ee7a5905058	2026-04-15 02:25:05.738746
5	add-size-functions	79e081a1455b63666c1294a440f8ad4b1e6a7f84	2026-04-15 02:25:05.747594
6	change-column-name-in-get-size	ded78e2f1b5d7e616117897e6443a925965b30d2	2026-04-15 02:25:05.756548
7	add-rls-to-buckets	e7e7f86adbc51049f341dfe8d30256c1abca17aa	2026-04-15 02:25:05.767524
8	add-public-to-buckets	fd670db39ed65f9d08b01db09d6202503ca2bab3	2026-04-15 02:25:05.776154
9	fix-search-function	af597a1b590c70519b464a4ab3be54490712796b	2026-04-15 02:25:05.785009
10	search-files-search-function	b595f05e92f7e91211af1bbfe9c6a13bb3391e16	2026-04-15 02:25:05.794115
11	add-trigger-to-auto-update-updated_at-column	7425bdb14366d1739fa8a18c83100636d74dcaa2	2026-04-15 02:25:05.803441
12	add-automatic-avif-detection-flag	8e92e1266eb29518b6a4c5313ab8f29dd0d08df9	2026-04-15 02:25:05.815112
13	add-bucket-custom-limits	cce962054138135cd9a8c4bcd531598684b25e7d	2026-04-15 02:25:05.823815
14	use-bytes-for-max-size	941c41b346f9802b411f06f30e972ad4744dad27	2026-04-15 02:25:05.832176
15	add-can-insert-object-function	934146bc38ead475f4ef4b555c524ee5d66799e5	2026-04-15 02:25:05.875865
16	add-version	76debf38d3fd07dcfc747ca49096457d95b1221b	2026-04-15 02:25:05.890724
17	drop-owner-foreign-key	f1cbb288f1b7a4c1eb8c38504b80ae2a0153d101	2026-04-15 02:25:05.905724
18	add_owner_id_column_deprecate_owner	e7a511b379110b08e2f214be852c35414749fe66	2026-04-15 02:25:05.914351
19	alter-default-value-objects-id	02e5e22a78626187e00d173dc45f58fa66a4f043	2026-04-15 02:25:05.9236
20	list-objects-with-delimiter	cd694ae708e51ba82bf012bba00caf4f3b6393b7	2026-04-15 02:25:05.932054
21	s3-multipart-uploads	8c804d4a566c40cd1e4cc5b3725a664a9303657f	2026-04-15 02:25:05.942119
22	s3-multipart-uploads-big-ints	9737dc258d2397953c9953d9b86920b8be0cdb73	2026-04-15 02:25:05.961905
23	optimize-search-function	9d7e604cddc4b56a5422dc68c9313f4a1b6f132c	2026-04-15 02:25:06.010516
24	operation-function	8312e37c2bf9e76bbe841aa5fda889206d2bf8aa	2026-04-15 02:25:06.019243
25	custom-metadata	d974c6057c3db1c1f847afa0e291e6165693b990	2026-04-15 02:25:06.029824
26	objects-prefixes	215cabcb7f78121892a5a2037a09fedf9a1ae322	2026-04-15 02:25:06.038855
27	search-v2	859ba38092ac96eb3964d83bf53ccc0b141663a6	2026-04-15 02:25:14.281797
28	object-bucket-name-sorting	c73a2b5b5d4041e39705814fd3a1b95502d38ce4	2026-04-15 02:25:14.293306
29	create-prefixes	ad2c1207f76703d11a9f9007f821620017a66c21	2026-04-15 02:25:14.302471
30	update-object-levels	2be814ff05c8252fdfdc7cfb4b7f5c7e17f0bed6	2026-04-15 02:25:14.311676
31	objects-level-index	b40367c14c3440ec75f19bbce2d71e914ddd3da0	2026-04-15 02:25:14.320481
32	backward-compatible-index-on-objects	e0c37182b0f7aee3efd823298fb3c76f1042c0f7	2026-04-15 02:25:14.329406
33	backward-compatible-index-on-prefixes	b480e99ed951e0900f033ec4eb34b5bdcb4e3d49	2026-04-15 02:25:14.338605
34	optimize-search-function-v1	ca80a3dc7bfef894df17108785ce29a7fc8ee456	2026-04-15 02:25:14.347839
35	add-insert-trigger-prefixes	458fe0ffd07ec53f5e3ce9df51bfdf4861929ccc	2026-04-15 02:25:14.356849
36	optimise-existing-functions	6ae5fca6af5c55abe95369cd4f93985d1814ca8f	2026-04-15 02:25:14.365945
37	add-bucket-name-length-trigger	3944135b4e3e8b22d6d4cbb568fe3b0b51df15c1	2026-04-15 02:25:14.375105
38	iceberg-catalog-flag-on-buckets	02716b81ceec9705aed84aa1501657095b32e5c5	2026-04-15 02:25:14.409586
39	add-search-v2-sort-support	6706c5f2928846abee18461279799ad12b279b78	2026-04-15 02:25:14.444231
40	fix-prefix-race-conditions-optimized	7ad69982ae2d372b21f48fc4829ae9752c518f6b	2026-04-15 02:25:14.453441
41	add-object-level-update-trigger	07fcf1a22165849b7a029deed059ffcde08d1ae0	2026-04-15 02:25:14.462763
42	rollback-prefix-triggers	771479077764adc09e2ea2043eb627503c034cd4	2026-04-15 02:25:14.472151
43	fix-object-level	84b35d6caca9d937478ad8a797491f38b8c2979f	2026-04-15 02:25:14.484146
44	vector-bucket-type	99c20c0ffd52bb1ff1f32fb992f3b351e3ef8fb3	2026-04-15 02:25:14.493916
45	vector-buckets	049e27196d77a7cb76497a85afae669d8b230953	2026-04-15 02:25:14.507433
46	buckets-objects-grants	fedeb96d60fefd8e02ab3ded9fbde05632f84aed	2026-04-15 02:25:14.537626
47	iceberg-table-metadata	649df56855c24d8b36dd4cc1aeb8251aa9ad42c2	2026-04-15 02:25:14.548483
48	iceberg-catalog-ids	e0e8b460c609b9999ccd0df9ad14294613eed939	2026-04-15 02:25:14.558106
49	buckets-objects-grants-postgres	072b1195d0d5a2f888af6b2302a1938dd94b8b3d	2026-04-15 02:25:14.597566
50	search-v2-optimised	6323ac4f850aa14e7387eb32102869578b5bd478	2026-04-15 02:25:14.607763
51	index-backward-compatible-search	2ee395d433f76e38bcd3856debaf6e0e5b674011	2026-04-15 02:25:15.140014
52	drop-not-used-indexes-and-functions	5cc44c8696749ac11dd0dc37f2a3802075f3a171	2026-04-15 02:25:15.145627
53	drop-index-lower-name	d0cb18777d9e2a98ebe0bc5cc7a42e57ebe41854	2026-04-15 02:25:15.161977
54	drop-index-object-level	6289e048b1472da17c31a7eba1ded625a6457e67	2026-04-15 02:25:15.167398
55	prevent-direct-deletes	262a4798d5e0f2e7c8970232e03ce8be695d5819	2026-04-15 02:25:15.17063
56	fix-optimized-search-function	cb58526ebc23048049fd5bf2fd148d18b04a2073	2026-04-15 02:25:15.184707
57	s3-multipart-uploads-metadata	f127886e00d1b374fadbc7c6b31e09336aad5287	2026-04-15 02:25:15.195494
58	operation-ergonomics	00ca5d483b3fe0d522133d9002ccc5df98365120	2026-04-15 02:25:15.205166
\.


--
-- Data for Name: objects; Type: TABLE DATA; Schema: storage; Owner: supabase_storage_admin
--

COPY storage.objects (id, bucket_id, name, owner, created_at, updated_at, last_accessed_at, metadata, version, owner_id, user_metadata) FROM stdin;
\.


--
-- Data for Name: s3_multipart_uploads; Type: TABLE DATA; Schema: storage; Owner: supabase_storage_admin
--

COPY storage.s3_multipart_uploads (id, in_progress_size, upload_signature, bucket_id, key, version, owner_id, created_at, user_metadata, metadata) FROM stdin;
\.


--
-- Data for Name: s3_multipart_uploads_parts; Type: TABLE DATA; Schema: storage; Owner: supabase_storage_admin
--

COPY storage.s3_multipart_uploads_parts (id, upload_id, size, part_number, bucket_id, key, etag, owner_id, version, created_at) FROM stdin;
\.


--
-- Data for Name: vector_indexes; Type: TABLE DATA; Schema: storage; Owner: supabase_storage_admin
--

COPY storage.vector_indexes (id, name, bucket_id, data_type, dimension, distance_metric, metadata_configuration, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: secrets; Type: TABLE DATA; Schema: vault; Owner: supabase_admin
--

COPY vault.secrets (id, name, description, secret, key_id, nonce, created_at, updated_at) FROM stdin;
\.


--
-- Name: refresh_tokens_id_seq; Type: SEQUENCE SET; Schema: auth; Owner: supabase_auth_admin
--

SELECT pg_catalog.setval('auth.refresh_tokens_id_seq', 1, false);


--
-- Name: global_banks_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.global_banks_id_seq', 6, true);


--
-- Name: month_balances_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.month_balances_id_seq', 1, false);


--
-- Name: months_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.months_id_seq', 3, true);


--
-- Name: transactions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.transactions_id_seq', 853, true);


--
-- Name: subscription_id_seq; Type: SEQUENCE SET; Schema: realtime; Owner: supabase_admin
--

SELECT pg_catalog.setval('realtime.subscription_id_seq', 1, false);


--
-- Name: mfa_amr_claims amr_id_pk; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.mfa_amr_claims
    ADD CONSTRAINT amr_id_pk PRIMARY KEY (id);


--
-- Name: audit_log_entries audit_log_entries_pkey; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.audit_log_entries
    ADD CONSTRAINT audit_log_entries_pkey PRIMARY KEY (id);


--
-- Name: custom_oauth_providers custom_oauth_providers_identifier_key; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.custom_oauth_providers
    ADD CONSTRAINT custom_oauth_providers_identifier_key UNIQUE (identifier);


--
-- Name: custom_oauth_providers custom_oauth_providers_pkey; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.custom_oauth_providers
    ADD CONSTRAINT custom_oauth_providers_pkey PRIMARY KEY (id);


--
-- Name: flow_state flow_state_pkey; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.flow_state
    ADD CONSTRAINT flow_state_pkey PRIMARY KEY (id);


--
-- Name: identities identities_pkey; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.identities
    ADD CONSTRAINT identities_pkey PRIMARY KEY (id);


--
-- Name: identities identities_provider_id_provider_unique; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.identities
    ADD CONSTRAINT identities_provider_id_provider_unique UNIQUE (provider_id, provider);


--
-- Name: instances instances_pkey; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.instances
    ADD CONSTRAINT instances_pkey PRIMARY KEY (id);


--
-- Name: mfa_amr_claims mfa_amr_claims_session_id_authentication_method_pkey; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.mfa_amr_claims
    ADD CONSTRAINT mfa_amr_claims_session_id_authentication_method_pkey UNIQUE (session_id, authentication_method);


--
-- Name: mfa_challenges mfa_challenges_pkey; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.mfa_challenges
    ADD CONSTRAINT mfa_challenges_pkey PRIMARY KEY (id);


--
-- Name: mfa_factors mfa_factors_last_challenged_at_key; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.mfa_factors
    ADD CONSTRAINT mfa_factors_last_challenged_at_key UNIQUE (last_challenged_at);


--
-- Name: mfa_factors mfa_factors_pkey; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.mfa_factors
    ADD CONSTRAINT mfa_factors_pkey PRIMARY KEY (id);


--
-- Name: oauth_authorizations oauth_authorizations_authorization_code_key; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.oauth_authorizations
    ADD CONSTRAINT oauth_authorizations_authorization_code_key UNIQUE (authorization_code);


--
-- Name: oauth_authorizations oauth_authorizations_authorization_id_key; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.oauth_authorizations
    ADD CONSTRAINT oauth_authorizations_authorization_id_key UNIQUE (authorization_id);


--
-- Name: oauth_authorizations oauth_authorizations_pkey; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.oauth_authorizations
    ADD CONSTRAINT oauth_authorizations_pkey PRIMARY KEY (id);


--
-- Name: oauth_client_states oauth_client_states_pkey; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.oauth_client_states
    ADD CONSTRAINT oauth_client_states_pkey PRIMARY KEY (id);


--
-- Name: oauth_clients oauth_clients_pkey; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.oauth_clients
    ADD CONSTRAINT oauth_clients_pkey PRIMARY KEY (id);


--
-- Name: oauth_consents oauth_consents_pkey; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.oauth_consents
    ADD CONSTRAINT oauth_consents_pkey PRIMARY KEY (id);


--
-- Name: oauth_consents oauth_consents_user_client_unique; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.oauth_consents
    ADD CONSTRAINT oauth_consents_user_client_unique UNIQUE (user_id, client_id);


--
-- Name: one_time_tokens one_time_tokens_pkey; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.one_time_tokens
    ADD CONSTRAINT one_time_tokens_pkey PRIMARY KEY (id);


--
-- Name: refresh_tokens refresh_tokens_pkey; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.refresh_tokens
    ADD CONSTRAINT refresh_tokens_pkey PRIMARY KEY (id);


--
-- Name: refresh_tokens refresh_tokens_token_unique; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.refresh_tokens
    ADD CONSTRAINT refresh_tokens_token_unique UNIQUE (token);


--
-- Name: saml_providers saml_providers_entity_id_key; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.saml_providers
    ADD CONSTRAINT saml_providers_entity_id_key UNIQUE (entity_id);


--
-- Name: saml_providers saml_providers_pkey; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.saml_providers
    ADD CONSTRAINT saml_providers_pkey PRIMARY KEY (id);


--
-- Name: saml_relay_states saml_relay_states_pkey; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.saml_relay_states
    ADD CONSTRAINT saml_relay_states_pkey PRIMARY KEY (id);


--
-- Name: schema_migrations schema_migrations_pkey; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.schema_migrations
    ADD CONSTRAINT schema_migrations_pkey PRIMARY KEY (version);


--
-- Name: sessions sessions_pkey; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.sessions
    ADD CONSTRAINT sessions_pkey PRIMARY KEY (id);


--
-- Name: sso_domains sso_domains_pkey; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.sso_domains
    ADD CONSTRAINT sso_domains_pkey PRIMARY KEY (id);


--
-- Name: sso_providers sso_providers_pkey; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.sso_providers
    ADD CONSTRAINT sso_providers_pkey PRIMARY KEY (id);


--
-- Name: users users_phone_key; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.users
    ADD CONSTRAINT users_phone_key UNIQUE (phone);


--
-- Name: users users_pkey; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- Name: webauthn_challenges webauthn_challenges_pkey; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.webauthn_challenges
    ADD CONSTRAINT webauthn_challenges_pkey PRIMARY KEY (id);


--
-- Name: webauthn_credentials webauthn_credentials_pkey; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.webauthn_credentials
    ADD CONSTRAINT webauthn_credentials_pkey PRIMARY KEY (id);


--
-- Name: global_banks global_banks_category_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.global_banks
    ADD CONSTRAINT global_banks_category_key UNIQUE (category);


--
-- Name: global_banks global_banks_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.global_banks
    ADD CONSTRAINT global_banks_pkey PRIMARY KEY (id);


--
-- Name: month_balances month_balances_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.month_balances
    ADD CONSTRAINT month_balances_pkey PRIMARY KEY (id);


--
-- Name: months months_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.months
    ADD CONSTRAINT months_pkey PRIMARY KEY (id);


--
-- Name: transactions transactions_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.transactions
    ADD CONSTRAINT transactions_pkey PRIMARY KEY (id);


--
-- Name: messages messages_pkey; Type: CONSTRAINT; Schema: realtime; Owner: supabase_realtime_admin
--

ALTER TABLE ONLY realtime.messages
    ADD CONSTRAINT messages_pkey PRIMARY KEY (id, inserted_at);


--
-- Name: subscription pk_subscription; Type: CONSTRAINT; Schema: realtime; Owner: supabase_admin
--

ALTER TABLE ONLY realtime.subscription
    ADD CONSTRAINT pk_subscription PRIMARY KEY (id);


--
-- Name: schema_migrations schema_migrations_pkey; Type: CONSTRAINT; Schema: realtime; Owner: supabase_admin
--

ALTER TABLE ONLY realtime.schema_migrations
    ADD CONSTRAINT schema_migrations_pkey PRIMARY KEY (version);


--
-- Name: buckets_analytics buckets_analytics_pkey; Type: CONSTRAINT; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE ONLY storage.buckets_analytics
    ADD CONSTRAINT buckets_analytics_pkey PRIMARY KEY (id);


--
-- Name: buckets buckets_pkey; Type: CONSTRAINT; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE ONLY storage.buckets
    ADD CONSTRAINT buckets_pkey PRIMARY KEY (id);


--
-- Name: buckets_vectors buckets_vectors_pkey; Type: CONSTRAINT; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE ONLY storage.buckets_vectors
    ADD CONSTRAINT buckets_vectors_pkey PRIMARY KEY (id);


--
-- Name: migrations migrations_name_key; Type: CONSTRAINT; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE ONLY storage.migrations
    ADD CONSTRAINT migrations_name_key UNIQUE (name);


--
-- Name: migrations migrations_pkey; Type: CONSTRAINT; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE ONLY storage.migrations
    ADD CONSTRAINT migrations_pkey PRIMARY KEY (id);


--
-- Name: objects objects_pkey; Type: CONSTRAINT; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE ONLY storage.objects
    ADD CONSTRAINT objects_pkey PRIMARY KEY (id);


--
-- Name: s3_multipart_uploads_parts s3_multipart_uploads_parts_pkey; Type: CONSTRAINT; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE ONLY storage.s3_multipart_uploads_parts
    ADD CONSTRAINT s3_multipart_uploads_parts_pkey PRIMARY KEY (id);


--
-- Name: s3_multipart_uploads s3_multipart_uploads_pkey; Type: CONSTRAINT; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE ONLY storage.s3_multipart_uploads
    ADD CONSTRAINT s3_multipart_uploads_pkey PRIMARY KEY (id);


--
-- Name: vector_indexes vector_indexes_pkey; Type: CONSTRAINT; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE ONLY storage.vector_indexes
    ADD CONSTRAINT vector_indexes_pkey PRIMARY KEY (id);


--
-- Name: audit_logs_instance_id_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX audit_logs_instance_id_idx ON auth.audit_log_entries USING btree (instance_id);


--
-- Name: confirmation_token_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE UNIQUE INDEX confirmation_token_idx ON auth.users USING btree (confirmation_token) WHERE ((confirmation_token)::text !~ '^[0-9 ]*$'::text);


--
-- Name: custom_oauth_providers_created_at_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX custom_oauth_providers_created_at_idx ON auth.custom_oauth_providers USING btree (created_at);


--
-- Name: custom_oauth_providers_enabled_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX custom_oauth_providers_enabled_idx ON auth.custom_oauth_providers USING btree (enabled);


--
-- Name: custom_oauth_providers_identifier_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX custom_oauth_providers_identifier_idx ON auth.custom_oauth_providers USING btree (identifier);


--
-- Name: custom_oauth_providers_provider_type_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX custom_oauth_providers_provider_type_idx ON auth.custom_oauth_providers USING btree (provider_type);


--
-- Name: email_change_token_current_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE UNIQUE INDEX email_change_token_current_idx ON auth.users USING btree (email_change_token_current) WHERE ((email_change_token_current)::text !~ '^[0-9 ]*$'::text);


--
-- Name: email_change_token_new_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE UNIQUE INDEX email_change_token_new_idx ON auth.users USING btree (email_change_token_new) WHERE ((email_change_token_new)::text !~ '^[0-9 ]*$'::text);


--
-- Name: factor_id_created_at_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX factor_id_created_at_idx ON auth.mfa_factors USING btree (user_id, created_at);


--
-- Name: flow_state_created_at_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX flow_state_created_at_idx ON auth.flow_state USING btree (created_at DESC);


--
-- Name: identities_email_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX identities_email_idx ON auth.identities USING btree (email text_pattern_ops);


--
-- Name: INDEX identities_email_idx; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON INDEX auth.identities_email_idx IS 'Auth: Ensures indexed queries on the email column';


--
-- Name: identities_user_id_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX identities_user_id_idx ON auth.identities USING btree (user_id);


--
-- Name: idx_auth_code; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX idx_auth_code ON auth.flow_state USING btree (auth_code);


--
-- Name: idx_oauth_client_states_created_at; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX idx_oauth_client_states_created_at ON auth.oauth_client_states USING btree (created_at);


--
-- Name: idx_user_id_auth_method; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX idx_user_id_auth_method ON auth.flow_state USING btree (user_id, authentication_method);


--
-- Name: idx_users_created_at_desc; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX idx_users_created_at_desc ON auth.users USING btree (created_at DESC);


--
-- Name: idx_users_email; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX idx_users_email ON auth.users USING btree (email);


--
-- Name: idx_users_last_sign_in_at_desc; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX idx_users_last_sign_in_at_desc ON auth.users USING btree (last_sign_in_at DESC);


--
-- Name: idx_users_name; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX idx_users_name ON auth.users USING btree (((raw_user_meta_data ->> 'name'::text))) WHERE ((raw_user_meta_data ->> 'name'::text) IS NOT NULL);


--
-- Name: mfa_challenge_created_at_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX mfa_challenge_created_at_idx ON auth.mfa_challenges USING btree (created_at DESC);


--
-- Name: mfa_factors_user_friendly_name_unique; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE UNIQUE INDEX mfa_factors_user_friendly_name_unique ON auth.mfa_factors USING btree (friendly_name, user_id) WHERE (TRIM(BOTH FROM friendly_name) <> ''::text);


--
-- Name: mfa_factors_user_id_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX mfa_factors_user_id_idx ON auth.mfa_factors USING btree (user_id);


--
-- Name: oauth_auth_pending_exp_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX oauth_auth_pending_exp_idx ON auth.oauth_authorizations USING btree (expires_at) WHERE (status = 'pending'::auth.oauth_authorization_status);


--
-- Name: oauth_clients_deleted_at_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX oauth_clients_deleted_at_idx ON auth.oauth_clients USING btree (deleted_at);


--
-- Name: oauth_consents_active_client_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX oauth_consents_active_client_idx ON auth.oauth_consents USING btree (client_id) WHERE (revoked_at IS NULL);


--
-- Name: oauth_consents_active_user_client_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX oauth_consents_active_user_client_idx ON auth.oauth_consents USING btree (user_id, client_id) WHERE (revoked_at IS NULL);


--
-- Name: oauth_consents_user_order_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX oauth_consents_user_order_idx ON auth.oauth_consents USING btree (user_id, granted_at DESC);


--
-- Name: one_time_tokens_relates_to_hash_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX one_time_tokens_relates_to_hash_idx ON auth.one_time_tokens USING hash (relates_to);


--
-- Name: one_time_tokens_token_hash_hash_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX one_time_tokens_token_hash_hash_idx ON auth.one_time_tokens USING hash (token_hash);


--
-- Name: one_time_tokens_user_id_token_type_key; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE UNIQUE INDEX one_time_tokens_user_id_token_type_key ON auth.one_time_tokens USING btree (user_id, token_type);


--
-- Name: reauthentication_token_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE UNIQUE INDEX reauthentication_token_idx ON auth.users USING btree (reauthentication_token) WHERE ((reauthentication_token)::text !~ '^[0-9 ]*$'::text);


--
-- Name: recovery_token_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE UNIQUE INDEX recovery_token_idx ON auth.users USING btree (recovery_token) WHERE ((recovery_token)::text !~ '^[0-9 ]*$'::text);


--
-- Name: refresh_tokens_instance_id_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX refresh_tokens_instance_id_idx ON auth.refresh_tokens USING btree (instance_id);


--
-- Name: refresh_tokens_instance_id_user_id_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX refresh_tokens_instance_id_user_id_idx ON auth.refresh_tokens USING btree (instance_id, user_id);


--
-- Name: refresh_tokens_parent_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX refresh_tokens_parent_idx ON auth.refresh_tokens USING btree (parent);


--
-- Name: refresh_tokens_session_id_revoked_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX refresh_tokens_session_id_revoked_idx ON auth.refresh_tokens USING btree (session_id, revoked);


--
-- Name: refresh_tokens_updated_at_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX refresh_tokens_updated_at_idx ON auth.refresh_tokens USING btree (updated_at DESC);


--
-- Name: saml_providers_sso_provider_id_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX saml_providers_sso_provider_id_idx ON auth.saml_providers USING btree (sso_provider_id);


--
-- Name: saml_relay_states_created_at_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX saml_relay_states_created_at_idx ON auth.saml_relay_states USING btree (created_at DESC);


--
-- Name: saml_relay_states_for_email_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX saml_relay_states_for_email_idx ON auth.saml_relay_states USING btree (for_email);


--
-- Name: saml_relay_states_sso_provider_id_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX saml_relay_states_sso_provider_id_idx ON auth.saml_relay_states USING btree (sso_provider_id);


--
-- Name: sessions_not_after_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX sessions_not_after_idx ON auth.sessions USING btree (not_after DESC);


--
-- Name: sessions_oauth_client_id_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX sessions_oauth_client_id_idx ON auth.sessions USING btree (oauth_client_id);


--
-- Name: sessions_user_id_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX sessions_user_id_idx ON auth.sessions USING btree (user_id);


--
-- Name: sso_domains_domain_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE UNIQUE INDEX sso_domains_domain_idx ON auth.sso_domains USING btree (lower(domain));


--
-- Name: sso_domains_sso_provider_id_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX sso_domains_sso_provider_id_idx ON auth.sso_domains USING btree (sso_provider_id);


--
-- Name: sso_providers_resource_id_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE UNIQUE INDEX sso_providers_resource_id_idx ON auth.sso_providers USING btree (lower(resource_id));


--
-- Name: sso_providers_resource_id_pattern_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX sso_providers_resource_id_pattern_idx ON auth.sso_providers USING btree (resource_id text_pattern_ops);


--
-- Name: unique_phone_factor_per_user; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE UNIQUE INDEX unique_phone_factor_per_user ON auth.mfa_factors USING btree (user_id, phone);


--
-- Name: user_id_created_at_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX user_id_created_at_idx ON auth.sessions USING btree (user_id, created_at);


--
-- Name: users_email_partial_key; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE UNIQUE INDEX users_email_partial_key ON auth.users USING btree (email) WHERE (is_sso_user = false);


--
-- Name: INDEX users_email_partial_key; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON INDEX auth.users_email_partial_key IS 'Auth: A partial unique index that applies only when is_sso_user is false';


--
-- Name: users_instance_id_email_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX users_instance_id_email_idx ON auth.users USING btree (instance_id, lower((email)::text));


--
-- Name: users_instance_id_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX users_instance_id_idx ON auth.users USING btree (instance_id);


--
-- Name: users_is_anonymous_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX users_is_anonymous_idx ON auth.users USING btree (is_anonymous);


--
-- Name: webauthn_challenges_expires_at_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX webauthn_challenges_expires_at_idx ON auth.webauthn_challenges USING btree (expires_at);


--
-- Name: webauthn_challenges_user_id_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX webauthn_challenges_user_id_idx ON auth.webauthn_challenges USING btree (user_id);


--
-- Name: webauthn_credentials_credential_id_key; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE UNIQUE INDEX webauthn_credentials_credential_id_key ON auth.webauthn_credentials USING btree (credential_id);


--
-- Name: webauthn_credentials_user_id_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX webauthn_credentials_user_id_idx ON auth.webauthn_credentials USING btree (user_id);


--
-- Name: month_balances_month_id_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX month_balances_month_id_idx ON public.month_balances USING btree (month_id);


--
-- Name: months_year_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX months_year_idx ON public.months USING btree (year);


--
-- Name: transactions_date_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX transactions_date_idx ON public.transactions USING btree (date);


--
-- Name: transactions_month_id_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX transactions_month_id_idx ON public.transactions USING btree (month_id);


--
-- Name: transactions_type_category_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX transactions_type_category_idx ON public.transactions USING btree (type, category);


--
-- Name: ix_realtime_subscription_entity; Type: INDEX; Schema: realtime; Owner: supabase_admin
--

CREATE INDEX ix_realtime_subscription_entity ON realtime.subscription USING btree (entity);


--
-- Name: messages_inserted_at_topic_index; Type: INDEX; Schema: realtime; Owner: supabase_realtime_admin
--

CREATE INDEX messages_inserted_at_topic_index ON ONLY realtime.messages USING btree (inserted_at DESC, topic) WHERE ((extension = 'broadcast'::text) AND (private IS TRUE));


--
-- Name: subscription_subscription_id_entity_filters_action_filter_key; Type: INDEX; Schema: realtime; Owner: supabase_admin
--

CREATE UNIQUE INDEX subscription_subscription_id_entity_filters_action_filter_key ON realtime.subscription USING btree (subscription_id, entity, filters, action_filter);


--
-- Name: bname; Type: INDEX; Schema: storage; Owner: supabase_storage_admin
--

CREATE UNIQUE INDEX bname ON storage.buckets USING btree (name);


--
-- Name: bucketid_objname; Type: INDEX; Schema: storage; Owner: supabase_storage_admin
--

CREATE UNIQUE INDEX bucketid_objname ON storage.objects USING btree (bucket_id, name);


--
-- Name: buckets_analytics_unique_name_idx; Type: INDEX; Schema: storage; Owner: supabase_storage_admin
--

CREATE UNIQUE INDEX buckets_analytics_unique_name_idx ON storage.buckets_analytics USING btree (name) WHERE (deleted_at IS NULL);


--
-- Name: idx_multipart_uploads_list; Type: INDEX; Schema: storage; Owner: supabase_storage_admin
--

CREATE INDEX idx_multipart_uploads_list ON storage.s3_multipart_uploads USING btree (bucket_id, key, created_at);


--
-- Name: idx_objects_bucket_id_name; Type: INDEX; Schema: storage; Owner: supabase_storage_admin
--

CREATE INDEX idx_objects_bucket_id_name ON storage.objects USING btree (bucket_id, name COLLATE "C");


--
-- Name: idx_objects_bucket_id_name_lower; Type: INDEX; Schema: storage; Owner: supabase_storage_admin
--

CREATE INDEX idx_objects_bucket_id_name_lower ON storage.objects USING btree (bucket_id, lower(name) COLLATE "C");


--
-- Name: name_prefix_search; Type: INDEX; Schema: storage; Owner: supabase_storage_admin
--

CREATE INDEX name_prefix_search ON storage.objects USING btree (name text_pattern_ops);


--
-- Name: vector_indexes_name_bucket_id_idx; Type: INDEX; Schema: storage; Owner: supabase_storage_admin
--

CREATE UNIQUE INDEX vector_indexes_name_bucket_id_idx ON storage.vector_indexes USING btree (name, bucket_id);


--
-- Name: subscription tr_check_filters; Type: TRIGGER; Schema: realtime; Owner: supabase_admin
--

CREATE TRIGGER tr_check_filters BEFORE INSERT OR UPDATE ON realtime.subscription FOR EACH ROW EXECUTE FUNCTION realtime.subscription_check_filters();


--
-- Name: buckets enforce_bucket_name_length_trigger; Type: TRIGGER; Schema: storage; Owner: supabase_storage_admin
--

CREATE TRIGGER enforce_bucket_name_length_trigger BEFORE INSERT OR UPDATE OF name ON storage.buckets FOR EACH ROW EXECUTE FUNCTION storage.enforce_bucket_name_length();


--
-- Name: buckets protect_buckets_delete; Type: TRIGGER; Schema: storage; Owner: supabase_storage_admin
--

CREATE TRIGGER protect_buckets_delete BEFORE DELETE ON storage.buckets FOR EACH STATEMENT EXECUTE FUNCTION storage.protect_delete();


--
-- Name: objects protect_objects_delete; Type: TRIGGER; Schema: storage; Owner: supabase_storage_admin
--

CREATE TRIGGER protect_objects_delete BEFORE DELETE ON storage.objects FOR EACH STATEMENT EXECUTE FUNCTION storage.protect_delete();


--
-- Name: objects update_objects_updated_at; Type: TRIGGER; Schema: storage; Owner: supabase_storage_admin
--

CREATE TRIGGER update_objects_updated_at BEFORE UPDATE ON storage.objects FOR EACH ROW EXECUTE FUNCTION storage.update_updated_at_column();


--
-- Name: identities identities_user_id_fkey; Type: FK CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.identities
    ADD CONSTRAINT identities_user_id_fkey FOREIGN KEY (user_id) REFERENCES auth.users(id) ON DELETE CASCADE;


--
-- Name: mfa_amr_claims mfa_amr_claims_session_id_fkey; Type: FK CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.mfa_amr_claims
    ADD CONSTRAINT mfa_amr_claims_session_id_fkey FOREIGN KEY (session_id) REFERENCES auth.sessions(id) ON DELETE CASCADE;


--
-- Name: mfa_challenges mfa_challenges_auth_factor_id_fkey; Type: FK CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.mfa_challenges
    ADD CONSTRAINT mfa_challenges_auth_factor_id_fkey FOREIGN KEY (factor_id) REFERENCES auth.mfa_factors(id) ON DELETE CASCADE;


--
-- Name: mfa_factors mfa_factors_user_id_fkey; Type: FK CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.mfa_factors
    ADD CONSTRAINT mfa_factors_user_id_fkey FOREIGN KEY (user_id) REFERENCES auth.users(id) ON DELETE CASCADE;


--
-- Name: oauth_authorizations oauth_authorizations_client_id_fkey; Type: FK CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.oauth_authorizations
    ADD CONSTRAINT oauth_authorizations_client_id_fkey FOREIGN KEY (client_id) REFERENCES auth.oauth_clients(id) ON DELETE CASCADE;


--
-- Name: oauth_authorizations oauth_authorizations_user_id_fkey; Type: FK CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.oauth_authorizations
    ADD CONSTRAINT oauth_authorizations_user_id_fkey FOREIGN KEY (user_id) REFERENCES auth.users(id) ON DELETE CASCADE;


--
-- Name: oauth_consents oauth_consents_client_id_fkey; Type: FK CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.oauth_consents
    ADD CONSTRAINT oauth_consents_client_id_fkey FOREIGN KEY (client_id) REFERENCES auth.oauth_clients(id) ON DELETE CASCADE;


--
-- Name: oauth_consents oauth_consents_user_id_fkey; Type: FK CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.oauth_consents
    ADD CONSTRAINT oauth_consents_user_id_fkey FOREIGN KEY (user_id) REFERENCES auth.users(id) ON DELETE CASCADE;


--
-- Name: one_time_tokens one_time_tokens_user_id_fkey; Type: FK CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.one_time_tokens
    ADD CONSTRAINT one_time_tokens_user_id_fkey FOREIGN KEY (user_id) REFERENCES auth.users(id) ON DELETE CASCADE;


--
-- Name: refresh_tokens refresh_tokens_session_id_fkey; Type: FK CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.refresh_tokens
    ADD CONSTRAINT refresh_tokens_session_id_fkey FOREIGN KEY (session_id) REFERENCES auth.sessions(id) ON DELETE CASCADE;


--
-- Name: saml_providers saml_providers_sso_provider_id_fkey; Type: FK CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.saml_providers
    ADD CONSTRAINT saml_providers_sso_provider_id_fkey FOREIGN KEY (sso_provider_id) REFERENCES auth.sso_providers(id) ON DELETE CASCADE;


--
-- Name: saml_relay_states saml_relay_states_flow_state_id_fkey; Type: FK CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.saml_relay_states
    ADD CONSTRAINT saml_relay_states_flow_state_id_fkey FOREIGN KEY (flow_state_id) REFERENCES auth.flow_state(id) ON DELETE CASCADE;


--
-- Name: saml_relay_states saml_relay_states_sso_provider_id_fkey; Type: FK CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.saml_relay_states
    ADD CONSTRAINT saml_relay_states_sso_provider_id_fkey FOREIGN KEY (sso_provider_id) REFERENCES auth.sso_providers(id) ON DELETE CASCADE;


--
-- Name: sessions sessions_oauth_client_id_fkey; Type: FK CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.sessions
    ADD CONSTRAINT sessions_oauth_client_id_fkey FOREIGN KEY (oauth_client_id) REFERENCES auth.oauth_clients(id) ON DELETE CASCADE;


--
-- Name: sessions sessions_user_id_fkey; Type: FK CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.sessions
    ADD CONSTRAINT sessions_user_id_fkey FOREIGN KEY (user_id) REFERENCES auth.users(id) ON DELETE CASCADE;


--
-- Name: sso_domains sso_domains_sso_provider_id_fkey; Type: FK CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.sso_domains
    ADD CONSTRAINT sso_domains_sso_provider_id_fkey FOREIGN KEY (sso_provider_id) REFERENCES auth.sso_providers(id) ON DELETE CASCADE;


--
-- Name: webauthn_challenges webauthn_challenges_user_id_fkey; Type: FK CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.webauthn_challenges
    ADD CONSTRAINT webauthn_challenges_user_id_fkey FOREIGN KEY (user_id) REFERENCES auth.users(id) ON DELETE CASCADE;


--
-- Name: webauthn_credentials webauthn_credentials_user_id_fkey; Type: FK CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.webauthn_credentials
    ADD CONSTRAINT webauthn_credentials_user_id_fkey FOREIGN KEY (user_id) REFERENCES auth.users(id) ON DELETE CASCADE;


--
-- Name: month_balances month_balances_month_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.month_balances
    ADD CONSTRAINT month_balances_month_id_fkey FOREIGN KEY (month_id) REFERENCES public.months(id) ON DELETE CASCADE;


--
-- Name: transactions transactions_month_id_months_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.transactions
    ADD CONSTRAINT transactions_month_id_months_id_fk FOREIGN KEY (month_id) REFERENCES public.months(id) ON DELETE CASCADE;


--
-- Name: objects objects_bucketId_fkey; Type: FK CONSTRAINT; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE ONLY storage.objects
    ADD CONSTRAINT "objects_bucketId_fkey" FOREIGN KEY (bucket_id) REFERENCES storage.buckets(id);


--
-- Name: s3_multipart_uploads s3_multipart_uploads_bucket_id_fkey; Type: FK CONSTRAINT; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE ONLY storage.s3_multipart_uploads
    ADD CONSTRAINT s3_multipart_uploads_bucket_id_fkey FOREIGN KEY (bucket_id) REFERENCES storage.buckets(id);


--
-- Name: s3_multipart_uploads_parts s3_multipart_uploads_parts_bucket_id_fkey; Type: FK CONSTRAINT; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE ONLY storage.s3_multipart_uploads_parts
    ADD CONSTRAINT s3_multipart_uploads_parts_bucket_id_fkey FOREIGN KEY (bucket_id) REFERENCES storage.buckets(id);


--
-- Name: s3_multipart_uploads_parts s3_multipart_uploads_parts_upload_id_fkey; Type: FK CONSTRAINT; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE ONLY storage.s3_multipart_uploads_parts
    ADD CONSTRAINT s3_multipart_uploads_parts_upload_id_fkey FOREIGN KEY (upload_id) REFERENCES storage.s3_multipart_uploads(id) ON DELETE CASCADE;


--
-- Name: vector_indexes vector_indexes_bucket_id_fkey; Type: FK CONSTRAINT; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE ONLY storage.vector_indexes
    ADD CONSTRAINT vector_indexes_bucket_id_fkey FOREIGN KEY (bucket_id) REFERENCES storage.buckets_vectors(id);


--
-- Name: audit_log_entries; Type: ROW SECURITY; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE auth.audit_log_entries ENABLE ROW LEVEL SECURITY;

--
-- Name: flow_state; Type: ROW SECURITY; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE auth.flow_state ENABLE ROW LEVEL SECURITY;

--
-- Name: identities; Type: ROW SECURITY; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE auth.identities ENABLE ROW LEVEL SECURITY;

--
-- Name: instances; Type: ROW SECURITY; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE auth.instances ENABLE ROW LEVEL SECURITY;

--
-- Name: mfa_amr_claims; Type: ROW SECURITY; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE auth.mfa_amr_claims ENABLE ROW LEVEL SECURITY;

--
-- Name: mfa_challenges; Type: ROW SECURITY; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE auth.mfa_challenges ENABLE ROW LEVEL SECURITY;

--
-- Name: mfa_factors; Type: ROW SECURITY; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE auth.mfa_factors ENABLE ROW LEVEL SECURITY;

--
-- Name: one_time_tokens; Type: ROW SECURITY; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE auth.one_time_tokens ENABLE ROW LEVEL SECURITY;

--
-- Name: refresh_tokens; Type: ROW SECURITY; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE auth.refresh_tokens ENABLE ROW LEVEL SECURITY;

--
-- Name: saml_providers; Type: ROW SECURITY; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE auth.saml_providers ENABLE ROW LEVEL SECURITY;

--
-- Name: saml_relay_states; Type: ROW SECURITY; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE auth.saml_relay_states ENABLE ROW LEVEL SECURITY;

--
-- Name: schema_migrations; Type: ROW SECURITY; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE auth.schema_migrations ENABLE ROW LEVEL SECURITY;

--
-- Name: sessions; Type: ROW SECURITY; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE auth.sessions ENABLE ROW LEVEL SECURITY;

--
-- Name: sso_domains; Type: ROW SECURITY; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE auth.sso_domains ENABLE ROW LEVEL SECURITY;

--
-- Name: sso_providers; Type: ROW SECURITY; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE auth.sso_providers ENABLE ROW LEVEL SECURITY;

--
-- Name: users; Type: ROW SECURITY; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE auth.users ENABLE ROW LEVEL SECURITY;

--
-- Name: global_banks; Type: ROW SECURITY; Schema: public; Owner: postgres
--

ALTER TABLE public.global_banks ENABLE ROW LEVEL SECURITY;

--
-- Name: month_balances; Type: ROW SECURITY; Schema: public; Owner: postgres
--

ALTER TABLE public.month_balances ENABLE ROW LEVEL SECURITY;

--
-- Name: months; Type: ROW SECURITY; Schema: public; Owner: postgres
--

ALTER TABLE public.months ENABLE ROW LEVEL SECURITY;

--
-- Name: transactions; Type: ROW SECURITY; Schema: public; Owner: postgres
--

ALTER TABLE public.transactions ENABLE ROW LEVEL SECURITY;

--
-- Name: messages; Type: ROW SECURITY; Schema: realtime; Owner: supabase_realtime_admin
--

ALTER TABLE realtime.messages ENABLE ROW LEVEL SECURITY;

--
-- Name: buckets; Type: ROW SECURITY; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE storage.buckets ENABLE ROW LEVEL SECURITY;

--
-- Name: buckets_analytics; Type: ROW SECURITY; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE storage.buckets_analytics ENABLE ROW LEVEL SECURITY;

--
-- Name: buckets_vectors; Type: ROW SECURITY; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE storage.buckets_vectors ENABLE ROW LEVEL SECURITY;

--
-- Name: migrations; Type: ROW SECURITY; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE storage.migrations ENABLE ROW LEVEL SECURITY;

--
-- Name: objects; Type: ROW SECURITY; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE storage.objects ENABLE ROW LEVEL SECURITY;

--
-- Name: s3_multipart_uploads; Type: ROW SECURITY; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE storage.s3_multipart_uploads ENABLE ROW LEVEL SECURITY;

--
-- Name: s3_multipart_uploads_parts; Type: ROW SECURITY; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE storage.s3_multipart_uploads_parts ENABLE ROW LEVEL SECURITY;

--
-- Name: vector_indexes; Type: ROW SECURITY; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE storage.vector_indexes ENABLE ROW LEVEL SECURITY;

--
-- Name: supabase_realtime; Type: PUBLICATION; Schema: -; Owner: postgres
--

CREATE PUBLICATION supabase_realtime WITH (publish = 'insert, update, delete, truncate');


ALTER PUBLICATION supabase_realtime OWNER TO postgres;

--
-- Name: SCHEMA auth; Type: ACL; Schema: -; Owner: supabase_admin
--

GRANT USAGE ON SCHEMA auth TO anon;
GRANT USAGE ON SCHEMA auth TO authenticated;
GRANT USAGE ON SCHEMA auth TO service_role;
GRANT ALL ON SCHEMA auth TO supabase_auth_admin;
GRANT ALL ON SCHEMA auth TO dashboard_user;
GRANT USAGE ON SCHEMA auth TO postgres;


--
-- Name: SCHEMA extensions; Type: ACL; Schema: -; Owner: postgres
--

GRANT USAGE ON SCHEMA extensions TO anon;
GRANT USAGE ON SCHEMA extensions TO authenticated;
GRANT USAGE ON SCHEMA extensions TO service_role;
GRANT ALL ON SCHEMA extensions TO dashboard_user;


--
-- Name: SCHEMA public; Type: ACL; Schema: -; Owner: pg_database_owner
--

GRANT USAGE ON SCHEMA public TO postgres;
GRANT USAGE ON SCHEMA public TO anon;
GRANT USAGE ON SCHEMA public TO authenticated;
GRANT USAGE ON SCHEMA public TO service_role;


--
-- Name: SCHEMA realtime; Type: ACL; Schema: -; Owner: supabase_admin
--

GRANT USAGE ON SCHEMA realtime TO postgres;
GRANT USAGE ON SCHEMA realtime TO anon;
GRANT USAGE ON SCHEMA realtime TO authenticated;
GRANT USAGE ON SCHEMA realtime TO service_role;
GRANT ALL ON SCHEMA realtime TO supabase_realtime_admin;


--
-- Name: SCHEMA storage; Type: ACL; Schema: -; Owner: supabase_admin
--

GRANT USAGE ON SCHEMA storage TO postgres WITH GRANT OPTION;
GRANT USAGE ON SCHEMA storage TO anon;
GRANT USAGE ON SCHEMA storage TO authenticated;
GRANT USAGE ON SCHEMA storage TO service_role;
GRANT ALL ON SCHEMA storage TO supabase_storage_admin WITH GRANT OPTION;
GRANT ALL ON SCHEMA storage TO dashboard_user;


--
-- Name: SCHEMA vault; Type: ACL; Schema: -; Owner: supabase_admin
--

GRANT USAGE ON SCHEMA vault TO postgres WITH GRANT OPTION;
GRANT USAGE ON SCHEMA vault TO service_role;


--
-- Name: FUNCTION email(); Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT ALL ON FUNCTION auth.email() TO dashboard_user;


--
-- Name: FUNCTION jwt(); Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT ALL ON FUNCTION auth.jwt() TO postgres;
GRANT ALL ON FUNCTION auth.jwt() TO dashboard_user;


--
-- Name: FUNCTION role(); Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT ALL ON FUNCTION auth.role() TO dashboard_user;


--
-- Name: FUNCTION uid(); Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT ALL ON FUNCTION auth.uid() TO dashboard_user;


--
-- Name: FUNCTION armor(bytea); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.armor(bytea) FROM postgres;
GRANT ALL ON FUNCTION extensions.armor(bytea) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.armor(bytea) TO dashboard_user;


--
-- Name: FUNCTION armor(bytea, text[], text[]); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.armor(bytea, text[], text[]) FROM postgres;
GRANT ALL ON FUNCTION extensions.armor(bytea, text[], text[]) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.armor(bytea, text[], text[]) TO dashboard_user;


--
-- Name: FUNCTION crypt(text, text); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.crypt(text, text) FROM postgres;
GRANT ALL ON FUNCTION extensions.crypt(text, text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.crypt(text, text) TO dashboard_user;


--
-- Name: FUNCTION dearmor(text); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.dearmor(text) FROM postgres;
GRANT ALL ON FUNCTION extensions.dearmor(text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.dearmor(text) TO dashboard_user;


--
-- Name: FUNCTION decrypt(bytea, bytea, text); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.decrypt(bytea, bytea, text) FROM postgres;
GRANT ALL ON FUNCTION extensions.decrypt(bytea, bytea, text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.decrypt(bytea, bytea, text) TO dashboard_user;


--
-- Name: FUNCTION decrypt_iv(bytea, bytea, bytea, text); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.decrypt_iv(bytea, bytea, bytea, text) FROM postgres;
GRANT ALL ON FUNCTION extensions.decrypt_iv(bytea, bytea, bytea, text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.decrypt_iv(bytea, bytea, bytea, text) TO dashboard_user;


--
-- Name: FUNCTION digest(bytea, text); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.digest(bytea, text) FROM postgres;
GRANT ALL ON FUNCTION extensions.digest(bytea, text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.digest(bytea, text) TO dashboard_user;


--
-- Name: FUNCTION digest(text, text); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.digest(text, text) FROM postgres;
GRANT ALL ON FUNCTION extensions.digest(text, text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.digest(text, text) TO dashboard_user;


--
-- Name: FUNCTION encrypt(bytea, bytea, text); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.encrypt(bytea, bytea, text) FROM postgres;
GRANT ALL ON FUNCTION extensions.encrypt(bytea, bytea, text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.encrypt(bytea, bytea, text) TO dashboard_user;


--
-- Name: FUNCTION encrypt_iv(bytea, bytea, bytea, text); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.encrypt_iv(bytea, bytea, bytea, text) FROM postgres;
GRANT ALL ON FUNCTION extensions.encrypt_iv(bytea, bytea, bytea, text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.encrypt_iv(bytea, bytea, bytea, text) TO dashboard_user;


--
-- Name: FUNCTION gen_random_bytes(integer); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.gen_random_bytes(integer) FROM postgres;
GRANT ALL ON FUNCTION extensions.gen_random_bytes(integer) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.gen_random_bytes(integer) TO dashboard_user;


--
-- Name: FUNCTION gen_random_uuid(); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.gen_random_uuid() FROM postgres;
GRANT ALL ON FUNCTION extensions.gen_random_uuid() TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.gen_random_uuid() TO dashboard_user;


--
-- Name: FUNCTION gen_salt(text); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.gen_salt(text) FROM postgres;
GRANT ALL ON FUNCTION extensions.gen_salt(text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.gen_salt(text) TO dashboard_user;


--
-- Name: FUNCTION gen_salt(text, integer); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.gen_salt(text, integer) FROM postgres;
GRANT ALL ON FUNCTION extensions.gen_salt(text, integer) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.gen_salt(text, integer) TO dashboard_user;


--
-- Name: FUNCTION grant_pg_cron_access(); Type: ACL; Schema: extensions; Owner: supabase_admin
--

REVOKE ALL ON FUNCTION extensions.grant_pg_cron_access() FROM supabase_admin;
GRANT ALL ON FUNCTION extensions.grant_pg_cron_access() TO supabase_admin WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.grant_pg_cron_access() TO dashboard_user;


--
-- Name: FUNCTION grant_pg_graphql_access(); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.grant_pg_graphql_access() TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION grant_pg_net_access(); Type: ACL; Schema: extensions; Owner: supabase_admin
--

REVOKE ALL ON FUNCTION extensions.grant_pg_net_access() FROM supabase_admin;
GRANT ALL ON FUNCTION extensions.grant_pg_net_access() TO supabase_admin WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.grant_pg_net_access() TO dashboard_user;


--
-- Name: FUNCTION hmac(bytea, bytea, text); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.hmac(bytea, bytea, text) FROM postgres;
GRANT ALL ON FUNCTION extensions.hmac(bytea, bytea, text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.hmac(bytea, bytea, text) TO dashboard_user;


--
-- Name: FUNCTION hmac(text, text, text); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.hmac(text, text, text) FROM postgres;
GRANT ALL ON FUNCTION extensions.hmac(text, text, text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.hmac(text, text, text) TO dashboard_user;


--
-- Name: FUNCTION pg_stat_statements(showtext boolean, OUT userid oid, OUT dbid oid, OUT toplevel boolean, OUT queryid bigint, OUT query text, OUT plans bigint, OUT total_plan_time double precision, OUT min_plan_time double precision, OUT max_plan_time double precision, OUT mean_plan_time double precision, OUT stddev_plan_time double precision, OUT calls bigint, OUT total_exec_time double precision, OUT min_exec_time double precision, OUT max_exec_time double precision, OUT mean_exec_time double precision, OUT stddev_exec_time double precision, OUT rows bigint, OUT shared_blks_hit bigint, OUT shared_blks_read bigint, OUT shared_blks_dirtied bigint, OUT shared_blks_written bigint, OUT local_blks_hit bigint, OUT local_blks_read bigint, OUT local_blks_dirtied bigint, OUT local_blks_written bigint, OUT temp_blks_read bigint, OUT temp_blks_written bigint, OUT shared_blk_read_time double precision, OUT shared_blk_write_time double precision, OUT local_blk_read_time double precision, OUT local_blk_write_time double precision, OUT temp_blk_read_time double precision, OUT temp_blk_write_time double precision, OUT wal_records bigint, OUT wal_fpi bigint, OUT wal_bytes numeric, OUT jit_functions bigint, OUT jit_generation_time double precision, OUT jit_inlining_count bigint, OUT jit_inlining_time double precision, OUT jit_optimization_count bigint, OUT jit_optimization_time double precision, OUT jit_emission_count bigint, OUT jit_emission_time double precision, OUT jit_deform_count bigint, OUT jit_deform_time double precision, OUT stats_since timestamp with time zone, OUT minmax_stats_since timestamp with time zone); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.pg_stat_statements(showtext boolean, OUT userid oid, OUT dbid oid, OUT toplevel boolean, OUT queryid bigint, OUT query text, OUT plans bigint, OUT total_plan_time double precision, OUT min_plan_time double precision, OUT max_plan_time double precision, OUT mean_plan_time double precision, OUT stddev_plan_time double precision, OUT calls bigint, OUT total_exec_time double precision, OUT min_exec_time double precision, OUT max_exec_time double precision, OUT mean_exec_time double precision, OUT stddev_exec_time double precision, OUT rows bigint, OUT shared_blks_hit bigint, OUT shared_blks_read bigint, OUT shared_blks_dirtied bigint, OUT shared_blks_written bigint, OUT local_blks_hit bigint, OUT local_blks_read bigint, OUT local_blks_dirtied bigint, OUT local_blks_written bigint, OUT temp_blks_read bigint, OUT temp_blks_written bigint, OUT shared_blk_read_time double precision, OUT shared_blk_write_time double precision, OUT local_blk_read_time double precision, OUT local_blk_write_time double precision, OUT temp_blk_read_time double precision, OUT temp_blk_write_time double precision, OUT wal_records bigint, OUT wal_fpi bigint, OUT wal_bytes numeric, OUT jit_functions bigint, OUT jit_generation_time double precision, OUT jit_inlining_count bigint, OUT jit_inlining_time double precision, OUT jit_optimization_count bigint, OUT jit_optimization_time double precision, OUT jit_emission_count bigint, OUT jit_emission_time double precision, OUT jit_deform_count bigint, OUT jit_deform_time double precision, OUT stats_since timestamp with time zone, OUT minmax_stats_since timestamp with time zone) FROM postgres;
GRANT ALL ON FUNCTION extensions.pg_stat_statements(showtext boolean, OUT userid oid, OUT dbid oid, OUT toplevel boolean, OUT queryid bigint, OUT query text, OUT plans bigint, OUT total_plan_time double precision, OUT min_plan_time double precision, OUT max_plan_time double precision, OUT mean_plan_time double precision, OUT stddev_plan_time double precision, OUT calls bigint, OUT total_exec_time double precision, OUT min_exec_time double precision, OUT max_exec_time double precision, OUT mean_exec_time double precision, OUT stddev_exec_time double precision, OUT rows bigint, OUT shared_blks_hit bigint, OUT shared_blks_read bigint, OUT shared_blks_dirtied bigint, OUT shared_blks_written bigint, OUT local_blks_hit bigint, OUT local_blks_read bigint, OUT local_blks_dirtied bigint, OUT local_blks_written bigint, OUT temp_blks_read bigint, OUT temp_blks_written bigint, OUT shared_blk_read_time double precision, OUT shared_blk_write_time double precision, OUT local_blk_read_time double precision, OUT local_blk_write_time double precision, OUT temp_blk_read_time double precision, OUT temp_blk_write_time double precision, OUT wal_records bigint, OUT wal_fpi bigint, OUT wal_bytes numeric, OUT jit_functions bigint, OUT jit_generation_time double precision, OUT jit_inlining_count bigint, OUT jit_inlining_time double precision, OUT jit_optimization_count bigint, OUT jit_optimization_time double precision, OUT jit_emission_count bigint, OUT jit_emission_time double precision, OUT jit_deform_count bigint, OUT jit_deform_time double precision, OUT stats_since timestamp with time zone, OUT minmax_stats_since timestamp with time zone) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.pg_stat_statements(showtext boolean, OUT userid oid, OUT dbid oid, OUT toplevel boolean, OUT queryid bigint, OUT query text, OUT plans bigint, OUT total_plan_time double precision, OUT min_plan_time double precision, OUT max_plan_time double precision, OUT mean_plan_time double precision, OUT stddev_plan_time double precision, OUT calls bigint, OUT total_exec_time double precision, OUT min_exec_time double precision, OUT max_exec_time double precision, OUT mean_exec_time double precision, OUT stddev_exec_time double precision, OUT rows bigint, OUT shared_blks_hit bigint, OUT shared_blks_read bigint, OUT shared_blks_dirtied bigint, OUT shared_blks_written bigint, OUT local_blks_hit bigint, OUT local_blks_read bigint, OUT local_blks_dirtied bigint, OUT local_blks_written bigint, OUT temp_blks_read bigint, OUT temp_blks_written bigint, OUT shared_blk_read_time double precision, OUT shared_blk_write_time double precision, OUT local_blk_read_time double precision, OUT local_blk_write_time double precision, OUT temp_blk_read_time double precision, OUT temp_blk_write_time double precision, OUT wal_records bigint, OUT wal_fpi bigint, OUT wal_bytes numeric, OUT jit_functions bigint, OUT jit_generation_time double precision, OUT jit_inlining_count bigint, OUT jit_inlining_time double precision, OUT jit_optimization_count bigint, OUT jit_optimization_time double precision, OUT jit_emission_count bigint, OUT jit_emission_time double precision, OUT jit_deform_count bigint, OUT jit_deform_time double precision, OUT stats_since timestamp with time zone, OUT minmax_stats_since timestamp with time zone) TO dashboard_user;


--
-- Name: FUNCTION pg_stat_statements_info(OUT dealloc bigint, OUT stats_reset timestamp with time zone); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.pg_stat_statements_info(OUT dealloc bigint, OUT stats_reset timestamp with time zone) FROM postgres;
GRANT ALL ON FUNCTION extensions.pg_stat_statements_info(OUT dealloc bigint, OUT stats_reset timestamp with time zone) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.pg_stat_statements_info(OUT dealloc bigint, OUT stats_reset timestamp with time zone) TO dashboard_user;


--
-- Name: FUNCTION pg_stat_statements_reset(userid oid, dbid oid, queryid bigint, minmax_only boolean); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.pg_stat_statements_reset(userid oid, dbid oid, queryid bigint, minmax_only boolean) FROM postgres;
GRANT ALL ON FUNCTION extensions.pg_stat_statements_reset(userid oid, dbid oid, queryid bigint, minmax_only boolean) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.pg_stat_statements_reset(userid oid, dbid oid, queryid bigint, minmax_only boolean) TO dashboard_user;


--
-- Name: FUNCTION pgp_armor_headers(text, OUT key text, OUT value text); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.pgp_armor_headers(text, OUT key text, OUT value text) FROM postgres;
GRANT ALL ON FUNCTION extensions.pgp_armor_headers(text, OUT key text, OUT value text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.pgp_armor_headers(text, OUT key text, OUT value text) TO dashboard_user;


--
-- Name: FUNCTION pgp_key_id(bytea); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.pgp_key_id(bytea) FROM postgres;
GRANT ALL ON FUNCTION extensions.pgp_key_id(bytea) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.pgp_key_id(bytea) TO dashboard_user;


--
-- Name: FUNCTION pgp_pub_decrypt(bytea, bytea); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.pgp_pub_decrypt(bytea, bytea) FROM postgres;
GRANT ALL ON FUNCTION extensions.pgp_pub_decrypt(bytea, bytea) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.pgp_pub_decrypt(bytea, bytea) TO dashboard_user;


--
-- Name: FUNCTION pgp_pub_decrypt(bytea, bytea, text); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.pgp_pub_decrypt(bytea, bytea, text) FROM postgres;
GRANT ALL ON FUNCTION extensions.pgp_pub_decrypt(bytea, bytea, text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.pgp_pub_decrypt(bytea, bytea, text) TO dashboard_user;


--
-- Name: FUNCTION pgp_pub_decrypt(bytea, bytea, text, text); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.pgp_pub_decrypt(bytea, bytea, text, text) FROM postgres;
GRANT ALL ON FUNCTION extensions.pgp_pub_decrypt(bytea, bytea, text, text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.pgp_pub_decrypt(bytea, bytea, text, text) TO dashboard_user;


--
-- Name: FUNCTION pgp_pub_decrypt_bytea(bytea, bytea); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.pgp_pub_decrypt_bytea(bytea, bytea) FROM postgres;
GRANT ALL ON FUNCTION extensions.pgp_pub_decrypt_bytea(bytea, bytea) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.pgp_pub_decrypt_bytea(bytea, bytea) TO dashboard_user;


--
-- Name: FUNCTION pgp_pub_decrypt_bytea(bytea, bytea, text); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.pgp_pub_decrypt_bytea(bytea, bytea, text) FROM postgres;
GRANT ALL ON FUNCTION extensions.pgp_pub_decrypt_bytea(bytea, bytea, text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.pgp_pub_decrypt_bytea(bytea, bytea, text) TO dashboard_user;


--
-- Name: FUNCTION pgp_pub_decrypt_bytea(bytea, bytea, text, text); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.pgp_pub_decrypt_bytea(bytea, bytea, text, text) FROM postgres;
GRANT ALL ON FUNCTION extensions.pgp_pub_decrypt_bytea(bytea, bytea, text, text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.pgp_pub_decrypt_bytea(bytea, bytea, text, text) TO dashboard_user;


--
-- Name: FUNCTION pgp_pub_encrypt(text, bytea); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.pgp_pub_encrypt(text, bytea) FROM postgres;
GRANT ALL ON FUNCTION extensions.pgp_pub_encrypt(text, bytea) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.pgp_pub_encrypt(text, bytea) TO dashboard_user;


--
-- Name: FUNCTION pgp_pub_encrypt(text, bytea, text); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.pgp_pub_encrypt(text, bytea, text) FROM postgres;
GRANT ALL ON FUNCTION extensions.pgp_pub_encrypt(text, bytea, text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.pgp_pub_encrypt(text, bytea, text) TO dashboard_user;


--
-- Name: FUNCTION pgp_pub_encrypt_bytea(bytea, bytea); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.pgp_pub_encrypt_bytea(bytea, bytea) FROM postgres;
GRANT ALL ON FUNCTION extensions.pgp_pub_encrypt_bytea(bytea, bytea) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.pgp_pub_encrypt_bytea(bytea, bytea) TO dashboard_user;


--
-- Name: FUNCTION pgp_pub_encrypt_bytea(bytea, bytea, text); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.pgp_pub_encrypt_bytea(bytea, bytea, text) FROM postgres;
GRANT ALL ON FUNCTION extensions.pgp_pub_encrypt_bytea(bytea, bytea, text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.pgp_pub_encrypt_bytea(bytea, bytea, text) TO dashboard_user;


--
-- Name: FUNCTION pgp_sym_decrypt(bytea, text); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.pgp_sym_decrypt(bytea, text) FROM postgres;
GRANT ALL ON FUNCTION extensions.pgp_sym_decrypt(bytea, text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.pgp_sym_decrypt(bytea, text) TO dashboard_user;


--
-- Name: FUNCTION pgp_sym_decrypt(bytea, text, text); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.pgp_sym_decrypt(bytea, text, text) FROM postgres;
GRANT ALL ON FUNCTION extensions.pgp_sym_decrypt(bytea, text, text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.pgp_sym_decrypt(bytea, text, text) TO dashboard_user;


--
-- Name: FUNCTION pgp_sym_decrypt_bytea(bytea, text); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.pgp_sym_decrypt_bytea(bytea, text) FROM postgres;
GRANT ALL ON FUNCTION extensions.pgp_sym_decrypt_bytea(bytea, text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.pgp_sym_decrypt_bytea(bytea, text) TO dashboard_user;


--
-- Name: FUNCTION pgp_sym_decrypt_bytea(bytea, text, text); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.pgp_sym_decrypt_bytea(bytea, text, text) FROM postgres;
GRANT ALL ON FUNCTION extensions.pgp_sym_decrypt_bytea(bytea, text, text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.pgp_sym_decrypt_bytea(bytea, text, text) TO dashboard_user;


--
-- Name: FUNCTION pgp_sym_encrypt(text, text); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.pgp_sym_encrypt(text, text) FROM postgres;
GRANT ALL ON FUNCTION extensions.pgp_sym_encrypt(text, text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.pgp_sym_encrypt(text, text) TO dashboard_user;


--
-- Name: FUNCTION pgp_sym_encrypt(text, text, text); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.pgp_sym_encrypt(text, text, text) FROM postgres;
GRANT ALL ON FUNCTION extensions.pgp_sym_encrypt(text, text, text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.pgp_sym_encrypt(text, text, text) TO dashboard_user;


--
-- Name: FUNCTION pgp_sym_encrypt_bytea(bytea, text); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.pgp_sym_encrypt_bytea(bytea, text) FROM postgres;
GRANT ALL ON FUNCTION extensions.pgp_sym_encrypt_bytea(bytea, text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.pgp_sym_encrypt_bytea(bytea, text) TO dashboard_user;


--
-- Name: FUNCTION pgp_sym_encrypt_bytea(bytea, text, text); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.pgp_sym_encrypt_bytea(bytea, text, text) FROM postgres;
GRANT ALL ON FUNCTION extensions.pgp_sym_encrypt_bytea(bytea, text, text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.pgp_sym_encrypt_bytea(bytea, text, text) TO dashboard_user;


--
-- Name: FUNCTION pgrst_ddl_watch(); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.pgrst_ddl_watch() TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION pgrst_drop_watch(); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.pgrst_drop_watch() TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION set_graphql_placeholder(); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.set_graphql_placeholder() TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION uuid_generate_v1(); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.uuid_generate_v1() FROM postgres;
GRANT ALL ON FUNCTION extensions.uuid_generate_v1() TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.uuid_generate_v1() TO dashboard_user;


--
-- Name: FUNCTION uuid_generate_v1mc(); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.uuid_generate_v1mc() FROM postgres;
GRANT ALL ON FUNCTION extensions.uuid_generate_v1mc() TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.uuid_generate_v1mc() TO dashboard_user;


--
-- Name: FUNCTION uuid_generate_v3(namespace uuid, name text); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.uuid_generate_v3(namespace uuid, name text) FROM postgres;
GRANT ALL ON FUNCTION extensions.uuid_generate_v3(namespace uuid, name text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.uuid_generate_v3(namespace uuid, name text) TO dashboard_user;


--
-- Name: FUNCTION uuid_generate_v4(); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.uuid_generate_v4() FROM postgres;
GRANT ALL ON FUNCTION extensions.uuid_generate_v4() TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.uuid_generate_v4() TO dashboard_user;


--
-- Name: FUNCTION uuid_generate_v5(namespace uuid, name text); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.uuid_generate_v5(namespace uuid, name text) FROM postgres;
GRANT ALL ON FUNCTION extensions.uuid_generate_v5(namespace uuid, name text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.uuid_generate_v5(namespace uuid, name text) TO dashboard_user;


--
-- Name: FUNCTION uuid_nil(); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.uuid_nil() FROM postgres;
GRANT ALL ON FUNCTION extensions.uuid_nil() TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.uuid_nil() TO dashboard_user;


--
-- Name: FUNCTION uuid_ns_dns(); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.uuid_ns_dns() FROM postgres;
GRANT ALL ON FUNCTION extensions.uuid_ns_dns() TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.uuid_ns_dns() TO dashboard_user;


--
-- Name: FUNCTION uuid_ns_oid(); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.uuid_ns_oid() FROM postgres;
GRANT ALL ON FUNCTION extensions.uuid_ns_oid() TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.uuid_ns_oid() TO dashboard_user;


--
-- Name: FUNCTION uuid_ns_url(); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.uuid_ns_url() FROM postgres;
GRANT ALL ON FUNCTION extensions.uuid_ns_url() TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.uuid_ns_url() TO dashboard_user;


--
-- Name: FUNCTION uuid_ns_x500(); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.uuid_ns_x500() FROM postgres;
GRANT ALL ON FUNCTION extensions.uuid_ns_x500() TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.uuid_ns_x500() TO dashboard_user;


--
-- Name: FUNCTION graphql("operationName" text, query text, variables jsonb, extensions jsonb); Type: ACL; Schema: graphql_public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION graphql_public.graphql("operationName" text, query text, variables jsonb, extensions jsonb) TO postgres;
GRANT ALL ON FUNCTION graphql_public.graphql("operationName" text, query text, variables jsonb, extensions jsonb) TO anon;
GRANT ALL ON FUNCTION graphql_public.graphql("operationName" text, query text, variables jsonb, extensions jsonb) TO authenticated;
GRANT ALL ON FUNCTION graphql_public.graphql("operationName" text, query text, variables jsonb, extensions jsonb) TO service_role;


--
-- Name: FUNCTION pg_reload_conf(); Type: ACL; Schema: pg_catalog; Owner: supabase_admin
--

GRANT ALL ON FUNCTION pg_catalog.pg_reload_conf() TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION get_auth(p_usename text); Type: ACL; Schema: pgbouncer; Owner: supabase_admin
--

REVOKE ALL ON FUNCTION pgbouncer.get_auth(p_usename text) FROM PUBLIC;
GRANT ALL ON FUNCTION pgbouncer.get_auth(p_usename text) TO pgbouncer;


--
-- Name: FUNCTION rls_auto_enable(); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.rls_auto_enable() TO anon;
GRANT ALL ON FUNCTION public.rls_auto_enable() TO authenticated;
GRANT ALL ON FUNCTION public.rls_auto_enable() TO service_role;


--
-- Name: FUNCTION apply_rls(wal jsonb, max_record_bytes integer); Type: ACL; Schema: realtime; Owner: supabase_admin
--

GRANT ALL ON FUNCTION realtime.apply_rls(wal jsonb, max_record_bytes integer) TO postgres;
GRANT ALL ON FUNCTION realtime.apply_rls(wal jsonb, max_record_bytes integer) TO dashboard_user;
GRANT ALL ON FUNCTION realtime.apply_rls(wal jsonb, max_record_bytes integer) TO anon;
GRANT ALL ON FUNCTION realtime.apply_rls(wal jsonb, max_record_bytes integer) TO authenticated;
GRANT ALL ON FUNCTION realtime.apply_rls(wal jsonb, max_record_bytes integer) TO service_role;
GRANT ALL ON FUNCTION realtime.apply_rls(wal jsonb, max_record_bytes integer) TO supabase_realtime_admin;


--
-- Name: FUNCTION broadcast_changes(topic_name text, event_name text, operation text, table_name text, table_schema text, new record, old record, level text); Type: ACL; Schema: realtime; Owner: supabase_admin
--

GRANT ALL ON FUNCTION realtime.broadcast_changes(topic_name text, event_name text, operation text, table_name text, table_schema text, new record, old record, level text) TO postgres;
GRANT ALL ON FUNCTION realtime.broadcast_changes(topic_name text, event_name text, operation text, table_name text, table_schema text, new record, old record, level text) TO dashboard_user;


--
-- Name: FUNCTION build_prepared_statement_sql(prepared_statement_name text, entity regclass, columns realtime.wal_column[]); Type: ACL; Schema: realtime; Owner: supabase_admin
--

GRANT ALL ON FUNCTION realtime.build_prepared_statement_sql(prepared_statement_name text, entity regclass, columns realtime.wal_column[]) TO postgres;
GRANT ALL ON FUNCTION realtime.build_prepared_statement_sql(prepared_statement_name text, entity regclass, columns realtime.wal_column[]) TO dashboard_user;
GRANT ALL ON FUNCTION realtime.build_prepared_statement_sql(prepared_statement_name text, entity regclass, columns realtime.wal_column[]) TO anon;
GRANT ALL ON FUNCTION realtime.build_prepared_statement_sql(prepared_statement_name text, entity regclass, columns realtime.wal_column[]) TO authenticated;
GRANT ALL ON FUNCTION realtime.build_prepared_statement_sql(prepared_statement_name text, entity regclass, columns realtime.wal_column[]) TO service_role;
GRANT ALL ON FUNCTION realtime.build_prepared_statement_sql(prepared_statement_name text, entity regclass, columns realtime.wal_column[]) TO supabase_realtime_admin;


--
-- Name: FUNCTION "cast"(val text, type_ regtype); Type: ACL; Schema: realtime; Owner: supabase_admin
--

GRANT ALL ON FUNCTION realtime."cast"(val text, type_ regtype) TO postgres;
GRANT ALL ON FUNCTION realtime."cast"(val text, type_ regtype) TO dashboard_user;
GRANT ALL ON FUNCTION realtime."cast"(val text, type_ regtype) TO anon;
GRANT ALL ON FUNCTION realtime."cast"(val text, type_ regtype) TO authenticated;
GRANT ALL ON FUNCTION realtime."cast"(val text, type_ regtype) TO service_role;
GRANT ALL ON FUNCTION realtime."cast"(val text, type_ regtype) TO supabase_realtime_admin;


--
-- Name: FUNCTION check_equality_op(op realtime.equality_op, type_ regtype, val_1 text, val_2 text); Type: ACL; Schema: realtime; Owner: supabase_admin
--

GRANT ALL ON FUNCTION realtime.check_equality_op(op realtime.equality_op, type_ regtype, val_1 text, val_2 text) TO postgres;
GRANT ALL ON FUNCTION realtime.check_equality_op(op realtime.equality_op, type_ regtype, val_1 text, val_2 text) TO dashboard_user;
GRANT ALL ON FUNCTION realtime.check_equality_op(op realtime.equality_op, type_ regtype, val_1 text, val_2 text) TO anon;
GRANT ALL ON FUNCTION realtime.check_equality_op(op realtime.equality_op, type_ regtype, val_1 text, val_2 text) TO authenticated;
GRANT ALL ON FUNCTION realtime.check_equality_op(op realtime.equality_op, type_ regtype, val_1 text, val_2 text) TO service_role;
GRANT ALL ON FUNCTION realtime.check_equality_op(op realtime.equality_op, type_ regtype, val_1 text, val_2 text) TO supabase_realtime_admin;


--
-- Name: FUNCTION is_visible_through_filters(columns realtime.wal_column[], filters realtime.user_defined_filter[]); Type: ACL; Schema: realtime; Owner: supabase_admin
--

GRANT ALL ON FUNCTION realtime.is_visible_through_filters(columns realtime.wal_column[], filters realtime.user_defined_filter[]) TO postgres;
GRANT ALL ON FUNCTION realtime.is_visible_through_filters(columns realtime.wal_column[], filters realtime.user_defined_filter[]) TO dashboard_user;
GRANT ALL ON FUNCTION realtime.is_visible_through_filters(columns realtime.wal_column[], filters realtime.user_defined_filter[]) TO anon;
GRANT ALL ON FUNCTION realtime.is_visible_through_filters(columns realtime.wal_column[], filters realtime.user_defined_filter[]) TO authenticated;
GRANT ALL ON FUNCTION realtime.is_visible_through_filters(columns realtime.wal_column[], filters realtime.user_defined_filter[]) TO service_role;
GRANT ALL ON FUNCTION realtime.is_visible_through_filters(columns realtime.wal_column[], filters realtime.user_defined_filter[]) TO supabase_realtime_admin;


--
-- Name: FUNCTION list_changes(publication name, slot_name name, max_changes integer, max_record_bytes integer); Type: ACL; Schema: realtime; Owner: supabase_admin
--

GRANT ALL ON FUNCTION realtime.list_changes(publication name, slot_name name, max_changes integer, max_record_bytes integer) TO postgres;
GRANT ALL ON FUNCTION realtime.list_changes(publication name, slot_name name, max_changes integer, max_record_bytes integer) TO dashboard_user;


--
-- Name: FUNCTION quote_wal2json(entity regclass); Type: ACL; Schema: realtime; Owner: supabase_admin
--

GRANT ALL ON FUNCTION realtime.quote_wal2json(entity regclass) TO postgres;
GRANT ALL ON FUNCTION realtime.quote_wal2json(entity regclass) TO dashboard_user;
GRANT ALL ON FUNCTION realtime.quote_wal2json(entity regclass) TO anon;
GRANT ALL ON FUNCTION realtime.quote_wal2json(entity regclass) TO authenticated;
GRANT ALL ON FUNCTION realtime.quote_wal2json(entity regclass) TO service_role;
GRANT ALL ON FUNCTION realtime.quote_wal2json(entity regclass) TO supabase_realtime_admin;


--
-- Name: FUNCTION send(payload jsonb, event text, topic text, private boolean); Type: ACL; Schema: realtime; Owner: supabase_admin
--

GRANT ALL ON FUNCTION realtime.send(payload jsonb, event text, topic text, private boolean) TO postgres;
GRANT ALL ON FUNCTION realtime.send(payload jsonb, event text, topic text, private boolean) TO dashboard_user;


--
-- Name: FUNCTION subscription_check_filters(); Type: ACL; Schema: realtime; Owner: supabase_admin
--

GRANT ALL ON FUNCTION realtime.subscription_check_filters() TO postgres;
GRANT ALL ON FUNCTION realtime.subscription_check_filters() TO dashboard_user;
GRANT ALL ON FUNCTION realtime.subscription_check_filters() TO anon;
GRANT ALL ON FUNCTION realtime.subscription_check_filters() TO authenticated;
GRANT ALL ON FUNCTION realtime.subscription_check_filters() TO service_role;
GRANT ALL ON FUNCTION realtime.subscription_check_filters() TO supabase_realtime_admin;


--
-- Name: FUNCTION to_regrole(role_name text); Type: ACL; Schema: realtime; Owner: supabase_admin
--

GRANT ALL ON FUNCTION realtime.to_regrole(role_name text) TO postgres;
GRANT ALL ON FUNCTION realtime.to_regrole(role_name text) TO dashboard_user;
GRANT ALL ON FUNCTION realtime.to_regrole(role_name text) TO anon;
GRANT ALL ON FUNCTION realtime.to_regrole(role_name text) TO authenticated;
GRANT ALL ON FUNCTION realtime.to_regrole(role_name text) TO service_role;
GRANT ALL ON FUNCTION realtime.to_regrole(role_name text) TO supabase_realtime_admin;


--
-- Name: FUNCTION topic(); Type: ACL; Schema: realtime; Owner: supabase_realtime_admin
--

GRANT ALL ON FUNCTION realtime.topic() TO postgres;
GRANT ALL ON FUNCTION realtime.topic() TO dashboard_user;


--
-- Name: FUNCTION _crypto_aead_det_decrypt(message bytea, additional bytea, key_id bigint, context bytea, nonce bytea); Type: ACL; Schema: vault; Owner: supabase_admin
--

GRANT ALL ON FUNCTION vault._crypto_aead_det_decrypt(message bytea, additional bytea, key_id bigint, context bytea, nonce bytea) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION vault._crypto_aead_det_decrypt(message bytea, additional bytea, key_id bigint, context bytea, nonce bytea) TO service_role;


--
-- Name: FUNCTION create_secret(new_secret text, new_name text, new_description text, new_key_id uuid); Type: ACL; Schema: vault; Owner: supabase_admin
--

GRANT ALL ON FUNCTION vault.create_secret(new_secret text, new_name text, new_description text, new_key_id uuid) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION vault.create_secret(new_secret text, new_name text, new_description text, new_key_id uuid) TO service_role;


--
-- Name: FUNCTION update_secret(secret_id uuid, new_secret text, new_name text, new_description text, new_key_id uuid); Type: ACL; Schema: vault; Owner: supabase_admin
--

GRANT ALL ON FUNCTION vault.update_secret(secret_id uuid, new_secret text, new_name text, new_description text, new_key_id uuid) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION vault.update_secret(secret_id uuid, new_secret text, new_name text, new_description text, new_key_id uuid) TO service_role;


--
-- Name: TABLE audit_log_entries; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT ALL ON TABLE auth.audit_log_entries TO dashboard_user;
GRANT INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,MAINTAIN,UPDATE ON TABLE auth.audit_log_entries TO postgres;
GRANT SELECT ON TABLE auth.audit_log_entries TO postgres WITH GRANT OPTION;


--
-- Name: TABLE custom_oauth_providers; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT ALL ON TABLE auth.custom_oauth_providers TO postgres;
GRANT ALL ON TABLE auth.custom_oauth_providers TO dashboard_user;


--
-- Name: TABLE flow_state; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,MAINTAIN,UPDATE ON TABLE auth.flow_state TO postgres;
GRANT SELECT ON TABLE auth.flow_state TO postgres WITH GRANT OPTION;
GRANT ALL ON TABLE auth.flow_state TO dashboard_user;


--
-- Name: TABLE identities; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,MAINTAIN,UPDATE ON TABLE auth.identities TO postgres;
GRANT SELECT ON TABLE auth.identities TO postgres WITH GRANT OPTION;
GRANT ALL ON TABLE auth.identities TO dashboard_user;


--
-- Name: TABLE instances; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT ALL ON TABLE auth.instances TO dashboard_user;
GRANT INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,MAINTAIN,UPDATE ON TABLE auth.instances TO postgres;
GRANT SELECT ON TABLE auth.instances TO postgres WITH GRANT OPTION;


--
-- Name: TABLE mfa_amr_claims; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,MAINTAIN,UPDATE ON TABLE auth.mfa_amr_claims TO postgres;
GRANT SELECT ON TABLE auth.mfa_amr_claims TO postgres WITH GRANT OPTION;
GRANT ALL ON TABLE auth.mfa_amr_claims TO dashboard_user;


--
-- Name: TABLE mfa_challenges; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,MAINTAIN,UPDATE ON TABLE auth.mfa_challenges TO postgres;
GRANT SELECT ON TABLE auth.mfa_challenges TO postgres WITH GRANT OPTION;
GRANT ALL ON TABLE auth.mfa_challenges TO dashboard_user;


--
-- Name: TABLE mfa_factors; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,MAINTAIN,UPDATE ON TABLE auth.mfa_factors TO postgres;
GRANT SELECT ON TABLE auth.mfa_factors TO postgres WITH GRANT OPTION;
GRANT ALL ON TABLE auth.mfa_factors TO dashboard_user;


--
-- Name: TABLE oauth_authorizations; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT ALL ON TABLE auth.oauth_authorizations TO postgres;
GRANT ALL ON TABLE auth.oauth_authorizations TO dashboard_user;


--
-- Name: TABLE oauth_client_states; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT ALL ON TABLE auth.oauth_client_states TO postgres;
GRANT ALL ON TABLE auth.oauth_client_states TO dashboard_user;


--
-- Name: TABLE oauth_clients; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT ALL ON TABLE auth.oauth_clients TO postgres;
GRANT ALL ON TABLE auth.oauth_clients TO dashboard_user;


--
-- Name: TABLE oauth_consents; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT ALL ON TABLE auth.oauth_consents TO postgres;
GRANT ALL ON TABLE auth.oauth_consents TO dashboard_user;


--
-- Name: TABLE one_time_tokens; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,MAINTAIN,UPDATE ON TABLE auth.one_time_tokens TO postgres;
GRANT SELECT ON TABLE auth.one_time_tokens TO postgres WITH GRANT OPTION;
GRANT ALL ON TABLE auth.one_time_tokens TO dashboard_user;


--
-- Name: TABLE refresh_tokens; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT ALL ON TABLE auth.refresh_tokens TO dashboard_user;
GRANT INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,MAINTAIN,UPDATE ON TABLE auth.refresh_tokens TO postgres;
GRANT SELECT ON TABLE auth.refresh_tokens TO postgres WITH GRANT OPTION;


--
-- Name: SEQUENCE refresh_tokens_id_seq; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT ALL ON SEQUENCE auth.refresh_tokens_id_seq TO dashboard_user;
GRANT ALL ON SEQUENCE auth.refresh_tokens_id_seq TO postgres;


--
-- Name: TABLE saml_providers; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,MAINTAIN,UPDATE ON TABLE auth.saml_providers TO postgres;
GRANT SELECT ON TABLE auth.saml_providers TO postgres WITH GRANT OPTION;
GRANT ALL ON TABLE auth.saml_providers TO dashboard_user;


--
-- Name: TABLE saml_relay_states; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,MAINTAIN,UPDATE ON TABLE auth.saml_relay_states TO postgres;
GRANT SELECT ON TABLE auth.saml_relay_states TO postgres WITH GRANT OPTION;
GRANT ALL ON TABLE auth.saml_relay_states TO dashboard_user;


--
-- Name: TABLE schema_migrations; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT SELECT ON TABLE auth.schema_migrations TO postgres WITH GRANT OPTION;


--
-- Name: TABLE sessions; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,MAINTAIN,UPDATE ON TABLE auth.sessions TO postgres;
GRANT SELECT ON TABLE auth.sessions TO postgres WITH GRANT OPTION;
GRANT ALL ON TABLE auth.sessions TO dashboard_user;


--
-- Name: TABLE sso_domains; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,MAINTAIN,UPDATE ON TABLE auth.sso_domains TO postgres;
GRANT SELECT ON TABLE auth.sso_domains TO postgres WITH GRANT OPTION;
GRANT ALL ON TABLE auth.sso_domains TO dashboard_user;


--
-- Name: TABLE sso_providers; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,MAINTAIN,UPDATE ON TABLE auth.sso_providers TO postgres;
GRANT SELECT ON TABLE auth.sso_providers TO postgres WITH GRANT OPTION;
GRANT ALL ON TABLE auth.sso_providers TO dashboard_user;


--
-- Name: TABLE users; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT ALL ON TABLE auth.users TO dashboard_user;
GRANT INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,MAINTAIN,UPDATE ON TABLE auth.users TO postgres;
GRANT SELECT ON TABLE auth.users TO postgres WITH GRANT OPTION;


--
-- Name: TABLE webauthn_challenges; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT ALL ON TABLE auth.webauthn_challenges TO postgres;
GRANT ALL ON TABLE auth.webauthn_challenges TO dashboard_user;


--
-- Name: TABLE webauthn_credentials; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT ALL ON TABLE auth.webauthn_credentials TO postgres;
GRANT ALL ON TABLE auth.webauthn_credentials TO dashboard_user;


--
-- Name: TABLE pg_stat_statements; Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON TABLE extensions.pg_stat_statements FROM postgres;
GRANT ALL ON TABLE extensions.pg_stat_statements TO postgres WITH GRANT OPTION;
GRANT ALL ON TABLE extensions.pg_stat_statements TO dashboard_user;


--
-- Name: TABLE pg_stat_statements_info; Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON TABLE extensions.pg_stat_statements_info FROM postgres;
GRANT ALL ON TABLE extensions.pg_stat_statements_info TO postgres WITH GRANT OPTION;
GRANT ALL ON TABLE extensions.pg_stat_statements_info TO dashboard_user;


--
-- Name: TABLE global_banks; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.global_banks TO anon;
GRANT ALL ON TABLE public.global_banks TO authenticated;
GRANT ALL ON TABLE public.global_banks TO service_role;


--
-- Name: SEQUENCE global_banks_id_seq; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON SEQUENCE public.global_banks_id_seq TO anon;
GRANT ALL ON SEQUENCE public.global_banks_id_seq TO authenticated;
GRANT ALL ON SEQUENCE public.global_banks_id_seq TO service_role;


--
-- Name: TABLE month_balances; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.month_balances TO anon;
GRANT ALL ON TABLE public.month_balances TO authenticated;
GRANT ALL ON TABLE public.month_balances TO service_role;


--
-- Name: SEQUENCE month_balances_id_seq; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON SEQUENCE public.month_balances_id_seq TO anon;
GRANT ALL ON SEQUENCE public.month_balances_id_seq TO authenticated;
GRANT ALL ON SEQUENCE public.month_balances_id_seq TO service_role;


--
-- Name: TABLE months; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.months TO anon;
GRANT ALL ON TABLE public.months TO authenticated;
GRANT ALL ON TABLE public.months TO service_role;


--
-- Name: SEQUENCE months_id_seq; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON SEQUENCE public.months_id_seq TO anon;
GRANT ALL ON SEQUENCE public.months_id_seq TO authenticated;
GRANT ALL ON SEQUENCE public.months_id_seq TO service_role;


--
-- Name: TABLE transactions; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.transactions TO anon;
GRANT ALL ON TABLE public.transactions TO authenticated;
GRANT ALL ON TABLE public.transactions TO service_role;


--
-- Name: SEQUENCE transactions_id_seq; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON SEQUENCE public.transactions_id_seq TO anon;
GRANT ALL ON SEQUENCE public.transactions_id_seq TO authenticated;
GRANT ALL ON SEQUENCE public.transactions_id_seq TO service_role;


--
-- Name: TABLE messages; Type: ACL; Schema: realtime; Owner: supabase_realtime_admin
--

GRANT ALL ON TABLE realtime.messages TO postgres;
GRANT ALL ON TABLE realtime.messages TO dashboard_user;
GRANT SELECT,INSERT,UPDATE ON TABLE realtime.messages TO anon;
GRANT SELECT,INSERT,UPDATE ON TABLE realtime.messages TO authenticated;
GRANT SELECT,INSERT,UPDATE ON TABLE realtime.messages TO service_role;


--
-- Name: TABLE schema_migrations; Type: ACL; Schema: realtime; Owner: supabase_admin
--

GRANT ALL ON TABLE realtime.schema_migrations TO postgres;
GRANT ALL ON TABLE realtime.schema_migrations TO dashboard_user;
GRANT SELECT ON TABLE realtime.schema_migrations TO anon;
GRANT SELECT ON TABLE realtime.schema_migrations TO authenticated;
GRANT SELECT ON TABLE realtime.schema_migrations TO service_role;
GRANT ALL ON TABLE realtime.schema_migrations TO supabase_realtime_admin;


--
-- Name: TABLE subscription; Type: ACL; Schema: realtime; Owner: supabase_admin
--

GRANT ALL ON TABLE realtime.subscription TO postgres;
GRANT ALL ON TABLE realtime.subscription TO dashboard_user;
GRANT SELECT ON TABLE realtime.subscription TO anon;
GRANT SELECT ON TABLE realtime.subscription TO authenticated;
GRANT SELECT ON TABLE realtime.subscription TO service_role;
GRANT ALL ON TABLE realtime.subscription TO supabase_realtime_admin;


--
-- Name: SEQUENCE subscription_id_seq; Type: ACL; Schema: realtime; Owner: supabase_admin
--

GRANT ALL ON SEQUENCE realtime.subscription_id_seq TO postgres;
GRANT ALL ON SEQUENCE realtime.subscription_id_seq TO dashboard_user;
GRANT USAGE ON SEQUENCE realtime.subscription_id_seq TO anon;
GRANT USAGE ON SEQUENCE realtime.subscription_id_seq TO authenticated;
GRANT USAGE ON SEQUENCE realtime.subscription_id_seq TO service_role;
GRANT ALL ON SEQUENCE realtime.subscription_id_seq TO supabase_realtime_admin;


--
-- Name: TABLE buckets; Type: ACL; Schema: storage; Owner: supabase_storage_admin
--

REVOKE ALL ON TABLE storage.buckets FROM supabase_storage_admin;
GRANT ALL ON TABLE storage.buckets TO supabase_storage_admin WITH GRANT OPTION;
GRANT ALL ON TABLE storage.buckets TO service_role;
GRANT ALL ON TABLE storage.buckets TO authenticated;
GRANT ALL ON TABLE storage.buckets TO anon;
GRANT ALL ON TABLE storage.buckets TO postgres WITH GRANT OPTION;


--
-- Name: TABLE buckets_analytics; Type: ACL; Schema: storage; Owner: supabase_storage_admin
--

GRANT ALL ON TABLE storage.buckets_analytics TO service_role;
GRANT ALL ON TABLE storage.buckets_analytics TO authenticated;
GRANT ALL ON TABLE storage.buckets_analytics TO anon;


--
-- Name: TABLE buckets_vectors; Type: ACL; Schema: storage; Owner: supabase_storage_admin
--

GRANT SELECT ON TABLE storage.buckets_vectors TO service_role;
GRANT SELECT ON TABLE storage.buckets_vectors TO authenticated;
GRANT SELECT ON TABLE storage.buckets_vectors TO anon;


--
-- Name: TABLE objects; Type: ACL; Schema: storage; Owner: supabase_storage_admin
--

REVOKE ALL ON TABLE storage.objects FROM supabase_storage_admin;
GRANT ALL ON TABLE storage.objects TO supabase_storage_admin WITH GRANT OPTION;
GRANT ALL ON TABLE storage.objects TO service_role;
GRANT ALL ON TABLE storage.objects TO authenticated;
GRANT ALL ON TABLE storage.objects TO anon;
GRANT ALL ON TABLE storage.objects TO postgres WITH GRANT OPTION;


--
-- Name: TABLE s3_multipart_uploads; Type: ACL; Schema: storage; Owner: supabase_storage_admin
--

GRANT ALL ON TABLE storage.s3_multipart_uploads TO service_role;
GRANT SELECT ON TABLE storage.s3_multipart_uploads TO authenticated;
GRANT SELECT ON TABLE storage.s3_multipart_uploads TO anon;


--
-- Name: TABLE s3_multipart_uploads_parts; Type: ACL; Schema: storage; Owner: supabase_storage_admin
--

GRANT ALL ON TABLE storage.s3_multipart_uploads_parts TO service_role;
GRANT SELECT ON TABLE storage.s3_multipart_uploads_parts TO authenticated;
GRANT SELECT ON TABLE storage.s3_multipart_uploads_parts TO anon;


--
-- Name: TABLE vector_indexes; Type: ACL; Schema: storage; Owner: supabase_storage_admin
--

GRANT SELECT ON TABLE storage.vector_indexes TO service_role;
GRANT SELECT ON TABLE storage.vector_indexes TO authenticated;
GRANT SELECT ON TABLE storage.vector_indexes TO anon;


--
-- Name: TABLE secrets; Type: ACL; Schema: vault; Owner: supabase_admin
--

GRANT SELECT,REFERENCES,DELETE,TRUNCATE ON TABLE vault.secrets TO postgres WITH GRANT OPTION;
GRANT SELECT,DELETE ON TABLE vault.secrets TO service_role;


--
-- Name: TABLE decrypted_secrets; Type: ACL; Schema: vault; Owner: supabase_admin
--

GRANT SELECT,REFERENCES,DELETE,TRUNCATE ON TABLE vault.decrypted_secrets TO postgres WITH GRANT OPTION;
GRANT SELECT,DELETE ON TABLE vault.decrypted_secrets TO service_role;


--
-- Name: DEFAULT PRIVILEGES FOR SEQUENCES; Type: DEFAULT ACL; Schema: auth; Owner: supabase_auth_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_auth_admin IN SCHEMA auth GRANT ALL ON SEQUENCES TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_auth_admin IN SCHEMA auth GRANT ALL ON SEQUENCES TO dashboard_user;


--
-- Name: DEFAULT PRIVILEGES FOR FUNCTIONS; Type: DEFAULT ACL; Schema: auth; Owner: supabase_auth_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_auth_admin IN SCHEMA auth GRANT ALL ON FUNCTIONS TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_auth_admin IN SCHEMA auth GRANT ALL ON FUNCTIONS TO dashboard_user;


--
-- Name: DEFAULT PRIVILEGES FOR TABLES; Type: DEFAULT ACL; Schema: auth; Owner: supabase_auth_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_auth_admin IN SCHEMA auth GRANT ALL ON TABLES TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_auth_admin IN SCHEMA auth GRANT ALL ON TABLES TO dashboard_user;


--
-- Name: DEFAULT PRIVILEGES FOR SEQUENCES; Type: DEFAULT ACL; Schema: extensions; Owner: supabase_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA extensions GRANT ALL ON SEQUENCES TO postgres WITH GRANT OPTION;


--
-- Name: DEFAULT PRIVILEGES FOR FUNCTIONS; Type: DEFAULT ACL; Schema: extensions; Owner: supabase_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA extensions GRANT ALL ON FUNCTIONS TO postgres WITH GRANT OPTION;


--
-- Name: DEFAULT PRIVILEGES FOR TABLES; Type: DEFAULT ACL; Schema: extensions; Owner: supabase_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA extensions GRANT ALL ON TABLES TO postgres WITH GRANT OPTION;


--
-- Name: DEFAULT PRIVILEGES FOR SEQUENCES; Type: DEFAULT ACL; Schema: graphql; Owner: supabase_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql GRANT ALL ON SEQUENCES TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql GRANT ALL ON SEQUENCES TO anon;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql GRANT ALL ON SEQUENCES TO authenticated;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql GRANT ALL ON SEQUENCES TO service_role;


--
-- Name: DEFAULT PRIVILEGES FOR FUNCTIONS; Type: DEFAULT ACL; Schema: graphql; Owner: supabase_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql GRANT ALL ON FUNCTIONS TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql GRANT ALL ON FUNCTIONS TO anon;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql GRANT ALL ON FUNCTIONS TO authenticated;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql GRANT ALL ON FUNCTIONS TO service_role;


--
-- Name: DEFAULT PRIVILEGES FOR TABLES; Type: DEFAULT ACL; Schema: graphql; Owner: supabase_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql GRANT ALL ON TABLES TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql GRANT ALL ON TABLES TO anon;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql GRANT ALL ON TABLES TO authenticated;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql GRANT ALL ON TABLES TO service_role;


--
-- Name: DEFAULT PRIVILEGES FOR SEQUENCES; Type: DEFAULT ACL; Schema: graphql_public; Owner: supabase_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql_public GRANT ALL ON SEQUENCES TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql_public GRANT ALL ON SEQUENCES TO anon;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql_public GRANT ALL ON SEQUENCES TO authenticated;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql_public GRANT ALL ON SEQUENCES TO service_role;


--
-- Name: DEFAULT PRIVILEGES FOR FUNCTIONS; Type: DEFAULT ACL; Schema: graphql_public; Owner: supabase_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql_public GRANT ALL ON FUNCTIONS TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql_public GRANT ALL ON FUNCTIONS TO anon;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql_public GRANT ALL ON FUNCTIONS TO authenticated;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql_public GRANT ALL ON FUNCTIONS TO service_role;


--
-- Name: DEFAULT PRIVILEGES FOR TABLES; Type: DEFAULT ACL; Schema: graphql_public; Owner: supabase_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql_public GRANT ALL ON TABLES TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql_public GRANT ALL ON TABLES TO anon;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql_public GRANT ALL ON TABLES TO authenticated;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql_public GRANT ALL ON TABLES TO service_role;


--
-- Name: DEFAULT PRIVILEGES FOR SEQUENCES; Type: DEFAULT ACL; Schema: public; Owner: postgres
--

ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA public GRANT ALL ON SEQUENCES TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA public GRANT ALL ON SEQUENCES TO anon;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA public GRANT ALL ON SEQUENCES TO authenticated;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA public GRANT ALL ON SEQUENCES TO service_role;


--
-- Name: DEFAULT PRIVILEGES FOR SEQUENCES; Type: DEFAULT ACL; Schema: public; Owner: supabase_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA public GRANT ALL ON SEQUENCES TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA public GRANT ALL ON SEQUENCES TO anon;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA public GRANT ALL ON SEQUENCES TO authenticated;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA public GRANT ALL ON SEQUENCES TO service_role;


--
-- Name: DEFAULT PRIVILEGES FOR FUNCTIONS; Type: DEFAULT ACL; Schema: public; Owner: postgres
--

ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA public GRANT ALL ON FUNCTIONS TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA public GRANT ALL ON FUNCTIONS TO anon;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA public GRANT ALL ON FUNCTIONS TO authenticated;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA public GRANT ALL ON FUNCTIONS TO service_role;


--
-- Name: DEFAULT PRIVILEGES FOR FUNCTIONS; Type: DEFAULT ACL; Schema: public; Owner: supabase_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA public GRANT ALL ON FUNCTIONS TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA public GRANT ALL ON FUNCTIONS TO anon;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA public GRANT ALL ON FUNCTIONS TO authenticated;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA public GRANT ALL ON FUNCTIONS TO service_role;


--
-- Name: DEFAULT PRIVILEGES FOR TABLES; Type: DEFAULT ACL; Schema: public; Owner: postgres
--

ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA public GRANT ALL ON TABLES TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA public GRANT ALL ON TABLES TO anon;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA public GRANT ALL ON TABLES TO authenticated;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA public GRANT ALL ON TABLES TO service_role;


--
-- Name: DEFAULT PRIVILEGES FOR TABLES; Type: DEFAULT ACL; Schema: public; Owner: supabase_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA public GRANT ALL ON TABLES TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA public GRANT ALL ON TABLES TO anon;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA public GRANT ALL ON TABLES TO authenticated;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA public GRANT ALL ON TABLES TO service_role;


--
-- Name: DEFAULT PRIVILEGES FOR SEQUENCES; Type: DEFAULT ACL; Schema: realtime; Owner: supabase_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA realtime GRANT ALL ON SEQUENCES TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA realtime GRANT ALL ON SEQUENCES TO dashboard_user;


--
-- Name: DEFAULT PRIVILEGES FOR FUNCTIONS; Type: DEFAULT ACL; Schema: realtime; Owner: supabase_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA realtime GRANT ALL ON FUNCTIONS TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA realtime GRANT ALL ON FUNCTIONS TO dashboard_user;


--
-- Name: DEFAULT PRIVILEGES FOR TABLES; Type: DEFAULT ACL; Schema: realtime; Owner: supabase_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA realtime GRANT ALL ON TABLES TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA realtime GRANT ALL ON TABLES TO dashboard_user;


--
-- Name: DEFAULT PRIVILEGES FOR SEQUENCES; Type: DEFAULT ACL; Schema: storage; Owner: postgres
--

ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA storage GRANT ALL ON SEQUENCES TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA storage GRANT ALL ON SEQUENCES TO anon;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA storage GRANT ALL ON SEQUENCES TO authenticated;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA storage GRANT ALL ON SEQUENCES TO service_role;


--
-- Name: DEFAULT PRIVILEGES FOR FUNCTIONS; Type: DEFAULT ACL; Schema: storage; Owner: postgres
--

ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA storage GRANT ALL ON FUNCTIONS TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA storage GRANT ALL ON FUNCTIONS TO anon;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA storage GRANT ALL ON FUNCTIONS TO authenticated;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA storage GRANT ALL ON FUNCTIONS TO service_role;


--
-- Name: DEFAULT PRIVILEGES FOR TABLES; Type: DEFAULT ACL; Schema: storage; Owner: postgres
--

ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA storage GRANT ALL ON TABLES TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA storage GRANT ALL ON TABLES TO anon;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA storage GRANT ALL ON TABLES TO authenticated;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA storage GRANT ALL ON TABLES TO service_role;


--
-- Name: ensure_rls; Type: EVENT TRIGGER; Schema: -; Owner: postgres
--

CREATE EVENT TRIGGER ensure_rls ON ddl_command_end
         WHEN TAG IN ('CREATE TABLE', 'CREATE TABLE AS', 'SELECT INTO')
   EXECUTE FUNCTION public.rls_auto_enable();


ALTER EVENT TRIGGER ensure_rls OWNER TO postgres;

--
-- Name: issue_graphql_placeholder; Type: EVENT TRIGGER; Schema: -; Owner: supabase_admin
--

CREATE EVENT TRIGGER issue_graphql_placeholder ON sql_drop
         WHEN TAG IN ('DROP EXTENSION')
   EXECUTE FUNCTION extensions.set_graphql_placeholder();


ALTER EVENT TRIGGER issue_graphql_placeholder OWNER TO supabase_admin;

--
-- Name: issue_pg_cron_access; Type: EVENT TRIGGER; Schema: -; Owner: supabase_admin
--

CREATE EVENT TRIGGER issue_pg_cron_access ON ddl_command_end
         WHEN TAG IN ('CREATE EXTENSION')
   EXECUTE FUNCTION extensions.grant_pg_cron_access();


ALTER EVENT TRIGGER issue_pg_cron_access OWNER TO supabase_admin;

--
-- Name: issue_pg_graphql_access; Type: EVENT TRIGGER; Schema: -; Owner: supabase_admin
--

CREATE EVENT TRIGGER issue_pg_graphql_access ON ddl_command_end
         WHEN TAG IN ('CREATE FUNCTION')
   EXECUTE FUNCTION extensions.grant_pg_graphql_access();


ALTER EVENT TRIGGER issue_pg_graphql_access OWNER TO supabase_admin;

--
-- Name: issue_pg_net_access; Type: EVENT TRIGGER; Schema: -; Owner: supabase_admin
--

CREATE EVENT TRIGGER issue_pg_net_access ON ddl_command_end
         WHEN TAG IN ('CREATE EXTENSION')
   EXECUTE FUNCTION extensions.grant_pg_net_access();


ALTER EVENT TRIGGER issue_pg_net_access OWNER TO supabase_admin;

--
-- Name: pgrst_ddl_watch; Type: EVENT TRIGGER; Schema: -; Owner: supabase_admin
--

CREATE EVENT TRIGGER pgrst_ddl_watch ON ddl_command_end
   EXECUTE FUNCTION extensions.pgrst_ddl_watch();


ALTER EVENT TRIGGER pgrst_ddl_watch OWNER TO supabase_admin;

--
-- Name: pgrst_drop_watch; Type: EVENT TRIGGER; Schema: -; Owner: supabase_admin
--

CREATE EVENT TRIGGER pgrst_drop_watch ON sql_drop
   EXECUTE FUNCTION extensions.pgrst_drop_watch();


ALTER EVENT TRIGGER pgrst_drop_watch OWNER TO supabase_admin;

--
-- PostgreSQL database dump complete
--

\unrestrict fXXhp7TSKEKRjJdfNtwNG4qfzdf8zPaLVU21CqpZvKtmGFxc8gOFrUnCDqBnamN

