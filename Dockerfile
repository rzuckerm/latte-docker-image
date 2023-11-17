FROM openjdk:8-slim

COPY LATTE_* /tmp/
RUN apt-get update && \
    apt-get install -y git wget unzip python2.7 python-is-python2 && \
    wget https://services.gradle.org/distributions/gradle-2.12-bin.zip -O /tmp/gradle.zip && \
    cd /usr/local && \
    unzip /tmp/gradle.zip && \
    rm -f /tmp/gradle.zip && \
    mkdir -p /opt && \
    cd /opt && \
    git clone https://github.com/seanpm2001/Wkgcass_Latte-Lang -b $(cat /tmp/LATTE_VERSION) && \
    cd Wkgcass_Latte-Lang && \
    sed -i 's/java version/openjdk version/' build.py && \
    PATH=/usr/local/gradle-2.12/bin:$PATH ./build.py && \
    cp -p build/latte-$(cat /tmp/LATTE_VERSION)-ALPHA/bin/* /usr/local/bin/ && \
    cp -p build/latte-$(cat /tmp/LATTE_VERSION)-ALPHA/lib/* /usr/local/lib/ && \
    apt-get remove -y wget unzip python2.7 python-is-python2 && \
    apt-get autoremove -y && \
    apt-get clean && \
    rm -rf /usr/local/gradle-2.12 /opt/Wkgcass_Latte-Lang /var/lib/apt/lists/*
