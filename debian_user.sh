#!/usr/bin/env bash

ansible-pull -U https://github.com/benburwell/bootstrap.git --directory /tmp/ansible-bootstrap --purge main.yml
