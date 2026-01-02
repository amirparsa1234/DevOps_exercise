#!/usr/bin/env bash
set -e
cd "$(dirname "$0")"

: > http_methods_report.txt

echo "HTTP methods test report" >> http_methods_report.txt
date >> http_methods_report.txt
echo "" >> http_methods_report.txt

echo "GET (jsonplaceholder)" >> http_methods_report.txt
curl --connect-timeout 5 --max-time 15 -i -X GET https://jsonplaceholder.typicode.com/posts/1 >> http_methods_report.txt 2>&1
echo "" >> http_methods_report.txt

echo "POST (jsonplaceholder)" >> http_methods_report.txt
curl --connect-timeout 5 --max-time 15 -i -X POST https://jsonplaceholder.typicode.com/posts \
  -H "Content-Type: application/json" \
  -d '{"title":"test","body":"content","userId":1}' >> http_methods_report.txt 2>&1
echo "" >> http_methods_report.txt

echo "PUT (jsonplaceholder)" >> http_methods_report.txt
curl --connect-timeout 5 --max-time 15 -i -X PUT https://jsonplaceholder.typicode.com/posts/1 \
  -H "Content-Type: application/json" \
  -d '{"id":1,"title":"updated","body":"new","userId":1}' >> http_methods_report.txt 2>&1
echo "" >> http_methods_report.txt

echo "DELETE (jsonplaceholder)" >> http_methods_report.txt
curl --connect-timeout 5 --max-time 15 -i -X DELETE https://jsonplaceholder.typicode.com/posts/1 >> http_methods_report.txt 2>&1
echo "" >> http_methods_report.txt

echo "Response code checks" >> http_methods_report.txt
echo "200 from jsonplaceholder:" >> http_methods_report.txt
curl -s -o /dev/null -w "%{http_code}\n" https://jsonplaceholder.typicode.com/posts/1 >> http_methods_report.txt 2>&1

echo "404 example (jsonplaceholder unknown path):" >> http_methods_report.txt
curl -s -o /dev/null -w "%{http_code}\n" https://jsonplaceholder.typicode.com/no_such_path >> http_methods_report.txt 2>&1

echo "500 example (httpstat.us):" >> http_methods_report.txt
curl -s -o /dev/null -w "%{http_code}\n" https://httpstat.us/500 >> http_methods_report.txt 2>&1

echo "" >> http_methods_report.txt
echo "Done" >> http_methods_report.txt
