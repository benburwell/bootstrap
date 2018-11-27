#!/bin/bash

sudo apt update
sudo apt install -y \
  ca-certificates \
  exuberant-ctags \
  gnucash \
  irssi \
  maven \
  mutt \
  oathtool \
  pass \
  postgresql-client \
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

# java
echo "deb http://ppa.launchpad.net/webupd8team/java/ubuntu trusty main" | sudo tee /etc/apt/sources.list.d/java.list
echo "deb-src http://ppa.launchpad.net/webupd8team/java/ubuntu trusty main" | sudo tee -a /etc/apt/sources.list.d/java.list
sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys EEA14886
sudo apt install -y oracle-java8-installer

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

# google-java-format
sudo curl \
  --location \
  --fail \
  --create-dirs \
  --output /usr/local/opt/google-java-format/libexec/google-java-format-1.6-all-deps.jar \
  https://github.com/google/google-java-format/releases/download/google-java-format-1.6/google-java-format-1.6-all-deps.jar

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

# aws
sudo pip install awscli
mkdir ~/.aws
cat <<EOF > ~/.aws/credentials
[default]
aws_access_key_id = $(pass virtyx/aws-access-key)
aws_secret_access_key = $(pass virtyx/aws-secret-key)
EOF

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

curl \
  --fail \
  --silent \
  --location \
  --output /tmp/ngrok.zip \
  https://bin.equinox.io/c/4VmDzA7iaHb/ngrok-stable-linux-amd64.zip
sudo unzip /tmp/ngrok.zip -d /usr/local/bin
rm -f /tmp/ngrok.zip
mkdir -p ~/.ngrok2
echo "authtoken: $(pass ngrok-token)" > ~/.ngrok2/ngrok.yml

# TODO: openvpn
# TODO: maven settings.xml
