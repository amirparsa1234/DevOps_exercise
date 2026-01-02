#!/usr/bin/env bash
set -e

echo "Start FTP setup"

echo "Update..."
sudo apt update -y

echo "Install vsftpd..."
sudo apt install -y vsftpd

echo "Make anonymous folder..."
sudo mkdir -p /srv/ftp/anonymous
sudo chmod -R 755 /srv/ftp/anonymous
echo "hello ftp" | sudo tee /srv/ftp/anonymous/README.txt >/dev/null

echo "Make user ftpuser..."
sudo useradd -m ftpuser 2>/dev/null || true
echo "Set password for ftpuser now"
sudo passwd ftpuser

echo "Copy config..."
sudo cp ./vsftpd.conf /etc/vsftpd.conf

echo "Restart service..."
sudo systemctl restart vsftpd

echo "Show status..."
sudo systemctl status vsftpd --no-pager || true

echo "Done"
echo "Commands:"
echo "  sudo systemctl start vsftpd"
echo "  sudo systemctl stop vsftpd"
echo "  sudo systemctl restart vsftpd"
