# Use a base image with Ubuntu
FROM ubuntu:latest

# Update package lists and install necessary packages
RUN apt-get update && apt-get install -y openssh-server git

# Create a new user 'git' 
RUN useradd -ms /bin/bash git

# Disable password authentication for SSH
RUN sed -i 's/PasswordAuthentication yes/PasswordAuthentication no/g' /etc/ssh/sshd_config

# Expose SSH port
EXPOSE 22

# Start SSH server
CMD ["/usr/sbin/sshd", "-D"]