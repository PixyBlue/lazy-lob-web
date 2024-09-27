FROM caddy:builder-alpine AS builder

RUN xcaddy build \
  --with github.com/infogulch/xtemplate-caddy \
  --with github.com/WingLim/caddy-webhook \
  --with github.com/jackc/pgx \
  --with github.com/greenpau/caddy-security

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
