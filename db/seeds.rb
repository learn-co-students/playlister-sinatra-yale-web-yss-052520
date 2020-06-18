# Add seed data here. Seed your database with `rake db:seed`
require_relative '../config/environment.rb'
Artist.destroy_all
Genre.destroy_all
Song.destroy_all
SongGenre.destroy_all

LibraryParser.parse()
