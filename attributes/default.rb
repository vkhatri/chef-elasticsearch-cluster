default['elasticsearch']['version'] = '5.1.2'
default['elasticsearch']['sha256sum'] = nil
default['elasticsearch']['version_suffix'] = value_for_platform_family(
  'debian' => '',
  'rhel' => '-1'
)

default['elasticsearch']['install_method']  = 'package' # options: package tarball
default['elasticsearch']['install_java']    = true
default['elasticsearch']['tarball_purge'] = false

# cookbook for configuration files template resources
default['elasticsearch']['cookbook'] = 'elasticsearch-cluster'

default['elasticsearch']['user']          = 'elasticsearch'
default['elasticsearch']['group']         = 'elasticsearch'
default['elasticsearch']['setup_user']    = true # for tarball install

default['elasticsearch']['enable_sensitive'] = true
default['elasticsearch']['conf_dir']      = '/etc/elasticsearch'
default['elasticsearch']['scripts_dir']   = '/etc/elasticsearch/scripts'
default['elasticsearch']['data_dir']      = '/var/lib/elasticsearch'
default['elasticsearch']['log_dir']       = '/var/log/elasticsearch'
default['elasticsearch']['work_dir']      = '/tmp/elasticsearch'

# source install directory locations
default['elasticsearch']['parent_dir'] = '/usr/local/elasticsearch'

default['elasticsearch']['sysconfig_file'] = value_for_platform_family(
  'debian' => '/etc/default/elasticsearch',
  'rhel' => '/etc/sysconfig/elasticsearch'
)

default['elasticsearch']['tarball_url'] = 'auto'

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
default['elasticsearch']['sysconfig']['MAX_OPEN_FILES']         = 65_536
default['elasticsearch']['sysconfig']['MAX_LOCKED_MEMORY']      = 'unlimited'
default['elasticsearch']['sysconfig']['MAX_MAP_COUNT']          = 262_144
default['elasticsearch']['sysconfig']['ES_RESTART_ON_UPGRADE']  = true

default['elasticsearch']['databag_configs'] = nil
default['elasticsearch']['scripts'] = {}
default['elasticsearch']['jvm_options_file'] = '/etc/elasticsearch/jvm.options'

# set this attribute to an entirely different key attribute under
# node['elasticsearch']['XYZ']. this allows users to ignore default
# config attributes completely
default['elasticsearch']['config_attribute'] = nil
