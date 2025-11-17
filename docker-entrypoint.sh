#!/bin/sh
set -e

echo "Running Database Importer..."
bundle exec rails importer:shopping

echo "Starting Rails Server..."
exec bundle exec rails s -b '0.0.0.0'