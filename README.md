# Rsync Docker

[![rsync-docker](https://github.com/qdm12/rsync-docker/raw/master/title.png)](https://hub.docker.com/r/qmcgaw/rsync)

[![Docker Build Status](https://img.shields.io/docker/cloud/build/qmcgaw/rsync.svg)](https://hub.docker.com/r/qmcgaw/rsync)
[![Docker Pulls](https://img.shields.io/docker/pulls/qmcgaw/rsync.svg)](https://hub.docker.com/r/qmcgaw/rsync)
[![Docker Stars](https://img.shields.io/docker/stars/qmcgaw/rsync.svg)](https://hub.docker.com/r/qmcgaw/rsync)
[![Docker Automated](https://img.shields.io/docker/cloud/automated/qmcgaw/rsync.svg)](https://hub.docker.com/r/qmcgaw/rsync)

[![GitHub last commit](https://img.shields.io/github/last-commit/qdm12/rsync-docker.svg)](https://github.com/qdm12/rsync-docker/issues)
[![GitHub commit activity](https://img.shields.io/github/commit-activity/y/qdm12/rsync-docker.svg)](https://github.com/qdm12/rsync-docker/issues)
[![GitHub issues](https://img.shields.io/github/issues/qdm12/rsync-docker.svg)](https://github.com/qdm12/rsync-docker/issues)

All Rsync are version 3.1.3, built from source with this [Dockerfile](https://github.com/qdm12/rsync-docker/blob/master/Dockerfile)

- `qmcgaw/rsync`: Rsync only
    - Tiny **790KB** Docker image
    - [Readme](https://github.com/qdm12/rsync-docker/tree/master/rsync)
- `qmcgaw/rsync:ssh-client`: Rsync with SSH client
    - *12.2MB* Docker image
    - [Readme](https://github.com/qdm12/rsync-docker/tree/master/rsync-ssh-client)
- `qmcgaw/rsync:ssh-server`: Rsync with SSH server
    - *13.3MB* Docker image
    - [Readme](https://github.com/qdm12/rsync-docker/tree/master/rsync-ssh-server)

## TODOs

1. Run without root
    1. Fix bind mounted file permissions with Gosu, see [fixing permissions for Docker](http://gianluca.dellavedova.org/2018/09/04/fixing-permissions-for-docker/)
    1. Create home directories etc. of non root users for the ssh-server variant
1. More examples
1. Periodic execution of Rsync SSH client
    - With Golang binary, or with crontab
1. SSH server with passwords
1. Healthcheck

## License

This repository is under an [MIT license](https://github.com/qdm12/rsync-docker/master/license)
