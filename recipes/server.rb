#
# Cookbook Name:: phpmyadmin4
# Recipe:: server
#
# Copyright 2014 Pressable
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

require 'digest/sha1'

include_recipe 'apt'
include_recipe 'apt-dotdeb'
include_recipe 'percona::toolkit'

# Install the Percona MySQL Server

include_recipe 'percona::server'

#include_recipe 'percona::client'

# MySQL Root User password when running chef-solo will be "solotesting"
unless Chef::Config[:solo] || node[:percona][:server][:root_password]
  node.set['percona']['server']['root_password'] = "therootisonfire"
  node.save
end

# Password for the system user of mysql  chef-solo will be "solotesting"
unless Chef::Config[:solo] || node[:percona][:server][:debian_password]
  node.set['percona']['server']['debian_password'] = "thesystemisonfire"
  node.save
end




package "apt-transport-https" do
  action :upgrade
end

## Install some basic utilities that we need/want.
package "htop"
package "redis-server"
package "redis-tools"
package "memcached"
package "apache2"

# Go through the list of packages mentioned in attributes/default.rb
# and install them.

node['pr-php']['packages'].each do |package_name, version_to_install|
  unless version_to_install == false
    package package_name do
      version version_to_install
    end
  end
end



