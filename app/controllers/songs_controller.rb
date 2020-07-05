
class SongsController < ApplicationController
    use Rack::Flash
    
    get '/songs' do
        @songs = Song.all
        erb :'songs/index'
    end
    
    post '/songs' do
        @song = Song.create(params[:song])
        @song.artist = Artist.find_or_create_by(name: params[:artist][:name])
        @song.genre_ids = params[:genres]
        @song.save
        # binding.pry
    
        flash[:message] = "Successfully created song."
        redirect "/songs/#{@song.slug}"
    end
    
    get '/songs/new' do
        @genres = Genre.all
        erb :'songs/new'
    end
    
    get '/songs/:slug' do
        @song = Song.find_by_slug(params[:slug])
        @artist_name = @song.artist.name
        erb :'songs/show'
    end
    
    get '/songs/:slug/edit' do
        @song = Song.find_by_slug(params[:slug])
        @genres = Genre.all
        erb :'songs/edit'
    end
    
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