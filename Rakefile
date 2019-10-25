require_relative 'config/environment'
require 'sinatra/activerecord/rake'

desc 'starts a console'
task :console do
  ActiveRecord::Base.logger = Logger.new(STDOUT)
  Pry.start
end

desc 'migrates, seeds, starts app'
task :start_up do
    Rake::Task["db:migrate"].invoke
    Rake::Task["db:seed"].invoke
    ruby "bin/run.rb"
end

desc 're-seeds database with original data, starts program'
task :refresh do
    5.times do  
      Rake::Task["db:rollback"]
      end
    begin
      f = File.open('db/development.db', 'r')
    ensure
      f.close unless f.nil? or f.closed?
      File.delete('db/development.db') if File.exists? 'db/development.db'
    end
    begin
      f = File.open('db/schema.rb', 'r')
    ensure
      f.close unless f.nil? or f.closed?
      File.delete('db/schema.rb') if File.exists? 'db/schema.rb'
    end
    Rake::Task["db:migrate"].invoke
    Rake::Task["db:seed"].invoke
  ruby "bin/run.rb"
end

