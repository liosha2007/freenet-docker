#!/bin/bash

FRED_HOME=/home/fred

# Fix access rights
chown -R fred:fredg $FRED_HOME
chmod 664 $FRED_HOME/data $FRED_HOME/conf

# Run freenet by fred user
exec sudo -u fred $FRED_HOME/freenet-run.sh