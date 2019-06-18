ARG ALPINE_VERSION=3.9
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
    image-size="12.2MB" \
    ram-usage="Medium to High" \
    cpu-usage="Medium to High"
COPY --chown=1000 --from=qmcgaw/rsync:builder /rsync/rsync /rsync
RUN apk --update --no-cache --progress -q add openssh-client && \
    rm  -rf /tmp/* /var/cache/apk/*
RUN mkdir -p "/home/user/.ssh" && \
    adduser -D -u 1000 user && \
    echo "user:$(date +%s | sha256sum | base64 | head -c 32)" | chpasswd &> /dev/null
VOLUME ["/source", "/destination"]
USER 1000
ENTRYPOINT ["/rsync"]
CMD ["--help"]
