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

def tarball_sha256sum(version)
  sha256sums = {
    '1.6.0' => 'dc336c83394b2f2f72f362e0f959a4cfdec2109aa3de15668401afeab0b02d2e', '1.7.0' => '6fabed2db09e1b88587df15269df328ecef33e155b3c675a2a6d2299bda09c95', '1.7.1' => '86a0c20eea6ef55b14345bff5adf896e6332437b19180c4582a346394abde019',
    '1.7.2' => '6f81935e270c403681e120ec4395c28b2ddc87e659ff7784608b86beb5223dd2',
    '2.0.0-beta1' => '6fd37b0289720304ea77ae1f8b97881804976fba8d02a5617177ab1c53d271c2', '2.0.0-beta2' => 'd0d50778ab8dad552a19afdf4119f53a3950bfa4414c6f7c58a2d31fdf130f3d'
  }
  sha256sum = sha256sums[version]
  fail "sha256sum is missing for elasticsearch tarball version #{version}" unless sha256sum
  sha256sum
end
