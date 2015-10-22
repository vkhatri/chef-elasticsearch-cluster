elasticsearch-cluster CHANGELOG
===============================

This file is used to list changes made in each version of the elasticsearch-cluster cookbook.

0.5.0
-----

- Virender Khatri - #49, fix for plugin syntax changed in es 2.x

- Virender Khatri - #50, bump es version to 1.7.3

- Virender Khatri - #51, plugins dir should be created under install_dir for tarball installation

- Virender Khatri - #52, rename resource plugin attribute install_name to install_source


0.4.7
-----

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

- WEI WU - Fixed config file location issue on CentOS7

- Grant Ridder - Updated .rubocop.yml

- Grant Ridder - Fixed ruby syntax

- Grant Ridder -  Updated test kitchen platforms

0.2.7
-----

- Virender Khatri - issue #23, Consider using directory-based plugin detection

- Virender Khatri - issue #24, add attribute host & port to plugin resource

- Virender Khatri - issue #25, plugin version is not the same as installed version

- Virender Khatri - issue #26, bump elasticsearch version to 1.7.1

0.2.5
-----

- Michael Klishin - Update README.md

- Virender Khatri - issue #15, kopf and bigdesk are always installed, removed default plugins

- Virender Khatri - issue #17, update elasticsearch service resource to delayed start

- Virender Khatri - issue #18, add attribute ignore_error to plugin resource for issue #16

- Virender Khatri - issue #19, add attribute notify_restart to plugin resource

0.2.2
-----

- Michael Klishin - Provide dependency info in the README

- Virender Khatri - issue #13, added 1.7.0 checksum attribute default['elasticsearch']['tarball_checksum']['1.7.0']

0.2.0
-----

- Virender Khatri - added lwrp `elasticsearch_plugin`

- Virender Khatri - bumped elasticsearch version to 1.7.0

- Virender Khatri - added attribute default[elasticsearch][bin_dir]

- Virender Khatri - move common directory resources to recipe install

0.1.8
-----

- Virender Khatri - added os support and README update

- Virender Khatri - issue #1, package install needs to manage ES data, work and log dir

- Virender Khatri - issue #2, add ES_JAVA_OPTS with double quotes

- Virender Khatri - issue #3, added missing attribute default['elasticsearch']['cookbook']

- Virender Khatri - issue #4, added config attribute name for elasticsearch.yml file

- Virender Khatri - issue #5, disable auto_java_memory by default

- Virender Khatri - issue #6, set default ES_HEAP_SIZE value to half of the memory

0.1.1
-----
- Virender Khatri - README and minor updates

0.1.0
-----
- Virender Khatri - Initial release of elasticsearch-cluster

- - -
Check the [Markdown Syntax Guide](http://daringfireball.net/projects/markdown/syntax) for help with Markdown.

The [Github Flavored Markdown page](http://github.github.com/github-flavored-markdown/) describes the differences between markdown on github and standard markdown.
