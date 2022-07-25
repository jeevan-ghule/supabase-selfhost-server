#!/usr/bin/env bash
echo "start"
echo "$POSTGRES_DB"
# use same db as the one from env
dbname="$POSTGRES_DB"
echo "$dbname"
# include custom config from main config
conf=/var/lib/postgresql/data/postgresql.conf
echo "# pg_cron settings file" > $conf
echo "shared_preload_libraries = 'pg_cron'" >> $conf
echo "cron.database_name = '$dbname'" >> $conf
cat "$conf"

# Required to load pg_cron
pg_ctl restart