require 'pry'
class MusicImporter
  attr_accessor :path
  
  def initialize(path)
    @path = path
  end
  
  def files
    filenames = Dir["#{path}/*.mp3"]
    filenames.collect{|filename|filename.split("/").pop}
  end

  def import
    self.files.each { |filename| Song.create_from_filename(filename) } 
  end

end