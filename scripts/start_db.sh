#!/usr/bin/env bash
# Start the local PostgreSQL cluster.
set -euo pipefail
PGDATA="${PGDATA:-$HOME/data-analytics-pgdata}"
LOG="${HOME}/data-analytics-pg.log"
conda run -n pg-suite pg_ctl -D "$PGDATA" -l "$LOG" -w start
