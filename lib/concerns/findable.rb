module Findable
  
  module ClassMethods
    
    def find_by_name(given_name)
      self.all.find {|a| a.name == given_name}
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
end