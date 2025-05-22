#!/bin/bash
set -e

rm -rf /var/lib/mysql/*
exec docker-entrypoint.sh "$@"
