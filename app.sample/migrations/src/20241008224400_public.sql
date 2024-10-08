-- migrate:up
DO $$
BEGIN
  IF NOT EXISTS (SELECT 1 FROM information_schema.schemata WHERE schema_name = 'public') THEN
    CREATE SCHEMA public;
  END IF;
END $$;
GRANT SELECT ON ALL TABLES IN SCHEMA public TO $DB_ANON_ROLE;
GRANT SELECT ON ALL SEQUENCES IN SCHEMA public TO $DB_ANON_ROLE;

-- migrate:down
REVOKE SELECT ON ALL TABLES IN SCHEMA public FROM $DB_ANON_ROLE;
REVOKE SELECT ON ALL SEQUENCES IN SCHEMA public FROM $DB_ANON_ROLE;
DO $$
BEGIN
  IF EXISTS (SELECT 1 FROM information_schema.schemata WHERE schema_name = 'public' AND NOT EXISTS (SELECT 1 FROM information_schema.tables WHERE table_schema = 'public')) THEN
    DROP SCHEMA public;
  END IF;
END $$;
