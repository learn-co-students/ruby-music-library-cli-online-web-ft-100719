require_relative './concerns/findable'

class Song
  
  extend Concerns::Findable
  
  attr_accessor :name
  attr_reader :artist, :genre
  
  @@all = []
  
  def initialize(name, artist = nil, genre = nil)
    @name = name
    self.artist = artist if artist
    self.genre = genre if genre
  end
  
  def artist=(artist)
    @artist = artist
    artist.add_song(self) if artist
  end
  
  def genre=(genre)
    @genre = genre if genre
    genre.songs << self unless genre.songs.include?(self)
  end
  
  def self.destroy_all
    @@all = []
  end
  
  def save
    @@all << self
  end
  
  def self.new_from_filename(filename)
    artist_name, song_name, genre = filename.gsub(/(.mp3)/, "").split(" - ")
    song = self.new
  end
  
end