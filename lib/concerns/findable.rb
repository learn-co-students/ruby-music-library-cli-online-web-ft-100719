module Concerns
  module Findable
    def find_by_name(name)
      self.all.find { |cur_obj| cur_obj.name == name }
    end # find by name
  
    def find_or_create_by_name(name)
      cur_obj = self.find_by_name(name) 
      !cur_obj ? self.create(name) : cur_obj
    end # find or create
  end
end
