#!/bin/bash

echo "Downloading M17 Hostlist..."
curl 'http://www.dudetronics.com/ar-dns/M17Hosts.txt' 2>/dev/null > /app/mmdvm/M17Hosts.txt

echo "Starting supervisord..."
cd /app
supervisord -c /app/supervisor.conf
