-- migrate:up
ALTER TABLE private.posts ADD CONSTRAINT unique_slug UNIQUE (slug);
-- migrate:down
ALTER TABLE private.posts DROP CONSTRAINT unique_slug;
