class Slugifiable
    def self.slug(name)
        slug = name.split(" ")
        slug.map! {|e| e.downcase}
        slug.join("-")
    end
end

