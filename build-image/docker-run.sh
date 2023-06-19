#!/bin/bash

FRED_HOME=/home/fred

# Fix access rights
chown -Rc fred:fredg $FRED_HOME

chmod -c 777 $FRED_HOME/data $FRED_HOME/conf
find $FRED_HOME $FRED_HOME -type f -exec chmod 664 {} +
find $FRED_HOME $FRED_HOME -type d -exec chmod 777 {} +
chmod -c 774 $FRED_HOME/docker-run.sh $FRED_HOME/freenet-run.sh $FRED_HOME/run.sh $FRED_HOME/bin/wrapper

whoami
pwd
ls -la
ls -la $FRED_HOME/bin

# Run freenet by fred user
exec sudo -u fred $FRED_HOME/freenet-run.sh