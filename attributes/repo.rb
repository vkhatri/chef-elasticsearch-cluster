default['elasticsearch']['repo_version'] = node['elasticsearch']['version'].split('.').take(2).join('.')

default['elasticsearch']['yum']['description'] = "ElasticSearch #{node['elasticsearch']['repo_version']} repository"
default['elasticsearch']['yum']['gpgcheck'] = true
default['elasticsearch']['yum']['enabled'] = true
default['elasticsearch']['yum']['baseurl'] = "http://packages.elasticsearch.org/elasticsearch/#{node['elasticsearch']['repo_version']}/centos"
default['elasticsearch']['yum']['gpgkey'] = 'https://packages.elasticsearch.org/GPG-KEY-elasticsearch'
default['elasticsearch']['yum']['mirrorlist'] = nil
default['elasticsearch']['yum']['action'] = :create

default['elasticsearch']['apt']['description'] = "ElasticSearch #{node['elasticsearch']['repo_version']} repository"
default['elasticsearch']['apt']['components'] = %w(stable main)
default['elasticsearch']['apt']['action'] = :add
default['elasticsearch']['apt']['uri'] = "http://packages.elasticsearch.org/elasticsearch/#{node['elasticsearch']['repo_version']}/debian"
default['elasticsearch']['apt']['key'] = 'http://packages.elasticsearch.org/GPG-KEY-elasticsearch' # 'D88E42B4'
