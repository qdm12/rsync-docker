ARG ALPINE_VERSION=3.10
ARG BASE_IMAGE=alpine

FROM ${BASE_IMAGE}:${ALPINE_VERSION}
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
    org.opencontainers.image.title="Rsync SSH Client" \
    org.opencontainers.image.description="Rsync with SSH client in 12.5MB Docker image" \
    image-size="12.5MB"
RUN apk --update --no-cache --progress -q add openssh-client inotify-tools && \
    rm  -rf /tmp/* /var/cache/apk/*
ENV STRICT_HOST_KEY_CHECKING=no \
    WATCHDIR= \
    SYNCPERIOD= \
    LOG=on
COPY --from=qmcgaw/rsync:builder /rsync/rsync /usr/bin/rsync
ENTRYPOINT ["/entrypoint.sh"]
CMD ["--help"]
COPY entrypoint.sh /entrypoint.sh
RUN chmod 500 /entrypoint.sh