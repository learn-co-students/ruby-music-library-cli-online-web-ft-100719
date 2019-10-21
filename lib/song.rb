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
  
  def artist=(a)
    @artist = a 
    a.add_song(self)
  end
  
  def genre=(g)
    @genre = g 
    g.songs << self unless g.songs.include?(self)
  end
  
  def self.find_by_name(name)
    self.all.each{|song| return song if song.name == name}
  end
  
  def self.find_or_create_by_name(name)
    if find_by_name(name)
      return find_by_name(name)
    else 
      Song.create(name)
    end
  end
end