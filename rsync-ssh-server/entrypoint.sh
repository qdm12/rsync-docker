#!/bin/sh

printf "\n =========================================\n"
printf " =========================================\n"
printf " ============== Rsync Docker =============\n"
printf " =========================================\n"
printf " =========================================\n"
printf " == by github.com/qdm12 - Quentin McGaw ==\n\n"
if [ "$PUBKEY" = "" ]; then
    printf "No PUBKEY environment variable was provided\n"
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
chmod 700 /root/.ssh
echo "$PUBKEY" > /root/.ssh/authorized_keys
chmod -R 600 /root/.ssh/authorized_keys
printf "Launching SSH server...\n"
/usr/sbin/sshd -D -e
status=$?
printf "\n =========================================\n"
printf " Exit with status $status\n"
printf " =========================================\n"