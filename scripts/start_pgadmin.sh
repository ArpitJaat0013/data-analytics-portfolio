#!/usr/bin/env bash
# Launch pgAdmin 4 (server mode) for local database management.
# Sign in at the URL printed on startup with the credentials below.
set -euo pipefail
# Local-only credentials live outside the repository.
ENV_FILE="${HOME}/.data-analytics-env"
if [ -f "$ENV_FILE" ]; then
  set -a
  # shellcheck disable=SC1090
  source "$ENV_FILE"
  set +a
fi
export PGADMIN_SETUP_EMAIL="${PGADMIN_SETUP_EMAIL:?set PGADMIN_SETUP_EMAIL first}"
export PGADMIN_SETUP_PASSWORD="${PGADMIN_SETUP_PASSWORD:?set PGADMIN_SETUP_PASSWORD first}"
exec conda run -n pg-suite pgadmin4
