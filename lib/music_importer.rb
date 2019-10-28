require 'pry'

class MusicImporter

  attr_accessor :path

  def initialize(path = "./db/mp3s/")
    @path = path
  end

  def files
    Dir[@path + "/*"].collect {|file| File.basename(file)}
  end

  def import
    self.files.each { |filename| Song.create_from_filename(filename) }
  end

end
