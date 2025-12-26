#!/bin/bash


{
  echo " ping 8.8.8.8 "
  ping -c 5 8.8.8.8

  echo
  echo " ping google.com "
  ping -c 5 google.com

  echo
  echo " DNS for github.con"
  nslookup github.com
} > connectivity_report.txt
