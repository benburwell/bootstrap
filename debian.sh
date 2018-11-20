#!/usr/bin/env bash

echo "Adding Ansible apt repo..."
echo "deb http://ppa.launchpad.net/ansible/ansible/ubuntu trusty main" >> /etc/apt/sources.list
apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 93C4A3FD7BB9C367

echo "Installing sudo, ansible, git..."
apt update
apt install sudo ansible git

echo "Adding bb to sudo group..."
usermod bb --append --groups sudo

echo "Done with pre-Ansible setup. Now, log into account bb and run debian_user.sh"
