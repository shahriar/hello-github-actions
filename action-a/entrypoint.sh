#!/bin/sh -l

apt-get update -qq
apt-get install -qq git

# Setup SSH deploy keys
apt-get install -qq openssh-client
eval $(ssh-agent -s)
echo "$SSH_PRIVATE_KEY" | ssh-add -
mkdir -p ~/.ssh
echo -e "Host *\n\tStrictHostKeyChecking no\n\tStrictHostKeyChecking no\n\n" > ~/.ssh/config

ssh -T ubuntu@ec2-13-239-59-103.ap-southeast-2.compute.amazonaws.com "cd $REMOTE_TARGET && touch testing.txt && exit"
echo "Finished deploy"