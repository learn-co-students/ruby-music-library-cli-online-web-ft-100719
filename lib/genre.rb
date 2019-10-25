class Genre
extend Concerns::Findable

  attr_reader :name, :genre
  attr_accessor :song

  @@all = []

  def initialize(name)
    @name = name
    self.class.all << self
    @songs = []
  end

  def self.all
    @@all
  end

  def name= (name)  #custom setter
    @name = name
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
      song.genre = self unless song.genre == self
      @songs << song unless @songs.include?(song)
  end

  def artists
    artists = @songs.collect do |song|
      song.artist
    end
    artists.uniq
  end


end
