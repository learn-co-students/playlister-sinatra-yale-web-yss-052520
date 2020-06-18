require './config/environment'
# require "bundler/setup"
begin
  fi_check_migration
  # use Rack::Flash

  use Rack::MethodOverride
  use SongsController 
  use ArtistsController 
  use GenresController 
  run ApplicationController
rescue ActiveRecord::PendingMigrationError => err
  STDERR.puts err
  exit 1
end
