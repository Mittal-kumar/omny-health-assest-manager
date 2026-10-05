#!/usr/bin/env bash
# Backs up the Omny Health Asset Manager database and uploaded files.
# Usage: ./omny/backup.sh   (keeps the 14 most recent backups in ./backups)
set -euo pipefail
cd "$(dirname "$0")/.."
DC="${DOCKER_COMPOSE:-/Applications/Docker.app/Contents/Resources/cli-plugins/docker-compose}"
[ -x "$DC" ] || DC="docker compose"
STAMP=$(date +%Y%m%d-%H%M%S)
OUT="backups/$STAMP"
mkdir -p "$OUT"
getenv() { grep -m1 "^$1=" .env | cut -d= -f2-; }
MYSQL_ROOT_PASSWORD=$(getenv MYSQL_ROOT_PASSWORD); DB_DATABASE=$(getenv DB_DATABASE)
$DC -f docker-compose.local.yml exec -T db sh -c \
  "mariadb-dump -u root -p\"$MYSQL_ROOT_PASSWORD\" --single-transaction $DB_DATABASE" | gzip > "$OUT/database.sql.gz"
$DC -f docker-compose.local.yml exec -T app tar czf - -C /var/lib/snipeit . > "$OUT/files.tar.gz"
ls -1dt backups/*/ | tail -n +15 | xargs -I{} rm -rf {}
echo "Backup saved to $OUT"
