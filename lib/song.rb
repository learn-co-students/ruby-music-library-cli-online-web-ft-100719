require_relative './concerns/findable.rb'
class Song
  extend Concerns::Findable
  attr_accessor :name
  attr_reader :artist, :genre
  @@all = []

  def initialize(name, artist = nil, genre = nil)
    self.name = name
    self.artist = artist
    self.genre = genre
  end

  def save
    @@all << self
  end

  def self.all
    @@all
  end

  def self.destroy_all
    @@all.clear
  end

  def self.create(name)
    new_song = Song.new(name)
    new_song.save
    new_song
  end

  def artist=(artist)
    if artist.is_a? Artist
      @artist = artist
      artist.add_song(self) unless artist.songs.include?(self)
    end
  end

  def genre=(genre)
    if genre.is_a? Genre
      @genre = genre
      genre.add_song(self) unless genre.songs.include?(self)
    end
  end

  def self.new_from_filename(filename)
    file_info = filename.split(/ - |.mp3/)
    artist_from_file = Artist.find_or_create_by_name(file_info[0])
    genre_from_file = Genre.find_or_create_by_name(file_info[2])
    Song.new(file_info[1], artist_from_file, genre_from_file)
  end

  def self.create_from_filename(filename)
    new_song = self.new_from_filename(filename)
    new_song.save
    new_song
  end

end
