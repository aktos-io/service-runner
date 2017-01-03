#!/bin/bash 

INSTALL_DIR="/etc/aktos"
sudo apt-get install tmux 
echo "Installing in $INSTALL_DIR"
sudo mkdir -p $INSTALL_DIR
sudo git clone . "$INSTALL_DIR/service-runner"
echo "all done..."
