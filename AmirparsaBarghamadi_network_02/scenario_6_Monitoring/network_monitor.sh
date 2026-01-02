#!/usr/bin/env bash
cd "$(dirname "$0")"
set -e

IFACE="$(ip route get 1.1.1.1 2>/dev/null | awk '{for(i=1;i<=NF;i++) if($i=="dev"){print $(i+1); exit}}')"
[ -n "$IFACE" ] || IFACE="eth0"

echo "Monitoring interface: $IFACE"
echo "Writing to: monitoring_log.txt"
echo "Stop with Ctrl+C"

while true
do
  echo "-----" >> monitoring_log.txt
  date >> monitoring_log.txt

  rx1="$(awk -v i="$IFACE" '$0 ~ i ":" {gsub(":","",$1); print $2}' /proc/net/dev | head -n 1)"
  tx1="$(awk -v i="$IFACE" '$0 ~ i ":" {gsub(":","",$1); print $10}' /proc/net/dev | head -n 1)"
  sleep 5
  rx2="$(awk -v i="$IFACE" '$0 ~ i ":" {gsub(":","",$1); print $2}' /proc/net/dev | head -n 1)"
  tx2="$(awk -v i="$IFACE" '$0 ~ i ":" {gsub(":","",$1); print $10}' /proc/net/dev | head -n 1)"

  rx_rate="$(( (rx2 - rx1) / 5 ))"
  tx_rate="$(( (tx2 - tx1) / 5 ))"

  echo "Interface stats:" >> monitoring_log.txt
  ip -s link show "$IFACE" >> monitoring_log.txt 2>&1 || true

  echo "Bandwidth (bytes/sec, approx):" >> monitoring_log.txt
  echo "  RX: $rx_rate" >> monitoring_log.txt
  echo "  TX: $tx_rate" >> monitoring_log.txt

  echo "Active connections:" >> monitoring_log.txt
  ss -ntuH | wc -l >> monitoring_log.txt 2>&1 || true

  echo "Top 5 remote IPs (by connection count):" >> monitoring_log.txt
  ss -ntuH | awk '{split($5,a,":"); print a[1]}' | sort | uniq -c | sort -nr | head -n 5 >> monitoring_log.txt 2>&1 || true

  echo "" >> monitoring_log.txt
done
