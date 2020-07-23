#!/bin/sh -l

apt-get update -qq
apt-get install -qq git

# Setup SSH deploy keys
apt-get install -qq openssh-client
eval $(ssh-agent -s)
ssh-add - <<< "${SSH_PRIVATE_KEY}"
mkdir -p ~/.ssh
echo -e "Host *\n\tStrictHostKeyChecking no\n\n" > ~/.ssh/config

bash -c 'ssh $REMOTE_USER@$REMOTE_HOST "cd $REMOTE_TARGET && touch testing.txt"'
echo "Finished deploy"