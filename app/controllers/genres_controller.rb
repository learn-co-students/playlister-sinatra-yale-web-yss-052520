class GenresController < ApplicationController
    set :views, set :views, Proc.new { File.join(root, "../views/genres") }
end