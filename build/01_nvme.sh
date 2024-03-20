#!/bin/bash

#sets up the nvme disks. Adjust based on the system

sudo mkdir /share
sudo mdadm --create /dev/md120 --level 0 --raid-devices 2 /dev/nvme0n1 /dev/nvme1n1
sudo mkfs.xfs /dev/md120
sudo mount /dev/md120 /share
sudo chmod 1777 /share
