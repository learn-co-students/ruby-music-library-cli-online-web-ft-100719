
require 'pry'
class Song 
  attr_accessor :name, :artist, :genre
                
  extend Concerns::Findable
  
  @@all = []
  
  def initialize(name, artist=nil, genre=nil)
    @name = name
    self.artist = artist if artist 
    self.genre = genre if genre
    #@@all << self
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
    new_self = self.new(name)
    new_self.save
    new_self
  end
  
  def artist=(artist)
    @artist = artist
    artist.add_song(self)
  end
  
  def genre=(genre)
    @genre = genre
    genre.add_song(self)
  end
  
  def self.new_from_filename(filename)
    song_details = filename.gsub(/.mp3$/, '').split(" - ")
    song_name = song_details[1]
    new_song = self.new(song_name)
    new_song.artist = Artist.find_or_create_by_name(song_details[0])
    new_song.genre = Genre.find_or_create_by_name(song_details[2])
    new_song
  end
  
  def self.create_from_filename(filename)
    new_song = self.new_from_filename(filename)
    new_song.save
    new_song
  end #create_from_filename
  
end