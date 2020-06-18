class SongsController < ApplicationController
    register Sinatra::ActiveRecordExtension
    set :views, "app/views/songs"
  
    def find_song
        @category = Category.find_by(name: params[:name])
    end
  
    get '/songs' do
        @songs = Song.all
        erb :index
    end

    get '/' do
        redirect "/songs"
    end

    get '/songs/new' do
        erb :new
    end
 
    #Show page for single song
    get '/songs/:slug' do 
        @song = current_song
        erb :show
    end
 
    #form for editing an existing song
    get '/songs/:slug
    /edit' do
        @song = current_song
        erb :edit
    end
 
    #create an song
    post '/songs' do
        song = Song.create(address: params[:address]) #params => {address: "user input"}
        redirect "/songs/#{song.slug}"
    end
 
    #updating an song
    patch '/songs/:slug' do
        song = current_song
        song.update(address: params[:address])
        
        redirect "/songs/#{song.slug}"
    end
 
    #Delete an song
    delete '/songs/:slug
    ' do
        song = current_song
        song.destroy
        redirect '/songs'
    end
 
    # finding an existing song
    def current_song
        Song.find_by_slug(params[:slug])
    end
 
  end