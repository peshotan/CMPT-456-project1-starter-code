FROM openjdk:8-jdk

LABEL maintainer="Nguyen Cao \"nguyen_cao@sfu.ca\""
LABEL repository="https://csil-git1.cs.surrey.sfu.ca/nguyenc/lucene-solr.git"

# Installs Ant
ENV ANT_VERSION 1.10.8
RUN cd && \
    wget -q http://www.us.apache.org/dist//ant/binaries/apache-ant-${ANT_VERSION}-bin.tar.gz && \
    tar -xzf apache-ant-${ANT_VERSION}-bin.tar.gz && \
    mv apache-ant-${ANT_VERSION} /opt/ant && \
    rm apache-ant-${ANT_VERSION}-bin.tar.gz
ENV ANT_HOME /opt/ant
ENV PATH ${PATH}:/opt/ant/bin

# Compile Lucene
WORKDIR /lucene-solr
COPY . /lucene-solr
RUN ant ivy-bootstrap
RUN ant -f lucene/benchmark/build.xml
RUN ant compile
RUN ant -f lucene/demo/build.xml
