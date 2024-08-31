#!/bin/bash

echo "Starting supervisord..."

supervisord -c /app/supervisor.conf
