default:
  just --list

init:
  docker compose exec web npm install
  docker compose exec web dbmate up
  docker compose exec web migrate

init-dev: init
  sudo trust anchor ./data/caddy/pki/authorities/local/root.crt
  sudo update-ca-trust

boot:
  docker compose up &

start: boot
  xdg-open https://localhost

build:
  docker compose build

stop:
  docker compose down

reload-caddy-config:
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
  xdg-open https://swagger.localhost

open-api:
  xdg-open https://api.localhost

migrate:
  just command web migrate
