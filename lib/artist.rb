require_relative './concerns/findable'

class Artist
  
  extend Concerns::Findable
  
  attr_accessor :name, :song
  
  @@all = []
  
  def initialize(name)
    @name = name
    @songs = []
  end
  
  def self.destroy_all
    @@all = []
  end
  
  def save
    @@all << self
  end
  
  def self.create(name)
    artist = Artist.new(name)
    artist.save
    self
  end
  
  def songs
    @songs
  end
  
  def add_song(song)
    song.artist = self if !song.artist
    @songs << song unless @songs.include?(song)
  end
  
  def genres
    @songs.map { |song| song.genre }.uniq
  end
  
end