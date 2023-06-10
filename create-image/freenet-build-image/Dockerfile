FROM openjdk:12-alpine

LABEL maintainer="liosha (using config of Tobias Vollmer <info+docker@tvollmer.de> as source)"

# Build argument (e.g. "build01497")
ARG freenet_build

# Runtime arguments
ENV allowedhosts=172.17.0.0/24,127.0.0.1,0:0:0:0:0:0:0:1
ENV darknetport=12345
ENV opennetport=12346
ENV FRED_HOME=/home/fred

# Interfaces
EXPOSE 8888 9481 ${darknetport}/udp ${opennetport}/udp

# Command to run on start of the container. It is run by the root user to fix access rights of mounted /conf and /data directories
CMD ["sh", "-c", "$FRED_HOME/docker-run.sh"]

# Check every 5 minutes if Freenet is still running
HEALTHCHECK --interval=5m --timeout=3s CMD $FRED_HOME/run.sh status || exit 1

# Install glibc
RUN apk update \
    && apk add curl ca-certificates \
    && curl -sLO https://github.com/sgerrand/alpine-pkg-glibc/releases/download/2.34-r0/glibc-2.34-r0.apk \
    && apk add --allow-untrusted glibc-2.34-r0.apk \
    && echo "export LANG=en_US.UTF-8" > /etc/profile.d/locale.sh \
    && rm -f glibc-2.34-r0.apk

# Install necessary packages
RUN apk add --update openssl su-exec && ln -s /lib /lib64

### Prepare user to run Freenet

RUN \
    # Create directories for config and Freenet data
    mkdir -p $FRED_HOME/conf $FRED_HOME/data \
    # Add group with GID 1000 and name 'fredg'
    && addgroup -g 1000 fredg \
    # Add user 'fred' with UID 1000, disable password, assign it to group 'fredg', and create the home directory '/fred'
    && adduser -D -u 1000 -G fredg -h $FRED_HOME fred \
    # Make the 'fredg' group the owner of the specified directories recursively
    && chown -Rc fred:fredg $FRED_HOME \
    # Assign appropriate permissions: read, write, and execute for the user and group; read and execute for others
    && chmod -Rc 700 $FRED_HOME

### Prepare files for Freenet installation

# Switch to the 'fred' user
USER fred:fredg

WORKDIR $FRED_HOME
VOLUME ["$FRED_HOME/conf", "$FRED_HOME/data"]

COPY ./freenet-build-image/default-freenet.ini $FRED_HOME/
# Script to run Freenet, will be executed by 'docker-run.sh' using the 'fred' user
COPY ./freenet-build-image/freenet-run.sh $FRED_HOME/
# Script to fix access rights of /conf and /data directories in case they are mounted (addressing potential problems on Windows)
COPY ./freenet-build-image/docker-run.sh $FRED_HOME/

# Get the latest Freenet build or use the supplied version
RUN build=$(test -n "${freenet_build}" && echo ${freenet_build} || wget -qO - https://api.github.com/repos/freenet/fred/releases/latest | grep 'tag_name' | cut -d'"' -f 4) \
    && short_build=$(echo ${build} | cut -c7-) \
    && echo -e "build: $build\nurl: https://github.com/freenet/fred/releases/download/$build/new_installer_offline_$short_build.jar" > buildinfo.json \
    && echo "Building:" \
    && cat $FRED_HOME/buildinfo.json

# Download and install Freenet in the specified version
RUN wget -O /tmp/new_installer.jar $(grep url $FRED_HOME/buildinfo.json | cut -d" " -f2) \
    && echo -e "INSTALL_PATH=$FRED_HOME/\nDEBUG=true\nTRACE=true" >/tmp/install_options.conf \
    && cat /tmp/install_options.conf \
    && id \
    && ls -la $FRED_HOME/ \
    && java -version \
    && java -DDEBUG=true -jar /tmp/new_installer.jar -debug -trace -options /tmp/install_options.conf \
    && sed -i "s#wrapper.app.parameter.1=freenet.ini#wrapper.app.parameter.1=$FRED_HOME/conf/freenet.ini#" $FRED_HOME/wrapper.conf \
    && rm /tmp/new_installer.jar /tmp/install_options.conf \
    && echo "Build successful" \
    && echo "----------------" \
    && cat $FRED_HOME/buildinfo.json

# The script 'docker-run.sh' inside the container should be executed by the root user to fix problems with access rights, while Freenet itself will be run by 'fred'
USER root

RUN chmod 700 $FRED_HOME/docker-run.sh $FRED_HOME/freenet-run.sh $FRED_HOME/run.sh
