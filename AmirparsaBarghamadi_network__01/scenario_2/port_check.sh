#!/bin/bash


{
  echo "port 80 :"
  timeout 3 telnet localhost 80

  echo
  echo "port 22 :"
  timeout 3 telnet localhost 22

  echo
  echo "port 3306 "
  timeout 3 telnet localhost 3306
} > port_check_report.txt
