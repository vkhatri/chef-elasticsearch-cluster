require 'spec_helper'

describe 'elasticsearch-cluster::default' do
  shared_examples_for 'elasticsearch' do
    context 'all_platforms' do
      %w(attributes install config package plugins).each do |r|
        it "include recipe elasticsearch-cluster::#{r}" do
          expect(chef_run).to include_recipe("elasticsearch-cluster::#{r}")
        end
      end

      %w(/etc/elasticsearch /etc/elasticsearch/scripts /usr/share/elasticsearch/plugins /var/lib/elasticsearch /var/log/elasticsearch /tmp/elasticsearch).each do |d|
        it "create directory #{d}" do
          expect(chef_run).to create_directory(d)
        end
      end

      it 'create template elasticsearch environment file' do
        expect(chef_run).to create_template('elasticsearch_env_file')
      end

      it 'create template elasticsearch configuration file /etc/elasticsearch/elasticsearch.yml' do
        expect(chef_run).to create_template('/etc/elasticsearch/elasticsearch.yml')
      end

      it 'create template elasticsearch configuration file /etc/elasticsearch/logging.yml' do
        expect(chef_run).to create_template('/etc/elasticsearch/logging.yml')
      end

      it 'enable elasticsearch-cluster service' do
        expect(chef_run).to enable_service('elasticsearch')
      end

      it 'notifies elasticsearch service' do
        expect(chef_run).to run_ruby_block('delay elasticsearch service start')
        expect(chef_run.ruby_block('delay elasticsearch service start')).to notify('service[elasticsearch]').to(:start).delayed
      end
    end
  end

  context 'rhel' do
    let(:chef_run) do
      ChefSpec::SoloRunner.new(platform: 'centos', version: '6.8') do |node|
        node.automatic['platform_family'] = 'rhel'
        node.override['elasticsearch']['config_v5']['cluster.name'] = 'spec'
      end.converge(described_recipe)
    end

    include_examples 'elasticsearch'
  end

  context 'ubuntu' do
    let(:chef_run) do
      ChefSpec::SoloRunner.new(platform: 'ubuntu', version: '14.04') do |node|
        node.automatic['platform_family'] = 'debian'
        node.override['elasticsearch']['config_v5']['cluster.name'] = 'spec'
      end.converge(described_recipe)
    end

    include_examples 'elasticsearch'

    it 'execute update-ca-certificates' do
      expect(chef_run).to run_execute('update-ca-certificates')
    end
  end
end
