require_relative '../models/concerns/slugifiable.rb'

class Genre < ActiveRecord::Base
    include Slugger
    has_many :song_genres
    has_many :songs, through: :song_genres

    has_many :artists, through: :songs

end