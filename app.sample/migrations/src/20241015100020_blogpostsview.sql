-- migrate:up
DROP VIEW IF EXISTS public.posts;
CREATE VIEW public.blogposts AS
SELECT *
FROM private.posts
WHERE published = TRUE AND (published_at IS NOT NULL AND published_at <= NOW());

-- migrate:down
DROP VIEW IF EXISTS public.blogposts;
