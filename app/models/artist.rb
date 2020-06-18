require_relative './concerns/slugifiable'

class Artist < ActiveRecord::Base
    include Slugifiable::InstanceMethods
    extend Slugifiable::ClassMethods

    has_many :songs
    has_many :song_genres, through: :songs  
    has_many :genres, through: :song_genres 

    def self.find_by_slug(str)
    	name = deslug(str)
    	Artist.find_by(name: name)
    end
end 