require 'pry'

class Song

  attr_accessor :name

  @@all = []

  def initialize(name, artist = nil, genre = nil)
    @name = name
    self.artist = artist if artist
    self.genre = genre if genre
  end

  def self.find_or_create_by_name(name)
    if self.find_by_name(name)
      self.find_by_name(name)
    else
      song = self.create(name)
    end
  end

  def self.find_by_name(name)
    @@all.find {|song| song.name == name}
  end

  def genre
    @genre
  end

  def genre=(genre)
    @genre = genre
    unless genre.songs.include?(self)
      genre.songs << self
    end
  end

  def artist=(artist)
    @artist = artist
    artist.add_song(self)
  end

  def artist
    @artist
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
    song = self.new(name)
    song.save
    song
  end

end
