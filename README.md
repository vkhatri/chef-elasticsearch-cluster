elasticsearch-cluster Cookbook
==============================

[![Cookbook](https://img.shields.io/github/tag/vkhatri/chef-elasticsearch-cluster.svg)](https://github.com/vkhatri/chef-elasticsearch-cluster) [![Build Status](https://travis-ci.org/vkhatri/chef-elasticsearch-cluster.svg?branch=master)](https://travis-ci.org/vkhatri/chef-elasticsearch-cluster)

This is a [Chef] cookbook to manage [ElasticSearch] Cluster.

More features and attributes will be added over time, **feel free to contribute**
what you find missing!

>> For Production environment, always prefer the [most recent release](https://supermarket.chef.io/cookbooks/elasticsearch-cluster).

## Dependency

### Most Recent Release

``` ruby
cookbook 'elasticsearch-cluster', '~> 0.5.6'
```

### From Git

``` ruby
cookbook 'elasticsearch-cluster', github: 'vkhatri/chef-elasticsearch-cluster',  tag: 'v0.5.6'
```

## Repository

```
https://github.com/vkhatri/chef-elasticsearch-cluster
```


## Supported OS

This cookbook was tested on Amazon (2015-03) & Ubuntu (14.04) Linux and expected to work on similar platform family OS.


## Supported ElasticSearch Version

This cookbook was tested for ElasticSearch v1.6.0+.


## Supported ElasticSearch Deployment

This cookbook supports both Package and Tarball based installation.


## Cookbook Dependencies

* `java` cookbook
* `yum` cookbook
* `apt` cookbook


# TODO

- add more locations to nginx vhost
- add specs


## Recipes

- `elasticsearch-cluster::default` - default recipe (use it for run_list)

- `elasticsearch-cluster::install` - install elasticsearch via package or tarball

- `elasticsearch-cluster::java` - install java using `java` cookbook

- `elasticsearch-cluster::package` - install elasticsearch using repository package

- `elasticsearch-cluster::tarball` - install elasticsearch using tarball

- `elasticsearch-cluster::user` - create elasticsearch user/group when `node['elasticsearch']['install_method']` is set to `tarball`

- `elasticsearch-cluster::config` - configure elasticsearch

- `elasticsearch-cluster::plugins` - install / remove plugins using node attribute `node['elasticsearch']['plugins']`

- `elasticsearch-cluster::scripts` - install / remove scripts using node attribute `node['elasticsearch']['scripts']`


## HWRP elasticsearch_plugin

HWRP `elasticsearch_plugin` manages elasticsearch plugins install / remove. It is a wrapper for `plugin` binary.

For plugins validation (exists or not), it uses node API call to verify wheter required plugin or plugin version is installed.

>> `version` is evaluated to verify the correct installed `version`. Github plugins version `vX.Y.Z` is not the same as plugin installed version `X.Y.Z` discovered by provider. Check provider for more details.

**Install Plugin**

	elasticsearch_plugin 'cloud-aws' do
	  install_source   'elasticsearch/elasticsearch-cloud-aws'
	  version        '2.7.0'
	end

	elasticsearch_plugin 'kopf' do
	  install_source 'lmenezes/elasticsearch-kopf'
	end

Above HWRP resource will install two plugins: `cloud-aws` and `kopf`.

**Remove Plugin**

	elasticsearch_plugin 'kopf' do
	  action :remove
	end

Above HWRP resource will remove the `kopf` plugin.


**HWRP Options**

- *action* (optional)	- default :install, options: :install, :remove, :nothing
- *host* (optional, String)	- elasticsearch host (default: `node['elasticsearch']['config']['network.bind_host']`)
- *port* (optional, Integer)	- elasticsearch port (default: `node['elasticsearch']['config']['http.port']`)
- *install_source* (optional, String)	- plugin source to install, e.g. to install `kopf` plugin, `install_source` would be `lmenezes/elasticsearch-kopf`
- *url* (optional, String)	- plugin url
- *timeout* (optional, String)	- plugin install timeout
- *notify_restart* (optional, TrueClass, FalseClass)	- whether to restart elasticsearch service post plugin install (default: `false`)
- *ignore_error* (optional, TrueClass,FlaseClass)	- whether to ignore error like unable to fetch installed plugins when service is down, could ignore other errors in the future (default: `true`)
- *version* (optional, String)	- plugin install version



## HWRP elasticsearch_script

HWRP `elasticsearch_script` manages elasticsearch scripts under directory `node['elasticsearch']['scripts_dir']`. It is a wrapper for `cookbook_file` resource to manage scripts.

**Install Script**

	elasticsearch_script 'foo' do
	  cookbook 'cookbook'
	  source 'source'
	end

Above HWRP resource will add script `foo`.

**Remove Script**

	elasticsearch_script 'foo' do
	  action :delete
	end

Above HWRP resource will remove script `foo`.


**HWRP Options**

- *action* (optional)	- default :add, options: :add, :delete, :nothing
- *cookbook* (optional, String)	- script cookbook name for `cookbook_file` resource, required for action `:add`
- *source* (optional, String)	- default :name, script cookbook file source for `cookbook_file` resource


## Manage Plugins using Node attribute

Using recipe `plugins`, plugins can be installed or removed by node attribute `node['elasticsearch']['plugins']`. Below is the role attributes to install and remove plugins.


```
  "default_attributes": {
    "elasticsearch": {
      "plugins": {
        "bigdesk": {
          "install_source": "lukas-vlcek/bigdesk"
        },
        "kopf": {
          "install_source": "lmenezes/elasticsearch-kopf"
        },
        "head": {
          "action": "remove"
        }
      }
    }
  }

```

Check out HWRP `elasticsearch_plugin` or recipe `plugins` for more info on attributes.


## Manage Scripts using Node attribute

Using recipe `scripts`, scripts can be added or deleted by node attribute `node['elasticsearch']['scripts']`. Below is the role attributes to add and delete scripts.


```
  "default_attributes": {
    "elasticsearch": {
      "plugins": {
        "script-name": {
          "cookbook": "foo",
          "source": "foo"
        }
      }
    }
  }

```

Check out HWRP `elasticsearch_script` or recipe `scripts` for more info on attributes.



## Cookbook Advanced Attributes

* `default['elasticsearch']['config']['cluster.name']` (default: `nil`): elasticsearch cluster name, required to setup elasticsearch cluster

* `default['elasticsearch']['config_v5']['cluster.name']` (default: `nil`): elasticsearch cluster name, required to setup elasticsearch cluster

* `default['elasticsearch']['install_method']` (default: `package`): elasticsearch install method, options: package tarball

* `default['elasticsearch']['install_java']` (default: `true`): whether to install java using cookbook `java`

* `default['elasticsearch']['service_action']` (default: `[:enable, :start]`): elasticsearch service resource action

* `default['elasticsearch']['notify_restart']` (default: `false`): whether to notify elasticsearch service on any config change

* `default['elasticsearch']['setup_user']` (default: `true`): whether to setup elasticsearch service user when installing via tarball

* `default['elasticsearch']['cookbook']` (default: `elasticsearch-cluster`): cookbook to use for elasticsearch configuration file/template source

* `default['elasticsearch']['plugins']` (default: `{}`): node `Hash` attribute to install/remove elasticsearch plugins.

* `default['elasticsearch']['scripts']` (default: `{}`): node `Hash` attribute to install/remove elasticsearch scripts.

* `default['elasticsearch']['auto_java_memory']` (default: `false`): whether to allocate maximum possible heap size

* `default['elasticsearch']['auto_system_memory']` (default: `768`): minimum memory to keep for OS while allocating maximum possible memory to elasticsearch, used with node['elasticsearch']['auto_java_memory']

* `default['elasticsearch']['use_chef_search']` (default: `false`): whether to use Chef Search to find elasticsearch cluster nodes in an environment
for a given chef elasticsearch role

* `default['elasticsearch']['search_role_name']` (default: `elasticsearch_cluster`): chef role associated with elasticsearch nodes which add this cookbook
to elasticsearch nodes run list

* `default['elasticsearch']['search_cluster_name_attr']` (default: `nil`): node attribute to match elasticsearch cluster name, not necessary applicable to all

* `default['elasticsearch']['tarball_purge']` (default: `false`): purge older installed versions for tarball install method

* `default['elasticsearch']['enable_sensitive']` (default: `true`): enable sensitive resource attribute for configuration resources


## Cookbook Core Attributes

* `default['elasticsearch']['version']` (default: `5.1.2`): elasticsearch version to install

* `default['elasticsearch']['sha256sum']` (default: `nil`): allow users to provide sha256sum for unsupported elasticsearch version tarball file

* `default['elasticsearch']['version_suffix']` (default: `calculated`): elasticsearch package version suffix

* `default['elasticsearch']['user']` (default: `elasticsearch`): elasticsearch service user

* `default['elasticsearch']['group']` (default: `elasticsearch`): elasticsearch service group

* `default['elasticsearch']['conf_dir']` (default: `/etc/elasticsearch`): elasticsearch configuration directory

* `default['elasticsearch']['data_dir']` (default: `/var/lib/elasticsearch`): elasticsearch data directory

* `default['elasticsearch']['log_dir']` (default: `/var/log/elasticsearch`): elasticsearch log directory

* `default['elasticsearch']['work_dir']` (default: `/tmp/elasticsearch`): elasticsearch temporary files directory

* `default['elasticsearch']['plugins_dir']` (default: `calcualted`): elasticsearch plugins directory

* `default['elasticsearch']['conf_file']` (default: `/etc/elasticsearch/elasticsearch.yml`): elasticsearch configuration file

* `default['elasticsearch']['logging_conf_file']` (default: `/etc/elasticsearch/logging.yml`): elasticsearch logging configuration file

* `default['elasticsearch']['tarball_url']` (default: `auto`): elasticsearch tarball download url

* `default['elasticsearch']['tarball_checksum']` (default: `versions`): elasticsearch tarball version source sha256sum

* `default['elasticsearch']['parent_dir']` (default: `/usr/local/elasticsearch`): elasticsearch directory for tarball based installation

* `default['elasticsearch']['install_dir']` (default: `/usr/local/elasticsearch/elasticsearch`): elasticsearch symlink to current version source directory (for tarball based installation)

* `default['elasticsearch']['source_dir']` (default: `calculated`): elasticsearch current version directory (for tarball based installation)

* `default['elasticsearch']['home_dir']` (default: `calculated`): elasticsearch home directory

* `default['elasticsearch']['sysconfig_file']` (default: `calculated`): elasticsearch service config file location

* `default['elasticsearch']['umask']` (default: `0022`): file/directory umask for execute resource (for tarball based installation)

* `default['elasticsearch']['mode']` (default: `0755`): file/directory resource mode


# Service Attributes

* `default['elasticsearch']['sysconfig']['ES_HEAP_NEWSIZE']` (default: `calculated`): elasticsearch service config file parameter

* `default['elasticsearch']['sysconfig']['ES_DIRECT_SIZE']` (default: `nil`): elasticsearch service config file parameter

* `default['elasticsearch']['sysconfig']['ES_JAVA_OPTS']` (default: `nil`): elasticsearch service config file parameter

* `default['elasticsearch']['sysconfig']['MAX_OPEN_FILES']` (default: `65_536`): elasticsearch service config file parameter

* `default['elasticsearch']['sysconfig']['MAX_LOCKED_MEMORY']` (default: `unlimited`): elasticsearch service config file parameter

* `default['elasticsearch']['sysconfig']['MAX_MAP_COUNT']` (default: `262_144`): elasticsearch service config file parameter

* `default['elasticsearch']['sysconfig']['ES_RESTART_ON_UPGRADE']` (default: `true`): elasticsearch service config file parameter

* `default['elasticsearch']['sysconfig']['ES_HEAP_SIZE']` (default: `calculated`): elasticsearch service config file parameter


# ElasticSearch v1.x, 2.x Configuration File Attributes


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

* `default['elasticsearch']['config']['script.inline']` (default: `script.inline`): elasticsearch configuration parameter

* `default['elasticsearch']['config']['script.indexed']` (default: `script.indexed`): elasticsearch configuration parameter

* `default['elasticsearch']['config']['script.file']` (default: `on`): elasticsearch configuration parameter



# ElasticSearch v5.x Configuration File Attributes

* `default['elasticsearch']['config_v5']['cluster.name']` (default: `nil`): elasticsearch configuration parameter

* `default['elasticsearch']['config_v5']['node.name']` (default: `node.name`): elasticsearch configuration parameter

* `default['elasticsearch']['config_v5']['node.master']` (default: `true`): elasticsearch configuration parameter

* `default['elasticsearch']['config_v5']['node.data']` (default: `true`): elasticsearch configuration parameter

* `default['elasticsearch']['config_v5']['node.ingest']` (default: `true`): elasticsearch configuration parameter

* `default['elasticsearch']['config_v5']['node.attr.rack']` (default: `nil`): elasticsearch configuration parameter

* `default['elasticsearch']['config_v5']['node.attr.dc']` (default: `nil`): elasticsearch configuration parameter

* `default['elasticsearch']['config_v5']['node.attr.size']` (default: `nil`): elasticsearch configuration parameter

* `default['elasticsearch']['config_v5']['path.data']` (default: `nil`): elasticsearch configuration parameter

* `default['elasticsearch']['config_v5']['path.logs']` (default: `/var/log/elasticsearch`): elasticsearch configuration parameter

* `default['elasticsearch']['config_v5']['bootstrap.memory_lock']` (default: `true`): elasticsearch configuration parameter

* `default['elasticsearch']['config_v5']['network.host']` (default: `node['ipaddress']`): elasticsearch configuration parameter

* `default['elasticsearch']['config_v5']['transport.tcp.port']` (default: `9300`): elasticsearch configuration parameter

* `default['elasticsearch']['config_v5']['transport.tcp.compress']` (default: `true`): elasticsearch configuration parameter

* `default['elasticsearch']['config_v5']['http.port']` (default: `9200`): elasticsearch configuration parameter

* `default['elasticsearch']['config_v5']['discovery.zen.ping.unicast.hosts']` (default: `[]`): elasticsearch configuration parameter

* `default['elasticsearch']['config_v5']['discovery.zen.minimum_master_nodes']` (default: `1`): elasticsearch configuration parameter

* `default['elasticsearch']['config_v5']['discovery.zen.fd.ping_timeout']` (default: `3s`): elasticsearch configuration parameter

* `default['elasticsearch']['config_v5']['node.max_local_storage_nodes']` (default: `1`): elasticsearch configuration parameter

* `default['elasticsearch']['config_v5']['action.destructive_requires_name']` (default: `true`): elasticsearch configuration parameter

* `default['elasticsearch']['config_v5']['action.auto_create_index']` (default: `true`): elasticsearch configuration parameter

* `default['elasticsearch']['config_v5']['script.inline']` (default: `false`): elasticsearch configuration parameter

* `default['elasticsearch']['config_v5']['script.stored']` (default: `false`): elasticsearch configuration parameter

* `default['elasticsearch']['config_v5']['script.file']` (default: `true`): elasticsearch configuration parameter



# ElasticSearch Configuration From Data Bag Item


* `default['elasticsearch']['databag_configs']` (default: `nil`): elasticsearch configuration parameters from data bag
  * For example, following configuration will get data bag named 'aws_keys' and data bag item 'elasticsearch'.
  * The key of 'config_items' will be used as configuration name.
  * The value of 'config_items' will be used for fetching value from data bag.

```
'elasticsearch' => {
    'databag_configs' => [
      {
        'name' => 'aws_keys',
        'item' => 'elasticsearch',
        'config_items' => {
          'cloud.aws.access_key' => 'data_bag_key_for_access_key',
          'cloud.aws.secret_key' => 'data_bag_key_for_secret_key'
        }
      }
    ]
}
```


# Elasticsearch YUM/APT Repository Attributes

* `default['elasticsearch']['yum']['description']` (default: `calculated`): elasticsearch yum reporitory attribute

* `default['elasticsearch']['yum']['gpgcheck']` (default: `true`): elasticsearch yum reporitory attribute

* `default['elasticsearch']['yum']['enabled']` (default: `true`): elasticsearch yum reporitory attribute

* `default['elasticsearch']['yum']['baseurl']` (default: `calculated`): elasticsearch yum reporitory attribute

* `default['elasticsearch']['yum']['gpgkey']` (default: `https://packages.elasticsearch.org/GPG-KEY-elasticsearch`): elasticsearch yum reporitory attribute

* `default['elasticsearch']['yum']['action']` (default: `:create`): elasticsearch yum reporitory attribute


* `default['elasticsearch']['apt']['description']` (default: `calculated`): elasticsearch apt reporitory attribute

* `default['elasticsearch']['apt']['components']` (default: `['stable', 'main']`): elasticsearch apt reporitory attribute

* `default['elasticsearch']['apt']['uri']` (default: `calculated`): elasticsearch apt reporitory attribute

* `default['elasticsearch']['apt']['key']` (default: `http://packages.elasticsearch.org/GPG-KEY-elasticsearch`): elasticsearch apt reporitory attribute

* `default['elasticsearch']['apt']['action']` (default: `:add`): elasticsearch apt reporitory attribute



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
