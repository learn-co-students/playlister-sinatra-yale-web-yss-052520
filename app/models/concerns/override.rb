module Override
    def create(name: name)
        instance_1 = self.new(name: name, slug: name.parameterize)
        instance_1.save()
    end
end