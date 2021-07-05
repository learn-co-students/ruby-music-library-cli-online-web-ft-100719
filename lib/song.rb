class Song 
  
    attr_accessor :name, :artist, :genre
    
  @@all = []
  
  def initialize(name, artist=nil, genre=nil)
    @name = name 
   if artist != nil 
      self.artist=(artist)
    end
    if genre != nil 
      self.genre=(genre)
    end 
  end
    
  def self.all 
    @@all 
  end 
  
  def self.destroy_all 
    @@all.clear 
  end 
  
  def save 
    @@all << self 
  end 
  
  def self.create(name) 
    song = Song.new(name)
    song.save 
    song 
  end
  
  def artist=(art)
    @artist = art
    art.add_song(self)
  end 
  
  def genre=(gen)
    @genre = gen
    gen.add_song(self)
  end
  
  def self.find_by_name(name)
      @@all.find do |song|
        song.name == name
    end
  end 
  
  def self.find_or_create_by_name(name) 
    self.find_by_name(name) || self.create(name)
  end 
  
  def self.new_from_filename(filename)
    info = filename.split(" - ")
    artist, name, genre = info[0], info[1], info[2].gsub( ".mp3" , "")
    genre = Genre.find_or_create_by_name(genre)
    artist = Artist.find_or_create_by_name(artist)

    new(name,artist,genre)
  end 
  
  def self.create_from_filename(filename)
    song = self.new_from_filename(filename)
    song.save
  end 

end 
