#!/usr/bin/env bash

apt update
apt install sudo ansible
usermod bb --append --groups sudo

ansible-pull -U https://github.com/benburwell/bootstrap.git --directory /tmp/ansible-bootstrap --purge main.yml

