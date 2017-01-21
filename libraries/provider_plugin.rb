require 'chef/provider/template'
require 'chef/resource/template'
require 'net/http'

class Chef
  class Provider
    # provides elasticsearch_plugin
    class ElasticsearchPlugin < Chef::Provider
      provides :elasticsearch_plugin if respond_to?(:provides)

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

      def option_prefix
        if node['elasticsearch']['version'] >= '2'
          ''
        else
          '--'
        end
      end

      def installed_plugins
        plugins = {}
        begin
          uri = URI("http://#{new_resource.host}:#{new_resource.port}/_nodes/#{node['elasticsearch']['config']['node.name']}/plugins")
          response = Net::HTTP.get_response(uri)

          if response.is_a?(Net::HTTPSuccess)
            JSON.parse(response.body)['nodes'].each do |_k, v|
              v['plugins'].each do |plugin|
                plugins[plugin['name']] = plugin['version']
              end
            end
          end
        rescue => error
          if new_resource.ignore_error
            Chef::Log.info("ignored installed plugins check for elasticsearch, caught exception(#{error.class} - #{error.message})")
          else
            raise "unable to fetch installed plugins for elasticsearch, caught exception '#{error.class} - #{error.message}'. set resource attribute `ignore_error true` to ignore this error"
          end
        end
        plugins
      end

      def install_command
        plugin_command = "#{node['elasticsearch']['plugins_binary']} #{option_prefix}install #{new_resource.install_source}"
        plugin_command << "/#{new_resource.version}" if new_resource.version
        plugin_command << " --url #{new_resource.url}" if new_resource.url
        plugin_command << " --timeout #{new_resource.timeout}" if new_resource.timeout
        plugin_command
      end

      def reinstall_command
        plugin_command = "#{node['elasticsearch']['plugins_binary']} #{option_prefix}remove #{new_resource.name} && "
        plugin_command << install_command
        plugin_command
      end

      def uninstall_command
        "#{node['elasticsearch']['plugins_binary']} #{option_prefix}remove #{new_resource.name}"
      end

      def eval_version
        version = new_resource.version
        return version unless version.is_a? String
        if version.to_s =~ /^v/
          # left chop char `v` from the `version`
          # to match installed version
          #
          # Report in case of any issue
          version.to_s[1..-1].to_s
        else
          version
        end
      end

      def install_plugin
        run_it = false
        plugin_install_dir = ::File.join(node['elasticsearch']['plugins_dir'], new_resource.name)
        exist_plugins = installed_plugins

        case new_resource.action
        when :install, [:install], 'install'
          if ::File.exist?(plugin_install_dir)
            # reinstall if not the correct version
            if new_resource.version && exist_plugins.key?(new_resource.name) && eval_version != exist_plugins[new_resource.name]
              plugin_command = reinstall_command
              run_it = true
            end
          else
            # installing plugin
            plugin_command = install_command
            run_it = true
          end
        when :nothing, [:nothing], 'nothing'
          Chef::Log.info("not managing plugin #{new_resource.install_source}")
        when [:remove], :remove, 'remove'
          run_it = true if ::File.exist?(plugin_install_dir)
          plugin_command = uninstall_command
        end

        if run_it
          install_as_root = node['elasticsearch']['version'].to_i >= 5 && node['elasticsearch']['install_method'] == 'package'

          t = Chef::Resource::Execute.new("#{new_resource.action} plugin #{new_resource.name} #{new_resource.version}", run_context)
          t.user install_as_root ? 'root' : node['elasticsearch']['user']
          t.group install_as_root ? 'root' : node['elasticsearch']['group']
          t.umask node['elasticsearch']['umask']
          t.command plugin_command
          t.only_if { run_it }
          t.notifies :restart, 'service[elasticsearch]', :delayed if new_resource.notify_restart
          t.run_action :run
          update = t.updated_by_last_action?
        else
          update = false
        end
        update
      end
    end
  end
end
