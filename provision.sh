#!/usr/bin/env bash

echo "checking for ansible binary"
if ! [ `which ansible` ]; then
  echo "no ansible installed.  Installing..."
  pacman -S --noconfirm ansible
fi

#if ! [ -d "/etc/ansible/roles/leonidas.nvm" ]; then
#  ansible-galaxy install leonidas.nvm
#fi

#if ! [ -d "/etc/ansible/roles/rvm_io.rvm1-ruby" ]; then
#  ansible-galaxy install rvm_io.rvm1-ruby
#fi

if ! [ -f "/srv/ansible/hosts" ]; then
  echo "hosts file not found at /srv/ansible/hosts"
  exit -1
fi

if ! [ -f "/srv/ansible/playbook.yml" ]; then
  echo "playbook not found at /srv/ansible/playbook.yml"
  exit -1
fi

echo "running: ansible-playbook -i /srv/ansible/hosts /srv/ansible/playbook.yml"
ansible-playbook -i /srv/ansible/hosts /srv/ansible/playbook.yml
