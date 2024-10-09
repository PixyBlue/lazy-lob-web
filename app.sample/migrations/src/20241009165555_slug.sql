-- migrate:up
ALTER TABLE private.posts ADD COLUMN slug VARCHAR(255);
UPDATE private.posts SET slug = lower(replace(replace(replace(title, ' ', '-'), '[', ''), ']', ''));
ALTER TABLE private.posts ALTER COLUMN slug SET NOT NULL;
CREATE OR REPLACE FUNCTION set_slug()
RETURNS TRIGGER AS $$
BEGIN
    NEW.slug := lower(replace(replace(replace(NEW.title, ' ', '-'), '[', ''), ']', ''));
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER set_slug_trigger
BEFORE INSERT ON private.posts
FOR EACH ROW
EXECUTE PROCEDURE set_slug();
CREATE OR REPLACE VIEW public.posts AS SELECT * FROM private.posts;


-- migrate:down
DROP TRIGGER set_slug_trigger ON private.posts;
DROP FUNCTION set_slug();
ALTER TABLE private.posts DROP COLUMN slug;
CREATE OR REPLACE VIEW public.posts AS SELECT * FROM private.posts;
