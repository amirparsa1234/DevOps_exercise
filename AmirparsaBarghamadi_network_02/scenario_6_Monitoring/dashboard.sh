#!/usr/bin/env bash
set -e

IFACE="$(ip route get 1.1.1.1 2>/dev/null | awk '{for(i=1;i<=NF;i++) if($i=="dev"){print $(i+1); exit}}')"
[ -n "$IFACE" ] || IFACE="eth0"

while true
do
  clear
  echo "Simple monitoring dashboard"
  echo "Interface: $IFACE"
  echo ""

  rx1="$(awk -v i="$IFACE" '$0 ~ i ":" {gsub(":","",$1); print $2}' /proc/net/dev | head -n 1)"
  tx1="$(awk -v i="$IFACE" '$0 ~ i ":" {gsub(":","",$1); print $10}' /proc/net/dev | head -n 1)"
  sleep 1
  rx2="$(awk -v i="$IFACE" '$0 ~ i ":" {gsub(":","",$1); print $2}' /proc/net/dev | head -n 1)"
  tx2="$(awk -v i="$IFACE" '$0 ~ i ":" {gsub(":","",$1); print $10}' /proc/net/dev | head -n 1)"

  echo "Bandwidth (bytes/sec, approx):"
  echo "  RX: $((rx2 - rx1))"
  echo "  TX: $((tx2 - tx1))"
  echo ""

  echo "Active connections:"
  ss -ntuH | wc -l || true
  echo ""

  echo "Top 5 remote IPs (by connection count):"
  ss -ntuH | awk '{split($5,a,":"); print a[1]}' | sort | uniq -c | sort -nr | head -n 5 || true
  echo ""

  echo "Listening ports:"
  ss -lntu || true
  echo ""
  echo "Refresh in 5s (Ctrl+C to stop)"
  sleep 5
done
