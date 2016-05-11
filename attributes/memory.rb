
# enable auto memory calculation for ES_HEAP_SIZE
default['elasticsearch']['auto_java_memory'] = false

# minimum memory to preserve for system
default['elasticsearch']['auto_system_memory'] = 768

raise 'missing node memory attribute' if !node['memory'] && !node['memory'].key?('total')

# total memory in MB
total_memory = (node['memory']['total'].to_i / 1024).to_i

# allocate maximum memory possible
if node['elasticsearch']['auto_java_memory']
  # Calculate -Xmx (Multiple of 1024)
  total_memory_percentage = (total_memory % 1024)
  system_memory = if total_memory < 2048
                    total_memory / 2
                  elsif total_memory_percentage >= node['elasticsearch']['auto_system_memory'].to_i
                    total_memory_percentage
                  else
                    total_memory_percentage + 1024
                  end

  java_memory = total_memory - system_memory
  # Making Java -Xmx even
  java_memory += 1 unless java_memory.even?
  default['elasticsearch']['sysconfig']['ES_HEAP_SIZE'] = java_memory.to_s + 'm'
else
  # https://www.elastic.co/guide/en/elasticsearch/guide/current/heap-sizing.html
  half_memory = total_memory / 2
  half_memory += 1 unless half_memory.even?
  default['elasticsearch']['sysconfig']['ES_HEAP_SIZE'] = if half_memory >= 32_768
                                                            '32g'
                                                          else
                                                            half_memory.to_s + 'm'
                                                          end
end
