require 'chef/resource'

class Chef
  class Resource
    # ElasticSearch Plugin Install Resource
    class ElasticsearchPlugin < Chef::Resource
      identity_attr :name

      def initialize(name, run_context = nil)
        super
        @resource_name = :elasticsearch_plugin
        @provides = :elasticsearch_plugin
        @provider = Chef::Provider::ElasticsearchPlugin
        @action = :install
        @allowed_actions = [:install, :remove, :nothing]
        @name = name
      end

      def host(arg = nil)
        set_or_return(
          :host, arg,
          :kind_of => String,
          :default => node['elasticsearch']['config']['network.bind_host']
        )
      end

      def port(arg = nil)
        set_or_return(
          :port, arg,
          :kind_of => Integer,
          :default => node['elasticsearch']['config']['http.port']
        )
      end

      def install_source(arg = nil)
        set_or_return(
          :install_source, arg,
          :kind_of => String,
          :default => nil
        )
      end

      def url(arg = nil)
        set_or_return(
          :url, arg,
          :kind_of => String,
          :default => nil
        )
      end

      def options(arg = nil)
        set_or_return(
          :options, arg,
          :kind_of => Hash,
          :default => {}
        )
      end

      def version(arg = nil)
        set_or_return(
          :version, arg,
          :kind_of => String,
          :default => nil
        )
      end

      def timeout(arg = nil)
        set_or_return(
          :timeout, arg,
          :kind_of => [String, Integer],
          :default => nil
        )
      end

      def ignore_error(arg = nil)
        set_or_return(
          :ignore_error, arg,
          :kind_of => [TrueClass, FalseClass],
          :default => true
        )
      end

      def notify_restart(arg = nil)
        set_or_return(
          :notify_restart, arg,
          :kind_of => [TrueClass, FalseClass],
          :default => nil
        )
      end
    end
  end
end
