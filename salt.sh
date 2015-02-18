#!/bin/bash
# Justin Hoppensteadt <hop@crowdrise.com>

HOSTNAME=${HOSTNAME:-$(hostname)}
HOSTNAME=$(echo ${HOSTNAME%.crowdrise.io} | perl -pe 's/(\d+)/\.\1/g')
METRIC=salt

/usr/lib/rackspace-monitoring-agent/plugins/file_info.py /var/cache/salt/minion/ | while read LINE ; do
  echo $LINE
  echo $LINE | sed -e "s/metric /metric $HOSTNAME.$METRIC./g" -e "s/ int64/ uint64/g"
done | uniq
