require 'spec_helper'

describe 'elasticsearch-cluster::config' do
  shared_examples_for 'elasticsearch' do
    context 'all_platforms' do

      it 'create template elasticsearch jvm configuration file /etc/elasticsearch/jvm.options' do
        expect(chef_run).to create_template('/etc/elasticsearch/jvm.options').with(
          cookbook: 'elasticsearch-cluster',
          source: 'jvm.options.erb',
          owner: 'elasticsearch',
          group: 'elasticsearch',
          mode: 0600
        )
        expect(chef_run.template('/etc/elasticsearch/jvm.options')).to notify('service[elasticsearch]').to(:restart).immediately
      end
    end
  end
end
