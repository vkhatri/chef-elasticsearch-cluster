require 'chef/provider/template'
require 'chef/resource/template'
require 'net/http'

class Chef
  class Provider
    # Logstash Plugin Install Provider
    class ElasticsearchPlugin < Chef::Provider
      def initialize(*args)
        super
      end

      def whyrun_supported?
        true
      end

      def load_current_resource
        true
      end

      def action_install
        new_resource.updated_by_last_action(install_plugin)
      end

      def action_remove
        new_resource.updated_by_last_action(install_plugin)
      end

      private

      def installed_plugins
        uri = URI("http://#{node['elasticsearch']['config']['network.bind_host']}:#{node['elasticsearch']['config']['http.port']}/_nodes/#{node['elasticsearch']['config']['node.name']}/plugins")
        response = Net::HTTP.get_response(uri)
        plugins = {}

        if response.is_a?(Net::HTTPSuccess)
          JSON.parse(response.body)['nodes'].each do |_k, v|
            v['plugins'].each do |plugin|
              plugins[plugin['name']] = plugin['version']
            end
          end
        end
        plugins
      end

      def install_plugin
        run_it = false
        plugin_binary = ::File.join(node['elasticsearch']['bin_dir'], 'plugin')
        exist_plugins = installed_plugins

        case new_resource.action
        when :install, 'install'
          if exist_plugins.key?(new_resource.name)
            if new_resource.version && new_resource.version != exist_plugins[new_resource.name]
              plugin_command = "#{plugin_binary} --remove #{new_resource.name} && "
              plugin_command << "#{plugin_binary} --install #{new_resource.install_name}"
              plugin_command << "/#{new_resource.version}" if new_resource.version
              plugin_command << " --url #{new_resource.url}" if new_resource.url
              plugin_command << " --timeout #{new_resource.timeout}" if new_resource.timeout
              run_it = true
            end
          else
            plugin_command = "#{plugin_binary} --install #{new_resource.install_name}"
            plugin_command << "/#{new_resource.version}" if new_resource.version
            plugin_command << " --url #{new_resource.url}" if new_resource.url
            plugin_command << " --timeout #{new_resource.timeout}" if new_resource.timeout
            run_it = true
          end
        when :nothing
          Chef::Log.info("not managing plugin #{new_resource.install_name}")
        when [:remove], :remove, 'remove'
          run_it = true if exist_plugins.key?(new_resource.name)
          plugin_command = "#{plugin_binary} --remove #{new_resource.name}"
        end

        t = Chef::Resource::Execute.new("#{new_resource.action} plugin #{new_resource.name} #{new_resource.version}", run_context)
        t.user node['elasticsearch']['user']
        t.group node['elasticsearch']['group']
        t.umask node['elasticsearch']['umask']
        t.command plugin_command
        t.only_if { run_it }
        t.run_action :run
        t.updated_by_last_action?
      end
    end
  end
end
