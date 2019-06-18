# Rsync with SSH server

*This is the Rsync static binary with an OpenSSH server in a **???MB** Docker image*

[![Image size](https://images.microbadger.com/badges/image/qmcgaw/rsync:ssh-server.svg)](https://microbadger.com/images/qmcgaw/rsync:ssh-server)
[![Image version](https://images.microbadger.com/badges/version/qmcgaw/rsync:ssh-server.svg)](https://microbadger.com/images/qmcgaw/rsync:ssh-server)

| Image size | RAM usage | CPU usage |
| --- | --- | --- |
| 13.3MB | Low to High | Low to High |

It is based on:

- [Alpine 3.9](https://alpinelinux.org)
- [Rsync 3.1.3 built statically from source](https://rsync.samba.org/)
- [OpenSSH](https://pkgs.alpinelinux.org/package/v3.9/main/x86_64/openssh)

The SSH login is with `root` so there is no further file permissions issues with *rsync*

## Setup

1. Run the Rsync SSH server with

    ```sh
    docker run -it --rm --init -p 22:22/tcp -e PUBKEY=xxxxxx -v /yourpath:/mnt/directory qmcgaw/rsync:ssh-server
    ```

    where `PUBKEY` is your SSH client public key

1. If your host is a Linux system running a SSH server, you might want to map the SSH server host keys by adding:

    ```sh
    -v /etc/ssh/ssh_host_rsa_key:/etc/ssh/ssh_host_rsa_key:ro \
    -v /etc/ssh/ssh_host_ecdsa_key:/etc/ssh/ssh_host_ecdsa_key:ro \
    -v /etc/ssh/ssh_host_ed25519_key:/etc/ssh/ssh_host_ed25519_key:ro
    ```

    to the Docker command above, so that your clients recognize the server fingerprints.

1. You can then connect to it with the `qmcgaw/rsync:client` container for example.