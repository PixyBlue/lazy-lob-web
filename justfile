set dotenv-load

default:
  just --list

init:
  docker compose exec web npm install
  docker compose exec web dbmate up
  just migrate

init-dev: init
  sudo trust anchor ./app/data/web/pki/authorities/local/root.crt
  sudo update-ca-trust

boot:
  docker compose up &

start: boot
  xdg-open https://localhost &>/dev/null &

build:
  docker compose build

stop:
  docker compose down

reload-caddy-config:
  just make-caddyfile
  docker compose exec web caddy reload --config /etc/caddy/Caddyfile

reload:
  just reload-caddy-config

reboot:
  just stop
  just boot

shell service:
  docker compose exec {{service}} /bin/sh

command service command:
  docker compose exec {{service}} {{command}}

open-swagger:
  xdg-open https://swagger.localhost &>/dev/null &

open-api:
  xdg-open https://api.localhost &>/dev/null &

open:
  xdg-open https://localhost &>/dev/null &

migrate:
  just command web migrate

make-caddyfile:
  just command web make-caddyfile

logs service:
  docker compose logs {{service}} -f --tail 0

pg:
  docker compose exec db psql -U $POSTGRES_USER $POSTGRES_DB

pganon:
  docker compose exec db psql -U $DB_ANON_ROLE $POSTGRES_DB
