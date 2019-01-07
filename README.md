# Rsync Docker

- Rsync only, **790KB**, `qmcgaw/rsync`
- Rsync + SSH, *5.2MB*, `qmcgaw/rsync:ssh-client`

[![rsync-docker](https://github.com/qdm12/rsync-docker/raw/master/title.png)](https://hub.docker.com/r/qmcgaw/rsync)

[![GitHub last commit](https://img.shields.io/github/last-commit/qdm12/rsync-docker.svg)](https://github.com/qdm12/rsync-docker/issues)
[![GitHub commit activity](https://img.shields.io/github/commit-activity/y/qdm12/rsync-docker.svg)](https://github.com/qdm12/rsync-docker/issues)
[![GitHub issues](https://img.shields.io/github/issues/qdm12/rsync-docker.svg)](https://github.com/qdm12/rsync-docker/issues)

## Rsync only

[![Build Status](https://travis-ci.org/qdm12/rsync-docker.svg?branch=master)](https://travis-ci.org/qdm12/rsync-docker)
[![Docker Build Status](https://img.shields.io/docker/build/qmcgaw/rsync.svg)](https://hub.docker.com/r/qmcgaw/rsync)

[![Docker Pulls](https://img.shields.io/docker/pulls/qmcgaw/rsync.svg)](https://hub.docker.com/r/qmcgaw/rsync)
[![Docker Stars](https://img.shields.io/docker/stars/qmcgaw/rsync.svg)](https://hub.docker.com/r/qmcgaw/rsync)
[![Docker Automated](https://img.shields.io/docker/automated/qmcgaw/rsync.svg)](https://hub.docker.com/r/qmcgaw/rsync)

[![Image size](https://images.microbadger.com/badges/image/qmcgaw/rsync.svg)](https://microbadger.com/images/qmcgaw/rsync)
[![Image version](https://images.microbadger.com/badges/version/qmcgaw/rsync.svg)](https://microbadger.com/images/qmcgaw/rsync)

| Image size | RAM usage | CPU usage |
| --- | --- | --- |
| 790KB | ?MB | ? |

It is based on:

- [Scratch](https://hub.docker.com/_/scratch/)
- [Rsync 3.1.3 built statically from source](https://rsync.samba.org/)

In this image, rsync by default mirrors a source directory to a destination directory (with `--archive --compress --progress --delete /source/ /destination/`)

Use the following command:

```bash
docker run -d -v /dir1:/source:ro -v /dir2:/destination qmcgaw/rsync
```

or use [docker-compose.yml](https://github.com/qdm12/rsync-docker/blob/master/docker-compose.yml) with:

```bash
docker-compose up -d
```

You can change the arguments given to rsync with for example:

```bash
docker run -d -v /dir1:/source:ro -v /dir2:/destination qmcgaw/rsync --quiet /source/ /destination/
```

## Rsync + SSH Client

[![Build Status](https://travis-ci.org/qdm12/rsync-docker.svg?branch=master)](https://travis-ci.org/qdm12/rsync-docker)
[![Docker Build Status](https://img.shields.io/docker/build/qmcgaw/rsync:ssh-client.svg)](https://hub.docker.com/r/qmcgaw/rsync:ssh-client)

[![Docker Pulls](https://img.shields.io/docker/pulls/qmcgaw/rsync:ssh-client.svg)](https://hub.docker.com/r/qmcgaw/rsync:ssh-client)
[![Docker Stars](https://img.shields.io/docker/stars/qmcgaw/rsync:ssh-client.svg)](https://hub.docker.com/r/qmcgaw/rsync:ssh-client)
[![Docker Automated](https://img.shields.io/docker/automated/qmcgaw/rsync:ssh-client.svg)](https://hub.docker.com/r/qmcgaw/rsync:ssh-client)

[![Image size](https://images.microbadger.com/badges/image/qmcgaw/rsync:ssh-client.svg)](https://microbadger.com/images/qmcgaw/rsync:ssh-client)
[![Image version](https://images.microbadger.com/badges/version/qmcgaw/rsync:ssh-client.svg)](https://microbadger.com/images/qmcgaw/rsync:ssh-client)

| Image size | RAM usage | CPU usage |
| --- | --- | --- |
| 5.2MB | ?MB | ? |

It is based on:

- [Alpine 3.8](https://alpinelinux.org)
- [Rsync 3.1.3 built statically from source](https://rsync.samba.org/)
- [OpenSSH Client](https://pkgs.alpinelinux.org/package/v3.8/main/x86_64/openssh-client)

Note that you also need an Rsync daemon and SSH server to be running on the remote host.

We assume you have an SSH private key at `/abc/key`. If you don't, simply avoid mounting the key and enter your SSH password manually (not recommended).

### From remote to local

```bash
docker run -d -v /abc/key:/home/user/id_rsa:ro -v /dir2:/destination qmcgaw/rsync:ssh-client sshUser@sshHost:/dir1/ /destination/
```

Replace `/abc/key`, `/dir2` and `sshUser@sshHost:/dir1` by real values of yours.

or use [docker-compose-ssh-from-remote.yml](https://github.com/qdm12/rsync-docker/blob/master/docker-compose-ssh-from-remote.yml) with:

```bash
docker-compose up -d
```

### From local to remote

```bash
docker run -d -v /abc/key:/home/user/id_rsa:ro -v /dir1:/source:ro qmcgaw/rsync:ssh-client /source/ sshUser@sshHost:/dir2/
```

Replace `/abc/key`, `/dir1` and `sshUser@sshHost:/dir2` by real values of yours.

or use [docker-compose-ssh-to-remote.yml](https://github.com/qdm12/rsync-docker/blob/master/docker-compose-ssh-to-remote.yml) with:

```bash
docker-compose up -d
```

## TODOs

- [ ] Rsync daemon with SSH server
- [ ] Healthcheck

## License

This repository is under an [MIT license](https://github.com/qdm12/rsync-docker/master/license)