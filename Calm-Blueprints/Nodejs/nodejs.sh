#!/bin/bash
curl -sL https://deb.nodesource.com/setup_4.x | sudo -E bash -
sudo apt-get -y update
sudo apt-get install -y build-essential
sudo apt-get install -y nodejs