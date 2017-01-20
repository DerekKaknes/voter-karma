require 'yaml'
require 'erb'

@environment = ENV['SINATRA_ENV'] ||= "development"
@dbconfig = YAML.load(ERB.new(File.read('config/database.yml')).result)

require 'bundler/setup'
Bundler.require(:default, ENV['SINATRA_ENV'])

ActiveRecord::Base.establish_connection(
  @dbconfig[@environment]
)

s3 = Aws::S3::Resource.new(
  region: ENV['AWS_REGION'],
  access_key_id: ENV['S3_ACCESS_ID'],
  secret_access_key: ENV['S3_SECRET_KEY']
)

BUCKET = s3.bucket(ENV['S3_BUCKET_NAME'])

require_all 'app'

