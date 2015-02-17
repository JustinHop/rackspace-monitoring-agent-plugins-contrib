#!/bin/bash
# vim: set ft=sh ts=8 sw=2 tw=80 et :

HOSTNAME=${HOSTNAME:-$(hostname)}
HOSTNAME=$(echo ${HOSTNAME%.crowdrise.io} | perl -pe 's/(\d+)/\.\1/g')

cat /proc/net/sockstat{,6} | while read LINE ; do

  STAT1=${LINE%%:*}

  for STAT2 in ${LINE##*:} ; do
    case "${STAT2}" in
      [a-zA-Z]*)
        echo -n "${STAT1,,}_${STAT2} uint64 "
        ;;

      [[:digit:]]*)
        echo "$STAT2"
        ;;

    esac
  done

done | while read MLINE ; do 
  echo "metric ${HOSTNAME}.socket.${MLINE}"
done

