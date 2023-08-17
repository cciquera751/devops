#!/bin/bash

set -e

sudo apt-get -y install python3-pip

sudo pip3 install --ignore-installed -U pip
sudo pip3 install --no-cache-dir awscli --ignore-installed awscli
