#!/bin/sh
# docker-entrypoint.sh
#
# Runs the PostgreSQL migration script before starting Apache.
# The migration is idempotent — safe to run on every container start.

set -e

echo "[entrypoint] Running database migration..."
php /var/www/html/server/db/migrate.php

echo "[entrypoint] Starting Apache..."
exec "$@"
