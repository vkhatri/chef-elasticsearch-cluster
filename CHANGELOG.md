elasticsearch-cluster CHANGELOG
===============================

This file is used to list changes made in each version of the elasticsearch-cluster cookbook.

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
