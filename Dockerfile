FROM ubuntu:saucy

RUN apt-get -y -qq update &&\
    apt-get install -y -q software-properties-common wget iptables &&\
    add-apt-repository -y ppa:chris-lea/node.js &&\
    wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | apt-key add - &&\
    echo "deb http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google.list &&\
    apt-get update -y &&\
    mkdir -p /usr/share/desktop-directories &&\
    apt-get install -y -q \
            google-chrome-stable \
            openjdk-7-jre-headless \
            nodejs \
            x11vnc \
            xvfb \
            xfonts-100dpi \
            xfonts-75dpi \
            xfonts-scalable \
            xfonts-cyrillic \
            &&\
    useradd -d /home/chromeuser -m chromeuser &&\
    mkdir -p /home/chromeuser/chrome &&\
    chown chromeuser /home/chromeuser/chrome &&\
    chgrp chromeuser /home/chromeuser/chrome &&\
    apt-get clean

RUN npm install -g selenium-standalone@4.2.2 &&\
    selenium-standalone install --version=2.45.0

ADD ./scripts/ /home/root/scripts

EXPOSE 4444 5999

ENTRYPOINT ["sh", "/home/root/scripts/start.sh"]
