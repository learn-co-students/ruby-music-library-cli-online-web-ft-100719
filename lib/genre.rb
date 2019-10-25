class Genre 
  attr_accessor :name, :songs
  
  extend Concerns::Findable
  @@all = []
  
  def initialize(name)
    @name = name
    @@all << self
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
    new_self = self.new(name)
    new_self.save
    new_self
  end
  
  def add_song(song)
    if !song.genre 
      song.genre = self
    end
    @songs << song unless @songs.include?(song) 
  end
  
  def artists
      @songs.map{ |song| song.artist }.uniq
  end
end