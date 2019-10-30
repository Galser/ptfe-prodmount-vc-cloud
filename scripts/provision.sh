#!/usr/bin/env bash
# Provisin script for PTFE instance
sudo apt update -qq -y
sudo apt install -qq -y curl wget
# Prod mount disk
sudo mkfs -t xfs /dev/nvme0n1
sudo mkdir /tfe-data
PUUID=$(sudo blkid /dev/nvme0n1 | grep -E -o "[0-9a-fA-F]{8}\-[0-9a-fA-F]{4}\-[0-9a-fA-F]{4}\-[0-9a-fA-F]{4}\-[0-9a-fA-F]{12}")
sudo sh -c 'echo UUID='$PUUID'   /tfe-data  xfs  defaults,nofail  0  2 >> /etc/fstab'
sudo mount -a
