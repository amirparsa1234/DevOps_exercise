#!/usr/bin/env bash
cd "$(dirname "$0")"
set -e

echo "Network performance diagnosis" > network_performance_diagnosis.txt
date >> network_performance_diagnosis.txt
echo "" >> network_performance_diagnosis.txt

echo "Ping 8.8.8.8 (10)" >> network_performance_diagnosis.txt
ping -c 10 8.8.8.8 >> network_performance_diagnosis.txt 2>&1 || true
echo "" >> network_performance_diagnosis.txt

echo "Ping 1.1.1.1 (10)" >> network_performance_diagnosis.txt
ping -c 10 1.1.1.1 >> network_performance_diagnosis.txt 2>&1 || true
echo "" >> network_performance_diagnosis.txt

echo "DNS test (dig google.com)" >> network_performance_diagnosis.txt
if command -v dig >/dev/null 2>&1; then
  dig google.com >> network_performance_diagnosis.txt 2>&1 || true
else
  echo "dig not found: sudo apt install dnsutils" >> network_performance_diagnosis.txt
fi
echo "" >> network_performance_diagnosis.txt

echo "Routes" >> network_performance_diagnosis.txt
ip route >> network_performance_diagnosis.txt 2>&1 || true
echo "" >> network_performance_diagnosis.txt

echo "Interfaces" >> network_performance_diagnosis.txt
ip -br addr >> network_performance_diagnosis.txt 2>&1 || true
echo "" >> network_performance_diagnosis.txt

echo "MTU quick check (may fail)" >> network_performance_diagnosis.txt
ping -c 2 -M do -s 1472 8.8.8.8 >> network_performance_diagnosis.txt 2>&1 || true
echo "" >> network_performance_diagnosis.txt

echo "Traceroute 8.8.8.8 (if available)" >> network_performance_diagnosis.txt
if command -v traceroute >/dev/null 2>&1; then
  traceroute -m 10 8.8.8.8 >> network_performance_diagnosis.txt 2>&1 || true
else
  echo "traceroute not found: sudo apt install traceroute" >> network_performance_diagnosis.txt
fi
echo "" >> network_performance_diagnosis.txt

echo "Done" >> network_performance_diagnosis.txt
