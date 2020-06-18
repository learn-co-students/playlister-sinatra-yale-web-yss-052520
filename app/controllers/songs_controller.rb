require 'rack-flash'
require 'pry'

class SongsController < ApplicationController
    set :views, 'app/views/songs'

    enable :sessions
    use Rack::Flash

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
        erb :show
    end

    post '/songs' do
        song = Song.create(name: params[:song][:name])

        artist = Artist.find_or_create_by(name: params[:artist][:name])
        song.artist = artist

        params[:genres].each do |id|
            song.song_genres.build(genre: Genre.find(id))
        end

        song.save

        flash[:message] = "Successfully created song."
        redirect "/songs/#{song.slug}"
    end

    get '/songs/:slug/edit' do
        @song = Song.find_by_slug(params[:slug])
        @genres = Genre.all

        erb :edit
    end

    patch '/songs/:slug' do
        song = Song.find_by_slug(params[:slug])

        unless params[:song].empty?
            song.update(params[:song])
        end

        unless params[:artist].empty?
            artist = Artist.find_or_create_by(params[:artist])
            song.update(artist: artist)
        end

        unless params[:genres].empty?
            song.song_genres.destroy_all

            params[:genres].each do |id|
                song.song_genres.build(genre: Genre.find(id))
            end
        end
        
        song.save

        flash[:message] = "Successfully updated song."
        redirect "/songs/#{song.slug}"
    end
end
