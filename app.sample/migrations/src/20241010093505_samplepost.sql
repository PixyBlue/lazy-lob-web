-- migrate:up
INSERT INTO private.posts (published_at, title, summary, content, published) VALUES (NOW(), 'Sample post', 'This is the summary', 'This is the content', true)

-- migrate:down
DELETE FROM private.posts WHERE slug='sample-post';
