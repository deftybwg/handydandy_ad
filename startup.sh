#!/bin/bash

# Prompt for the network range
read -p "Enter the target network (e.g., 10.11.11.0/24): " TARGET_NET

# Name of the TUN interface
IFACE="ligolo"

# Add TUN interface
sudo ip tuntap add user $(whoami) mode tun $IFACE

# Bring up the interface
sudo ip link set $IFACE up

# Add route to the specified network
sudo ip route add "$TARGET_NET" dev $IFACE

# Change to the ligolo directory and run proxy
cd ~/Utils/ligolo || {
  echo "Directory ~/Utils/ligolo not found!"
  exit 1
}

# Run ligolo proxy with self-signed cert
./proxy -selfcert
