class MusicImporter

attr_reader :path

def initialize(filepath)
  @path=filepath
end


def path
  @path
end

def files
  # @files||= Dir.glob("#{path}/*.mp3").collect{ |f| f.gsub("#{path}/", "") }
  files =[]
  Dir.glob(@path + '/*.mp3').each do |f|
      files << f.split("/").last
    end
  files
end

def import
  files.each{|filename| Song.create_from_filename(filename)}
end


end
