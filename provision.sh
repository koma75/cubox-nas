#!/usr/bin/env bash

if ! [ `which ansible` ]; then
  apt-get update -y
  apt-get install -y python-software-properties
  apt-add-repository ppa:rquillo/ansible -y
  apt-get update -y
  apt-get install ansible -y
fi

ansible-playbook -i /vagrant/ansible/hosts /vagrant/ansible/playbook.yml
