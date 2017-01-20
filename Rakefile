ENV["SINATRA_ENV"] ||= "development"

require_relative './config/environment'
require 'sinatra/activerecord/rake'
require 'sinatra/asset_pipeline/task'


# Type `rake -T` on your command line to see the available rake tasks.
task :console do
  Pry.start
end


namespace :db do
  namespace :export do
    desc "Prints Rawvoter and VoterGrade in a seeds.rb way."
    task :seeds_format => :environment do
      Rawvoter.export_to_seed_format(20)
      VoterGrade.export_to_seed_format(20)
    end
  end
end
