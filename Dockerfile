ARG ALPINE_VERSION=3.10
ARG BUILDER_IMAGE=alpine

FROM ${BUILDER_IMAGE}:${ALPINE_VERSION}
ARG RSYNC_VERSION=3.1.3
WORKDIR /rsync
RUN apk --update --no-cache --progress -q add ca-certificates perl make automake autoconf build-base
RUN wget -q https://download.samba.org/pub/rsync/src/rsync-${RSYNC_VERSION}.tar.gz && \
    tar -xzf rsync-${RSYNC_VERSION}.tar.gz --strip-components=1 && \
    rm rsync-${RSYNC_VERSION}.tar.gz
RUN ./prepare-source && ./configure CFLAGS="-static"
RUN make && strip rsync