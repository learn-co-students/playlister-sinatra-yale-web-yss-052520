class GenresController < ApplicationController
    # display list of all genres
    get '/genres' do
        @genres = Genre.all
        erb :'genres/index'
    end

    # display specific song
    get '/genres/:slug' do
        @genre = Genre.find_by_slug(params[:slug])
        erb :'genres/show'
    end

end