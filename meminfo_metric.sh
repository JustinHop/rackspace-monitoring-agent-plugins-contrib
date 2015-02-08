#!/bin/bash

HOSTNAME=${HOSTNAME:-$(hostname)}
HOSTNAME=$(echo ${HOSTNAME%.crowdrise.io} | perl -pe 's/(\d+)/\.\1/g')

echo "status ok meminfo used"

tr -d ':' < /proc/meminfo | while read LINE ; do

  read -a WORDS <<< "$LINE"

  case "${WORDS[0]}" in
    Swap*|Mem*|Vmalloc*|Buff*|Cache*|Active|Inactive|Shmem|Slab|Dirty)
      echo "${WORDS[0]} uint64 ${WORDS[1]} kB"
      ;;
    *)
      true
      ;;
  esac

done | while read MLINE ; do 
  echo "metric ${HOSTNAME}.mem.${MLINE}"
done
