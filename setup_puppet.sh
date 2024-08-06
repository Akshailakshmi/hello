#!/bin/bash

# Set the Puppet master server and port
PUPPET_MASTER="puppet.example.com"
PUPPET_PORT="8080"

# Install Puppet
sudo apt-get update
sudo apt-get install -y puppet

# Configure the Puppet agent
sudo sed -i "s/#server =.*/server = ${PUPPET_MASTER}:${PUPPET_PORT}/g" /etc/puppetlabs/puppet/puppet.conf
sudo sed -i "s/#certname =.*/certname = $(hostname -f)/g" /etc/puppetlabs/puppet/puppet.conf

# Start the Puppet agent and enable it to start at boot
sudo systemctl start puppet
sudo systemctl enable puppet

# Run the Puppet agent to connect to the master server
sudo puppet agent --test --server ${PUPPET_MASTER}:${PUPPET_PORT}

# Output a success message
echo "Puppet agent setup complete!"
