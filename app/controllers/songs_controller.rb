class SongsController < ApplicationController
    set :views, Proc.new { File.join(root, "../views/songs") }
    set :method_override, true

    get '/songs' do
        @songs = Song.all
        erb :index
    end

    get '/songs/new' do
        @genres = Genre.all
        erb :new
    end

    get '/songs/:slug' do 
        @song = Song.find_by_slug(params[:slug])
        @genres = @song.genres
        @artist = @song.artist
        erb :show
    end

    get '/songs/:slug/edit' do
        @song = Song.find_by_slug(params[:slug])
        @genres = Genre.all
        @artist = @song.artist
        @song_genres = @song.genres
        erb :edit
    end

    post '/songs' do
        artist = Artist.find_by(name: params[:artist]) || Artist.create(name: params[:artist])
        song = Song.create(name: params[:name], artist_id: artist.id)
        
        params[:genres].each{|genre| 
            song.genres << Genre.find(genre)
        }
        redirect "/songs/#{song.slug}"
    end

    patch '/songs/:slug' do
        song = Song.find_by_slug(params[:slug])
        artist = Artist.find_by(name: params[:artist]) || Artist.create(name: params[:artist])
        
        song.update(artist_id: artist.id)

        song.genres.clear
        params[:genres].each {|genre_id| 
            song.genres << Genre.find(genre_id)
        }
        redirect "/songs/#{song.slug}"
    end

end