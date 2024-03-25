#!/bin/bash

# Create .ssh directory for git user
mkdir -p /home/git/.ssh

# Copy SSH public key to the appropriate location
# Necessary because of unavailability of permissions for volume mounts in k8s
cat /home/git/.ssh/volumeMounts/authorized_keys > /home/git/.ssh/authorized_keys

chown git:git /home/git/.ssh
chown git:git /home/git/.ssh/authorized_keys

# Set correct permissions
chmod 700 /home/git/.ssh
chmod 600 /home/git/.ssh/authorized_keys

chmod 755 /projects
chown git:git /projects

# Start SSH server
/usr/sbin/sshd -D
