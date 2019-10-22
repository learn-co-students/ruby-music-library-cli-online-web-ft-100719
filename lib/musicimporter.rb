class MusicImporter
  
  def initialize(filepath)
    @path = filepath
  end
  
  def path
    @path
  end
  
  def files
    Dir["#{path}/*.mp3"].map { |file| file.split("/").last }
  end
  
end