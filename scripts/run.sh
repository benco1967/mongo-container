#!/bin/bash

if [[ -e /scripts/.firstrun ]]; then
    /scripts/first_run.sh
fi

echo "Starting MongoDB..."
/usr/bin/mongod --dbpath /data --auth $@
