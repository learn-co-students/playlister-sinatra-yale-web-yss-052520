class Artist < ActiveRecord::Base
    has_many :songs
    has_many :genres, through: :songs

    def slug
        self.name.split(" ").join("-").downcase
    end

    def self.find_by_slug(slug)
        Artist.all.find{ |artist| artist.slug == slug}
    end

    def self.all_names
        self.all.map do |artist|
            artist.name
        end
    end
end