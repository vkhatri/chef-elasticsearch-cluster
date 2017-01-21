# ======================== Elasticsearch Configuration =========================
#
# Please see the documentation for further information on configuration options:
#
# ---------------------------------- Cluster -----------------------------------
#
# Use a descriptive name for your cluster:
#
# cluster.name: my-application
default['elasticsearch']['config_v5']['cluster.name'] = nil
#
# ------------------------------------ Node ------------------------------------
#
# Use a descriptive name for the node:
#
# node.name: node-1
default['elasticsearch']['config_v5']['node.name'] = node.name
default['elasticsearch']['config_v5']['node.master'] = true
default['elasticsearch']['config_v5']['node.data'] = true
default['elasticsearch']['config_v5']['node.ingest'] = true
#
# Add custom attributes to the node:
#
# node.attr.rack: r1
# Pre 5.0 attributes
# default['elasticsearch']['config']['node.rack'] = nil
default['elasticsearch']['config_v5']['node.attr.rack'] = nil
default['elasticsearch']['config_v5']['node.attr.dc'] = nil
default['elasticsearch']['config_v5']['node.attr.size'] = nil
#
# ----------------------------------- Paths ------------------------------------
#
# Path to directory where to store the data (separate multiple locations by comma):
#
# path.data: /path/to/data
default['elasticsearch']['config_v5']['path.data'] = nil
#
# Path to log files:
#
# path.logs: /path/to/logs
default['elasticsearch']['config_v5']['path.logs'] = '/var/log/elasticsearch'
#
# ----------------------------------- Memory -----------------------------------
#
# Lock the memory on startup:
#
# bootstrap.memory_lock: true
# Pre 5.0 attributes
# default['elasticsearch']['config']['bootstrap.mlockall'] = true
default['elasticsearch']['config_v5']['bootstrap.memory_lock'] = true
#
# Make sure that the heap size is set to about half the memory available
# on the system and that the owner of the process is allowed to use this
# limit.
#
# Elasticsearch performs poorly when the system is swapping the memory.
#
# ---------------------------------- Network -----------------------------------
#
# Set the bind address to a specific IP (IPv4 or IPv6):
#
# network.host: 192.168.0.1
# Pre 5.0 attributes
# default['elasticsearch']['config']['network.bind_host'] = node['ipaddress']
# default['elasticsearch']['config']['network.publish_host'] = node['ipaddress']
default['elasticsearch']['config_v5']['network.host'] = node['ipaddress']
#
# Set a custom port for HTTP:
#
# http.port: 9200
default['elasticsearch']['config_v5']['transport.tcp.port'] = 9_300
default['elasticsearch']['config_v5']['transport.tcp.compress'] = true
default['elasticsearch']['config_v5']['http.port'] = 9_200
#
# For more information, see the documentation at:
# <http://www.elastic.co/guide/en/elasticsearch/reference/5.0/modules-network.html>
#
# --------------------------------- Discovery ----------------------------------
#
# Pass an initial list of hosts to perform discovery when new node is started:
# The default list of hosts is ["127.0.0.1", "[::1]"]
#
# discovery.zen.ping.unicast.hosts: ["host1", "host2"]
default['elasticsearch']['config_v5']['discovery.zen.ping.unicast.hosts'] = []
#
# Prevent the "split brain" by configuring the majority of nodes (total number of nodes / 2 + 1):
#
# discovery.zen.minimum_master_nodes: 3
default['elasticsearch']['config_v5']['discovery.zen.minimum_master_nodes'] = 1
default['elasticsearch']['config_v5']['discovery.zen.fd.ping_timeout'] = '3s'
# Removed from ES 5.0
# default['elasticsearch']['config_v5']['discovery.zen.ping.multicast.enabled'] = false
#
# For more information, see the documentation at:
# <http://www.elastic.co/guide/en/elasticsearch/reference/5.0/modules-discovery.html>
#
# ---------------------------------- Gateway -----------------------------------
#
# Block initial recovery after a full cluster restart until N nodes are started:
#
# gateway.recover_after_nodes: 3
#
# For more information, see the documentation at:
# <http://www.elastic.co/guide/en/elasticsearch/reference/5.0/modules-gateway.html>
#
# ---------------------------------- Various -----------------------------------
#
# Disable starting multiple nodes on a single system:
#
# node.max_local_storage_nodes: 1
default['elasticsearch']['config_v5']['node.max_local_storage_nodes'] = 1
#
# Require explicit names when deleting indices:
#
# action.destructive_requires_name: true
# Pre 5.0 attributes
# default['elasticsearch']['config']['action.auto_create_index'] = true
default['elasticsearch']['config_v5']['action.destructive_requires_name'] = true
default['elasticsearch']['config_v5']['action.auto_create_index'] = true
default['elasticsearch']['config_v5']['script.inline'] = false
default['elasticsearch']['config_v5']['script.stored'] = false
default['elasticsearch']['config_v5']['script.file'] = true
