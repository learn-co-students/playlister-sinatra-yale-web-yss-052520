class SongsController < ApplicationController 
    set :views, 'app/views/songs'

    get '/songs' do 
        @songs = Song.all 
        erb :index 
    end 

    get '/songs/new' do
    	@artists = Artist.all
    	@genres = Genre.all
    	binding.pry
    	erb :new
    end

    get '/songs/:slug' do 
        @song = Song.find_by_slug(params[:slug])
        erb :show
    end 

    post '/songs' do
    	song = Song.new(params[:song])
    	unless params[:artists][:name].empty?
    		song.artist = Artist.create(name: params[:artists][:name])
    	end

    	unless params[:genres][:name].empty?
    		song.genres << Genre.create(name: params[:genres][:name])
    	end

    	song.save
    	redirect '/songs'
    end

end 