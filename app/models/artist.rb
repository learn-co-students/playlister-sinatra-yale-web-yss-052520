require_relative '../models/concerns/slugifiable.rb'

class Artist < ActiveRecord::Base
    include Slugger
    has_many :songs
    has_many :genres, through: :songs
end