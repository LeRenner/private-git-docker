# Use a base image with Ubuntu
FROM ubuntu:latest

# Update package lists and install necessary packages
RUN apt-get update && apt-get install -y openssh-server git

# Create a directory for SSH
RUN mkdir /var/run/sshd

# Create a new user 'git' 
RUN useradd -ms /bin/bash git

# Disable password authentication for SSH
RUN sed -i 's/PasswordAuthentication yes/PasswordAuthentication no/g' /etc/ssh/sshd_config
RUN sed -i 's/#PasswordAuthentication no/PasswordAuthentication no/g' /etc/ssh/sshd_config

# create .ssh directory for git user
RUN mkdir /home/git/.ssh

# Expose SSH port
EXPOSE 22

# Start SSH server
CMD ["/usr/sbin/sshd", "-D"]