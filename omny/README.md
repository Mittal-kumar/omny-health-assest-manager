# Omny Health Asset Manager

Built on [Snipe-IT](https://snipeitapp.com) (AGPL-3.0). Keep the license and attribution intact.

## Run locally (Mac, Docker Desktop)
    ./omny/start.sh            # starts everything, opens http://localhost:8000
First visit runs the setup wizard (create admin user). Then upload your logo under
Admin > Settings > Branding.

## Backups
    ./omny/backup.sh           # database + uploaded files into ./backups (last 14 kept)
Also back up `.env` (especially `APP_KEY`) somewhere safe. It is not in git.

## Put it online
1. Get a server (any Linux VPS with Docker) and a domain; point the domain's DNS A record at it.
2. Clone this repo on the server, create `.env` (copy the variables from your local one),
   set `APP_URL=https://YOUR_DOMAIN`, `APP_DEBUG=false`, and configure real SMTP mail settings.
3. Run:
       DOMAIN=YOUR_DOMAIN docker compose -f docker-compose.local.yml -f omny/docker-compose.https.yml up -d
   Caddy fetches and renews the HTTPS certificate automatically.
4. Schedule `./omny/backup.sh` daily with cron.
