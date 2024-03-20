#!/bin/bash

parallel-scp -h hostfile.txt $PWD/build/keys.sh $PWD/keys.sh
parallel-ssh -i -h hostfile.txt $PWD/keys.sh
