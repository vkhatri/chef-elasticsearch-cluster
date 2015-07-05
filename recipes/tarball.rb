#
# Cookbook Name:: elasticsearch-cluster
# Recipe:: tarball
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

include_recipe 'elasticsearch-cluster::user'

[node['elasticsearch']['parent_dir']
].each do |dir|
  directory dir do
    owner node['elasticsearch']['user']
    group node['elasticsearch']['group']
    mode node['elasticsearch']['mode']
    recursive true
  end
end

tarball_file  = ::File.join(node['elasticsearch']['parent_dir'], ::File.basename(node['elasticsearch']['tarball_url']))

# stop elasticsearch service if running for upgrade
service 'elasticsearch' do
  service_name 'elasticsearch'
  action :stop
  only_if { ::File.exist?('/etc/init.d/elasticsearch') && !File.exist?(node['elasticsearch']['source_dir']) }
end

# download tarball
remote_file tarball_file do
  source node['elasticsearch']['tarball_url']
  checksum node['elasticsearch']['tarball_checksum'][node['elasticsearch']['version']]
  owner node['elasticsearch']['user']
  group node['elasticsearch']['group']
  not_if { ::File.exist?(::File.join(node['elasticsearch']['source_dir'], 'bin', 'elasticsearch')) }
end

# extract tarball
execute 'extract_elasticsearch_tarball' do
  user node['elasticsearch']['user']
  group node['elasticsearch']['group']
  umask node['elasticsearch']['umask']
  cwd node['elasticsearch']['parent_dir']
  command "tar xzf #{tarball_file}"
  creates ::File.join(node['elasticsearch']['source_dir'], 'bin', 'elasticsearch')
end

remote_file tarball_file do
  action :delete
end

link node['elasticsearch']['install_dir'] do
  to node['elasticsearch']['source_dir']
  owner node['elasticsearch']['user']
  group node['elasticsearch']['group']
  notifies :restart, 'service[elasticsearch]', :delayed if node['elasticsearch']['notify_restart']
  action :create
end

# sysv init file
template '/etc/init.d/elasticsearch' do
  cookbook node['elasticsearch']['cookbook']
  source "initd.#{node['platform_family']}.erb"
  owner 'root'
  group 'root'
  mode 0755
  notifies :restart, 'service[elasticsearch]', :delayed if node['elasticsearch']['notify_restart']
end
