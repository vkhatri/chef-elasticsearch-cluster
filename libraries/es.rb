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
    '1.6.0' => 'dc336c83394b2f2f72f362e0f959a4cfdec2109aa3de15668401afeab0b02d2e',
    '1.7.0' => '6fabed2db09e1b88587df15269df328ecef33e155b3c675a2a6d2299bda09c95',
    '1.7.1' => '86a0c20eea6ef55b14345bff5adf896e6332437b19180c4582a346394abde019',
    '1.7.2' => '6f81935e270c403681e120ec4395c28b2ddc87e659ff7784608b86beb5223dd2',
    '1.7.3' => 'af517611493374cfb2daa8897ae17e63e2efea4d0377d316baa351c1776a2bca',
    '1.7.4' => '395f3417c26a6b36125f6a062c1129b454a961efea09151c692adc63562e5a94',
    '1.7.5' => '0aa58947d66b487488e86059352deb7c6cab5da4accdff043cce9fed7c3d2fa7',
    '2.0.0' => 'b25f13f615337c2072964fd9fc5c7250f8a2a983b22198daf93548285d5d16df',
    '2.0.1' => '7be4a6c717002057e422073ca8e957df8b4cb198bf2399a0d79f42121e34798b',
    '2.1.0' => '8a4e85bcb506daa369651506af1cbc55c09fd7ff387d111142ae14d0a85d4d14',
    '2.1.1' => 'ebd69c0483f20ba7e51caa9606d4e3ce5fe2667e1216c799f0cdbb815c317ce6',
    '2.2.0' => 'ed70cc81e1f55cd5f0032beea2907227b6ad8e7457dcb75ddc97a2cc6e054d30',
    '2.2.1' => '7d43d18a8ee8d715d827ed26b4ff3d939628f5a5b654c6e8de9d99bf3a9b2e03',
    '2.2.2' => 'c706db594f1feb5051d90697c6c412eadd60e00a9ec3b4f345a122801183af69',
    '2.3.0' => 'd68482c7633f2986263bc5f11f93b8a58c54c6cf5e337b615446d0a7c6fdcd8b',
    '2.3.1' => 'f0092e73038e0472fcdd923e5f2792e13692ea0f09ca034a54dd49b217110ebb',
    '2.3.2' => '04c4d3913d496d217e038da88df939108369ae2e78eea29cb1adf1c4ab3a000a',
    '2.3.3' => '5fe0a6887432bb8a8d3de2e79c9b81c83cfa241e6440f0f0379a686657789165',
    '2.3.4' => '371e0c5f4ded0a8548f1cce55faff3efebcfd5f895c2c816f220146521f6f06e',
    '2.3.5' => '1119a8c18620b98c4b85261318663a1f26dea92a26f34dfeb7f813fb7cbb468a',
    '2.4.0' => '3ae01140ae7bcbb91436feef381fbed774e36ef6d1e8e6a3153640db82acf4c9',
    '2.4.1' => '23a369ef42955c19aaaf9e34891eea3a055ed217d7fbe76da0998a7a54bbe167',
    '2.4.2' => '7741a2e78f5f155c5005ba891f9b6e57a4e45178cb540beed101d30517cbe22f',
    '2.4.3' => '01eb684943be01d4af3131c6795073187b1a5868b6525d9686cc0d7a315db12e',
    '2.4.4' => '981092e6ca65ba5560b8b97a74e5ed0eb2236e9128efdb85bb652cec340158e2',
    '5.0.0' => 'a866534f0fa7428e980c985d712024feef1dee04709add6e360fc7b73bb1e7ae',
    '5.0.1' => '542e197485fbcb1aac46097439337d2e9ac6a54b7b1e29ad17761f4d65898833',
    '5.0.2' => 'bbe761788570d344801cb91a8ba700465deb10601751007da791743e9308cb83',
    '5.1.1' => 'cd45bafb1f74a7df9bad12c77b7bf3080069266bcbe0b256b0959ef2536e31e8',
    '5.1.2' => '74d752f9a8b46898d306ad169b72f328e17215c0909149e156a576089ef11c42',
    '5.2.0' => '6beec13bc64291020df8532d991b673b94119c5c365e3ddbc154ee35c6032953',
    '5.2.1' => 'f28bfecbb8896bbcf8c6063a474a2ddee29a262c216f56ff6d524fc898094475',
    '5.2.2' => 'cf88930695794a8949342d386f028548bd10b26ecc8c4b422a94ea674faf8ac9',
    '5.3.0' => 'effd922973e9f4fe25565e0a194a4b534c08b22849f03cb9fea13c311401e21b',
    '5.3.1' => '1c277102bedf58d8e0f029b5eecc415260a4ad49442cf8265d6ed7adc0021269',
    '5.3.2' => 'a94fe46bc90eb271a0d448d20e49cb02526ac032281c683c79a219240280a1e8',
    '5.4.0' => 'bf74ff7efcf615febb62979e43045557dd8940eb48f111e45743c2def96e82d6',
    '5.4.1' => '09d6422bd33b82f065760cd49a31f2fec504f2a5255e497c81050fd3dceec485',
    '5.4.2' => '0206124d101a293b34b19cebee83fbf0e2a540f5214aabf133cde0719b896150'
  }
  sha256sum = sha256sums[version] || node['elasticsearch']['sha256sum']
  raise "sha256sum is missing for elasticsearch tarball version #{version}" unless sha256sum
  sha256sum
end
