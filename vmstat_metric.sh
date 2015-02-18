#!/bin/bash
# by Justin Hoppensteadt <hop@crowdrise.com>

HOSTNAME=${HOSTNAME:-$(hostname)}
HOSTNAME=$(echo ${HOSTNAME%.crowdrise.io} | perl -pe 's/(\d+)/\.\1/g')
STAT=vmstat

echo "status ok"

while read LINE ; do

  read -a WORDS <<< "$LINE"

  case "${WORDS[0]}" in
    nr_free_pages|nr_page_table_pages|nr_written|nr*file*|nr_dirty|nr_writeback|nr_unstable|nr_page_table_pages|nr_mapped|nr_slab|pgpgin|pgpgout|pswpin|pswpout|pgalloc*|pgfree|pg*activ*|pg*fault)
      echo "metric ${HOSTNAME}.${STAT}.${WORDS[0]} uint64 ${WORDS[1]}"
      ;;
    *)
      true
      ;;
  esac

done < /proc/vmstat
