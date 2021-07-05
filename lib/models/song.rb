require 'pry'
class Song
  attr_accessor :name
  attr_reader :artist, :genre
  @@all = []
  
  def initialize(name, artist = nil, genre = nil)
    @name = name
    artist.add_song(self) unless artist == nil
    self.genre = genre unless genre == nil
  end
  
  def self.all
    @@all
  end
  
  def save
    Song.all << self
    self
  end
  
  def self.destroy_all
    self.all.clear
  end
  
  def self.create(name)
    self.new(name).save
  end
  
  def artist=(artist)
    @artist = artist
    artist.add_song(self)
  end
  
  def genre=(genre)
    @genre = genre
    genre.songs << self unless genre.songs.include?(self)
  end

  def self.find_by_name(name)
    self.all.find{|song| song.name == name}
  end

  def self.find_or_create_by_name(name)
    !!self.find_by_name(name) ? self.find_by_name(name) : self.create(name)
  end


  
  def self.new_from_filename(filename)
    name = filename.split("-")[1].strip
    artist = Artist.find_or_create_by_name(filename.split("-")[0].strip)
    genre = Genre.find_or_create_by_name(filename.split(" - ")[2].split(".").shift.strip)
    song = Song.new(name, artist, genre)
    #binding.pry
  end

  def self.create_from_filename(filename)
    self.all << Song.new_from_filename(filename)
  end


end