class GenresController < ApplicationController
    register Sinatra::ActiveRecordExtension
    set :views, "app/views/genres"
  
    def find_genre
        @category = Category.find_by(name: params[:name])
    end
  
    get '/genres' do
        @genres = Genre.all
        erb :index
    end

    get '/' do
        redirect "/genres"
    end

    get '/genres/new' do
        erb :new
    end
 
    #Show page for single genre
    get '/genres/:slug' do 
        @genre = current_genre
        erb :show
    end
 
    #form for editing an existing genre
    get '/genres/:slug
    /edit' do
        @genre = current_genre
        erb :edit
    end
 
    #create an genre
    post '/genres' do
        genre = Genre.create(address: params[:address]) #params => {address: "user input"}
        redirect "/genres/#{genre.slug}"
    end
 
    #updating an genre
    patch '/genres/:slug' do
        genre = current_genre
        genre.update(address: params[:address])
        
        redirect "/genres/#{genre.slug}"
    end
 
    #Delete an genre
    delete '/genres/:slug
    ' do
        genre = current_genre
        genre.destroy
        redirect '/genres'
    end
 
    # finding an existing genre
    def current_genre
        Genre.find_by_slug(params[:slug])
    end
 
  end