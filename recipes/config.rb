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

config_attribute = if node['elasticsearch']['config_attribute']
                     node['elasticsearch']['config_attribute']
                   else
                     node['elasticsearch']['version'] >= '5.0' ? 'config_v5' : 'config'
                   end

raise "require value for node['elasticsearch']['#{config_attribute}']['cluster.name']" unless node['elasticsearch'][config_attribute]['cluster.name']

directory node['elasticsearch']['conf_dir'] do
  mode node['elasticsearch']['dir_mode']
end

[node['elasticsearch']['scripts_dir'],
 node['elasticsearch']['plugins_dir']].each do |d|
  directory d do
    owner node['elasticsearch']['user']
    group node['elasticsearch']['group']
    mode node['elasticsearch']['mode']
  end
end

template 'elasticsearch_env_file' do
  path node['elasticsearch']['sysconfig_file']
  cookbook node['elasticsearch']['cookbook']
  source 'sysconfig.erb'
  owner 'root'
  group 'root'
  mode 0644
  notifies :restart, 'service[elasticsearch]' if node['elasticsearch']['notify_restart']
end

if node['elasticsearch']['use_chef_search']
  node.default['elasticsearch']['config']['discovery.zen.ping.unicast.hosts'] = search_cluster_nodes(node.chef_environment, node['elasticsearch']['search_role_name'], node['elasticsearch']['search_cluster_name_attr'], node[node['elasticsearch']['search_cluster_name_attr']])
end

config = node['elasticsearch'][config_attribute].to_h
if node['elasticsearch']['databag_configs']
  node['elasticsearch']['databag_configs'].each do |databag|
    data_bag_item = Chef::EncryptedDataBagItem.load(databag['name'], databag['item'])
    databag['config_items'].each do |k, v|
      config[k] = data_bag_item[v]
    end
  end
end

template node['elasticsearch']['conf_file'] do
  cookbook node['elasticsearch']['cookbook']
  source 'elasticsearch.yml.erb'
  owner node['elasticsearch']['user']
  group node['elasticsearch']['group']
  mode 0600
  sensitive true if node['elasticsearch']['enable_sensitive'] && respond_to?(:sensitive)
  variables(:config => config)
  notifies :restart, 'service[elasticsearch]' if node['elasticsearch']['notify_restart']
end

template node['elasticsearch']['logging_conf_file'] do
  cookbook node['elasticsearch']['cookbook']
  source 'logging.yml.erb'
  owner node['elasticsearch']['user']
  group node['elasticsearch']['group']
  mode 0600
  notifies :restart, 'service[elasticsearch]' if node['elasticsearch']['notify_restart']
end

notify_service_start = if (node['elasticsearch']['service_action'].is_a?(Array) && [:stop, 'stop'].any? { |x| node['elasticsearch']['service_action'].include?(x) }) || node['elasticsearch']['service_action'].to_s == 'stop'
                         false
                       else
                         true
                       end

template node['elasticsearch']['jvm_options_file'] do
  cookbook node['elasticsearch']['cookbook']
  source 'jvm.options.erb'
  owner node['elasticsearch']['user']
  group node['elasticsearch']['group']
  mode 0600
  notifies :restart, 'service[elasticsearch]' if node['elasticsearch']['notify_restart']
end

ruby_block 'delay elasticsearch service start' do
  block do
  end
  notifies :start, 'service[elasticsearch]'
  only_if { notify_service_start }
end

service 'elasticsearch' do
  supports :restart => true, :start => true, :stop => true, :status => true, :reload => false
  action node['elasticsearch']['service_action']
end
