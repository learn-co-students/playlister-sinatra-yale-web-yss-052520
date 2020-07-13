class SongsController < ApplicationController
    set :views, "app/views/songs"

    get '/songs' do
        @songs = Song.all
        erb :index
    end

    get '/songs/new' do
        @genres = Genre.all
        @artist = Artist.all 
        erb :new
    end

    enable :sessions

    post '/songs' do
        artist = Artist.find_or_create_by(name: params[:artist_name])
        song = Song.create(name: params[:song_name], artist: artist)
        if !params[:genres].empty?
            params[:genres].each { |id|
                song.genres << Genre.find(id)
            }
        end
        song.save
        session[:message] = "Successfully created song."
        redirect "songs/#{song.slug}"
    end
    
    get '/songs/:slug/edit' do 
        @song = Song.find_by_slug(params[:slug])
        @genres = Genre.all 
        erb :edit
    end

    patch '/songs/:slug' do 
        song = Song.find_by_slug(params[:slug])
        song.update(name: params[:song_name])
        artist = Artist.find_or_create_by(name: params[:artist_name])
        song.artist = artist 
        song.song_genres.each { |sg|  
            sg.destroy
        }

        unless params[:genres].length == 0 
            params[:genres].each do |genre_id| 
                song.genres << Genre.find(genre_id) 
            end 
        end 
        song.save
        session[:message] = "Successfully updated song."

        redirect "/songs/#{song.slug}"
    end

    get '/songs/:slug' do 
        @message = session[:message]
        @song = Song.find_by_slug(params[:slug])
        erb :show
    end  

end
