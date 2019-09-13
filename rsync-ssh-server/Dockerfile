ARG ALPINE_VERSION=3.10
ARG BASE_IMAGE=alpine

FROM ${BASE_IMAGE}:${ALPINE_VERSION}
ARG BUILD_DATE
ARG VCS_REF
ARG RSYNC_VERSION=3.1.3
LABEL org.label-schema.schema-version="1.0.0-rc1" \
    maintainer="quentin.mcgaw@gmail.com" \
    org.label-schema.build-date=$BUILD_DATE \
    org.label-schema.vcs-ref=$VCS_REF \
    org.label-schema.vcs-url="https://github.com/qdm12/rsync-docker" \
    org.label-schema.url="https://github.com/qdm12/rsync-docker" \
    org.label-schema.vcs-description="Rsync with SSH client in 5.2MB Docker image" \
    org.label-schema.vcs-usage="https://github.com/qdm12/rsync-docker/blob/master/README.md" \
    org.label-schema.docker.cmd="docker run -it --rm qmcgaw/rsync:ssh-client" \
    org.label-schema.docker.cmd.devel="docker run -it --rm qmcgaw/rsync:ssh-client" \
    org.label-schema.docker.params="" \
    org.label-schema.version=${RSYNC_VERSION} \
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
COPY --from=qmcgaw/rsync:builder /rsync/rsync /usr/bin/rsync
ENV LOG=on
COPY entrypoint.sh /entrypoint.sh
RUN chmod 500 /entrypoint.sh
