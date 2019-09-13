FROM scratch
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
VOLUME ["/source", "/destination"]
COPY --from=qmcgaw/rsync:builder /rsync/rsync /rsync
ENTRYPOINT ["/rsync"]
CMD ["--help"]
