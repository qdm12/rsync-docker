#!/bin/sh

printf "\n =========================================\n"
printf " =========================================\n"
printf " =========== Rsync + SSH Client ==========\n"
printf " =========================================\n"
printf " =========================================\n"
printf " == by github.com/qdm12 - Quentin McGaw ==\n\n"
rsync --version | head -n 1
if [ ! -d /ssh ]; then
    printf "Error: /ssh directory does not exist\n"
    exit 1
else
    cp /ssh/* /tmp/
    mkdir -p /root/.ssh
    chmod 700 /root/.ssh
    if [ ! -f /tmp/known_hosts ]; then
        printf "Warning: /ssh/known_hosts not found\n"
        if [ "$STRICT_HOST_KEY_CHECKING" != "no" ]; then
            printf "Error: STRICT_HOST_KEY_CHECKING is not 'no', please either provide /ssh/known_hosts or set STRICT_HOST_KEY_CHECKING=no\n"
            exit 1
        fi
    else
        mv /tmp/known_hosts /root/.ssh/known_hosts
        chmod 600 /root/.ssh/known_hosts
    fi
    chmod 400 /tmp/*
    success=0
    for f in /tmp/*
    do
        output="$(ssh-keygen -l -f $f 2>&1)"
        if [ $? = 0 ]; then
            success=1
            filename="$(basename $f)"
            mv "$f" "/root/.ssh/$filename"
        fi
        printf "Info: $f --- $output\n"
    done
    if [ $success = 0 ]; then
        printf "Error: Please have at least one valid private key in /ssh\n"
        exit 1
    fi
fi
sed -i '/^StrictHostKeychecking=/ d' /etc/ssh/ssh_config
echo "StrictHostKeychecking=$STRICT_HOST_KEY_CHECKING" >> /etc/ssh/ssh_config
rsync "$@"
if [ ! -z "$SYNCPERIOD" ]; then
    while sleep $SYNCPERIOD; do
        printf "Info: Sleeping for $SYNCPERIOD seconds before running rsync command\n"
        rsync "$@"
    done
elif [ ! -z "$WATCHDIR" ]; then
    if [ ! -d "$WATCHDIR" ]; then
        printf "Error: Directory $WATCHDIR does not exist\n"
        exit 1
    fi
    printf "Watching directory $WATCHDIR\n"
    while true; do
        inotifywait -r -e modify,create,delete "$WATCHDIR"
        printf "Detected changes to $WATCHDIR\n\n"
        rsync "$@"
    done
fi
status=$?
printf "\n =========================================\n"
printf " Exit with status $status\n"
printf " =========================================\n"