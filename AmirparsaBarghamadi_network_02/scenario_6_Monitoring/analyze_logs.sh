#!/usr/bin/env bash
set -e

cd "$(dirname "$0")"
: > log_analysis_report.txt

echo "Log analysis report" >> log_analysis_report.txt
date >> log_analysis_report.txt
echo "" >> log_analysis_report.txt

echo "Log files (if exist):" >> log_analysis_report.txt
ls -lh /var/log/syslog /var/log/kern.log /var/log/auth.log 2>/dev/null >> log_analysis_report.txt || true
echo "" >> log_analysis_report.txt

echo "Last 10 auth.log events:" >> log_analysis_report.txt
if [ -f /var/log/auth.log ]; then
  tail -n 10 /var/log/auth.log >> log_analysis_report.txt
else
  echo "No /var/log/auth.log found" >> log_analysis_report.txt
fi
echo "" >> log_analysis_report.txt

echo "Last 10 syslog events:" >> log_analysis_report.txt
if [ -f /var/log/syslog ]; then
  tail -n 10 /var/log/syslog >> log_analysis_report.txt
else
  echo "No /var/log/syslog found" >> log_analysis_report.txt
fi
echo "" >> log_analysis_report.txt

echo "Last 10 kern.log events:" >> log_analysis_report.txt
if [ -f /var/log/kern.log ]; then
  tail -n 10 /var/log/kern.log >> log_analysis_report.txt
else
  echo "No /var/log/kern.log found" >> log_analysis_report.txt
fi
echo "" >> log_analysis_report.txt

echo "Top IPs in auth.log (all IPs):" >> log_analysis_report.txt
if [ -f /var/log/auth.log ]; then
  grep -Eo '([0-9]{1,3}\.){3}[0-9]{1,3}' /var/log/auth.log | sort | uniq -c | sort -nr | head -n 10 >> log_analysis_report.txt || true
else
  echo "No auth.log to extract IPs" >> log_analysis_report.txt
fi
echo "" >> log_analysis_report.txt

echo "Failed password attempts (by IP):" >> log_analysis_report.txt
if [ -f /var/log/auth.log ]; then
  grep "Failed password" /var/log/auth.log | grep -Eo '([0-9]{1,3}\.){3}[0-9]{1,3}' \
    | sort | uniq -c | sort -nr | head -n 10 >> log_analysis_report.txt || true
else
  echo "No auth.log to grep" >> log_analysis_report.txt
fi
echo "" >> log_analysis_report.txt

echo "Done" >> log_analysis_report.txt
echo "OK"
