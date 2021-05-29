#!/bin/bash

###################
# Install ansible #
if ! grep -q "ansible/ansible" /etc/apt/sources.list /etc/apt/sources.list.d/*; then
    echo "Adding Ansible PPA"
    sudo apt-add-repository ppa:ansible/ansible -y
fi

if ! hash ansible >/dev/null 2>&1; then
    echo "Installing Ansible..."
    sudo apt-get update
    sudo apt-get install software-properties-common ansible git python-apt -y
else
    echo "Ansible already installed"
fi

git clone https://github.com/Dash2701/ansible-lamp.git

cd ansible-lamp && ansible-playbook components.yaml