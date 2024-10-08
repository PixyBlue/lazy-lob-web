FROM caddy:builder-alpine AS builder

RUN xcaddy build \
  --with github.com/infogulch/xtemplate-caddy \
  --with github.com/WingLim/caddy-webhook \
  --with github.com/jackc/pgx \
  --with github.com/greenpau/caddy-security \
  --with github.com/infogulch/xtemplate/providers \
  --with github.com/abiosoft/caddy-json-schema

FROM caddy:alpine
COPY --from=builder /usr/bin/caddy /usr/bin/caddy

RUN echo "http://dl-cdn.alpinelinux.org/alpine/edge/testing" >> /etc/apk/repositories

RUN apk update && apk add --no-cache \
    npm \
    dbmate \
    envsubst

RUN cat > /usr/local/bin/migrate <<'EOF'
#!/bin/sh
find /srv/db/migrations/src/ -name "*.sql" -exec sh -c 'envsubst < "$0" > /srv/db/migrations/"$(basename "$0")"' {} \;
dbmate migrate
EOF

RUN chmod +x /usr/local/bin/migrate

RUN cat > /usr/local/bin/make-caddyfile <<'EOF'
#!/bin/sh
find /srv/db/migrations/src/ -name "*.sql" -exec sh -c 'envsubst < "$0" > /srv/db/migrations/"$(basename "$0")"' {} \;
envsubst < /etc/caddy/caddyfile.src.json > /etc/caddy/caddyfile.json
EOF

RUN chmod +x /usr/local/bin/make-caddyfile

ENTRYPOINT ["/bin/sh", "-c", "make-caddyfile && caddy run --config /etc/caddy/caddyfile.json"]
