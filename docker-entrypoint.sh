#!/bin/sh
set -e

host="mongodb"
port="27017"

until nc -z "$host" "$port"; do
  sleep 1
done

if [ -f tmp/pids/server.pid ]; then
  rm tmp/pids/server.pid
fi

exec "$@"