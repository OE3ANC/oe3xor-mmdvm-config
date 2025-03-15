#!/bin/bash

cd /workdir

# Clone MMDVMHost and gateway services
git clone https://github.com/g4klx/MMDVMHost.git
git clone https://github.com/g4klx/M17Gateway.git
git clone https://github.com/g4klx/FMGateway.git

# Build MMDVMHost
cd MMDVMHost
# Enable
sed -i 's/CFLAGS  = -g -O3 -Wall -std=c++0x -pthread -DHAVE_LOG_H -I\/usr\/local\/include/CFLAGS  = -g -O3 -Wall -std=c++0x -pthread -DHAVE_LOG_H -DHAS_SRC -I\/usr\/local\/include/' Makefile && \
sed -i 's/LIBS    = -lpthread -lutil/LIBS    = -lpthread -lutil -lsamplerate/' Makefile
cat Makefile
make -j8
cd ..

# Build M17Gateway
cd M17Gateway
git reset --hard 94b719e2294c762442d1e427bf959b4aeb516996 # Reverting to old version, latest in mqtt branch crashes
make -j8
cd ..

# Build FMGateway
cd FMGateway
sed -i 's/CFLAGS  = -g -O3 -Wall -pthread/CFLAGS  = -g -O3 -Wall -pthread -DHAS_SRC/' Makefile && \
sed -i 's/LIBS    = -lpthread -lmd/LIBS    = -lpthread -lmd -lsamplerate/' Makefile
cat Makefile
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

# Install SvxLink soundfiles
cd /usr/share/svxlink/sounds/
wget https://github.com/sm0svx/svxlink-sounds-en_US-heather/releases/download/24.02/svxlink-sounds-en_US-heather-16k-24.02.tar.bz2
tar xvjf svxlink-sounds-en_US-heather-16k-24.02.tar.bz2
ln -s en_US-heather-16k en_US
rm /usr/share/svxlink/sounds/svxlink-sounds-en_US-heather-16k-24.02.tar.bz2

ls -hal /app/mmdvm

cd / && rm -rf /workdir
