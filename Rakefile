#!/usr/bin/env rake
require "bundler/gem_tasks"
require 'rails/dummy/tasks'


class Rails::Dummy::Generator
  def original_name
    'habtm_generator'
  end
end


task :clear do
  rm_rf 'spec/dummy'
end
task :test => [:clear, 'dummy:app'] do
  system 'rails g model user'
  system 'rails g model post'
  system 'rails g model admin/process'
  system 'rails g habtm user post'
  system 'rails g habtm user admin/process'

  system 'rails g model chef_process'
  system 'rails g model chef_script'
  system 'rails g habtm chef_process chef_script'
  system 'rake db:migrate'
  system 'pwd'
  system 'rails r ../../test.rb'
end
