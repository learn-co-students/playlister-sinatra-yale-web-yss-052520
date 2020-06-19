class SongsController < ApplicationController 
    set :views, 'app/views/songs'

    get '/songs' do 
        @songs = Song.all 
        erb :index 
    end 

    get '/songs/new' do
        @artists = Artist.all
        @genres = Genre.all
        erb :new
    end

    get '/songs/:slug' do 
        @song = Song.find_by_slug(params[:slug])
        @artist = @song.artist 
        erb :show
    end 

    get '/songs/:slug/edit' do 
        @song = Song.find_by_slug(params[:slug])
        @genres = Genre.all  
        @artists = Artist.all 
        erb :edit 
    end 

    patch '/songs/:slug' do 
        song = Song.find_by_slug(params[:slug])
        song.update(params[:song])
        changing_artist(song)
        song.genres.clear 
        changing_genres(song)
        song.save 
        redirect "/songs/#{song.slug}"
    end 

    post '/songs' do
        song = Song.new(params[:song])
        changing_artist(song)
        changing_genres(song)
        song.save
        redirect "/songs/#{song.slug}"
    end

    #----- Methods for Processing Data from Forms --------#
    def changing_artist(song)
        # spec doesn't call for artist checkboxes, wants to enter artist in text box 
        # and if that name exists, not create new artist. We will handle both scenarios
        unless params[:artist][:name].empty? 
            if Artist.where(name: params[:artist][:name]).count > 0 
                song.artist = Artist.find_by(name: params[:artist][:name])
            else 
                song.artist = Artist.create(name: params[:artist][:name])
            end 
        end 
    end 

    def changing_genres(song)
        unless params[:genres][:name].empty?
            song.genres << Genre.create(name: params[:genres][:name])
        else 
            params[:genres][:id].each do |id|
                song.genres << Genre.find(id)
            end 
        end
    end 
end 