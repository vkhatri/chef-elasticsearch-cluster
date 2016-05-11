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

tarball_url = if node['elasticsearch']['tarball_url'] == 'auto'
                node['elasticsearch']['version'].split('.')[0] >= '2' ? "https://download.elasticsearch.org/elasticsearch/release/org/elasticsearch/distribution/tar/elasticsearch/#{node['elasticsearch']['version']}/elasticsearch-#{node['elasticsearch']['version']}.tar.gz" : "https://download.elastic.co/elasticsearch/elasticsearch/elasticsearch-#{node['elasticsearch']['version']}.tar.gz"
              else
                node['elasticsearch']['tarball_url']
              end

tarball_file = ::File.join(node['elasticsearch']['parent_dir'], ::File.basename(tarball_url))
tarball_checksum = tarball_sha256sum(node['elasticsearch']['version'])

include_recipe 'elasticsearch-cluster::user'

[node['elasticsearch']['parent_dir'],
 node['elasticsearch']['data_dir'],
 node['elasticsearch']['log_dir'],
 node['elasticsearch']['work_dir']].each do |dir|
  directory dir do
    owner node['elasticsearch']['user']
    group node['elasticsearch']['group']
    mode node['elasticsearch']['mode']
    recursive true
  end
end

# stop elasticsearch service if running for upgrade
service 'elasticsearch' do
  service_name 'elasticsearch'
  action :stop
  only_if { ::File.exist?('/etc/init.d/elasticsearch') && !File.exist?(node['elasticsearch']['source_dir']) }
end

# download tarball
remote_file tarball_file do
  source tarball_url
  checksum tarball_checksum
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

file tarball_file do
  action :delete
end

link node['elasticsearch']['install_dir'] do
  to node['elasticsearch']['source_dir']
  notifies :restart, 'service[elasticsearch]'
  action :create
end

# sysv init file
cookbook_file '/etc/init.d/elasticsearch' do
  cookbook node['elasticsearch']['cookbook']
  source "initd.#{node['platform_family']}.#{node['elasticsearch']['version'].split('.')[0]}.x"
  owner 'root'
  group 'root'
  mode 0755
  notifies :restart, 'service[elasticsearch]' if node['elasticsearch']['notify_restart']
end

# purge older versions
ruby_block 'purge-old-tarball' do
  block do
    require 'fileutils'
    installed_versions = Dir.entries(node['elasticsearch']['parent_dir']).reject { |a| a !~ /^elasticsearch-/ }.sort
    old_versions = installed_versions - ["elasticsearch-#{node['elasticsearch']['version']}"]

    old_versions.each do |v|
      v = ::File.join(node['elasticsearch']['parent_dir'], v)
      FileUtils.rm_rf Dir.glob(v)
      puts "deleted older elasticsearch tarball archive #{v}"
      Chef::Log.warn("deleted older elasticsearch tarball archive #{v}")
    end
  end
  only_if { node['elasticsearch']['tarball_purge'] }
end
