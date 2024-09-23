boot:
  docker compose up &

start:
  just boot
  xdg-open https://localhost

build:
  docker compose build

stop:
  docker compose down

reload-caddy-config:
  docker compose exec web caddy reload --config /etc/caddy/Caddyfile

reload:
  just reload-caddy-config

restart:
  just stop
  just boot
