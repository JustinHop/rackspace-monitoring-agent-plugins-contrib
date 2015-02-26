#!/bin/bash
# by Justin Hoppensteadt <hop@crowdrise.com>

HOSTNAME=${HOSTNAME:-$(hostname)}
HOSTNAME=$(echo ${HOSTNAME%.crowdrise.io} | perl -pe 's/(\d+)/\.\1/g')
PROCFILE=/proc/vmstat
STAT=vmstat

echo "status ok"
while read LINE ; do
  read -a WORDS <<< "$LINE"
  case "${WORDS[0]}" in
    *)
      echo "metric ${HOSTNAME}.${STAT}.${WORDS[0]} uint64 ${WORDS[1]}"
      ;;
  esac
done < $PROCFILE
