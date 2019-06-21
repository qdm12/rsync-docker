# Rsync with SSH client

*This is the Rsync static binary with an OpenSSH client in a **12.2MB** Docker image*

[![Image size](https://images.microbadger.com/badges/image/qmcgaw/rsync:ssh-client.svg)](https://microbadger.com/images/qmcgaw/rsync:ssh-client)
[![Image version](https://images.microbadger.com/badges/version/qmcgaw/rsync:ssh-client.svg)](https://microbadger.com/images/qmcgaw/rsync:ssh-client)

| Image size | RAM usage | CPU usage |
| --- | --- | --- |
| 12.2MB | Low to High | Low to High |

It is based on:

- [Alpine 3.9](https://alpinelinux.org)
- [Rsync 3.1.3 built statically from source](https://rsync.samba.org/)
- [OpenSSH Client](https://pkgs.alpinelinux.org/package/v3.9/main/x86_64/openssh-client)

## Setup

- You have an SSH key (recommended)
    1. Create a directory `ssh` on your host containing:

        ```sh
        mkdir ssh
        # Your SSH private key (could be id_ecdsa too for example)
        cat ~/.ssh/id_rsa > ssh/id_rsa
        cat ~/.ssh/known_hosts > ssh/known_hosts
        ```

    1. Run the Rsync SSH client with

        ```sh
        docker run -it --rm -v $(pwd)/ssh:/ssh:ro qmcgaw/rsync:ssh-client --help
        ```

- You have a username and password for SSH (not recommended!):

    ```sh
    docker run -it --rm qmcgaw/rsync:ssh-client --help
    ```

You might want to set `-e STRICT_HOST_KEY_CHECKING=no` if you encounter server host key errors.

## Examples

### Copy from remote to local

1. We assume:
    - The remote SSH host
        - Hostname is `192.168.1.100`
        - SSH port is `22`
        - Has an SSH daemon and Rsync daemon running
    - Your remote SSH username is `root` (the case for `qmcgaw/rsync:ssh-server`)
    - You have a SSH private key in the directory `ssh`
    - You want to sync the remote directory `remotedir` to your local directory `/localdir`
1. Use this command:

    ```sh
    docker run -it --rm \
    -v $(pwd)/ssh:/ssh:ro \
    -v /localdir:/localdir \
    qmcgaw/rsync:ssh-client \
    root@192.168.1.100:/remotedir/ /localdir/
    ```

### Copy from local to remote

1. We assume:
    - The remote SSH host
        - Hostname is `192.168.1.100`
        - SSH port is `22`
        - Has an SSH daemon and Rsync daemon running
    - Your remote SSH username is `root` (the case for `qmcgaw/rsync:ssh-server`)
    - You have a SSH private key in the directory `ssh`
    - You want to sync the local directory `/localdir` to the remote directory `remotedir`
1. Use this command:

    ```sh
    docker run -it --rm \
    -v $(pwd)/ssh:/ssh:ro \
    -v /localdir:/localdir \
    qmcgaw/rsync:ssh-client \
    /localdir/ root@192.168.1.100:/remotedir/
    ```

### Copy from remote to another remote

