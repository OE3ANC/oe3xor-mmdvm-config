#!/bin/bash

echo "Loading latest release of xorctl"
wget -qO- https://github.com/OE3ANC/xorctl/releases/latest/download/xorctl-x86_64-unknown-linux-musl.tar.gz | tar xvz -C /app/
chmod +x /app/xorctl

echo "Starting supervisord..."
cd /app
supervisord -c /app/supervisor.conf
