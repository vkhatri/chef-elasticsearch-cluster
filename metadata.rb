name 'elasticsearch-cluster'
maintainer 'Virender Khatri'
maintainer_email 'vir.khatri@gmail.com'
license 'Apache 2.0'
description 'Installs/Configures ElasticSearch Cluster'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version '0.5.6'

source_url 'https://github.com/vkhatri/chef-elasticsearch-cluster' if respond_to?(:source_url)
issues_url 'https://github.com/vkhatri/chef-elasticsearch-cluster/issues' if respond_to?(:issues_url)

%w(java yum apt).each do |d|
  depends d
end

%w(ubuntu centos amazon redhat fedora).each do |os|
  supports os
end
