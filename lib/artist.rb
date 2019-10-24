class Artist

  extend Concerns

  attr_accessor :name, :artist, :genre

  @@all = []


  def initialize(name)
    @name = name
    self.class.all << self
    @songs = []
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
    self.new(name)
  end

  def songs
    @songs
  end

  def add_song(song)
    song.artist = self unless song.artist == self
    @songs << song unless @songs.include?(song)
  end

  def genres
    genres = @songs.collect do |song|
      song.genre
    end
    genres.uniq
  end


end
