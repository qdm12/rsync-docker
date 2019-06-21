#!/bin/sh

printf "\n =========================================\n"
printf " =========================================\n"
printf " ============== Rsync Docker =============\n"
printf " =========================================\n"
printf " =========================================\n"
printf " == by github.com/qdm12 - Quentin McGaw ==\n\n"
rsync --version | head -n 1

if [ ! -d /ssh ]; then
    printf "Error: /ssh directory does not exist\n"
    exit 1
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
    printf "$f: $output\n"
done
if [ $success = 0 ]; then
    printf "Error: Please have at least one valid public key in /ssh\n"
    exit 1
fi
if [ ! -f "/etc/ssh/ssh_host_rsa_key" ]; then
    printf "Cannot find RSA host key, generating it.\n"
	ssh-keygen -f /etc/ssh/ssh_host_rsa_key -N '' -t rsa &> /dev/null
fi
if [ ! -f "/etc/ssh/ssh_host_ecdsa_key" ]; then
    printf "Cannot find ECDSA host key, generating it.\n"
	ssh-keygen -f /etc/ssh/ssh_host_ecdsa_key -N '' -t ecdsa &> /dev/null
fi
if [ ! -f "/etc/ssh/ssh_host_ed25519_key" ]; then
    printf "Cannot find ED25519 host key, generating it.\n"
	ssh-keygen -f /etc/ssh/ssh_host_ed25519_key -N '' -t ed25519 &> /dev/null
fi
echo "root:$(date +%s | sha256sum | base64 | head -c 32)" | chpasswd &> /dev/null
mkdir /root/.ssh
printf "Launching SSH server...\n"
/usr/sbin/sshd -D -e
status=$?
printf "\n =========================================\n"
printf " Exit with status $status\n"
printf " =========================================\n"