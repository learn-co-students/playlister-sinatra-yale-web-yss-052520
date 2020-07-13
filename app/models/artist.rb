class Artist < ActiveRecord::Base
    has_many :songs
    has_many :song_genres, through: :songs
    has_many :genres , through: :song_genres

    def slug
        self.name.split(" ").join("-").downcase
    end

    def self.find_by_slug(slug)
        Artist.find{|s| s.slug == slug}
    end
end