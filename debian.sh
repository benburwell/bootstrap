#!/usr/bin/env bash
#
# To run:
#
#   $ wget --no-check-certificate https://raw.githubusercontent.com/benburwell/bootstrap/master/debian.sh
#   $ chmod +x debian.sh
#   $ ./debian.sh

echo "Installing sudo, git, dirmngr"
apt update
apt install -y sudo git dirmngr

echo "Adding Ansible apt repo..."
echo "deb http://ppa.launchpad.net/ansible/ansible/ubuntu trusty main" >> /etc/apt/sources.list
apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 93C4A3FD7BB9C367

echo "Installing ansible..."
apt update
apt install -y ansible

echo "Adding bb to sudo group..."
usermod bb --append --groups sudo

echo "Done with pre-Ansible setup. Now, log into account bb and run debian_user.sh"
