#
# Cookbook Name:: elasticsearch-cluster
# Recipe:: config
#
# Copyright 2015, Virender Khatri
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

fail "require value for node['elasticsearch']['config']['cluster.name']" unless node['elasticsearch']['config']['cluster.name']

directory node['elasticsearch']['conf_dir'] do
  mode node['elasticsearch']['dir_mode']
  action :nothing
end

directory node['elasticsearch']['plugins_dir'] do
  owner node['elasticsearch']['user']
  group node['elasticsearch']['group']
  mode node['elasticsearch']['mode']
end

template node['elasticsearch']['sysconfig_file'] do
  cookbook node['elasticsearch']['cookbook']
  source 'sysconfig.erb'
  owner 'root'
  group 'root'
  mode 0644
  notifies :restart, 'service[elasticsearch]', :delayed if node['elasticsearch']['notify_restart']
end

if node['elasticsearch']['use_chef_search']
  node.default['elasticsearch']['config']['discovery.zen.ping.unicast.hosts'] = search_cluster_nodes(node.chef_environment, node['elasticsearch']['search_role_name'], node['elasticsearch']['search_cluster_name_attr'], node[node['elasticsearch']['search_cluster_name_attr']])
end

config = node['elasticsearch'][node['elasticsearch']['config_attribute']].to_h
node['elasticsearch']['databag_configs'].each do |databag|
  data_bag_item = Chef::EncryptedDataBagItem.load(databag['name'], databag['item'])
  databag['config_items'].each do |k, v|
    config[k] = data_bag_item[v]
  end
end if node['elasticsearch']['databag_configs']

template node['elasticsearch']['conf_file'] do
  cookbook node['elasticsearch']['cookbook']
  source 'elasticsearch.yml.erb'
  owner node['elasticsearch']['user']
  group node['elasticsearch']['group']
  mode 0600
  sensitive true
  variables(:config => config)
  notifies :restart, 'service[elasticsearch]', :delayed if node['elasticsearch']['notify_restart']
end

ruby_block 'delay elasticsearch service start' do
  block do
  end
  notifies :start, 'service[elasticsearch]', :delayed
end

service 'elasticsearch' do
  supports :restart => true, :start => true, :stop => true, :status => true, :reload => false
  action node['elasticsearch']['service_action']
end
