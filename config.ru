require './config/environment'

if ActiveRecord::Migrator.needs_migration?
  raise 'Migrations are pending. Run `rake db:migrate` to resolve the issue.'
end

use Rack::MethodOverride
use Rack::Static, :urls => ['/stylesheets', '/javascripts'], :root => 'assets'


# Add Controllers Here
# use NewController
# use Assets
run ApplicationController
