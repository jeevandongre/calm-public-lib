#!/bin/bash
sudo apt-get -y update
sudo apt-get install -y build-essential
sudo apt-get install -y nodejs
gpg --keyserver hkp://keys.gnupg.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3
\curl -sSL https://get.rvm.io | bash -s stable --rails
