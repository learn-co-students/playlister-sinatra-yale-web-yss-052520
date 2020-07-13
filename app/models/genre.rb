class Genre < ActiveRecord::Base
    has_many :song_genres
    has_many :songs, through: :song_genres
    has_many :artists, through: :songs

    def slug
        self.name.split(" ").join("-").downcase
    end

    def self.find_by_slug(slug)
        Genre.find{|s| s.slug == slug}
    end
end