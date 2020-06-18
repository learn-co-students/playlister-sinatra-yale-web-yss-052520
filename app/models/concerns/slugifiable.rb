module Slugger

    def self.included(klass)
        klass.extend(ClassMethods)
    end

    module ClassMethods
        def find_by_slug(slug)
            # self.find_by(name: slug.gsub("-", " "))
            self.all.find{|instance_1| instance_1.slug == slug}
        end
    end
    
    def slug()
        self.name.gsub(" ", "-").downcase
    end
end