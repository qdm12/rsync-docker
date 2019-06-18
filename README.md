# Rsync Docker

[![rsync-docker](https://github.com/qdm12/rsync-docker/raw/master/title.png)](https://hub.docker.com/r/qmcgaw/rsync)

[![Docker Build Status](https://img.shields.io/docker/cloud/build/qmcgaw/rsync:ssh-client.svg)](https://hub.docker.com/r/qmcgaw/rsync)
[![Docker Pulls](https://img.shields.io/docker/pulls/qmcgaw/rsync.svg)](https://hub.docker.com/r/qmcgaw/rsync)
[![Docker Stars](https://img.shields.io/docker/stars/qmcgaw/rsync.svg)](https://hub.docker.com/r/qmcgaw/rsync)
[![Docker Automated](https://img.shields.io/docker/cloud/automated/qmcgaw/rsync.svg)](https://hub.docker.com/r/qmcgaw/rsync)

[![GitHub last commit](https://img.shields.io/github/last-commit/qdm12/rsync-docker.svg)](https://github.com/qdm12/rsync-docker/issues)
[![GitHub commit activity](https://img.shields.io/github/commit-activity/y/qdm12/rsync-docker.svg)](https://github.com/qdm12/rsync-docker/issues)
[![GitHub issues](https://img.shields.io/github/issues/qdm12/rsync-docker.svg)](https://github.com/qdm12/rsync-docker/issues)

All Rsync are version 3.1.3

- `qmcgaw/rsync`: Rsync only
    - Tiny **790KB** Docker image
    - [Readme](rsync)
- `qmcgaw/rsync:ssh-client`: Rsync with SSH client
    - Small *5.2MB* Docker image
    - [Readme](rsync)
- Rsync SSH server... *in progress*

## TODOs

- [ ] Rsync daemon with SSH server
- [ ] Examples
- [ ] Periodic executions with Golang binary
- [ ] Healthcheck
- [ ] Run without root (file permission issues)

## License

This repository is under an [MIT license](https://github.com/qdm12/rsync-docker/master/license)
