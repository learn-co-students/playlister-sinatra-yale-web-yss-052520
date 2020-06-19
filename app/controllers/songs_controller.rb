require 'rack-flash'

class SongsController < ApplicationController

    use Rack::Flash
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

    get '/songs/:slug/edit' do

        @song = Song.find_by_slug(params[:slug])
        erb :'songs/edit'
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
        flash[:message] = "Successfully created song."

        redirect "/songs/#{song.slug}"
    end

    patch '/songs/:slug' do
        # binding.pry
        @song = Song.find_by_slug(params[:slug])
        @song.update(params[:song])
        @song.artist = Artist.find_or_create_by(name: params[:artist][:name])
        @song.genre_ids = params[:genres]
        @song.save
        flash[:message] = "Successfully updated song."
        redirect("/songs/#{@song.slug}")       
    end
end
