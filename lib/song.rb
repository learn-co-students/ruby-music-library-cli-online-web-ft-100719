require 'pry'

class Song

  attr_accessor :name, :genre
  attr_reader :artist
  @@all = []

  def initialize(name, artist = nil, genre = nil)
    @name = name
    self.artist = artist if artist
    self.genre = genre if genre
    # self.class.all << self
  end

  def self.all
    @@all
  end

  def self.destroy_all
      @@all = []
  end

  def save
    @@all << self
  end

  def self.create(name)
    c = Song.new(name)
    c.save
    c
  end

  def artist=(artist)
    if @artist == nil
      @artist = artist
    else
      @artist = @artist
    end
    if self.artist != nil
      @artist.add_song(self)
    end
    @artist
  end

  def artist
    @artist
  end

  def genre=(genre)
    if @genre == nil
      @genre = genre
    else
      @genre = @genre
    end
    if self.genre != nil
      @genre.add_song(self)
    end
    @genre
  end

  def genre
    @genre
  end

  def self.find_by_name(name)
    @@all.find do |song|
      song.name == name
    end
  end

  def self.find_or_create_by_name(name)
    self.find_by_name(name) || self.create(name)
  end

  def self.create_from_filename(name)
    file =  self.new_from_filename(name)
    file.save
    file
  end

  def self.new_from_filename(name)
    filename = name.gsub(/(\.mp3)/,'')
    filename = filename.split(" - ")

    song = self.find_or_create_by_name(filename[1])
    artist = Artist.find_or_create_by_name(filename[0])
    genre = Genre.find_or_create_by_name(filename[2])
    song.artist = artist
    song.genre = genre
    song
  end

end