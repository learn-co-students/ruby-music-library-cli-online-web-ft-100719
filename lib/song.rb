require 'pry'

class Song

  attr_accessor :name
  attr_reader :artist, :genre

  @@all = Array.new

  def initialize(name, artist = nil, genre = nil)
    @name = name
    self.artist=artist
    self.genre=genre
  end

  def self.all
    @@all
  end

  def save
    @@all << self
  end

  def self.destroy_all
    @@all.clear
  end

  def self.create(name)
    new_song = self.new(name)
    new_song.save
    new_song
  end

  def artist=(artist)
    @artist = artist
    artist.add_song(self) unless artist == nil
  end

  def genre=(genre)
    @genre = genre
    if genre != nil && !genre.songs.include?(self)
      genre.songs << self
    end
  end

  def self.find_by_name(name)
    self.all.find { |song| song.name == name }
  end

  def self.find_or_create_by_name(name)
    if self.find_by_name(name) == nil
      self.create(name)
    else 
      self.find_by_name(name)
    end
  end

  def self.new_from_filename(filename)
    song_name = filename.split(" - ")[1]
    artist_string = filename.split(" - ")[0]
    artist = Artist.find_or_create_by_name(artist_string)
    genre_string = filename.split(" - ")[2].split(".")[0]
    genre = Genre.find_or_create_by_name(genre_string)
    new_song = self.new(song_name, artist, genre)
  end

  def self.create_from_filename(filename)
    new_song = new_from_filename(filename)
    new_song.save
  end

end