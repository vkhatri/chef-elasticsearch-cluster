#
# Cookbook Name:: elasticsearch-cluster
# Recipe:: package
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

case node['platform_family']
when 'debian'
  # apt repository configuration
  apt_repository 'elasticsearch' do
    uri node['elasticsearch']['apt']['uri']
    distribution node['elasticsearch']['apt']['distribution']
    components node['elasticsearch']['apt']['components']
    key node['elasticsearch']['apt']['key']
    action node['elasticsearch']['apt']['action']
  end
when 'rhel'
  # yum repository configuration
  yum_repository 'elasticsearch' do
    description node['elasticsearch']['yum']['description']
    baseurl node['elasticsearch']['yum']['baseurl']
    mirrorlist node['elasticsearch']['yum']['mirrorlist'] if node['elasticsearch']['yum']['mirrorlist']
    gpgcheck node['elasticsearch']['yum']['gpgcheck']
    gpgkey node['elasticsearch']['yum']['gpgkey']
    enabled node['elasticsearch']['yum']['enabled']
    action node['elasticsearch']['yum']['action']
  end
end

# install elasticsearch
package 'elasticsearch' do
  version node['elasticsearch']['version'] + node['elasticsearch']['version_suffix']
  options node['elasticsearch']['apt']['options'] if node['elasticsearch']['apt']['options'] && node['platform_family'] == 'debian'
end

[node['elasticsearch']['data_dir'],
 node['elasticsearch']['log_dir'],
 node['elasticsearch']['work_dir']].each do |dir|
  directory dir do
    owner node['elasticsearch']['user']
    group node['elasticsearch']['group']
    mode node['elasticsearch']['mode']
    recursive true
  end
end
