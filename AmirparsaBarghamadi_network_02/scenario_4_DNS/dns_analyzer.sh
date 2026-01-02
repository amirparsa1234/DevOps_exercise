#!/usr/bin/env bash
set -e
cd "$(dirname "$0")"

: > dns_analysis_report.txt

echo "DNS analysis report (table)" >> dns_analysis_report.txt
date >> dns_analysis_report.txt
echo "" >> dns_analysis_report.txt

printf "%-18s | %-6s | %-16s | %-10s | %s\n" "DOMAIN" "TTL" "IP" "QTIME(ms)" "DNS_SERVER" >> dns_analysis_report.txt
printf "%-18s-+-%-6s-+-%-16s-+-%-10s-+-%s\n" "------------------" "------" "----------------" "----------" "----------------" >> dns_analysis_report.txt

for d in google.com github.com stackoverflow.com linkedin.com
do
  a_line="$(dig +noall +answer "$d" A | head -n 1)"
  ttl="$(echo "$a_line" | awk '{print $2}')"
  ip="$(echo "$a_line" | awk '{print $5}')"

  dig_full="$(dig "$d" A)"
  qtime="$(echo "$dig_full" | grep -i "Query time" | awk '{print $4}' | head -n 1)"
  server="$(echo "$dig_full" | grep -i "SERVER:" | awk '{print $3}' | head -n 1)"
  server="${server%%#*}"

  printf "%-18s | %-6s | %-16s | %-10s | %s\n" "$d" "${ttl:-NA}" "${ip:-NA}" "${qtime:-NA}" "${server:-NA}" >> dns_analysis_report.txt
done

echo "" >> dns_analysis_report.txt
echo "Done" >> dns_analysis_report.txt
