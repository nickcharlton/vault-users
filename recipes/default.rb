#
# Cookbook Name:: vault-users
# Recipe:: default
#
# Copyright 2013, Nick Charlton
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

chef_gem 'chef-vault'
require 'chef-vault'

vault = ChefVault::Item.load('secrets', 'users')

vault['users'].each do |u|
  user u['username'] do
    password u['password']
    home u['home']
    shell u['shell']
    comment u['comment']
    system true
    supports :manage_home => true
    action :create
  end

  group u['group'] do
    members u['username']
    append true
  end

  directory "#{u['home']}/.ssh" do
    owner u['username']
    group u['username']
    mode 0700
  end

  file "#{u['home']}/.ssh/authorized_keys" do
    content u['authorized_keys'].join('\n')
    owner u['username']
    group u['username']
    mode 0600
  end
end
