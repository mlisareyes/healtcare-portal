require './config/environment'
require 'sinatra'

if ActiveRecord::Migrator.needs_migration?
  raise 'Migrations are pending. Run `rake db:migrate` to resolve the issue.'
end

require_relative 'app/controllers/application_controller'

use Rack::MethodOverride
use PatientsController
use UsersController
use RegistrationsController
use SessionsController
run ApplicationController
