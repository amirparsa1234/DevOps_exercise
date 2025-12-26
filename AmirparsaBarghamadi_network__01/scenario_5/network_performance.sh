#!/bin/bash

echo "bandwidth tcp iperf3" > performance_report.txt
iperf3 -s -D >> performance_report.txt 2>&1
iperf3 -c 127.0.0.1 -t 10 >> performance_report.txt 2>&1

echo "" >> performance_report.txt
echo "latency jitter packet loss ping" >> performance_report.txt
ping -c 20 127.0.0.1 >> performance_report.txt 2>&1

echo "" >> performance_report.txt
echo "udp test jitter and packet loss iperf3" >> performance_report.txt
iperf3 -c 127.0.0.1 -u -b 100M -t 10 >> performance_report.txt 2>&1

pkill iperf3 >> performance_report.txt 2>&1
echo "saved in performance_report.txt" >> performance_report.txt

