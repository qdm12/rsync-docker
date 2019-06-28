# Rsync

*This is the Rsync static binary in a **790KB** Docker image*

[![Image size](https://images.microbadger.com/badges/image/qmcgaw/rsync.svg)](https://microbadger.com/images/qmcgaw/rsync)
[![Image version](https://images.microbadger.com/badges/version/qmcgaw/rsync.svg)](https://microbadger.com/images/qmcgaw/rsync)

| Image size | RAM usage | CPU usage |
| --- | --- | --- |
| 790KB | Medium to High | Medium to High |

It is based on:

- [Scratch](https://hub.docker.com/_/scratch/)
- [Rsync 3.1.3 built statically from source](https://rsync.samba.org)

## Setup

Use this command:

```sh
docker run -it --rm --network=none \
-v /yourpath1:/source:ro \
-v /yourpath2:/destination \
qmcgaw/rsync --help
```

You can use any Rsync commands instead of `--help`, except the ones depending on networking such as SSH. For this, use the other Docker image such as `qmcgaw/rsync:ssh-client`.

## Examples

### Copy directories

To copy from `/yourpath1` to `/yourpath2`, you can use

```sh
docker run -it --rm --network=none \
-v /yourpath1:/source:ro \
-v /yourpath2:/destination \
qmcgaw/rsync --append --recursive --progress /source/ /destination
```
