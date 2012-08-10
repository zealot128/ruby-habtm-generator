require 'rails/generators/migration'
require 'rails/generators/active_record'
class HabtmGenerator < ActiveRecord::Generators::Base
  source_root File.expand_path('../templates', __FILE__)
  argument :other_model, required: true,
    type: :string, desc: "List both part of the habtm migration to generate the table"

  def create_migration
    models.map!{|i|i.singularize}
    migration_template "habtm_migration.rb.erb",
      "db/migrate/#{migration_name}.rb"

    insert_into_file "app/models/#{models[0]}.rb",
      "  has_and_belongs_to_many :#{models[1].pluralize}\n",
      after: "class #{models[0].camelize} < ActiveRecord::Base\n"
    insert_into_file "app/models/#{models[1]}.rb",
      "  has_and_belongs_to_many :#{models[0].pluralize}\n",
      after: "class #{models[1].camelize} < ActiveRecord::Base\n"
  end

  private

  def table_name
    sorted_models.map(&:pluralize).join("_")
  end

  def models
    [name, other_model]
  end

  def sorted_models
    models.map(&:singularize).map(&:underscore).sort
  end

  def references
    sorted_models.map{|i| ":#{i}"}.join(", ")
  end

  def id_columns
    sorted_models.map{|i| ":#{i}_id"}.join(", ")
  end

  def migration_name
    "create_#{table_name}"
  end

  def migration_class_name
    migration_name.camelize
  end
end
