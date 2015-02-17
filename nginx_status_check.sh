#!/bin/bash

HOSTNAME=${HOSTNAME:-$(hostname)}
HOSTNAME=$(echo ${HOSTNAME%.crowdrise.io} | perl -pe 's/(\d+)/\.\1/g')

cd /usr/lib/rackspace-monitoring-agent/plugins/

./nginx_status_check.py "$@" | while read LINE ; do
  echo $LINE | sed -e "s/metric /metric $HOSTNAME.nginx./g" -e "s/ int64/ uint64/g"
done
