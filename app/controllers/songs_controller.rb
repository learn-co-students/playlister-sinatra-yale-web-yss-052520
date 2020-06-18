
class SongsController < ApplicationController
        
    set :views, "app/views/songs" 

    #display all songs 
    get '/songs' do 
        @songs = Song.all 
        erb :index
    end 

    #form to make new song 
    get '/songs/new' do 
        @genres = Genre.all 
        @artists = Artist.all 
        erb :new 
    end 

    enable :sessions
    #response to create new song 
    post '/songs' do 
        artist = Artist.find_or_create_by(name: params[:artist_name]) 
        song = Song.create(name: params[:song_name], artist: artist) 
        unless params[:genres].length == 0 
            params[:genres].each do |genre_id| 
                song.genres << Genre.find(genre_id) 
            end 
        end 
        song.save 
        session[:message] = "Successfully created song."
        redirect "/songs/#{song.slug}"
    end 

    get '/songs/:slug/edit' do 
        @song = Song.find_by_slug(params[:slug])
        @genres = Genre.all 
        erb :edit 
    end 

    get '/songs/:slug' do 
        @message = session[:message]
        @song = Song.find_by_slug(params[:slug])
        erb :show
    end  

    patch '/songs/:slug' do 
        song = Song.find_by_slug(params[:slug]) 
        song.update(name: params[:song_name]) 
        artist = Artist.find_or_create_by(name: params[:artist_name]) 
        song.artist = artist 
        song.song_genres.each do |songgenre| 
            songgenre.destroy 
        end 
        unless params[:genres].length == 0 
            params[:genres].each do |genre_id| 
                song.genres << Genre.find(genre_id) 
            end 
        end 
        song.save 
        session[:message] = "Successfully updated song."

        redirect "/songs/#{song.slug}"
        # {song_name, artist_name, genres[12]}
    end 
end
