require 'yaml'
require 'erb'

@environment = ENV['SINATRA_ENV'] ||= "development"
@dbconfig = YAML.load(ERB.new(File.read('config/database.yml')).result)

require 'bundler/setup'
Bundler.require(:default, ENV['SINATRA_ENV'])

ActiveRecord::Base.establish_connection(
  @dbconfig[@environment]
)

require_all 'app'
