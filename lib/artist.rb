require 'pry'
require_relative './concerns/findable.rb'

class Artist  
  
  attr_accessor :name, :songs
    
  @@all = []            
  
  extend Concerns::Findable
  
  
  def initialize(name)
    @name = name
    @songs = []
   # @@all << self
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
  
  ######################## 
  def add_song(song)
    #binding.pry
    if !song.artist 
      song.artist = self
    end
    @songs << song unless @songs.include?(song) 
   
  end
  
  def songs
    @songs
  end
  
  def genres 
    @songs.map{ |song| song.genre }.uniq
  end
  
end