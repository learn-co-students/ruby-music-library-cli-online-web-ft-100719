require 'pry'
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
    found = nil
    self.all.each{|song| found = song if song.name == name}
    found
  end
  
  def self.find_or_create_by_name(name)
    if find_by_name(name)
      return find_by_name(name)
    else 
      return Song.create(name)
    end
  end
  
  def self.new_from_filename(filename)
    song_parts = filename.split(" - ")
    genre = Genre.find_or_create_by_name(song_parts[2].gsub!(".mp3", ""))
    artist = Artist.find_or_create_by_name(song_parts[0])
    song = Song.new(song_parts[1], artist, genre)
  end
  
  def self.create_from_filename(filename)
    song = new_from_filename(filename)
    song.save
  end
end