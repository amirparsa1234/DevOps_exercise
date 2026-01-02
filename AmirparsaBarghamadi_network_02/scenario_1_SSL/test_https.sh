#!/usr/bin/env bash
set -e
cd "$(dirname "$0")"

: > https_test_report.txt

echo "HTTPS test report" >> https_test_report.txt
date >> https_test_report.txt
echo "" >> https_test_report.txt

echo "== Real HTTPS site (google.com) ==" >> https_test_report.txt
curl -I https://google.com >> https_test_report.txt 2>&1 || true
echo "" >> https_test_report.txt

echo "== TLS version / cipher (google.com) ==" >> https_test_report.txt
if command -v openssl >/dev/null 2>&1; then
  echo | openssl s_client -connect google.com:443 -servername google.com 2>/dev/null | grep -E "Protocol|Cipher" >> https_test_report.txt || true
else
  echo "openssl not found" >> https_test_report.txt
fi
echo "" >> https_test_report.txt

echo "== Certificate expiry dates (google.com) ==" >> https_test_report.txt
if command -v openssl >/dev/null 2>&1; then
  echo | openssl s_client -connect google.com:443 -servername google.com 2>/dev/null | openssl x509 -noout -dates >> https_test_report.txt || true
else
  echo "openssl not found" >> https_test_report.txt
fi
echo "" >> https_test_report.txt

echo "== Certificate chain (short) ==" >> https_test_report.txt
if command -v openssl >/dev/null 2>&1; then
  echo | openssl s_client -connect google.com:443 -servername google.com -showcerts 2>/dev/null | head -n 80 >> https_test_report.txt || true
else
  echo "openssl not found" >> https_test_report.txt
fi
echo "" >> https_test_report.txt

echo "Done" >> https_test_report.txt
