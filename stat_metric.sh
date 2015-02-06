#!/bin/bash

HOSTNAME=${HOSTNAME:-$(hostname)}
HOSTNAME=$(echo ${HOSTNAME%.crowdrise.io} | perl -pe 's/(\d+)/\.\1/g')

read -r -d '' CPU <<'EOF'
-vP '^cpu\d+'
EOF

if [[ "$1" ]] && [[ $1 =~ ^[0-9]+$ ]]; then
  CPU="cpu$1"
fi


echo "status ok system on"

eval grep $CPU /proc/stat | while read LINE ; do

  read -a WORDS <<< "$LINE"

  case "${WORDS[0]}" in
    cpu*)
      echo "${WORDS[0]}.jiffies.user uint64 ${WORDS[1]} jiffies"
      echo "${WORDS[0]}.jiffies.nice uint64 ${WORDS[2]} jiffies"
      echo "${WORDS[0]}.jiffies.system uint64 ${WORDS[3]} jiffies"
      echo "${WORDS[0]}.jiffies.idle uint64 ${WORDS[4]} jiffies"
      echo "${WORDS[0]}.jiffies.iowait uint64 ${WORDS[5]} jiffies"
      echo "${WORDS[0]}.jiffies.irq uint64 ${WORDS[6]} jiffies"
      echo "${WORDS[0]}.jiffies.softirq uint64 ${WORDS[7]} jiffies"
      ;;
    intr*)
      echo "interrupts uint64 ${WORDS[1]} interrupts"
      ;;
    ctxt*)
      echo "context_switches uint64 ${WORDS[1]} ctxt"
      ;;
    btime*)
      echo "uptime uint64 "$(( $(date +%s) - ${WORDS[1]} ))" seconds"
      ;;
    processes*)
      echo "processes.total uint64 ${WORDS[1]} processes"
      ;;
    procs_running*)
      echo "processes.running uint64 ${WORDS[1]} processes"
      ;;
    procs_blocked*)
      echo "processes.blocked uint64 ${WORDS[1]} processes"
      ;;
    softirq*)
      echo "softirq uint64 ${WORDS[1]} softirqs"
      ;;
    *)
      true
      ;;
  esac

done | while read MLINE ; do 
  echo "metric ${HOSTNAME}.proc.${MLINE}"
done
