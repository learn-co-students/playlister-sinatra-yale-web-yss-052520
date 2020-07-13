class Song < ActiveRecord::Base
    has_many :song_genres
    has_many :genres, through: :song_genres
    belongs_to :artist

    def slug
        self.name.strip.gsub(' ', '-').gsub(/[^\w-]/, '').downcase
        # self.name.split(" ").join("-").downcase
    end
    def self.find_by_slug(slug)
        Song.find{|s| s.slug == slug}
    end
end