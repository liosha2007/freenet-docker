#!/bin/sh

FRED_HOME=/home/fred

if [ "$(id -u)" -eq 0 ]; then
    echo "Please do not run Freenet as root! Check $FRED_HOME/docker-run.sh and $FRED_HOME/freenet-run.sh scripts." >&2
    exit 1
fi

whoami
ls -la $FRED_HOME/
echo "Running Freenet..."

trapexit() {
  echo -n "Trapped SIGTERM @" >> "$FRED_HOME/data/logs/term.log"
  date >> "$FRED_HOME/data/logs/term.log"
  "$FRED_HOME/run.sh" stop >> "$FRED_HOME/data/logs/term.log"
  echo "exited: $1" >> "$FRED_HOME/data/logs/term.log"
  exit 0
}

trap 'trapexit' SIGTERM

if [ ! -f "$FRED_HOME/conf/freenet.ini" ]; then
    cp "$FRED_HOME/default-freenet.ini" "$FRED_HOME/conf/freenet.ini"
    sed -i "s#ALLOWEDHOSTS#$allowedhosts#" "$FRED_HOME/conf/freenet.ini"
    sed -i "s#DARKNETPORT#$darknetport#" "$FRED_HOME/conf/freenet.ini"
    sed -i "s#OPENNETPORT#$opennetport#" "$FRED_HOME/conf/freenet.ini"
fi

if [ ! -f "$FRED_HOME/data/seednodes.fref" ]; then
    cp "$FRED_HOME/seednodes.fref" "$FRED_HOME/data/"
fi

cd "$FRED_HOME" || echo "Can't enter $FRED_HOME"

./run.sh console &
wait
