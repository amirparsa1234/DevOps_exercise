#!/usr/bin/env bash
set -e

echo "FTP client test"

echo "1) List ftp.ubuntu.com (first 30 lines)"
curl -s ftp://ftp.ubuntu.com/ | head -n 30 > ftp_list.txt || true
echo "Saved: ftp_list.txt"

echo "2) Download a file with wget"
wget -q -O ubuntu_readme.txt ftp://ftp.ubuntu.com/ubuntu/README 2> wget_error.txt || true
echo "Saved: ubuntu_readme.txt"
echo "If download failed: check wget_error.txt"

echo "3) Upload example (needs your own FTP server)"
echo 'curl -u user:pass -T file.txt ftp://your-server/path/file.txt'

echo "Done"
