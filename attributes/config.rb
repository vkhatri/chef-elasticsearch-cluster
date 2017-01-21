
################################### Cluster ###################################
default['elasticsearch']['config']['cluster.name'] = nil
#################################### Node #####################################
default['elasticsearch']['config']['node.name'] = node.name
default['elasticsearch']['config']['node.master'] = true
default['elasticsearch']['config']['node.data'] = true
# default['elasticsearch']['config']['node.rack'] = 'rack314'
default['elasticsearch']['config']['node.max_local_storage_nodes'] = 1
#################################### Index ####################################
default['elasticsearch']['config']['index.number_of_shards'] = 5
default['elasticsearch']['config']['index.number_of_replicas'] = 1
#################################### Plugin ###################################
# default['elasticsearch']['config']['plugin.mandatory'] = 'mapper-attachments,lang-groovy'
################################### Memory ####################################
default['elasticsearch']['config']['bootstrap.mlockall'] = true
############################## Network And HTTP ###############################
default['elasticsearch']['config']['network.bind_host'] = node['ipaddress']
default['elasticsearch']['config']['network.publish_host'] = node['ipaddress']
# default['elasticsearch']['config']['network.host'] = node['ipaddress']
default['elasticsearch']['config']['transport.tcp.port'] = 9_300
default['elasticsearch']['config']['transport.tcp.compress'] = true
default['elasticsearch']['config']['http.port'] = 9_200
# default['elasticsearch']['config']['http.max_content_length'] = '100mb'
# default['elasticsearch']['config']['http.enabled'] = false
################################### Gateway ###################################
# default['elasticsearch']['config']['gateway.type'] = 'local'
# default['elasticsearch']['config']['gateway.recover_after_nodes'] = 1
# default['elasticsearch']['config']['gateway.recover_after_time'] = '5m'
# default['elasticsearch']['config']['gateway.expected_nodes'] = 2
############################# Recovery Throttling #############################
# default['elasticsearch']['config']['cluster.routing.allocation.node_initial_primaries_recoveries'] = 4
# default['elasticsearch']['config']['cluster.routing.allocation.node_concurrent_recoveries'] = 2
# default['elasticsearch']['config']['indices.recovery.max_bytes_per_sec'] = '20mb'
# default['elasticsearch']['config']['indices.recovery.concurrent_streams'] = 5
################################## Discovery ##################################
default['elasticsearch']['config']['discovery.zen.minimum_master_nodes'] = 1
default['elasticsearch']['config']['discovery.zen.ping.timeout'] = '3s'
default['elasticsearch']['config']['discovery.zen.ping.multicast.enabled'] = false
default['elasticsearch']['config']['discovery.zen.ping.unicast.hosts'] = []
################################## Slow Log ##################################
# default['elasticsearch']['config']['index.search.slowlog.threshold.query.warn'] = '10s'
# default['elasticsearch']['config']['index.search.slowlog.threshold.query.info'] = '5s'
# default['elasticsearch']['config']['index.search.slowlog.threshold.query.debug'] = '2s'
# default['elasticsearch']['config']['index.search.slowlog.threshold.query.trace'] = '500ms'
# default['elasticsearch']['config']['index.search.slowlog.threshold.fetch.warn'] = '1s'
# default['elasticsearch']['config']['index.search.slowlog.threshold.fetch.info'] = ' 800ms'
# default['elasticsearch']['config']['index.search.slowlog.threshold.fetch.debug'] = '500ms'
# default['elasticsearch']['config']['index.search.slowlog.threshold.fetch.trace'] = '200ms'
# default['elasticsearch']['config']['index.indexing.slowlog.threshold.index.warn'] = '10s'
# default['elasticsearch']['config']['index.indexing.slowlog.threshold.index.info'] = '5s'
# default['elasticsearch']['config']['index.indexing.slowlog.threshold.index.debug'] = '2s'
# default['elasticsearch']['config']['index.indexing.slowlog.threshold.index.trace'] = '500ms'
################################## GC Logging ################################
# default['elasticsearch']['config']['monitor.jvm.gc.young.warn'] = '1000ms'
# default['elasticsearch']['config']['monitor.jvm.gc.young.info'] = '700ms'
# default['elasticsearch']['config']['monitor.jvm.gc.young.debug'] = '400ms'
# default['elasticsearch']['config']['monitor.jvm.gc.old.warn'] = '10s'
# default['elasticsearch']['config']['monitor.jvm.gc.old.info'] = '5s'
# default['elasticsearch']['config']['monitor.jvm.gc.old.debug'] = '2s'
################################## Security ################################
# default['elasticsearch']['config']['http.jsonp.enable'] = true

default['elasticsearch']['config']['action.auto_create_index'] = true
default['elasticsearch']['config']['action.disable_delete_all_indices'] = true
