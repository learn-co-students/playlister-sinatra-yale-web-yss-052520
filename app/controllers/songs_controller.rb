require 'rack-flash'

class SongsController < ApplicationController
    use Rack::Flash
    
    # display list of all songs
    get '/songs' do
        @songs = Song.all
        erb :'songs/index'
    end

    # form for creating song
    get '/songs/new' do
        @genres = Genre.all
        erb :'songs/new'
    end
  
    # display song info
    get '/songs/:slug' do
        @song = Song.find_by_slug(params[:slug])
        erb :'songs/show'
    end

    # get edit form
    get '/songs/:slug/edit' do 
        @song = Song.find_by_slug(params[:slug])
        erb :'songs/edit'
    end


    # create a song
    post '/songs' do
        @song = Song.create(params[:song])
        artist = Artist.find_or_create_by(name: params[:artist][:name])
        @song.update(artist_id: artist.id)

        params[:genres][:id].each do |id|
          @song.genres << Genre.find(id)
        end
        flash[:message] = "Successfully created song."
        redirect "/songs/#{@song.slug}"
    end

    # edit song
    patch '/songs/:slug' do 
        @song = Song.find_by_slug(params[:slug])
        @song.update(params[:song])

        @song.artist = Artist.find_or_create_by(name: params[:artist][:name])

        @song.genre_ids = params[:genres]
        @song.save

        flash[:message] = "Successfully updated song."
        redirect "/songs/#{@song.slug}"
    end

end