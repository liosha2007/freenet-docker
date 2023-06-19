FROM arm32v7/ubuntu:18.04

LABEL maintainer="liosha (using config of Tobias Vollmer <info+docker@tvollmer.de> as source)"

# Freenet v01497

ENV allowedhosts=172.17.0.0/24,127.0.0.1,0:0:0:0:0:0:0:1
ENV darknetport=12345
ENV opennetport=12346
ENV FRED_HOME=/home/fred

EXPOSE 8888 9481 ${darknetport}/udp ${opennetport}/udp

CMD ["sh", "-c", "$FRED_HOME/docker-run.sh"]

HEALTHCHECK --interval=5m --timeout=3s CMD $FRED_HOME/run.sh status || exit 1

USER root

RUN apt-get update \
	&& apt-get install -y sudo cron binutils openjdk-11-jre \
    && ln -s /lib /lib64

ENV JAVA_HOME /usr/lib/jvm/java-11-openjdk-armhf

RUN groupadd -g 1000 fredg \
    && useradd -u 1000 -g fredg -m -d $FRED_HOME fred \
    && mkdir -p $FRED_HOME/conf $FRED_HOME/data $FRED_HOME/data/logs

WORKDIR $FRED_HOME

COPY ./build-image/default-freenet.ini default-freenet.ini
COPY ./build-image/freenet-run.sh freenet-run.sh
COPY ./build-image/docker-run.sh docker-run.sh
COPY ./build-image/new_installer_offline_1497.jar /tmp/new_installer.jar
COPY ./build-image/install_options.conf /tmp/install_options.conf

VOLUME ["$FRED_HOME/conf", "$FRED_HOME/data"]

USER fred:fredg

RUN cat /tmp/install_options.conf \
    && java -DDEBUG=true -jar /tmp/new_installer.jar -debug -trace -options /tmp/install_options.conf \
    && sed -i "s#wrapper.app.parameter.1=freenet.ini#wrapper.app.parameter.1=$FRED_HOME/conf/freenet.ini#" $FRED_HOME/wrapper.conf \
    && rm $FRED_HOME/freenet.ini \
    && cat $FRED_HOME/wrapper.conf

USER root

RUN rm /tmp/new_installer.jar /tmp/install_options.conf \
    && echo "Build successful" \
    && echo "----------------" \
    && ln $FRED_HOME/bin/wrapper-linux-armhf-32 $FRED_HOME/bin/wrapper \
    && chmod -c 774 $FRED_HOME/docker-run.sh
