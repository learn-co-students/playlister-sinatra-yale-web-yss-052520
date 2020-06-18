module Slugifiable
	module InstanceMethods
		def slug
	    	slug_name = self.name.split(" ").join("-").downcase
	    	slug_name
	    end
	end

    module ClassMethods
	    def deslug(str)
	    	name = str.split("-").map{|word| word.capitalize}.join(" ")
	    	name
	    end
	end
end