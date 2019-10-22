module Concerns::Findable
  
    def create(name)
      obj = self.new(name)
      obj.save
      obj
    end
    
    def find_by_name(name)
      self.all.find {|a| a.name == name}
    end
    
    def all
      class_variable_get("@@all")
    end
    
    def find_or_create_by_name(name)
      if !find_by_name(name)
        self.create(name)
      else
        find_by_name(name)
      end
    end
    
end