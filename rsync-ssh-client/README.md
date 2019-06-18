# Rsync with SSH client

*This is the Rsync static binary in a **790KB** Docker image*

[![Image size](https://images.microbadger.com/badges/image/qmcgaw/rsync:ssh-client.svg)](https://microbadger.com/images/qmcgaw/rsync:ssh-client)
[![Image version](https://images.microbadger.com/badges/version/qmcgaw/rsync:ssh-client.svg)](https://microbadger.com/images/qmcgaw/rsync:ssh-client)

| Image size | RAM usage | CPU usage |
| --- | --- | --- |
| 5.2MB | ?MB | Low |

It is based on:

- [Alpine 3.9](https://alpinelinux.org)
- [Rsync 3.1.3 built statically from source](https://rsync.samba.org/)
- [OpenSSH Client](https://pkgs.alpinelinux.org/package/v3.9/main/x86_64/openssh-client)

## Setup

1. You will need an Rsync daemon and SSH server to be running on the remote host. You might want to use the `qmcgaw/rsync:ssh-server` Docker image for that.

1. Depending on your case:
    - You have an SSH key (recommended) at `~/.ssh/id_rsa`:

        ```sh
        docker run -it --rm \
        -v ~/.ssh/id_rsa:/home/user/id_rsa:ro \
        qmcgaw/rsync:ssh-client --help
        ```

    - You have a usernamd and password for SSH:

        ```sh
        docker run -it --rm qmcgaw/rsync:ssh-client --help
        ```

## Examples

### Copy from remote to local

1. We assume:
    - The remote SSH host is `192.168.1.100`
    - The remote SSH host is running on port `22`
    - Your remote SSH username is `remoteuser`
    - You have your SSH private key at `~/.ssh/id_rsa`
    - You want to sync the remote directory `remotedir` to your local directory `/localdir`
1. Use this command:

    ```sh
    docker run -it --rm \
    -v ~/.ssh/id_rsa:/home/user/id_rsa:ro \
    -v /localdir:/localdir \
    qmcgaw/rsync:ssh-client \
    remoteuser@192.168.1.100:/remotedir/ /localdir/
    ```

### Copy from local to remote

1. We assume:
    - The remote SSH host is `192.168.1.100`
    - The remote SSH host is running on port `22`
    - Your remote SSH username is `remoteuser`
    - You have your SSH private key at `~/.ssh/id_rsa`
    - You want to sync the local directory `/localdir` to the remote directory `remotedir`
1. Use this command:

    ```sh
    docker run -it --rm \
    -v ~/.ssh/id_rsa:/home/user/id_rsa:ro \
    -v /localdir:/localdir \
    qmcgaw/rsync:ssh-client \
    /localdir/ remoteuser@192.168.1.100:/remotedir/
    ```

### Copy from remote to another remote

