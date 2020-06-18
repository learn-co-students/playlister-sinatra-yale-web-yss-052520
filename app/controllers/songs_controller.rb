class SongsController < ApplicationController
    set :views, set :views, Proc.new { File.join(root, "../views/songs") }
    set :method_override, true
end