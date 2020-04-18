#!/bin/sh

# list the interfaces names.
INTERFACES=$(iw dev | awk '$1=="Interface"{print $2}')

# list interfaces that does not have any clients connected.
for INTERFACE in $INTERFACES
do
  ASSOC_CLIENTS=`iw dev $INTERFACE station dump | awk '$1=="Station"' | grep -c "Station"`

  if [ "$ASSOC_CLIENTS" -lt 1 ]
  then
    RESTART_LIST="$RESTART_LIST $INTERFACE"
  fi
done

if [ ! -z $RESTART_LIST ]
then
  echo "$(date +"%F_%T"): restarting wifi - no clients or issues with $RESTART_LIST"
  wifi down
  sleep 1
  wifi up
fi
