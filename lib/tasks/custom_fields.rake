require File.expand_path('../../../config/environment', __FILE__)
require 'yaml'

CONTACT_FIELDS_GROUP_ID = 3

namespace :custom_fields do

  task :create  => :environment do
    config[:fields].each do |_, field|
      as = field[:as]

      unless Field.exists?(field_group_id: field[:field_group_id], label: field[:label])
        klass = Field.lookup_class(as).classify.constantize
        klass.create(field)
      else
        #TODO update
        puts "SKIPPING! field with label: '#{field[:label]}' already exists for field_group_id: #{field[:field_group_id]}"
      end
    end
  end

  task :delete => :environment do
    Field.custom_fields.delete_all
  end

  def config
    config = YAML.load(ERB.new(File.read('./config/fields.yml')).result)
    config.symbolize_keys!
    config[:fields].each { |_, field| field.symbolize_keys! }
    config
  end
end