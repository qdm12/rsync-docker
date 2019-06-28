ARG ALPINE_VERSION=3.10
ARG BUILDER_IMAGE=alpine

FROM ${BUILDER_IMAGE}:${ALPINE_VERSION}
ARG RSYNC_VERSION=3.1.3
LABEL org.label-schema.schema-version="1.0.0-rc1" \
    maintainer="quentin.mcgaw@gmail.com" \
    org.label-schema.build-date=$BUILD_DATE \
    org.label-schema.vcs-ref=$VCS_REF \
    org.label-schema.vcs-url="https://github.com/qdm12/rsync-docker" \
    org.label-schema.url="https://github.com/qdm12/rsync-docker" \
    org.label-schema.vcs-description="Rsync builder Docker image" \
    org.label-schema.vcs-usage="https://github.com/qdm12/rsync-docker/blob/master/README.md" \
    org.label-schema.docker.cmd="docker run -it --rm qmcgaw/rsync:builder" \
    org.label-schema.docker.cmd.devel="docker run -it --rm qmcgaw/rsync:builder" \
    org.label-schema.docker.params="ALPINE_VERSION=3.9,BUILDER_IMAGE=alpine,RSYNC_VERSION=3.1.3" \
    org.label-schema.version=${RSYNC_VERSION} \
    image-size="?" \
    ram-usage="?" \
    cpu-usage="?"
WORKDIR /rsync
RUN apk --update --no-cache --progress -q add ca-certificates perl make automake autoconf build-base
RUN wget -q https://download.samba.org/pub/rsync/src/rsync-${RSYNC_VERSION}.tar.gz && \
    tar -xzf rsync-${RSYNC_VERSION}.tar.gz --strip-components=1 && \
    rm rsync-${RSYNC_VERSION}.tar.gz
RUN ./prepare-source && ./configure CFLAGS="-static"
RUN make && strip rsync