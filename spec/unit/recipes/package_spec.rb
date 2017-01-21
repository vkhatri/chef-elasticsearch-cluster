require 'spec_helper'

describe 'elasticsearch-cluster::default' do
  context 'rhel' do
    let(:chef_run) do
      ChefSpec::SoloRunner.new(platform: 'centos', version: '6.8') do |node|
        node.automatic['platform_family'] = 'rhel'
        node.default['elasticsearch']['install_method'] = 'package'
        node.override['elasticsearch']['config_v5']['cluster.name'] = 'spec'
      end.converge(described_recipe)
    end

    it 'adds elasticsearch yum repository' do
      expect(chef_run).to create_yum_repository('elasticsearch')
    end

    it 'install elasticsearch package' do
      expect(chef_run).to install_package('elasticsearch')
    end
  end

  context 'ubuntu' do
    let(:chef_run) do
      ChefSpec::SoloRunner.new(platform: 'ubuntu', version: '14.04') do |node|
        node.automatic['platform_family'] = 'debian'
        node.default['elasticsearch']['install_method'] = 'package'
        node.override['elasticsearch']['config_v5']['cluster.name'] = 'spec'
      end.converge(described_recipe)
    end

    it 'adds elasticsearch apt repository' do
      expect(chef_run).to add_apt_repository('elasticsearch')
    end

    it 'install elasticsearch package' do
      expect(chef_run).to install_package('elasticsearch')
    end
  end
end
