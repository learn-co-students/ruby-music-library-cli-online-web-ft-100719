class MusicImporter
  
  attr_accessor :path
  
  def initialize(filepath)
    @path = filepath
  end
  
  def path
    @path
  end
  
  def files
    Dir["#{path}/*.mp3"].map { |file| file.split("/").last }
  end
  
  def import
    files.each { |filename| Song.create_from_filename(filename) }
  end
  
end