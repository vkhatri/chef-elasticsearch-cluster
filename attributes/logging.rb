default['elasticsearch']['logging']['status'] = 'error'

# log action execution errors for easier debugging
default['elasticsearch']['logging']['logger.action.name'] = 'org.elasticsearch.action'
default['elasticsearch']['logging']['logger.action.level'] = 'debug'

default['elasticsearch']['logging']['appender.console.type'] = 'Console'
default['elasticsearch']['logging']['appender.console.name'] = 'console'
default['elasticsearch']['logging']['appender.console.layout.type'] = 'PatternLayout'
default['elasticsearch']['logging']['appender.console.layout.pattern'] = '[%d{ISO8601}][%-5p][%-25c{1.}] %marker%m%n'

default['elasticsearch']['logging']['appender.rolling.type'] = 'RollingFile'
default['elasticsearch']['logging']['appender.rolling.name'] = 'rolling'
default['elasticsearch']['logging']['appender.rolling.fileName'] = '${sys:es.logs}.log'
default['elasticsearch']['logging']['appender.rolling.layout.type'] = 'PatternLayout'
default['elasticsearch']['logging']['appender.rolling.layout.pattern'] = '[%d{ISO8601}][%-5p][%-25c{1.}] %marker%.-10000m%n'
default['elasticsearch']['logging']['appender.rolling.filePattern'] = '${sys:es.logs}-%d{yyyy-MM-dd}.log'
default['elasticsearch']['logging']['appender.rolling.policies.type'] = 'Policies'
default['elasticsearch']['logging']['appender.rolling.policies.time.type'] = 'TimeBasedTriggeringPolicy'
default['elasticsearch']['logging']['appender.rolling.policies.time.interval'] = 1
default['elasticsearch']['logging']['appender.rolling.policies.time.modulate'] = 'true'

default['elasticsearch']['logging']['rootLogger.level'] = 'info'
default['elasticsearch']['logging']['rootLogger.appenderRef.console.ref'] = 'console'
default['elasticsearch']['logging']['rootLogger.appenderRef.rolling.ref'] = 'rolling'

default['elasticsearch']['logging']['appender.deprecation_rolling.type'] = 'RollingFile'
default['elasticsearch']['logging']['appender.deprecation_rolling.name'] = 'deprecation_rolling'
default['elasticsearch']['logging']['appender.deprecation_rolling.fileName'] = '${sys:es.logs}_deprecation.log'
default['elasticsearch']['logging']['appender.deprecation_rolling.layout.type'] = 'PatternLayout'
default['elasticsearch']['logging']['appender.deprecation_rolling.layout.pattern'] = '[%d{ISO8601}][%-5p][%-25c{1.}] %marker%.-10000m%n'
default['elasticsearch']['logging']['appender.deprecation_rolling.filePattern'] = '${sys:es.logs}_deprecation-%i.log.gz'
default['elasticsearch']['logging']['appender.deprecation_rolling.policies.type'] = 'Policies'
default['elasticsearch']['logging']['appender.deprecation_rolling.policies.size.type'] = 'SizeBasedTriggeringPolicy'
default['elasticsearch']['logging']['appender.deprecation_rolling.policies.size.size'] = '1GB'
default['elasticsearch']['logging']['appender.deprecation_rolling.strategy.type'] = 'DefaultRolloverStrategy'
default['elasticsearch']['logging']['appender.deprecation_rolling.strategy.max'] = 4

default['elasticsearch']['logging']['logger.deprecation.name'] = 'org.elasticsearch.deprecation'
default['elasticsearch']['logging']['logger.deprecation.level'] = 'warn'
default['elasticsearch']['logging']['logger.deprecation.appenderRef.deprecation_rolling.ref'] = 'deprecation_rolling'
default['elasticsearch']['logging']['logger.deprecation.additivity'] = 'false'

default['elasticsearch']['logging']['appender.index_search_slowlog_rolling.type'] = 'RollingFile'
default['elasticsearch']['logging']['appender.index_search_slowlog_rolling.name'] = 'index_search_slowlog_rolling'
default['elasticsearch']['logging']['appender.index_search_slowlog_rolling.fileName'] = '${sys:es.logs}_index_search_slowlog.log'
default['elasticsearch']['logging']['appender.index_search_slowlog_rolling.layout.type'] = 'PatternLayout'
default['elasticsearch']['logging']['appender.index_search_slowlog_rolling.layout.pattern'] = '[%d{ISO8601}][%-5p][%-25c] %marker%.-10000m%n'
default['elasticsearch']['logging']['appender.index_search_slowlog_rolling.filePattern'] = '${sys:es.logs}_index_search_slowlog-%d{yyyy-MM-dd}.log'
default['elasticsearch']['logging']['appender.index_search_slowlog_rolling.policies.type'] = 'Policies'
default['elasticsearch']['logging']['appender.index_search_slowlog_rolling.policies.time.type'] = 'TimeBasedTriggeringPolicy'
default['elasticsearch']['logging']['appender.index_search_slowlog_rolling.policies.time.interval'] = 1
default['elasticsearch']['logging']['appender.index_search_slowlog_rolling.policies.time.modulate'] = 'true'

default['elasticsearch']['logging']['logger.index_search_slowlog_rolling.name'] = 'index.search.slowlog'
default['elasticsearch']['logging']['logger.index_search_slowlog_rolling.level'] = 'trace'
default['elasticsearch']['logging']['logger.index_search_slowlog_rolling.appenderRef.index_search_slowlog_rolling.ref'] = 'index_search_slowlog_rolling'
default['elasticsearch']['logging']['logger.index_search_slowlog_rolling.additivity'] = 'false'

default['elasticsearch']['logging']['appender.index_indexing_slowlog_rolling.type'] = 'RollingFile'
default['elasticsearch']['logging']['appender.index_indexing_slowlog_rolling.name'] = 'index_indexing_slowlog_rolling'
default['elasticsearch']['logging']['appender.index_indexing_slowlog_rolling.fileName'] = '${sys:es.logs}_index_indexing_slowlog.log'
default['elasticsearch']['logging']['appender.index_indexing_slowlog_rolling.layout.type'] = 'PatternLayout'
default['elasticsearch']['logging']['appender.index_indexing_slowlog_rolling.layout.pattern'] = '[%d{ISO8601}][%-5p][%-25c] %marker%.-10000m%n'
default['elasticsearch']['logging']['appender.index_indexing_slowlog_rolling.filePattern'] = '${sys:es.logs}_index_indexing_slowlog-%d{yyyy-MM-dd}.log'
default['elasticsearch']['logging']['appender.index_indexing_slowlog_rolling.policies.type'] = 'Policies'
default['elasticsearch']['logging']['appender.index_indexing_slowlog_rolling.policies.time.type'] = 'TimeBasedTriggeringPolicy'
default['elasticsearch']['logging']['appender.index_indexing_slowlog_rolling.policies.time.interval'] = '1'
default['elasticsearch']['logging']['appender.index_indexing_slowlog_rolling.policies.time.modulate'] = 'true'

default['elasticsearch']['logging']['logger.index_indexing_slowlog.name'] = 'index.indexing.slowlog.index'
default['elasticsearch']['logging']['logger.index_indexing_slowlog.level'] = 'trace'
default['elasticsearch']['logging']['logger.index_indexing_slowlog.appenderRef.index_indexing_slowlog_rolling.ref'] = 'index_indexing_slowlog_rolling'
default['elasticsearch']['logging']['logger.index_indexing_slowlog.additivity'] = 'false'
