#!/bin/bash

sudo apt-get update -y
sudo apt-get upgrade -y

cd /share
wget https://github.com/openpbs/openpbs/archive/refs/tags/v23.06.06.tar.gz
tar -xzvf v23.06.06.tar.gz
cd openpbs-23.06.06/
./autogen.sh

sudo apt-get install gcc make libtool libhwloc-dev libx11-dev \
      libxt-dev libedit-dev libical-dev ncurses-dev perl \
      postgresql-server-dev-all postgresql-contrib python3-dev tcl-dev tk-dev swig \
      libexpat-dev libssl-dev libxext-dev libxft-dev autoconf \
      automake g++ -y

sudo apt install expat libedit2 postgresql python3 postgresql-contrib sendmail-bin \
      sudo tcl tk libical3 postgresql-server-dev-all -y


./configure --prefix=/opt/pbs
make -j 64
sudo make install
sudo /opt/pbs/libexec/pbs_postinstall
sudo sed -i "s/PBS_START_MOM=0/PBS_START_MOM=1/" /etc/pbs.conf
sudo chmod 4755 /opt/pbs/sbin/pbs_iff /opt/pbs/sbin/pbs_rcp
sudo /etc/init.d/pbs start
. /etc/profile.d/pbs.sh

sudo /opt/pbs/bin/qmgr
s server managers += hpcadmin@*
q

/opt/pbs/bin/qmgr -c 's s flatuid=t'
/opt/pbs/bin/qmgr -c 's s job_history_enable=t'
/opt/pbs/bin/qmgr -c 'c r pool_name type=string,flag=h'
sudo sed -i "s/^resources: \"ncpus,/resources: \"ncpus, pool_name,/g" /var/spool/pbs/sched_priv/sched_config

sudo /etc/init.d/pbs restart

