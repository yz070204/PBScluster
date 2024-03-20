#!/bin/bash

echo "headnode=$1"
headnode=$1
headnode="compute0000KP"

sudo apt-get update -y
sudo apt-get upgrade -y

sudo apt-get install gcc make libtool libhwloc-dev libx11-dev \
      libxt-dev libedit-dev libical-dev ncurses-dev perl \
      postgresql-server-dev-all postgresql-contrib python3-dev tcl-dev tk-dev swig \
      libexpat-dev libssl-dev libxext-dev libxft-dev autoconf \
      automake g++ -y

sudo apt install expat libedit2 postgresql python3 postgresql-contrib sendmail-bin \
      sudo tcl tk libical3 postgresql-server-dev-all -y

wget https://github.com/openpbs/openpbs/archive/refs/tags/v23.06.06.tar.gz
tar -xzvf v23.06.06.tar.gz
cd openpbs-23.06.06/
./autogen.sh
./configure --prefix=/opt/pbs
make -j 144
sudo make install

sleep 1

sudo /opt/pbs/libexec/pbs_postinstall
sudo sed -i "s/PBS_SERVER=.*/PBS_SERVER=$headnode/" /etc/pbs.conf
sudo sed -i "s/PBS_START_SERVER=1/PBS_START_SERVER=0/" /etc/pbs.conf
sudo sed -i "s/PBS_START_SCHED=1/PBS_START_SCHED=0/" /etc/pbs.conf
sudo sed -i "s/PBS_START_COMM=1/PBS_START_COMM=0/" /etc/pbs.conf
sudo sed -i "s/PBS_START_MOM=0/PBS_START_MOM=1/" /etc/pbs.conf

sudo chmod 4755 /opt/pbs/sbin/pbs_iff /opt/pbs/sbin/pbs_rcp
sudo sed -i "s/^if /#if /g" /opt/pbs/lib/init.d/limits.pbs_mom
sudo sed -i "s/^fi/#fi /g" /opt/pbs/lib/init.d/limits.pbs_mom
sudo /etc/init.d/pbs start
. /etc/profile.d/pbs.sh

qmgr -c "c n $(hostname) resources_available.pool_name='compute'"
sudo /etc/init.d/pbs restart
