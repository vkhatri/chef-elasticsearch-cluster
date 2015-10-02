require 'chef/resource'

class Chef
  class Resource
    # provides elasticsearch_script
    class ElasticsearchScript < Chef::Resource
      identity_attr :name

      def initialize(name, run_context = nil)
        super
        @resource_name = :elasticsearch_script
        @provides = :elasticsearch_script
        @provider = Chef::Provider::ElasticsearchScript
        @action = :create
        @allowed_actions = [:create, :delete, :nothing]
        @name = name
      end

      def source(arg = nil)
        set_or_return(
          :source, arg,
          :kind_of => String,
          :default => name
        )
      end

      def cookbook(arg = nil)
        set_or_return(
          :cookbook, arg,
          :kind_of => String,
          :default => nil
        )
      end
    end
  end
end
