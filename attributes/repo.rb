default['elasticsearch']['yum']['gpgcheck'] = true
default['elasticsearch']['yum']['enabled'] = true
default['elasticsearch']['yum']['gpgkey'] = 'https://packages.elasticsearch.org/GPG-KEY-elasticsearch'
default['elasticsearch']['yum']['mirrorlist'] = nil
default['elasticsearch']['yum']['action'] = :create

default['elasticsearch']['apt']['components'] = %w(stable main)
default['elasticsearch']['apt']['action'] = :add
default['elasticsearch']['apt']['distribution'] = ''
default['elasticsearch']['apt']['options'] = nil
default['elasticsearch']['apt']['key'] = 'http://packages.elasticsearch.org/GPG-KEY-elasticsearch'
