#!/bin/bash

parallel-scp -h clientfile.txt $PWD/pbs-client.sh ~/pbs-client.sh
parallel-ssh -i -h clientfile.txt "~/pbs-client.sh $HOSTNAME"
