# Rsync with SSH server

*This is the Rsync static binary with an OpenSSH server in a **???MB** Docker image*

[![Image size](https://images.microbadger.com/badges/image/qmcgaw/rsync:ssh-server.svg)](https://microbadger.com/images/qmcgaw/rsync:ssh-server)
[![Image version](https://images.microbadger.com/badges/version/qmcgaw/rsync:ssh-server.svg)](https://microbadger.com/images/qmcgaw/rsync:ssh-server)

| Image size | RAM usage | CPU usage |
| --- | --- | --- |
| 13.4MB | Low to High | Low to High |

It is based on:

- [Alpine 3.10](https://alpinelinux.org)
- [Rsync 3.1.3 built statically from source](https://rsync.samba.org/)
- [OpenSSH](https://pkgs.alpinelinux.org/package/v3.10/main/x86_64/openssh)

The SSH login is with `root` so there is no further file permissions issues with *rsync*

Note that this image only works with SSH keys.

## Setup

1. Create a directory `ssh` on your host containing 1 SSH public key per `.pub` files

    ```sh
    mkdir ssh
    cat ~/.ssh/id_rsa.pub > ssh/id_rsa.pub
    cat ~/.ssh/custom.pub > ssh/custom.pub
    ```

1. Run the Rsync SSH server with

    ```sh
    docker run -it --rm --init -p 22:22/tcp -v $(pwd)/ssh:/ssh:ro -v /yourpath:/mnt/directory qmcgaw/rsync:ssh-server
    ```

### Advanced verification

If your host is a Linux system running an SSH server, you might want to map the SSH server host keys

```sh
docker ... \
-v /etc/ssh/ssh_host_rsa_key:/etc/ssh/ssh_host_rsa_key:ro \
-v /etc/ssh/ssh_host_ecdsa_key:/etc/ssh/ssh_host_ecdsa_key:ro \
-v /etc/ssh/ssh_host_ed25519_key:/etc/ssh/ssh_host_ed25519_key:ro \
-v /etc/ssh/ssh_host_rsa_key.pub:/etc/ssh/ssh_host_rsa_key.pub:ro \
-v /etc/ssh/ssh_host_ecdsa_key.pub:/etc/ssh/ssh_host_ecdsa_key.pub:ro \
-v /etc/ssh/ssh_host_ed25519_key.pub:/etc/ssh/ssh_host_ed25519_key.pub:ro \
qmcgaw/rsync:ssh-server
```

to the Docker command above, so that your clients recognize the server fingerprints and don't complain about MITM attacks.

You can then connect to it with the `qmcgaw/rsync:client` container for example.
