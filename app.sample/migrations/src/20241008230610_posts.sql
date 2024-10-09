-- migrate:up
CREATE SCHEMA IF NOT EXISTS private;

CREATE TABLE IF NOT EXISTS private.posts (
  id UUID PRIMARY KEY DEFAULT generate_ulid(),
  created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
  published_at TIMESTAMPTZ,
  title TEXT NOT NULL,
  summary TEXT,
  content TEXT NOT NULL,
  published BOOLEAN DEFAULT FALSE
);

CREATE VIEW public.posts AS
SELECT *
FROM private.posts
WHERE published = TRUE AND (published_at IS NOT NULL AND published_at <= NOW());

-- migrate:down
DROP VIEW IF EXISTS public.posts;

DROP TABLE IF EXISTS private.posts;

DROP SCHEMA IF EXISTS private;
