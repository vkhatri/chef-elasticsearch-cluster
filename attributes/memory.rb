
# enable auto memory calculation for ES_HEAP_SIZE
default['elasticsearch']['auto_java_memory'] = true

# minimum memory to preserve for system
default['elasticsearch']['auto_system_memory'] = 768

# Calculate -Xmx (Multiple of 1024)
if node['elasticsearch']['auto_java_memory'] && node['memory'] && node['memory'].key?('total')
  total_memory = (node['memory']['total'].gsub('kB', '').to_i / 1024).to_i
  total_memory_percentage = (total_memory % 1024)
  system_memory = if total_memory < 2048
                    total_memory / 2
                  else
                    if total_memory_percentage >= node['elasticsearch']['auto_system_memory'].to_i
                      total_memory_percentage
                    else
                      total_memory_percentage + 1024
                    end
                  end

  java_memory = total_memory - system_memory
  # Making Java -Xmx even
  java_memory += 1 unless java_memory.even?
  default['elasticsearch']['sysconfig']['ES_HEAP_SIZE'] = java_memory.to_s + 'm'
end
