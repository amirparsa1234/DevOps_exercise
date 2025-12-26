#!/bin/bash


echo "1 - more than 100 connections :" > security_report.txt
sudo netstat -ntu | awk '{print $5}' | cut -d: -f1 | sort | uniq -c | sort -nr | awk '$1>100' >> security_report.txt

echo "" >> security_report.txt
echo "2 -  SSH failed password :" >> security_report.txt
sudo grep "Failed password" /var/log/auth.log >> security_report.txt

echo "" >> security_report.txt
echo "3 - non ordinary ips :" >> security_report.txt
sudo netstat -ntu | awk '$4 ~ />10000/ {print $5, "->", $4}' >> security_report.txt

