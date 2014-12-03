require 'rails/generators/migration'
require 'rails/generators/active_record'
class HabtmGenerator < ActiveRecord::Generators::Base
  source_root File.expand_path('../templates', __FILE__)
  argument :other_model, required: true,
    type: :string, desc: "List both part of the habtm migration to generate the table"

  def create_migration_file
    models.map!{|i|i.singularize}
    migration_template "habtm_migration.rb.erb",
      "db/migrate/#{migration_name}.rb"

    add_migration_line model: models[0],  other: models[1]
    add_migration_line model: models[1],  other: models[0]
  end

  private

  def add_migration_line(hash)
    other = hash[:other]
    model = hash[:model]
    extra = if other.include?('/') || model.include?('/')
                   ", :join_table => '#{table_name}', :class_name => '#{other.camelcase}', :foreign_key => '#{no_ns(model.foreign_key)}', :association_foreign_key => '#{no_ns(other.foreign_key)}'"
                 else
                   ""
                 end
    insert_into_file "app/models/#{model}.rb",
      "  has_and_belongs_to_many :#{no_ns other.pluralize}#{extra}\n",
      after: "class #{model.camelize} < ActiveRecord::Base\n"

  end

  def no_ns(m)
    m.gsub('/','_')
  end

  def join_table(model)
  end

  def table_name
    sorted_models.map{|i| no_ns i.tableize}.join("_")
  end

  def models
    [name, other_model]
  end

  def sorted_models
    models.map(&:singularize).map(&:underscore).sort
  end

  def references
    sorted_models.map{|i| ":#{no_ns i.singularize}"}.join(", ")
  end

  def id_columns
    sorted_models.map{|i| ":#{no_ns i.foreign_key}"}.join(", ")
  end

  def migration_name
    "create_#{table_name}"
  end

  def migration_class_name
    migration_name.camelize
  end
end
