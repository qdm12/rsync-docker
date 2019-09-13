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
    printf " =========== Rsync + SSH Server ==========\n"
    printf " =========================================\n"
    printf " =========================================\n"
    printf " == by github.com/qdm12 - Quentin McGaw ==\n\n"
    rsync --version | head -n 1
fi

if [ ! -d /ssh ]; then
    printf "[ERROR] /ssh directory does not exist\n"
    exit 1
fi
if [ "$LOG" = "on" ]; then
    echo "[INFO] Connected to Rsync SSH server" > /etc/banner
fi
mkdir -p /root/.ssh
chmod 700 /root/.ssh
rm -f /root/.ssh/authorized_keys
touch /root/.ssh/authorized_keys
chmod 600 /root/.ssh/authorized_keys
success=0
for f in /ssh/*
do
    output="$(ssh-keygen -l -f $f 2>&1)"
    if [ $? = 0 ]; then
        success=1
        cat "$f" >> /root/.ssh/authorized_keys
    fi
    if [ "$LOG" != "off" ]; then
        printf "[INFO] Public key $f: $output\n"
    fi
done
if [ $success = 0 ]; then
    printf "[ERROR] Please have at least one valid public key in /ssh\n"
    exit 1
fi
if [ ! -f "/etc/ssh/ssh_host_rsa_key" ]; then
    if [ "$LOG" != "off" ]; then
        printf "[INFO] Cannot find RSA host key, generating it...\n"
    fi
	ssh-keygen -f /etc/ssh/ssh_host_rsa_key -N '' -t rsa &> /dev/null
fi
if [ "$LOG" != "off" ]; then
    printf "[INFO] Host RSA public key: "
    cat /etc/ssh/ssh_host_rsa_key.pub
fi
if [ ! -f "/etc/ssh/ssh_host_ecdsa_key" ]; then
    if [ "$LOG" != "off" ]; then
        printf "[INFO] Cannot find ECDSA host key, generating it...\n"
    fi
	ssh-keygen -f /etc/ssh/ssh_host_ecdsa_key -N '' -t ecdsa &> /dev/null
fi
if [ "$LOG" != "off" ]; then
    printf "[INFO] Host ECDSA public key: "
    cat /etc/ssh/ssh_host_ecdsa_key.pub
fi
if [ ! -f "/etc/ssh/ssh_host_ed25519_key" ]; then
    printf "[INFO] Cannot find ED25519 host key, generating it...\n"
	ssh-keygen -f /etc/ssh/ssh_host_ed25519_key -N '' -t ed25519 &> /dev/null
fi
if [ "$LOG" != "off" ]; then
    printf "[INFO] Host ED25519 public key: "
    cat /etc/ssh/ssh_host_ed25519_key.pub
fi
echo "root:$(date +%s | sha256sum | base64 | head -c 32)" | chpasswd &> /dev/null
if [ "$LOG" != "off" ]; then
    printf "[INFO] Launching SSH server...\n"
fi
if [ "$LOG" = "on" ]; then
    /usr/sbin/sshd -D -e 2>&1
else
    /usr/sbin/sshd -D -e > /dev/null 2>&1
fi
status=$?
printf "\n =========================================\n"
printf " Exit with status $status\n"
printf " =========================================\n"