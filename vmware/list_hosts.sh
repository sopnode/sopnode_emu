#!/bin/bash
touch hosts

if [[ $1 == 'add' ]]
then
  ip=$(vagrant ssh $2 -c "ip -4 addr show  eth0 | grep -oP '(?<=inet\s)\d+(\.\d+){3}'")
  echo "$ip $2" >> hosts
fi

if [[ $1 == 'rm' ]]
then
  sed -ie "/ $2\$/d" hosts
fi
