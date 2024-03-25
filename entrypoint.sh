#!/bin/bash

# Create .ssh directory for git user
mkdir -p /home/git/.ssh

# Copy SSH public key to the appropriate location
cat /k8sMounts/user-public-key/authorized_keys > /home/git/.ssh/authorized_keys
chown git:git /home/git/.ssh
chown git:git /home/git/.ssh/authorized_keys
chmod 700 /home/git/.ssh
chmod 600 /home/git/.ssh/authorized_keys

# Copy host SSH private keys to server location
cat /k8sMounts/host-private-key/ssh_host_rsa_key > /etc/ssh/ssh_host_rsa_key
cat /k8sMounts/host-private-key/ssh_host_ecdsa_key > /etc/ssh/ssh_host_ecdsa_key
cat /k8sMounts/host-private-key/ssh_host_ed25519_key > /etc/ssh/ssh_host_ed25519_key
chmod 600 /etc/ssh/ssh_host_rsa_key
chmod 600 /etc/ssh/ssh_host_ecdsa_key
chmod 600 /etc/ssh/ssh_host_ed25519_key

# Set correct permissions to /projects directory
chmod 755 /projects
chown git:git /projects

# Start SSH server
/usr/sbin/sshd -D
