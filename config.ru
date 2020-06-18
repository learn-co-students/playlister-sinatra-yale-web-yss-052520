require './config/environment'

begin
  fi_check_migration

  use Rack::MethodOverride
  use ArtistsController
  use SongsController
  use GenresController
  run ApplicationController

end
