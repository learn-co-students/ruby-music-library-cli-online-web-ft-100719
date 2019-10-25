class Artist

  extend Concerns::Findable

  attr_accessor :name

  @@all = []

  def initialize(name)
    @name = name
    @songs = []
  end

  def genres
    songs.collect {|song| song.genre}.uniq
  end

  def add_song(song)
    unless song.artist == self
      song.artist = self
    end
    unless @songs.include?(song)
      @songs << song
    end
  end

  def songs
    @songs
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
    artist = self.new(name)
    artist.save
    artist
  end

  def songs
    @songs
  end

end
