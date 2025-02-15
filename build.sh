#!/bin/bash

cd /workdir

# Clone MMDVMHost and gateway services
git clone -b mqtt https://github.com/g4klx/MMDVMHost.git
git clone -b mqtt https://github.com/g4klx/M17Gateway.git
git clone https://github.com/g4klx/FMGateway.git # MQTT branch has a connection problem

# Build MMDVMHost
cd MMDVMHost
make -j8
cd ..

# Build M17Gateway
cd M17Gateway
git reset --hard 94b719e2294c762442d1e427bf959b4aeb516996 # Reverting to old version, latest in mqtt branch crashes
make -j8
cd ..

# Build FMGateway
cd FMGateway
make -j8
cd ..

# Create directories
mkdir -p /app/mmdvm/configs
mkdir -p /app/mmdvm/logs

# Copy binaries
cp MMDVMHost/MMDVMHost   /app/
cp M17Gateway/M17Gateway /app/
cp FMGateway/FMGateway  /app/

# cp M17Gateway/M17Hosts.txt /app/mmdvm/M17Hosts.txt
cp -r M17Gateway/Audio /app/mmdvm/

# Copy and rename config examples -> TODO replace log dirs
cp MMDVMHost/MMDVM.ini       /app/mmdvm/configs/MMDVM.ini.example
cp M17Gateway/M17Gateway.ini /app/mmdvm/configs/M17Gateway.ini.example
cp FMGateway/FMGateway.ini  /app/mmdvm/configs/FMGateway.ini.example


ls -hal /app/mmdvm

cd / && rm -rf /workdir
