require_relative '../models/concerns/slugifiable.rb'
class Song < ActiveRecord::Base
    include Slugger

    belongs_to :artist

    has_many :song_genres
    has_many :genres, through: :song_genres
end