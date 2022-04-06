FROM ysicing/debian

LABEL maintainer="ysicing <i@ysicing.me>"

COPY ssh /root/.ssh

RUN set -x \
    && apt-get update \
    && apt-get install --no-install-recommends --no-install-suggests -y apt-transport-https ca-certificates procps curl wget git git-lfs nano openssh-client \
    && rm -rf /var/lib/apt/lists/* \
    && mkdir /code && \
    chmod 400 /root/.ssh/Jarvisbot*

WORKDIR /code

COPY entrypoint.sh /entrypoint.sh

RUN chmod +x /entrypoint.sh

ENTRYPOINT [ "/entrypoint.sh" ]