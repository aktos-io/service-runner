#!/bin/bash 

INSTALL_DIR="/etc/aktos/service-runner"

echo "Installing in $INSTALL_DIR"
sudo mkdir -p $INSTALL_DIR
sudo cp "tmux-launch" $INSTALL_DIR
echo "all done..."
