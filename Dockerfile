FROM ruby:2.4.3

ENV DEBIAN_FRONTED=noninteractive

# Need to add the "force-yes" since the debian jessian gpg keys was expired
RUN apt-get update && apt-get install -y --force-yes \
  sudo \
  build-essential \
  ruby-dev \
  postgresql-client \
  libopencv-dev=2.4.9.1+dfsg-1+deb8u2 \
  libcanberra-gtk-module libcanberra-gtk3-module libatk-adaptor libgail-common \
  && apt-get clean \
  && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# ADD an user
RUN adduser --disabled-password --gecos '' devel \
  && usermod -a -G sudo devel \
  && echo '%sudo ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers \
  && echo 'devel:devel' | chpasswd

ENV HOME=/home/devel
ENV APP=/var/www/app
ENV BUNDLE_PATH=/bundle/vendor
ENV GEM_HOME=${BUNDLE_PATH}
ENV PATH=${PATH}:${BUNDLE_PATH}/bin

ENV RAILS_LOG_TO_STDOUT true

RUN mkdir -p ${HOME} && \
  chown -R devel:devel ${HOME} && \
  mkdir -p ${APP} && \
  chown -R devel:devel ${APP} && \
  mkdir -p ${BUNDLE_PATH} && \
  chown -R devel:devel /bundle

USER devel:devel
WORKDIR $APP

RUN gem install ruby-opencv -v 0.0.18

EXPOSE 3000
