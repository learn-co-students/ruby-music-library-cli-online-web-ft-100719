require_relative './concerns/findable.rb'

class Genre 
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
    genre = Genre.new(name)
    genre.save 
    genre 
  end
  
  def songs 
    @songs
  end
  
  def artists
    artist_array = []
    songs.each{|song| artist_array << song.artist unless artist_array.include?(song.artist)}
    artist_array
  end 
end