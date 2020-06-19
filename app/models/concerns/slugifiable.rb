module Slugifiable
	module InstanceMethods
		def slug
	    	slug_name = self.name.split(" ").join("-").downcase
	    	slug_name
	    end
	end

    module ClassMethods
		def find_by_slug(str)
			name = str.split("-").map{|word| word.capitalize}.join(" ")
			# instance = self.find_by(name: name)
			instance = self.where(["name LIKE ?", name]).first
			instance 
		end 
	end
end