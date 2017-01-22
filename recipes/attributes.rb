#
# Cookbook Name:: elasticsearch-cluster
# Recipe:: attributes
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

node.default['elasticsearch']['conf_file'] = ::File.join(node['elasticsearch']['conf_dir'], 'elasticsearch.yml')
node.default['elasticsearch']['logging_conf_file'] = ::File.join(node['elasticsearch']['conf_dir'], 'logging.yml')
node.default['elasticsearch']['install_dir'] = ::File.join(node['elasticsearch']['parent_dir'], 'elasticsearch')
node.default['elasticsearch']['source_dir'] = ::File.join(node['elasticsearch']['parent_dir'], "elasticsearch-#{node['elasticsearch']['version']}")
node.default['elasticsearch']['home_dir'] = node['elasticsearch']['install_method'] == 'package' ? '/usr/share/elasticsearch' : node['elasticsearch']['install_dir']
node.default['elasticsearch']['bin_dir'] = ::File.join(node['elasticsearch']['home_dir'], 'bin')
node.default['elasticsearch']['plugins_dir'] = node['elasticsearch']['install_method'] == 'package' ? '/usr/share/elasticsearch/plugins' : ::File.join(node['elasticsearch']['install_dir'], 'plugins')

#################################### ES v1.x, 2.x configuration path parameters ####################################
node.default['elasticsearch']['config']['path.conf'] = node['elasticsearch']['conf_dir']
node.default['elasticsearch']['config']['path.data'] = node['elasticsearch']['data_dir']
node.default['elasticsearch']['config']['path.work'] = node['elasticsearch']['work_dir']
node.default['elasticsearch']['config']['path.logs'] = node['elasticsearch']['log_dir']
node.default['elasticsearch']['config']['path.plugins'] = node['elasticsearch']['plugins_dir']
node.default['elasticsearch']['config']['path.scripts'] = node['elasticsearch']['scripts_dir']

# version specific configuration options
if node['elasticsearch']['version'] >= '2.0'
  repo_version = node['elasticsearch']['version'].split('.')[0].to_s + '.x'
  node.default['elasticsearch']['config']['script.inline'] = 'sandbox'
  node.default['elasticsearch']['config']['script.indexed'] = 'sandbox'
  node.default['elasticsearch']['config']['script.file'] = 'on'
else
  repo_version = node['elasticsearch']['version'].split('.').take(2).join('.')
  node.default['elasticsearch']['config']['script.disable_dynamic'] = true
end

node.default['elasticsearch']['yum']['description'] = "ElasticSearch #{repo_version} repository"
node.default['elasticsearch']['apt']['description'] = "ElasticSearch #{repo_version} repository"

if node['elasticsearch']['version'] >= '5.0'
  node.default['elasticsearch']['plugins_binary'] = ::File.join(node['elasticsearch']['bin_dir'], 'elasticsearch-plugin')
  node.default['elasticsearch']['yum']['baseurl'] = "https://artifacts.elastic.co/packages/#{repo_version}/yum"
  node.default['elasticsearch']['yum']['gpgkey'] = 'https://artifacts.elastic.co/GPG-KEY-elasticsearch'
  node.default['elasticsearch']['apt']['uri'] = "https://artifacts.elastic.co/packages/#{repo_version}/apt"
else
  node.default['elasticsearch']['plugins_binary'] = ::File.join(node['elasticsearch']['bin_dir'], 'plugin')
  node.default['elasticsearch']['yum']['baseurl'] = "http://packages.elastic.co/elasticsearch/#{repo_version}/centos"
  node.default['elasticsearch']['apt']['uri'] = "http://packages.elastic.co/elasticsearch/#{repo_version}/debian"
end
