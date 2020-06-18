class ArtistsController < ApplicationController
    set :views, set :views, Proc.new { File.join(root, "../views/artists") }
end
