require_relative './concerns/findable.rb'

class Artist 
  extend Concerns::Findable
  attr_accessor :name, :songs  
  
  @@all = []
  
  def initialize(name)
    @name = name 
    @songs = []
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
    artist = Artist.new(name)
    artist.save 
    artist 
  end
  
  def songs 
    @songs 
  end
  
  def add_song(song)
    song.artist = self unless song.artist != nil 
    @songs << song unless @songs.include?(song)
  end
  
  def genres 
    genre_array = []
    songs.each{|song| genre_array << song.genre unless genre_array.include?(song.genre)}
    genre_array
  end 
end