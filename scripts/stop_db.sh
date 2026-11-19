#!/usr/bin/env bash
# Stop the local PostgreSQL cluster.
set -euo pipefail
PGDATA="${PGDATA:-$HOME/data-analytics-pgdata}"
conda run -n pg-suite pg_ctl -D "$PGDATA" -w stop
