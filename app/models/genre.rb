class Genre < ActiveRecord::Base 
    include Slugifiable::InstanceMethods
    extend Slugifiable::ClassMethods

    has_many :song_genres
    has_many :songs, through: :song_genres
    has_many :artists, through: :songs

    def self.find_by_slug(str)
    	name = deslug(str)
    	Genre.find_by(name: name)
    end
end 