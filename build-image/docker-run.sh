#!/bin/bash

FRED_HOME=/home/fred

rights_fixed_lock_file="$FRED_HOME/rights_fixed.lock"

whoami
pwd

if [ ! -f "$rights_fixed_lock_file" ]; then
    # Fix access rights
    chown -Rc fred:fredg $FRED_HOME

    chmod -c 777 $FRED_HOME/data $FRED_HOME/conf $FRED_HOME/data/logs
    find $FRED_HOME $FRED_HOME -type f -exec chmod 664 {} +
    find $FRED_HOME $FRED_HOME -type d -exec chmod 777 {} +
    chmod -c 774 $FRED_HOME/docker-run.sh $FRED_HOME/freenet-run.sh $FRED_HOME/run.sh $FRED_HOME/bin/wrapper
    touch "$rights_fixed_lock_file"
    ls -la
fi

# Run freenet by fred user
exec sudo -E -u fred $FRED_HOME/freenet-run.sh