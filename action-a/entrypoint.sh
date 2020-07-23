#!/bin/sh -l

apt-get update -qq
apt-get install -qq git

# Setup SSH deploy keys
apt-get install -qq openssh-client
apt-get install -qq sshpass
eval $(ssh-agent -s)
echo "$SSH_PRIVATE_KEY" | ssh-add -
mkdir -p ~/.ssh
echo -e "Host *\n\tStrictHostKeyChecking no\n\tAddKeysToAgent yes\n\n" > ~/.ssh/config

sshpass -p "$REMOTE_HOST" ssh -T $REMOTE_USER@$REMOTE_HOST "cd $REMOTE_TARGET && touch testing.txt && exit"
echo "Finished deploy"