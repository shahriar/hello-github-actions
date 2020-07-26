#!/bin/sh -l

apt-get update -qq
apt-get install -qq git

# Setup SSH deploy keys
apt-get install -qq openssh-client
eval $(ssh-agent -s)
echo $SSH_PRIVATE_KEY | ssh-add -
mkdir -p ~/.ssh
echo -e "Host *.compute.amazonaws.com\n\tStrictHostKeyChecking no\n\tUserKnownHostsFile /dev/null\n\RSAAuthentication yes\n\PubkeyAuthentication yes\n\n" > ~/.ssh/config
chmod 600 ~/.ssh/*

ssh -vT ubuntu@13.238.159.198 "cd /home/ubuntu/tura && touch testing.txt && exit"
echo "Finished deploy"