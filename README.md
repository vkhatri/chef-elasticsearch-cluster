elasticsearch-cluster Cookbook
==============================

[![Build Status](https://travis-ci.org/vkhatri/chef-elasticsearch-cluster.svg?branch=master)](https://travis-ci.org/vkhatri/chef-elasticsearch-cluster)

This is a [Chef] cookbook to manage [ElasticSearch] Cluster.

More features and attributes will be added over time, **feel free to contribute**
what you find missing!

>> For Production environment, always refer to [Chef Supermarket].


## Repository

https://github.com/vkhatri/chef-elasticsearch-cluster


## Supported OS

This cookbook was tested on Amazon (2015-03) & Ubuntu (14.04) Linux and expected to work on similar platform family OS.


## Supported ElasticSearch Version

This cookbook was tested for ElasticSearch v1.6.0.


## Supported ElasticSearch Deployment

This cookbook supports both Package and Tarball based installation.


## Cookbook Dependencies

* `java` cookbook
* `yum` cookbook
* `apt` cookbook


# TODO

- add LWRP to manage plugins
- add LWRP to manage indexes


## Recipes

- `elasticsearch-cluster::default` - default recipe (use it for run_list)

- `elasticsearch-cluster::install` - install elasticsearch via package or tarball

- `elasticsearch-cluster::java` - install java using `java` cookbook

- `elasticsearch-cluster::package` - install elasticsearch using repository package

- `elasticsearch-cluster::tarball` - install elasticsearch using tarball

- `elasticsearch-cluster::user` - setup user/group for elasticsearch service

- `elasticsearch-cluster::config` - configure elasticsearch


## Cookbook Advanced Attributes

* `default['elasticsearch']['config']['cluster.name']` (default: `nil`): elasticsearch cluster name, required to setup elasticsearch cluster

* `default['elasticsearch']['install_method']` (default: `package`): elasticsearch install method, options: package tarball

* `default['elasticsearch']['install_java']` (default: `true`): whether to install java using cookbook `java`

* `default['elasticsearch']['service_action']` (default: `[:enable, :start]`): elasticsearch service resource action

* `default['elasticsearch']['notify_restart']` (default: `false`): whether to notify elasticsearch service on any config change

* `default['elasticsearch']['setup_user']` (default: `true`): whether to setup elasticsearch service user when installing via tarball

* `default['elasticsearch']['cookbook']` (default: `elasticsearch-cluster`): cookbook to use for elasticsearch configuration file/template source

* `default['elasticsearch']['auto_java_memory']` (default: `false`): whether to allocate maximum possible heap size

* `default['elasticsearch']['auto_system_memory']` (default: `768`): minimum memory to keep for OS while allocating maximum possible memory to elasticsearch, used with node['elasticsearch']['auto_java_memory']

* `default['elasticsearch']['use_chef_search']` (default: `false`): whether to use Chef Search to find elasticsearch cluster nodes in an environment
for a given chef elasticsearch role

* `default['elasticsearch']['search_role_name']` (default: `elasticsearch_cluster`): chef role associated with elasticsearch nodes which add this cookbook
to elasticsearch nodes run list

* `default['elasticsearch']['search_cluster_name_attr']` (default: `nil`): node attribute to match elasticsearch cluster name, not necessary applicable to all

## Cookbook Core Attributes

* `default['elasticsearch']['version']` (default: `1.6.0`): elasticsearch version to install

* `default['elasticsearch']['version_suffix']` (default: `calculated`): elasticsearch package version suffix

* `default['elasticsearch']['user']` (default: `elasticsearch`): elasticsearch service user

* `default['elasticsearch']['group']` (default: `elasticsearch`): elasticsearch service group

* `default['elasticsearch']['conf_dir']` (default: `/etc/elasticsearch`): elasticsearch configuration directory

* `default['elasticsearch']['data_dir']` (default: `/var/lib/elasticsearch`): elasticsearch data directory

* `default['elasticsearch']['log_dir']` (default: `/var/log/elasticsearch`): elasticsearch log directory

* `default['elasticsearch']['work_dir']` (default: `/tmp/elasticsearch`): elasticsearch temporary files directory

* `default['elasticsearch']['plugins_dir']` (default: `calcualted`): elasticsearch plugins directory

* `default['elasticsearch']['conf_file']` (default: `/etc/elasticsearch/elasticsearch.yml`): elasticsearch configuration file

* `default['elasticsearch']['tarball_url']` (default: `calculated`): elasticsearch tarball source url

* `default['elasticsearch']['tarball_checksum']` (default: `versions`): elasticsearch tarball version source sha256sum

* `default['elasticsearch']['parent_dir']` (default: `/usr/local/elasticsearch`): elasticsearch directory for tarball based installation

* `default['elasticsearch']['install_dir']` (default: `/usr/local/elasticsearch/elasticsearch`): elasticsearch symlink to current version source directory (for tarball based installation)

* `default['elasticsearch']['source_dir']` (default: `/usr/local/elasticsearch`): elasticsearch current version directory (for tarball based installation)

* `default['elasticsearch']['home_dir']` (default: `calculated`): elasticsearch home directory

* `default['elasticsearch']['sysconfig_file']` (default: `calculated`): elasticsearch service config file location

* `default['elasticsearch']['umask']` (default: `0022`): file/directory umask for execute resource (for tarball based installation)

* `default['elasticsearch']['mode']` (default: `0755`): file/directory resource mode


# Service Attributes

* `default['elasticsearch']['sysconfig']['ES_HEAP_NEWSIZE']` (default: `calculated`): elasticsearch service config file parameter

* `default['elasticsearch']['sysconfig']['ES_DIRECT_SIZE']` (default: `nil`): elasticsearch service config file parameter

* `default['elasticsearch']['sysconfig']['ES_JAVA_OPTS']` (default: `nil`): elasticsearch service config file parameter

* `default['elasticsearch']['sysconfig']['MAX_OPEN_FILES']` (default: `65_535`): elasticsearch service config file parameter

* `default['elasticsearch']['sysconfig']['MAX_LOCKED_MEMORY']` (default: `unlimited`): elasticsearch service config file parameter

* `default['elasticsearch']['sysconfig']['MAX_MAP_COUNT']` (default: `262_144`): elasticsearch service config file parameter

* `default['elasticsearch']['sysconfig']['ES_RESTART_ON_UPGRADE']` (default: `true`): elasticsearch service config file parameter

* `default['elasticsearch']['sysconfig']['ES_HEAP_SIZE']` (default: `calculated`): elasticsearch service config file parameter


# ElasticSearch Configuration File Attributes


* `default['elasticsearch']['config']['cluster.name']` (default: `nil`): elasticsearch configuration parameter

* `default['elasticsearch']['config']['node.name']` (default: `node.name`): elasticsearch configuration parameter

* `default['elasticsearch']['config']['node.master']` (default: `true`): elasticsearch configuration parameter

* `default['elasticsearch']['config']['node.data']` (default: `true`): elasticsearch configuration parameter

* `default['elasticsearch']['config']['node.max_local_storage_nodes']` (default: `1`): elasticsearch configuration parameter

* `default['elasticsearch']['config']['index.number_of_shards']` (default: `5`): elasticsearch configuration parameter

* `default['elasticsearch']['config']['index.number_of_replicas']` (default: `1`): elasticsearch configuration parameter

* `default['elasticsearch']['config']['path.conf']` (default: `node['elasticsearch']['conf_dir']`): elasticsearch configuration parameter

* `default['elasticsearch']['config']['path.data']` (default: `node['elasticsearch']['data_dir']`): elasticsearch configuration parameter

* `default['elasticsearch']['config']['path.work']` (default: `node['elasticsearch']['work_dir']`): elasticsearch configuration parameter

* `default['elasticsearch']['config']['path.logs']` (default: `node['elasticsearch']['log_dir']`): elasticsearch configuration parameter

* `default['elasticsearch']['config']['path.plugins']` (default: `node['elasticsearch']['plugins_dir']`): elasticsearch configuration parameter

* `default['elasticsearch']['config']['bootstrap.mlockall']` (default: `true`): elasticsearch configuration parameter

* `default['elasticsearch']['config']['network.bind_host']` (default: `node['ipaddress']`): elasticsearch configuration parameter

* `default['elasticsearch']['config']['network.publish_host']` (default: `node['ipaddress']`): elasticsearch configuration parameter

* `default['elasticsearch']['config']['transport.tcp.port']` (default: `9300`): elasticsearch configuration parameter

* `default['elasticsearch']['config']['transport.tcp.compress']` (default: `true`): elasticsearch configuration parameter

* `default['elasticsearch']['config']['http.port']` (default: `9200`): elasticsearch configuration parameter

* `default['elasticsearch']['config']['discovery.zen.minimum_master_nodes']` (default: `1`): elasticsearch configuration parameter

* `default['elasticsearch']['config']['discovery.zen.ping.timeout']` (default: `3s`): elasticsearch configuration parameter

* `default['elasticsearch']['config']['discovery.zen.ping.multicast.enabled']` (default: `false`): elasticsearch configuration parameter

* `default['elasticsearch']['config']['discovery.zen.ping.unicast.hosts']` (default: `[]`): elasticsearch configuration parameter

* `default['elasticsearch']['config']['action.auto_create_index']` (default: `true`): elasticsearch configuration parameter

* `default['elasticsearch']['config']['action.disable_delete_all_indices']` (default: `true`): elasticsearch configuration parameter

* `default['elasticsearch']['config']['script.disable_dynamic']` (default: `true`): elasticsearch configuration parameter



## Contributing

1. Fork the repository on Github
2. Create a named feature branch (like `add_component_x`)
3. Write your change
4. Write tests for your change (if applicable)
5. Run the tests (`rake & rake knife`), ensuring they all pass
6. Write new resource/attribute description to `README.md`
7. Write description about changes to PR
8. Submit a Pull Request using Github


## Copyright & License

Authors:: Virender Khatri and [Contributors]

<pre>
Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
</pre>


[Chef]: https://www.chef.io/
[ElasticSearch]: https://www.elastic.co/products/elasticsearch
[Contributors]: https://github.com/vkhatri/chef-elasticsearch-cluster/graphs/contributors
[Chef Supermarket]: https://supermarket.chef.io/cookbooks/elasticsearch-cluster
