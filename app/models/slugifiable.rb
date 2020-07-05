module Slugifiable
    def self.included(base)
        base.extend(ClassMethods)
    end
    
    def slug
        name.downcase.gsub(" ", "-")
    end
    
    module ClassMethods
        def find_by_slug(slug)
            self.all.find{|artist| artist.slug == slug}
        end
    end
end