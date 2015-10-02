class Chef
  class Provider
    # provides elasticsearch_script
    class ElasticsearchScript < Chef::Provider
      provides :elasticsearch_script if respond_to?(:provides)

      def initialize(*args)
        super
      end

      def whyrun_supported?
        true
      end

      def load_current_resource
        true
      end

      def action_create
        new_resource.updated_by_last_action(script_template)
      end

      def action_delete
        new_resource.updated_by_last_action(script_template)
      end

      protected

      def script_template
        t = Chef::Resource::CookbookFile.new("elasticsearch_script_#{new_resource.name}", run_context)
        t.path ::File.join(node['elasticsearch']['scripts_dir'], new_resource.name)
        t.cookbook new_resource.cookbook
        t.source new_resource.source
        t.owner node['elasticsearch']['user']
        t.group node['elasticsearch']['group']
        t.mode 0755
        t.run_action new_resource.action
        t.updated?
      end
    end
  end
end
