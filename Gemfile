source 'http://rubygems.org'

ruby '2.3.3'

gem 'sinatra', :require => 'sinatra/base'
gem 'activerecord', :require => 'active_record'
gem 'sinatra-activerecord', :require => 'sinatra/activerecord'
gem 'sprockets-helpers', :require => 'sprockets-helpers'
gem 'rake'
gem 'require_all'
gem "pg"
gem 'bcrypt'
gem "tux"
gem 'dotenv', :require => 'dotenv/load'
gem 'json'
gem 'httparty'
gem 'rack-flash3', :require => 'rack-flash'

# Asset Pipeline
gem 'sprockets'
gem 'sprockets-helpers', :require => 'sinatra/sprockets-helpers'
gem 'yui-compressor'
gem 'coffee-script'
gem 'sass'
gem 'aws-sdk', '~> 2'

group :development do
  gem 'pry'
  gem 'thin'
  gem 'shotgun'
  gem 'sqlite3'
end

group :test do
  gem 'rspec'
  gem 'capybara'
  gem 'rack-test'
  gem 'database_cleaner', git: 'https://github.com/bmabey/database_cleaner.git'
end
