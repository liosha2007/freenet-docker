FROM arm32v7/ubuntu:18.04

LABEL maintainer="liosha (using config of Tobias Vollmer <info+docker@tvollmer.de> as source)"

# Build argument (e.g. "build01497")
ARG freenet_build

ENV allowedhosts=172.17.0.0/24,127.0.0.1,0:0:0:0:0:0:0:1
ENV darknetport=12345
ENV opennetport=12346
ENV FRED_HOME=/home/fred

EXPOSE 8888 9481 ${darknetport}/udp ${opennetport}/udp

CMD ["sh", "-c", "$FRED_HOME/docker-run.sh"]

HEALTHCHECK --interval=5m --timeout=3s CMD $FRED_HOME/run.sh status || exit 1

RUN apt-get update \
	&& apt-get install -y apt-utils openssl binutils openjdk-11-jre \
    && ln -s /lib /lib64

ENV JAVA_HOME /usr/lib/jvm/java-11-openjdk-armhf

RUN \
    mkdir -p $FRED_HOME/conf $FRED_HOME/data \
    && groupadd -g 1000 fredg \
    && useradd -u 1000 -g fredg -m -d $FRED_HOME fred \
    && chown -Rc fred:fredg $FRED_HOME \
    && chmod -Rc 700 $FRED_HOME \
    && chmod +x freenet-run.sh

WORKDIR $FRED_HOME

COPY ./freenet-build-image/default-freenet.ini default-freenet.ini
COPY ./freenet-build-image/freenet-run.sh freenet-run.sh
COPY ./freenet-build-image/docker-run.sh docker-run.sh
COPY ./freenet-build-image/new_installer_offline_1497.jar /tmp/new_installer.jar
COPY ./freenet-build-image/install_options.conf /tmp/install_options.conf

VOLUME ["$FRED_HOME/conf", "$FRED_HOME/data"]

USER fred:fredg

RUN cat /tmp/install_options.conf \
    && java -DDEBUG=true -jar /tmp/new_installer.jar -debug -trace -options /tmp/install_options.conf \
    && sed -i "s#wrapper.app.parameter.1=freenet.ini#wrapper.app.parameter.1=$FRED_HOME/conf/freenet.ini#" $FRED_HOME/wrapper.conf \
    && rm /tmp/new_installer.jar /tmp/install_options.conf \
    && echo "Build successful" \
    && echo "----------------" \
    && cat $FRED_HOME/wrapper.conf \
    && cat $FRED_HOME/buildinfo.json

USER root

RUN chmod 700 $FRED_HOME/docker-run.sh $FRED_HOME/freenet-run.sh $FRED_HOME/run.sh
