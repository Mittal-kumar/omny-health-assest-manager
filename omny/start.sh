#!/usr/bin/env bash
# Starts Omny Health Asset Manager locally and opens it in the browser.
cd "$(dirname "$0")/.."
DC=/Applications/Docker.app/Contents/Resources/cli-plugins/docker-compose
open -a Docker 2>/dev/null
until docker info >/dev/null 2>&1; do sleep 3; done
$DC -f docker-compose.local.yml up -d
open http://localhost:8000
