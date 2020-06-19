class SongsController < ApplicationController

    get '/songs' do
        @songs = Song.all
        erb :'songs/index'

    end

    get '/songs/new' do
        @genres = Genre.all
        erb :'songs/new'
    end

    get '/songs/:slug' do
        @song = Song.find_by_slug(params[:slug])
        erb :'songs/show'
    end

    post '/songs' do
        # binding.pry

        artist_name = params[:artist][:name]
        song_name = params[:song][:name]
        song = Song.create(name: song_name)

        params[:genres].each do |genre_id|
            genre_id = genre_id.to_i
            song.genres << Genre.find(genre_id)
        end

        if Artist.all_names.include?(artist_name)
            artist = Artist.find_by(name: artist_name)
            artist.songs << song
            # song.artist = artist
        else
            artist = Artist.create(name: artist_name)
            artist.songs << song
        end
        # binding.pry
        artist.save
        redirect "/songs/#{song.slug}"
    end
end
