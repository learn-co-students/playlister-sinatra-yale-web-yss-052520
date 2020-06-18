class Song < ActiveRecord::Base 
	include Slugifiable::InstanceMethods
    extend Slugifiable::ClassMethods

    belongs_to :artist
    has_many :song_genres
    has_many :genres, through: :song_genres

    def self.find_by_slug(str)
    	name = deslug(str)
    	Song.find_by(name: name)
    end
end 