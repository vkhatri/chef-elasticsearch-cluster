elasticsearch-cluster CHANGELOG
===============================

This file is used to list changes made in each version of the elasticsearch-cluster cookbook.

0.5.6
-----

### Breaking Changes

- cookbook by default now uses `node['elasticsearch']['config_v5']` for ES v5.x configuration


### Changes

- PR #80 - Grant Ridder
  * fix rubocop offenses
  * fix install repo for ES 5.x
  * use correct java version for ES 5+
  * fix ES v5 plugin installation

- PR #87 - Virender Khatri
  * update default elasticsearch version to v5.1.2, #83
  * ubuntu update ca certificates, #82
  * use default config_v5 attributes for elasticsearch v5.x, #84
  * attributes cleanup, #81
  * MAX_OPEN_FILES should be at least 65536 for v5, #85
  * add kitchen tests for v1, v2 and v5, #86
  * ci fix, rubocop, specs


0.5.5
-----

### Changes

- Wei Wu - add jvm options file

- Wei Wu - skip index settings in elasticsearch.yml.erb

- Wei Wu - add v5 configuration attributes

- Wei Wu - fix cluster name validation

- Wei Wu - fix spec and change `set` to `normal` to remove warnings

- Grant Ridder - update Travis to Ruby 2.3.1

- Grant Ridder - update CI configuration

- Grant Ridder - fix lint

0.5.4
-----

### Changes

- Virender Khatri - bump es version v2.2.0

- Martin Tomes - use the correct path to the tar file for the Elasticsearch distribution.

- Virender Khatri - added checksum for missing versions tar file

- Virender Khatri - fix for issue #75

- Virender Khatri - fix lint and kitchen test default config

0.5.3
-----

### Changes

- Virender Khatri - tarball_file delete should be a file resource #71

- Virender Khatri - add ES v2.1.1 support #70


0.5.2
-----

### Changes

- Virender Khatri - #65, update metadata for issues source url

- Virender Khatri - #64, bump elasticsearch version to 2.1.0

- Virender Khatri - #63, :delayed is default timer for notify service

- Virender Khatri - #62, fix for ruby_block always notify service start


0.5.1
-----

### Changes

- Virender Khatri - #53, bump es version to 2.0.0

- Virender Khatri - #54, es 2.x repo url change

- Virender Khatri - #55, fix es 2.0 invalid parameter CONF_FILE

- Virender Khatri - #56, add sha256sum for 2.0.0 tar

- Virender Khatri - #57, update package repository to use http://packages.elastic.co

- Virender Khatri - #58, updated es 2.x initd

- Virender Khatri - #59, es 2.x new tarball url


0.5.0
-----

## Breaking Changes

- resource `elasticsearch_plugin` attribute `install_name` has been renamed to `install_source`

### Changes

- Virender Khatri - #49, fix for plugin syntax changed in es 2.x

- Virender Khatri - #50, bump es version to 1.7.3

- Virender Khatri - #51, plugins dir should be created under install_dir for tarball installation

- Virender Khatri - #52, rename resource plugin attribute install_name to install_source


0.4.7
-----

### Changes

- Virender Khatri - #39, script.disable_dynamic is not supported in v2.x

- Virender Khatri - #40, update init.d scripts resource type from template to cookbook_file

- Virender Khatri - #41, update cookbook for wrapper cookbook support

- Virender Khatri - #42, move default attribute tarball_url to recipe tarball

- Virender Khatri - #43, manage logging.yml configuration file

- Virender Khatri - #44, add attribute to enable sensitive

- Virender Khatri - #46, link node['elasticsearch']['install_dir'] should always notify service restart and does
not require `service` restart

- Virender Khatri - #47, added path.scripts directory resource config

- Virender Khatri - #48, add resource script


0.3.8
-----

### Changes

- WEI WU - set databag config related attributes before generating template file. Instead of storing in chef node.

- WEI WU - add sensitive flag only if chef respond to this flag

- Virender Khatri - #32, move tarball checksum to helper method

- Virender Khatri - #33, move install recipe directory resources to install method recipe

- Virender Khatri - #34, bump elasticsearch version to 1.7.2

- Virender Khatri - #35, manage es config dir in favor of tarball install method

- Virender Khatri - #36, update sysv init templates

- Virender Khatri - #37, add feature to purge old tarball es revisions

0.3.0
-----

### Changes

- WEI WU - Fixed config file location issue on CentOS7

- Grant Ridder - Updated .rubocop.yml

- Grant Ridder - Fixed ruby syntax

- Grant Ridder -  Updated test kitchen platforms

0.2.7
-----

### Changes

- Virender Khatri - issue #23, Consider using directory-based plugin detection

- Virender Khatri - issue #24, add attribute host & port to plugin resource

- Virender Khatri - issue #25, plugin version is not the same as installed version

- Virender Khatri - issue #26, bump elasticsearch version to 1.7.1

0.2.5
-----

### Changes

- Michael Klishin - Update README.md

- Virender Khatri - issue #15, kopf and bigdesk are always installed, removed default plugins

- Virender Khatri - issue #17, update elasticsearch service resource to delayed start

- Virender Khatri - issue #18, add attribute ignore_error to plugin resource for issue #16

- Virender Khatri - issue #19, add attribute notify_restart to plugin resource

0.2.2
-----

### Changes

- Michael Klishin - Provide dependency info in the README

- Virender Khatri - issue #13, added 1.7.0 checksum attribute default['elasticsearch']['tarball_checksum']['1.7.0']

0.2.0
-----

### Changes

- Virender Khatri - added lwrp `elasticsearch_plugin`

- Virender Khatri - bumped elasticsearch version to 1.7.0

- Virender Khatri - added attribute default[elasticsearch][bin_dir]

- Virender Khatri - move common directory resources to recipe install

0.1.8
-----

### Changes

- Virender Khatri - added os support and README update

- Virender Khatri - issue #1, package install needs to manage ES data, work and log dir

- Virender Khatri - issue #2, add ES_JAVA_OPTS with double quotes

- Virender Khatri - issue #3, added missing attribute default['elasticsearch']['cookbook']

- Virender Khatri - issue #4, added config attribute name for elasticsearch.yml file

- Virender Khatri - issue #5, disable auto_java_memory by default

- Virender Khatri - issue #6, set default ES_HEAP_SIZE value to half of the memory

0.1.1
-----

### Changes

- Virender Khatri - README and minor updates

0.1.0
-----

### Changes

- Virender Khatri - Initial release of elasticsearch-cluster

- - -
Check the [Markdown Syntax Guide](http://daringfireball.net/projects/markdown/syntax) for help with Markdown.

The [Github Flavored Markdown page](http://github.github.com/github-flavored-markdown/) describes the differences between markdown on github and standard markdown.
