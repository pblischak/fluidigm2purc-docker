# Dockerfile for fluidigm2purc

FROM ubuntu

MAINTAINER Paul Blischak <blischak.4@osu.edu>

# Run update and then install C/C++ compilers and make
RUN apt-get update -qq \
  && apt-get install gcc \
                     g++ \
                     make \
                     git \
                     wget \
                     autotools \
                     default-jre \
                     default-jdk \
                     build-essential \
                     checkinstall \
                     libreadline-gplv2-dev \
                     libncursesw5-dev \
                     libssl-dev \
                     libsqlite3-dev \
                     tk-dev \
                     libgdbm-dev \
                     libc6-dev \
                     libbz2-dev

# Install Python 2.7
WORKDIR /tmp
RUN wget https://www.python.org/ftp/python/2.7.13/Python-2.7.13.tgz \
  && tar xzf Python-2.7.13.tgz \
  && cd Python-2.7.13 \
  && ./configure --prefix=/usr/local --enable-shared LDFLAGS="-Wl,--rpath=/usr/local/lib" \
  && make && make altinstall \
  && ln -sf python2.7 python

# Install Mafft
#WORKDIR /home
#RUN wget

# Install Phyutility
WORKDIR /home
RUN wget https://github.com/blackrim/phyutility/releases/download/v2.7.1/phyutility_2.7.1.tar.gz \
  && tar xzf phyutility_2.7.1.tar.gz \
  && cd phyutility \
  && echo 'java -Xmx2g -jar /home/phyutility/phyutility.jar $*' > /usr/local/bin/phyutility \
  && chmod +x /usr/local/bin/phyutility

# Clone and install fluidigm2purc
WORKDIR /home
RUN git clone https://github.com/pblischak/fluidigm2purc.git \
  && cd fluidigm2purc \
  && make && make install

# Remove cloned repository
WORKDIR /home
RUN rm -rf fluidigm2purc

WORKDIR /home
CMD bash
