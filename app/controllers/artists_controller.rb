class ArtistsController < ApplicationController
    # display list of all artists
    get '/artists' do
        @artists = Artist.all
        erb :'artists/index'
    end

    # display specific song
    get '/artists/:slug' do
        @artist = Artist.find_by_slug(params[:slug])
        erb :'artists/show'
    end

end
