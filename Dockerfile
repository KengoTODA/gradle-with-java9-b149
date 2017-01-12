FROM ubuntu:trusty

# refs http://www.webupd8.org/2015/02/install-oracle-java-9-in-ubuntu-linux.html
RUN apt-get update
RUN apt-get install -y software-properties-common python-software-properties

# refs http://askubuntu.com/a/190674
RUN echo oracle-java9-installer shared/accepted-oracle-license-v1-1 select true | debconf-set-selections

RUN add-apt-repository ppa:webupd8team/java && \
    apt-get update && \
    apt-get install -y --no-install-recommends oracle-java9-installer=9b149+9b149arm-1~webupd8~0 oracle-java9-set-default && \
    rm -rf /var/cache/oracle-jdk9-installer

# this was needless for Java9 b140, but necessary from Java9 b149
# refs http://stackoverflow.com/a/41265267/814928
ENV GRADLE_OPTS --add-opens java.base/java.lang=ALL-UNNAMED
