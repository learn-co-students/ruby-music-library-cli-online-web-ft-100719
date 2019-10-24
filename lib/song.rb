
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
  
  def self.find_by_name(name)
    self.all.find { |cur_obj| cur_obj.name == name }
  end
  
  def self.find_or_create_by_name(name)
    cur_obj = self.find_by_name(name) 
    !cur_obj ? self.create(name) : cur_obj
  end
end