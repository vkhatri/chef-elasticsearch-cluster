require 'spec_helper'

describe 'elasticsearch-cluster::config' do
  shared_examples_for 'elasticsearch' do
    context 'all_platforms' do
      it 'create directory elasticsearch conf_dir' do
        expect(chef_run).to create_directory('/etc/elasticsearch').with(
          mode: '0755'
        )
      end

      it 'create directory elasticsearch scripts_dir' do
        expect(chef_run).to create_directory('/etc/elasticsearch/scripts').with(
          owner: 'elasticsearch',
          group: 'elasticsearch',
          mode: '0755'
        )
      end

      it 'create directory elasticsearch plugins_dir' do
        expect(chef_run).to create_directory('/usr/share/elasticsearch/plugins').with(
          owner: 'elasticsearch',
          group: 'elasticsearch',
          mode: '0755'
        )
      end

      it 'create template elasticsearch jvm configuration file /etc/elasticsearch/jvm.options' do
        expect(chef_run).to create_template('/etc/elasticsearch/jvm.options').with(
          cookbook: 'elasticsearch-cluster',
          source: 'jvm.options.erb',
          owner: 'elasticsearch',
          group: 'elasticsearch',
          mode: 0600
        )
        expect(chef_run.template('/etc/elasticsearch/jvm.options')).to notify('service[elasticsearch]').to(:restart).delayed
      end

      it 'create template elasticsearch log configuration file /etc/elasticsearch/jvm.options' do
        expect(chef_run).to create_template('/etc/elasticsearch/logging.yml').with(
          cookbook: 'elasticsearch-cluster',
          source: 'logging.yml.erb',
          owner: 'elasticsearch',
          group: 'elasticsearch',
          mode: 0600
        )
        expect(chef_run.template('/etc/elasticsearch/logging.yml')).to notify('service[elasticsearch]').to(:restart).delayed
      end

      it 'start elasticsearch service' do
        expect(chef_run).to enable_service('elasticsearch')
      end
    end
  end

  context 'rhel' do
    let(:chef_run) do
      ChefSpec::SoloRunner.new(platform: 'centos', version: '6.8') do |node|
        node.automatic['platform_family'] = 'rhel'
        node.override['elasticsearch']['config_v5']['cluster.name'] = 'spec'
        node.default['elasticsearch']['dir_mode'] = '0755'
        node.default['elasticsearch']['install_method'] = 'package'
        node.default['elasticsearch']['conf_file'] = '/etc/elasticsearch/elasticsearch.yml'
        node.default['elasticsearch']['logging_conf_file'] = '/etc/elasticsearch/logging.yml'
        node.default['elasticsearch']['plugins_dir'] = '/usr/share/elasticsearch/plugins'
        node.override['elasticsearch']['notify_restart'] = true
      end.converge(described_recipe)
    end

    include_examples 'elasticsearch'

    it 'create template elasticsearch env configuration file' do
      expect(chef_run).to create_template('elasticsearch_env_file').with(
        path: '/etc/sysconfig/elasticsearch',
        cookbook: 'elasticsearch-cluster',
        source: 'sysconfig.erb',
        owner: 'root',
        group: 'root',
        mode: 0644
      )
      expect(chef_run.template('/etc/sysconfig/elasticsearch')).to notify('service[elasticsearch]').to(:restart).delayed
    end
  end

  context 'ubuntu' do
    let(:chef_run) do
      ChefSpec::SoloRunner.new(platform: 'ubuntu', version: '14.04') do |node|
        node.automatic['platform_family'] = 'debian'
        node.override['elasticsearch']['config_v5']['cluster.name'] = 'spec'
        node.default['elasticsearch']['dir_mode'] = '0755'
        node.default['elasticsearch']['install_method'] = 'package'
        node.default['elasticsearch']['conf_file'] = '/etc/elasticsearch/elasticsearch.yml'
        node.default['elasticsearch']['logging_conf_file'] = '/etc/elasticsearch/logging.yml'
        node.default['elasticsearch']['plugins_dir'] = '/usr/share/elasticsearch/plugins'
        node.override['elasticsearch']['notify_restart'] = true
      end.converge(described_recipe)
    end

    include_examples 'elasticsearch'

    it 'create template elasticsearch env configuration file' do
      expect(chef_run).to create_template('elasticsearch_env_file').with(
        path: '/etc/default/elasticsearch',
        cookbook: 'elasticsearch-cluster',
        source: 'sysconfig.erb',
        owner: 'root',
        group: 'root',
        mode: 0644
      )
      expect(chef_run.template('/etc/default/elasticsearch')).to notify('service[elasticsearch]').to(:restart).delayed
    end
  end
end
