FROM ubuntu:14.04
RUN apt-get update && apt-get install -y \
    git \
    vim \
    nodejs \
    npm \
    libkrb5-dev \
    libssl-dev

RUN apt-get install -y libssh-dev

RUN mkdir /opt/dev && cd /opt/dev && git clone https://github.com/freenetconf/testconf.git testconf
RUN sudo ln -sf /usr/bin/nodejs /usr/bin/node
RUN cd /opt/dev/testconf && npm install

RUN sed -i "s/config.netconf.host = '127.0.0.1'/config.netconf.host = 'sysrepo'/" /opt/dev/testconf/core/config.js
RUN sed -i "s/config.netconf.port = 830/config.netconf.port = 6001/" /opt/dev/testconf/core/config.js

CMD ["node", "/opt/dev/testconf/netconf_client/test_interactive.js"]
