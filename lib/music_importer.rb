class MusicImporter
    attr_accessor :path
  
    def initialize(path)
      self.path = path
    end
  
    def import
      song_filenames = self.files
      song_filenames.each { |filename| Song.create_from_filename(filename) }
    end
  
    def files
      new_files = Dir["#{path}/**/*.mp3"]
      new_files.map { |filename| filename.split("/").last }
    end
  end