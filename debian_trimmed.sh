#!/bin/bash

sudo apt update
sudo apt install -y \
  ca-certificates \
  exuberant-ctags \
  gnucash \
  irssi \
  mutt \
  oathtool \
  pass \
  texlive \
  transmission \
  wget \
  wireshark

# SSH and GPG keys
KEYS=/media/ben/FW
gpg --import $KEYS/ben.pub.asc
gpg --import $KEYS/ben.sec.asc
gpg --import $KEYS/pass.pub.asc
gpg --import $KEYS/pass.sec.asc
mkdir -p ~/.ssh
cp $KEYS/id_rsa ~/.ssh/id_rsa
cp $KEYS/id_rsa.pub ~/.ssh/id_rsa.pub
chmod 600 ~/.ssh/id_rsa
chmod 600 ~/.ssh/id_rsa.pub
ssh-add ~/.ssh/id_rsa

# nodejs
mkdir -p ~/.nvm
curl \
  --fail \
  --silent \
  --location \
  --output - \
  https://raw.githubusercontent.com/creationix/nvm/v0.33.11/install.sh | bash
# shellcheck source=/dev/null
. ~/.nvm/nvm.sh
nvm install node
npm install --global typescript

# fzf
go get -u github.com/junegunn/fzf

# ripgrep
curl \
  --location \
  --fail \
  --output /tmp/ripgrep_0.8.1_amd64.deb \
  https://github.com/BurntSushi/ripgrep/releases/download/0.8.1/ripgrep_0.8.1_amd64.deb
sudo dpkg -i /tmp/ripgrep_0.8.1_amd64.deb
rm -f /tmp/ripgrep_0.8.1_amd64.deb

# pass-otp
mkdir -p ~/code/src/github.com/tadfisher
git clone git@github.com:tadfisher/pass-otp.git ~/code/src/github.com/tadfisher/pass-otp
cd ~/code/src/github.com/tadfisher/pass-otp || exit
sudo make install

# ctop
sudo curl \
  --fail \
  --location \
  --output /usr/local/bin/ctop \
  https://github.com/bcicen/ctop/releases/download/v0.7.1/ctop-0.7.1-linux-amd64
sudo chmod +x /usr/local/bin/ctop

# dep
curl https://raw.githubusercontent.com/golang/dep/master/install.sh | sh

# hub
mkdir -p ~/code/src/github.com/github
git clone git@github.com:github/hub.git ~/code/src/github.com/github/hub
cd ~/code/src/github.com/github/hub || exit
sudo make install prefix=/usr/local

# password store
git clone git@gitlab.int.burwell.io:benburwell/password-store.git ~/.password-store

sudo apt install -y gconf2 libappindicator1
sudo apt --fix-broken install
curl \
  --fail \
  --silent \
  --location \
  --output /tmp/slack.deb \
  https://downloads.slack-edge.com/linux_releases/slack-desktop-3.2.1-amd64.deb
sudo dpkg -i /tmp/slack.deb
rm -f /tmp/slack.deb

# TODO: openvpn
