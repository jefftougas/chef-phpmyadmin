#
# Cookbook Name:: phpmyadmin4
# Recipe:: default
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

# Install the Percona MySQL Client
include_recipe 'percona::client'
include_recipe 'percona::server'

include_recipe 'percona::toolkit'


package "apt-transport-https" do
  action :upgrade
end

include_recipe 'phpmyadmin4::server'
include_recipe 'phpmyadmin4::pma'

