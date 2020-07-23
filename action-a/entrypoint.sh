#!/bin/sh -l

apt-get update -qq
apt-get install -qq git

# Setup SSH deploy keys
apt-get install -qq openssh-client
eval $(ssh-agent -s)
echo "${SSH_PRIVATE_KEY}"
echo "$SSH_PRIVATE_KEY" | ssh-add -
mkdir -p ~/.ssh
echo -e "Host *\n\tStrictHostKeyChecking no\n\n" > ~/.ssh/config

ssh -T $REMOTE_USER@$REMOTE_HOST "cd $REMOTE_TARGET && touch testing.txt"
echo "Finished deploy"