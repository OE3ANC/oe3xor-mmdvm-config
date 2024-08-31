#!/bin/bash

# Clone MMDVMHost and gateway services
git clone https://github.com/g4klx/MMDVMHost.git
git clone https://github.com/g4klx/YSFClients.git
git clone https://github.com/g4klx/M17Gateway.git

# Build MMDVMHost
cd MMDVMHost
make -j8
cd ..

# Build YSFClients
cd YSFClients
make -j8
cd ../..

# Build M17Gateway
cd M17Gateway
make -j8
cd ..

# Create directories
mkdir -p /app/mmdvm/configs

# Copy binaries
cp MMDVMHost/MMDVMHost   /app/mmdvm/
cp YSFClients/YSFGateway /app/mmdvm/
cp M17Gateway/M17Gateway /app/mmdvm/

# Copy and rename config examples
cp MMDVMHost/MMDVM.ini       /app/mmdvm/configs/MMDVM.ini.example
cp YSFClients/YSFGateway.ini /app/mmdvm/configs/YSFGateway.ini.example
cp M17Gateway/M17Gateway.ini /app/mmdvm/configs/M17Gateway.ini.example
