#!/usr/bin/env bash
set -e

COMMAND="$1"

if [ -z "$COMMAND" ]; then
  echo "Brddify installer"
  echo "Usage: $0 install"
  exit 1
fi

if [ "$COMMAND" = "install" ]; then
  echo "[Brddify] Starting install using docker compose..."

  if ! command -v docker >/dev/null 2>&1; then
    echo "[Brddify] ERROR: docker is not installed. Please install Docker first."
    exit 1
  fi

  # docker compose v2 (integrated) preferred
  if command -v docker-compose >/dev/null 2>&1; then
    COMPOSE_CMD="docker-compose"
  else
    COMPOSE_CMD="docker compose"
  fi

  echo "[Brddify] Using compose command: $COMPOSE_CMD"

  $COMPOSE_CMD up -d

  echo "[Brddify] Containers started."
  echo "[Brddify] Make sure you have set SQLALCHEMY_DATABASE_URL in .env for your MySQL database."
  echo "[Brddify] Default dashboard path: /brddify/"
else
  echo "Unknown command: $COMMAND"
  echo "Usage: $0 install"
  exit 1
fi
