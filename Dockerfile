
FROM ubuntu:20.04
CMD [ "/sbin/init.sh" ]

ARG MTPROXY_VERSION
ENV MTPROXY_VERSION=${MTPROXY_VERSION:-dc0c7f3de40530053189c572936ae4fd1567269b}

ENV deps_buld=" \
    git \
    curl \
    build-essential \
    libssl-dev \
    zlib1g-dev \
"

RUN set -x \
  && export DEBIAN_FRONTEND=noninteractive \
  && apt-get update \
  && apt-get install -y \
    ${deps_buld} \
  && cd /opt/ \
  && curl -Ls https://github.com/TelegramMessenger/MTProxy/archive/${MTPROXY_VERSION}.tar.gz \
    | tar -xzf - \
  && cd MTProxy-${MTPROXY_VERSION} \
  && make \
  && install -m 744 objs/bin/mtproto-proxy /usr/local/bin/ \
  && apt-get autoremove -y \
    ${deps_buld}

COPY root/ /
