#!/bin/bash 

INSTALL_DIR="/etc/aktos/service-runner"

echo "Installing in $INSTALL_DIR"
sudo mkdir -p $INSTALL_DIR
cp "tmux-launch" /tmp/tmux-launch 
sudo cp /tmp/tmux-launch $INSTALL_DIR
echo "all done..."
