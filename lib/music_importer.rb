class MusicImporter
  attr_accessor :path 
  
  def initialize(path)
    @path = path
  end
  
  def files 
    files = Dir.entries(self.path)
    files.delete_if{|file| !file.end_with?("3")}
  end 
  
  def import 
    files.each do |file|
      Song.create_from_filename(file)
    end
  end 
end 