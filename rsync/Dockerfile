FROM scratch
ARG BUILD_DATE
ARG VCS_REF
ARG RSYNC_VERSION=3.1.3
LABEL org.label-schema.schema-version="1.0.0-rc1" \
    maintainer="quentin.mcgaw@gmail.com" \
    org.label-schema.build-date=$BUILD_DATE \
    org.label-schema.vcs-ref=$VCS_REF \
    org.label-schema.vcs-url="https://github.com/qdm12/rsync-docker" \
    org.label-schema.url="https://github.com/qdm12/rsync-docker" \
    org.label-schema.vcs-description="Rsync only in 790KB Docker image" \
    org.label-schema.vcs-usage="https://github.com/qdm12/rsync-docker/blob/master/README.md#setup" \
    org.label-schema.docker.cmd="docker run -it --rm qmcgaw/rsync --help" \
    org.label-schema.docker.cmd.devel="docker run -it --rm qmcgaw/rsync --help" \
    org.label-schema.docker.params="" \
    org.label-schema.version=${RSYNC_VERSION} \
    image-size="0.8MB" \
    ram-usage="?" \
    cpu-usage="Low"
VOLUME ["/source", "/destination"]
COPY --from=qmcgaw/rsync:builder /rsync/rsync /rsync
ENTRYPOINT ["/rsync"]
CMD ["--help"]
