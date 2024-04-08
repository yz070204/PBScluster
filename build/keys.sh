#!/bin/bash

echo "Paste  public key contents here" > ~/.ssh/id_rsa.pub

chmod 644 ~/.ssh/id_rsa.pub

echo "-----BEGIN RSA PRIVATE KEY-----
Paste private key contents here
-----END RSA PRIVATE KEY-----" > ~/.ssh/id_rsa

chmod 600 ~/.ssh/id_rsa

cat <<EOF > ~/.ssh/config
Host *
    StrictHostKeyChecking no
    UserKnownHostsFile /dev/null
    LogLevel ERROR
EOF
