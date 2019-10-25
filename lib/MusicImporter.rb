class MusicImporter


  def initialize(path)
    @path = path
  end

  def path
    @path
  end

  def files()
    #glob retuns an array containg the matching filenames, gsub strips the path and just gives the filename
    # plus a ,
    @files ||= Dir.glob("#{path}/*.mp3").collect{ |file| file.gsub("{@path}/","")}
  end

  def import()
    files.each do |filename|
      Song.find_or_create_by_name(name)
    end
  end

end
