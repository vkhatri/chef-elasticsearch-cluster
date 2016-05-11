def evaluate_config(value)
  if value.is_a?(String)
    value = value.strip
    if value =~ /[[:blank:]]/
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
    search_query << " AND #{cluster_name_attr}:#{cluster_name_value}" if cluster_name_attr && !cluster_name_value.to_s.empty?

    search(:node, search_query).map(&:name).sort.uniq
  end
end

def tarball_sha256sum(version)
  sha256sums = {
    '1.6.0' => 'dc336c83394b2f2f72f362e0f959a4cfdec2109aa3de15668401afeab0b02d2e', '1.7.0' => '6fabed2db09e1b88587df15269df328ecef33e155b3c675a2a6d2299bda09c95', '1.7.1' => '86a0c20eea6ef55b14345bff5adf896e6332437b19180c4582a346394abde019',
    '1.7.2' => '6f81935e270c403681e120ec4395c28b2ddc87e659ff7784608b86beb5223dd2', '1.7.3' => 'af517611493374cfb2daa8897ae17e63e2efea4d0377d316baa351c1776a2bca',
    '2.0.0-beta1' => '6fd37b0289720304ea77ae1f8b97881804976fba8d02a5617177ab1c53d271c2', '2.0.0-beta2' => 'd0d50778ab8dad552a19afdf4119f53a3950bfa4414c6f7c58a2d31fdf130f3d',
    '2.0.0-rc1' => 'cfd97bba0c49000a2799fffd359ec351f0ca7ef5f0a8c160920137db6b057784', '2.0.0' => 'b25f13f615337c2072964fd9fc5c7250f8a2a983b22198daf93548285d5d16df',
    '2.0.1' => '7be4a6c717002057e422073ca8e957df8b4cb198bf2399a0d79f42121e34798b', '2.1.0' => '8a4e85bcb506daa369651506af1cbc55c09fd7ff387d111142ae14d0a85d4d14',
    '2.1.1' => 'ebd69c0483f20ba7e51caa9606d4e3ce5fe2667e1216c799f0cdbb815c317ce6', '2.2.0' => 'ed70cc81e1f55cd5f0032beea2907227b6ad8e7457dcb75ddc97a2cc6e054d30',
    '2.2.1' => '7d43d18a8ee8d715d827ed26b4ff3d939628f5a5b654c6e8de9d99bf3a9b2e03', '2.2.2' => 'c706db594f1feb5051d90697c6c412eadd60e00a9ec3b4f345a122801183af69',
    '2.3.0' => 'd68482c7633f2986263bc5f11f93b8a58c54c6cf5e337b615446d0a7c6fdcd8b', '2.3.1' => 'f0092e73038e0472fcdd923e5f2792e13692ea0f09ca034a54dd49b217110ebb'
  }
  sha256sum = sha256sums[version] || node['elasticsearch']['sha256sum']
  raise "sha256sum is missing for elasticsearch tarball version #{version}" unless sha256sum
  sha256sum
end
