#!/bin/bash

echo "Starting supervisord..."
cd /app
supervisord -c /app/supervisor.conf
