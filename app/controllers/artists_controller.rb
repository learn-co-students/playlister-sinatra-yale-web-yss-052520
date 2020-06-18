class ArtistsController < ApplicationController
    register Sinatra::ActiveRecordExtension
    set :views, "app/views/artists"

    def find_artist
        @category = Category.find_by(name: params[:name])
    end
  
    get '/artists' do
        @artists = Artist.all
        erb :index
    end

    get '/' do
        redirect "/artists"
    end

    get '/artists/new' do
        erb :new
    end
 
    #Show page for single artist
    get '/artists/:slug' do 
        @artist = current_artist
        erb :show
    end
 
    #form for editing an existing artist
    get '/artists/:slug/edit' do
        @artist = current_artist
        erb :edit
    end
 
    #create an artist
    post '/artists' do
        artist = Artist.create(address: params[:address]) #params => {address: "user input"}
        redirect "/artists/#{artist.slug}"
    end
 
    #updating an artist
    patch '/artists/:slug' do
        artist = current_artist
        artist.update(name: params[:new_name])
        
        redirect "/artists/#{artist.slug}"
    end
 
    #Delete an artist
    delete '/artists/:slug' do
        artist = current_artist
        artist.destroy
        redirect '/artists'
    end
 
    # finding an existing artist
    def current_artist
        Artist.find_by_slug(params[:slug])
    end
 
  end