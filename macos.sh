#!/usr/bin/env bash

ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
brew install ansible
ansible-pull -U https://github.com/benburwell/bootstrap.git --directory /tmp/ansible-bootstrap --purge macos-workstation-local.yml

#brew services start offlineimap
