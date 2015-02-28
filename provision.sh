#!/usr/bin/env bash

echo "checking for ansible binary"
if ! [ `which ansible` ]; then
  echo "no ansible installed.  Installing..."
  pacman -Sy --noconfirm ansible
else
  echo found ansible at `which ansible`
fi

#if ! [ -d "/etc/ansible/roles/leonidas.nvm" ]; then
#  ansible-galaxy install leonidas.nvm
#fi

#if ! [ -d "/etc/ansible/roles/rvm_io.rvm1-ruby" ]; then
#  ansible-galaxy install rvm_io.rvm1-ruby
#fi

if ! [ -f "/srv/ansible/hosts" ]; then
  echo "FATAL: hosts file not found at /srv/ansible/hosts"
  echo "make sure Vagrantfile is set up properly"
  exit -1
fi

if ! [ -f "/srv/ansible/playbook.yml" ]; then
  echo "FATAL: playbook not found at /srv/ansible/playbook.yml"
  echo "make sure Vagrantfile is set up properly"
  exit -1
fi

echo "running: ansible-playbook -i /srv/ansible/hosts /srv/ansible/playbook.yml"
ansible-playbook \
  -i /srv/ansible/hosts /srv/ansible/playbook.yml \
  --vault-password-file /srv/ansible/.vault_pass.txt
