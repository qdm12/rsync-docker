ARG ALPINE_VERSION=3.10
ARG BASE_IMAGE=alpine

FROM ${BASE_IMAGE}:${ALPINE_VERSION} AS build
ARG RSYNC_VERSION=3.1.3
WORKDIR /rsync
RUN apk --update --no-cache --progress -q add ca-certificates perl make automake autoconf build-base
RUN wget -q https://download.samba.org/pub/rsync/src/rsync-${RSYNC_VERSION}.tar.gz && \
    tar -xzf rsync-${RSYNC_VERSION}.tar.gz --strip-components=1 && \
    rm rsync-${RSYNC_VERSION}.tar.gz
RUN ./prepare-source && ./configure CFLAGS="-static"
RUN make && strip rsync

FROM scratch AS latest
ARG BUILD_DATE
ARG VCS_REF
ARG RSYNC_VERSION=3.1.3
LABEL \
    org.opencontainers.image.authors="quentin.mcgaw@gmail.com" \
    org.opencontainers.image.created=$BUILD_DATE \
    org.opencontainers.image.version=$RSYNC_VERSION \
    org.opencontainers.image.revision=$VCS_REF \
    org.opencontainers.image.url="https://github.com/qdm12/rsync-docker" \
    org.opencontainers.image.documentation="https://github.com/qdm12/rsync-docker/blob/master/README.md" \
    org.opencontainers.image.source="https://github.com/qdm12/rsync-docker" \
    org.opencontainers.image.title="rsync" \
    org.opencontainers.image.description="Rsync only in 790KB Docker image" \
    image-size="0.8MB"
COPY --from=build /rsync/rsync /rsync
ENTRYPOINT ["/rsync"]
CMD ["--help"]

FROM ${BASE_IMAGE}:${ALPINE_VERSION} AS base
ARG BUILD_DATE
ARG VCS_REF
ARG RSYNC_VERSION=3.1.3
LABEL \
    org.opencontainers.image.authors="quentin.mcgaw@gmail.com" \
    org.opencontainers.image.created=$BUILD_DATE \
    org.opencontainers.image.version=$RSYNC_VERSION \
    org.opencontainers.image.revision=$VCS_REF \
    org.opencontainers.image.url="https://github.com/qdm12/rsync-docker" \
    org.opencontainers.image.documentation="https://github.com/qdm12/rsync-docker/blob/master/README.md" \
    org.opencontainers.image.source="https://github.com/qdm12/rsync-docker"

FROM base AS ssh-client
LABEL \
    org.opencontainers.image.title="Rsync SSH Client" \
    org.opencontainers.image.description="Rsync with SSH client in 12.5MB Docker image" \
    image-size="12.5MB"
RUN apk --update --no-cache --progress -q add openssh-client inotify-tools && \
    rm  -rf /tmp/* /var/cache/apk/*
ENTRYPOINT ["/entrypoint.sh"]
COPY --from=build /rsync/rsync /usr/bin/rsync
ENV STRICT_HOST_KEY_CHECKING=no \
    WATCHDIR= \
    SYNCPERIOD= \
    LOG=on
CMD ["--help"]
COPY rsync-ssh-client/entrypoint.sh /entrypoint.sh
RUN chmod 500 /entrypoint.sh

FROM base AS ssh-server
LABEL \
    org.opencontainers.image.title="Rsync SSH server" \
    org.opencontainers.image.description="Rsync with SSH server in 13.4MB Docker image" \
    image-size="13.4MB"
RUN apk --update --no-cache --progress -q add openssh && \
    rm  -rf /tmp/* /var/cache/apk/* /etc/ssh/ssh_host_*key* /etc/ssh/ssh_config /etc/ssh/sshd_config && \
    touch /etc/banner && \
    echo $'\
    Protocol 2\n\
    HostKey /etc/ssh/ssh_host_ed25519_key\n\
    HostKey /etc/ssh/ssh_host_rsa_key\n\
    HostKey /etc/ssh/ssh_host_ecdsa_key\n\
    Port 22\n\
    PermitRootLogin without-password\n\
    PubkeyAuthentication yes\n\
    PasswordAuthentication no\n\
    PermitTunnel yes\n\
    AllowTcpForwarding yes\n\
    X11Forwarding no\n\
    AllowStreamLocalForwarding no\n\
    Banner /etc/banner\n\
    UseDNS no\n\
    Compression delayed\n\
    LogLevel VERBOSE\n' > /etc/ssh/sshd_config
EXPOSE 22
ENTRYPOINT ["/entrypoint.sh"]
COPY --from=build /rsync/rsync /usr/bin/rsync
ENV LOG=on
COPY rsync-ssh-server/entrypoint.sh /entrypoint.sh
RUN chmod 500 /entrypoint.sh