default['elasticsearch']['version'] = '1.7.2'
default['elasticsearch']['version_suffix'] = value_for_platform_family(
  'debian' => '',
  'rhel' => '-1'
)

default['elasticsearch']['install_method']  = 'package' # options: package tarball
default['elasticsearch']['install_java']    = true

# cookbook for configuration files template resources
default['elasticsearch']['cookbook'] = 'elasticsearch-cluster'

default['elasticsearch']['user']          = 'elasticsearch'
default['elasticsearch']['group']         = 'elasticsearch'
default['elasticsearch']['setup_user']    = true # for tarball install

default['elasticsearch']['conf_dir']      = '/etc/elasticsearch'
default['elasticsearch']['data_dir']      = '/var/lib/elasticsearch'
default['elasticsearch']['log_dir']       = '/var/log/elasticsearch'
default['elasticsearch']['work_dir']      = '/tmp/elasticsearch'
default['elasticsearch']['conf_file']     = ::File.join(node['elasticsearch']['conf_dir'], 'elasticsearch.yml')

default['elasticsearch']['tarball_url'] = "https://download.elastic.co/elasticsearch/elasticsearch/elasticsearch-#{node['elasticsearch']['version']}.tar.gz"

# source install directory locations
default['elasticsearch']['parent_dir']   = '/usr/local/elasticsearch'
default['elasticsearch']['install_dir']  = ::File.join(node['elasticsearch']['parent_dir'], 'elasticsearch')
default['elasticsearch']['source_dir']   = ::File.join(node['elasticsearch']['parent_dir'], "elasticsearch-#{node['elasticsearch']['version']}")

default['elasticsearch']['home_dir'] = node['elasticsearch']['install_method'] == 'package' ? '/usr/share/elasticsearch' : node['elasticsearch']['install_dir']

default['elasticsearch']['bin_dir'] = ::File.join(node['elasticsearch']['home_dir'], 'bin')

default['elasticsearch']['plugins_dir'] = node['elasticsearch']['install_method'] == 'package' ? '/usr/share/elasticsearch/plugins' : ::File.join(node['elasticsearch']['parent_dir'], 'plugins')
default['elasticsearch']['plugins_binary'] = ::File.join(node['elasticsearch']['bin_dir'], 'plugin')

default['elasticsearch']['sysconfig_file'] = value_for_platform_family(
  'debian' => '/etc/default/elasticsearch',
  'rhel' => '/etc/sysconfig/elasticsearch'
)

default['elasticsearch']['service_action'] = [:enable]

default['elasticsearch']['notify_restart'] = false

default['elasticsearch']['umask'] = '0022'
default['elasticsearch']['mode']  = '0755'

default['elasticsearch']['use_chef_search'] = false
default['elasticsearch']['search_role_name'] = 'elasticsearch_cluster'
default['elasticsearch']['search_cluster_name_attr'] = nil # 'cluster_name'

default['elasticsearch']['sysconfig']['ES_HEAP_NEWSIZE']        = nil
default['elasticsearch']['sysconfig']['ES_DIRECT_SIZE']         = nil
default['elasticsearch']['sysconfig']['ES_JAVA_OPTS']           = nil
default['elasticsearch']['sysconfig']['MAX_OPEN_FILES']         = 65_535
default['elasticsearch']['sysconfig']['MAX_LOCKED_MEMORY']      = 'unlimited'
default['elasticsearch']['sysconfig']['MAX_MAP_COUNT']          = 262_144
default['elasticsearch']['sysconfig']['ES_RESTART_ON_UPGRADE']  = true

default['elasticsearch']['databag_configs'] = nil
