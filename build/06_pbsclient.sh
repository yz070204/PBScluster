#!/bin/bash

parallel-scp -h clientfile.txt $PWD/build/pbs-client.sh $PWD/pbs-client.sh
parallel-ssh -i -h clientfile.txt "$PWD/pbs-client.sh $HOSTNAME"
