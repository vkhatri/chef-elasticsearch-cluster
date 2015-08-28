def evaluate_config(value)
  if value.is_a?(String)
    value = value.strip
    if value.match(/[[:blank:]]/)
      value.inspect
    else
      value
    end
  elsif value.is_a?(Array)
    value.inspect
  else
    value
  end
end

def search_cluster_nodes(env, search_role, cluster_name_attr = nil, cluster_name_value = nil)
  unless Chef::Config[:solo]
    search_query = "chef_environment:#{env} AND role:#{search_role}"
    # e.g. each node is mapped to a cluster with a unique cluster_name - node['cluster_name'], hence
    # set node['elasticsearch']['search_cluster_name_attr'] = 'cluster_name' to search within same
    # cluster environment. this provides multiple cluster support in an environment. but not
    # necessarily applicable to all scenarios
    search_query << " AND #{cluster_name_attr}:#{cluster_name_value}" if cluster_name_attr && cluster_name_value.to_s.length != 0

    search(:node, search_query).map(&:name).sort.uniq
  end
end
