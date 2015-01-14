require File.expand_path('../../../config/environment', __FILE__)
require 'pry'

CONTACT_FIELDS_GROUP_ID = 3

namespace :custom_fields do
  task :create  => :environment do

    #TODO move params to yaml file and add new fields
    params = {
        field: {
            field_group_id: CONTACT_FIELDS_GROUP_ID,
            label: 'Address 1:',
            as: 'string',
            maxlength: '100',
            required: false,
            disabled: false,
            hint: '',
            placeholder: ''}
    }
    #TODO for all fields

    field_params = params[:field]
    as = field_params[:as]

    unless Field.exists?(field_group_id: field_params[:field_group_id], label: field_params[:label])
      klass = Field.lookup_class(as).classify.constantize
      klass.create(field_params)
    else
      puts "STOP! field with label: '#{field_params[:label]}' already exists for field_group_id: #{field_params[:field_group_id]}"
    end
  end
end