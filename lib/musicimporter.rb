class MusicImporter
  attr_accessor :path, :filename 
  
  #path ="./spec/fixtures/mp3s")
  def initialize(path)
    @path = path 
  end #initialize
  
  def import 
    self.files.each { |filename| Song.create_from_filename(filename) }
  end #import
  
  def files
    files = []
    
    Dir.glob(@path + '/*.mp3').each do |f|
      files << f.split("/").last
    end #each
   
    files

  end #files
end #MusicImporter