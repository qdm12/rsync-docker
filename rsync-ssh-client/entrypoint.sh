#!/bin/sh

exitIfNotIn(){
  # $1 is the name of the variable to check - not the variable itself
  # $2 is a string of comma separated possible values
  var="$(eval echo "\$$1")"
  for value in ${2//,/ }
  do
    if [ "$var" = "$value" ]; then
      return 0
    fi
  done
  printf "[ERROR] Environment variable $1 cannot be '$var' and must be one of the following: "
  for value in ${2//,/ }
  do
    printf "$value "
  done
  printf "\n"
  exit 1
}

exitIfNotIn LOG "off,start,on"
if [ "$LOG" != "off" ]; then
    printf "\n =========================================\n"
    printf " =========================================\n"
    printf " =========== Rsync + SSH Client ==========\n"
    printf " =========================================\n"
    printf " =========================================\n"
    printf " == by github.com/qdm12 - Quentin McGaw ==\n\n"
    rsync --version | head -n 1
fi
if [ ! -d /ssh ]; then
    printf "[ERROR] /ssh directory does not exist\n"
    exit 1
else
    cp /ssh/* /tmp/
    mkdir -p /root/.ssh
    chmod 700 /root/.ssh
    if [ ! -f /tmp/known_hosts ]; then
        printf "[WARNING] /ssh/known_hosts not found\n"
        if [ "$STRICT_HOST_KEY_CHECKING" != "no" ]; then
            printf "[ERROR] STRICT_HOST_KEY_CHECKING is not 'no', please either provide /ssh/known_hosts or set STRICT_HOST_KEY_CHECKING=no\n"
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
        if [ "$LOG" != "off" ]; then
            printf "[INFO] Public key $f: $output\n"
        fi
    done
    if [ $success = 0 ]; then
        printf "[ERROR] Please have at least one valid private key in /ssh\n"
        exit 1
    fi
fi
sed -i '/^StrictHostKeychecking=/ d' /etc/ssh/ssh_config
echo "StrictHostKeychecking=$STRICT_HOST_KEY_CHECKING" >> /etc/ssh/ssh_config
if [ "$LOG" != "off" ]; then
    printf "[INFO] `date +"%H:%M:%S"` First Rsync run...\n"
fi
rsync "$@" 2>&1
if [ ! -z "$SYNCPERIOD" ]; then
    while sleep $SYNCPERIOD; do
        if [ "$LOG" = "on" ]; then
            printf "[INFO] `date +"%H:%M:%S"` Sleeping for $SYNCPERIOD seconds before running rsync command\n"
        fi
        rsync "$@" 2>&1
    done
elif [ ! -z "$WATCHDIR" ]; then
    if [ ! -d "$WATCHDIR" ]; then
        printf "[ERROR] Directory $WATCHDIR does not exist\n"
        exit 1
    fi
    if [ "$LOG" != "off" ]; then
        printf "[INFO] `date +"%H:%M:%S"` Watching directory $WATCHDIR\n"
    fi
    while true; do
        if [ "$LOG" = "on" ]; then
            inotifywait -r -e modify,create,delete "$WATCHDIR" 2>&1
        else
            inotifywait -r -e modify,create,delete "$WATCHDIR" > /dev/null 2>&1
        fi
        if [ "$LOG" = "on" ]; then
            printf "[INFO] `date +"%H:%M:%S"` Detected changes to $WATCHDIR\n\n"
        fi
        rsync "$@" 2>&1
    done
fi
status=$?
printf "\n =========================================\n"
printf " Exit with status $status\n"
printf " =========================================\n"