FROM ubuntu:20.04

RUN apt update && apt install -y build-essential git supervisor

ADD ./supervisor.conf /app/supervisor.conf

ADD ./build.sh /workdir/build.sh
ADD ./run.sh /app/run.sh

RUN chmod u+x /workdir/build.sh
RUN chmod u+x /app/run.sh


RUN ls -hal /workdir/build.sh && /workdir/build.sh

ENTRYPOINT /app/run.sh
