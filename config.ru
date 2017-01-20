require './config/environment'

if ActiveRecord::Migrator.needs_migration?
  raise 'Migrations are pending. Run `rake db:migrate` to resolve the issue.'
end

use Rack::Session::Cookie
use Rack::MethodOverride
use Rack::Static, :urls => ['/stylesheets', '/javascripts'], :root => 'assets'
use Rack::Flash


# Add Controllers Here
# use NewController
# use Assets
run ApplicationController
