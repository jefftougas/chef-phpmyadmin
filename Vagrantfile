# encoding: utf-8
# -*- mode: ruby -*-
# vi: set ft=ruby :
#
# Author:: Vid Luther (vid@pressable.com)
#
# Copyright 2014, Vid Luther
#
# Licensed under the Apache License, Version 2.0 (the 'License');
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an 'AS IS' BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#
  
Vagrant.configure('2') do |config|

  config.berkshelf.enabled = true
  config.omnibus.chef_version = :latest

  config.vm.box_url = "https://opscode-vm-bento.s3.amazonaws.com/vagrant/opscode_ubuntu-12.04_provisionerless.box"
  config.vm.box = "opscode_ubuntu-12.04_provisionerless"

  # The ip address we'll assign to this virtual machine
  config.vm.network :private_network, ip: "33.33.33.10"
  config.vm.network :public_network

  # If you want to login to the box directly in a window, instead of just doing
  # vagrant ssh, set this to true. 
  config.vm.provider :virtualbox do |v|
    v.gui = false
  end

  config.vm.box = 'ubuntu'
  config.vm.hostname = 'phpmyadmin'
  config.vm.provision :chef_solo do |chef|
    chef.arguments = '-Fdoc'
    chef.run_list = [
      'recipe[phpmyadmin::server]',
      'recipe[phpmyadmin::pma]'
    ]

  end
end
