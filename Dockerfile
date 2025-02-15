FROM ubuntu:20.04

RUN apt update && DEBIAN_FRONTEND=noninteractive TZ=Etc/UTC apt install -y wget build-essential git supervisor nlohmann-json3-dev mosquitto-dev libmosquitto-dev libsamplerate0-dev iaxmodem
ADD ./supervisor.conf /app/supervisor.conf

ADD ./build.sh /workdir/build.sh
ADD ./run.sh /app/run.sh

RUN chmod u+x /workdir/build.sh
RUN chmod u+x /app/run.sh

RUN cd /workdir/ && /workdir/build.sh

ENTRYPOINT /app/run.sh
