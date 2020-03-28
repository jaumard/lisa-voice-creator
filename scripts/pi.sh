#!/usr/bin/env bash

apt-get update
apt-get -y upgrade
apt-get install -y curl git
apt-get install -y build-essential

#install node
if which node > /dev/null ; then
    wget -O - https://raw.githubusercontent.com/sdesalas/node-pi-zero/master/install-node-v10.15.0.sh | bash
else
    echo "node is installed, skipping..."
fi

#install yarn
if which yarn > /dev/null ; then
    curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add -
    echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list
    apt-get update && apt-get install -y yarn
else
    echo "yarn is installed, skipping..."
fi

#matrix board
if which malos > /dev/null ; then
  curl https://apt.matrix.one/doc/apt-key.gpg | sudo apt-key add -
  echo "deb https://apt.matrix.one/raspbian $(lsb_release -sc) main" | sudo tee /etc/apt/sources.list.d/matrixlabs.list
  apt-get update
  apt-get install -y matrixio-malos matrixio-kernel-modules
  #echo 'export AUDIODEV=mic_channel8' >>~/.bash_profile
  echo 'export LANG=en-US' >>~/.bash_profile
  source ~/.bash_profile
fi

#sox install for sonus speech recognition
apt-get install -y sox libsox-fmt-all alsa-utils libatlas-base-dev

# others
apt-get install -y libzmq3-dev libavahi-compat-libdnssd-dev

if [ ! -d "/var/www" ]; then
  mkdir /var/www
fi

cd /var/www

git clone https://github.com/jaumard/lisa-voice-creator

cd lisa-voice-creator
yarn
yarn global add forever

cd /etc/init.d/
wget https://raw.githubusercontent.com/jaumard/lisa-voice-creator/master/scripts/lisa
chmod 755 /etc/init.d/lisa
update-rc.d lisa defaults

echo "now reboot your system to make minilisa working"
