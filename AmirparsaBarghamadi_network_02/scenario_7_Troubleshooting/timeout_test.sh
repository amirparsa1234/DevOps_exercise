#!/usr/bin/env bash
set -e

echo "Timeout test"

echo "Port test (10.255.255.1:22)"
if command -v nc >/dev/null 2>&1; then
  nc -zv -w 5 10.255.255.1 22 || true
else
  echo "nc not found: sudo apt install netcat-openbsd"
fi

echo "SSH timeout test"
timeout 5 ssh -o ConnectTimeout=5 user@10.255.255.1 2>/dev/null || true

echo "Done"
