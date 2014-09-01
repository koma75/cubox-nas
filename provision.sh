#!/usr/bin/env bash

if ! [ `which ansible` ]; then
  apt-get update -y
  apt-get install -y python-software-properties
  apt-add-repository ppa:rquillo/ansible -y
  apt-get update -y
  apt-get install ansible -y
fi

if ! [ -d "/etc/ansible/roles/leonidas.nvm" ]; then
  ansible-galaxy install leonidas.nvm
fi

if ! [ -d "/etc/ansible/roles/rvm_io.rvm1-ruby" ]; then
  ansible-galaxy install rvm_io.rvm1-ruby
fi

ansible-playbook -i /vagrant/ansible/hosts /vagrant/ansible/playbook.yml
