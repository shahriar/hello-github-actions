#!/bin/sh -l

apt-get update -qq
apt-get install -qq git

# Setup SSH deploy keys
apt-get install -qq openssh-client
eval $(ssh-agent -s)
echo $SSH_PRIVATE_KEY | ssh-add -
mkdir -p ~/.ssh
echo -e "Host *.compute.amazonaws.com\n\tStrictHostKeyChecking no\n\tUserKnownHostsFile /dev/null\n\n" > ~/.ssh/config
cat ~/.ssh/config
ls ~/.ssh/

ssh -vT -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null ubuntu@13.238.159.198 "cd /home/ubuntu/tura && touch testing.txt && exit"
echo "Finished deploy"