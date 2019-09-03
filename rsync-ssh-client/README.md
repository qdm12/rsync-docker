# Rsync with SSH client

*This is the Rsync static binary with an OpenSSH client in a **12.2MB** Docker image*

[![Image size](https://images.microbadger.com/badges/image/qmcgaw/rsync:ssh-client.svg)](https://microbadger.com/images/qmcgaw/rsync:ssh-client)
[![Image version](https://images.microbadger.com/badges/version/qmcgaw/rsync:ssh-client.svg)](https://microbadger.com/images/qmcgaw/rsync:ssh-client)

| Image size | RAM usage | CPU usage |
| --- | --- | --- |
| 12.5MB | Low to High | Low to High |

It is based on:

- [Alpine 3.10](https://alpinelinux.org)
- [Rsync 3.1.3 built statically from source](https://rsync.samba.org/)
- [OpenSSH Client](https://pkgs.alpinelinux.org/package/v3.10/main/x86_64/openssh-client)

## Setup

1. In your home SSH directory `~/.ssh`, you need an SSH private key to connect to your Rsync server which can be any of:
    - `id_rsa`
    - `id_ecdsa`
    - `id_ed25519`
1. Run the Rsync SSH client with

    ```sh
    docker run -it --rm -v ~/.ssh:/ssh:ro qmcgaw/rsync:ssh-client --help
    ```

### Advanced verification

If you want to verify the Rsync server you are connecting to is the right server:

1. Set the environment variable `-e STRICT_HOST_KEY_CHECKING=yes`
1. Update your `~/.ssh/known_hosts` file with your Rsync server public fingerprint
1. If you use `qmcgaw/rsync:ssh-server`, you might want to map the server host keys to the container as described
in its [readme](../rsync-ssh-server/README.md) so that they are not re-generated randomly on each run.

### Syncing

To maintain sync, you can either set

- `-e SYNCPERIOD=30` to run your rsync command every 30 seconds, or
- `-e WATCHDIR=/data` where `/data` is your bind mounted volume
 to run rsync on changes made in the `/data` directory. This **only works on Linux**

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

