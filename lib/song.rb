class Song

  attr_accessor :name, :artist, :genre
  @@all = []

  def initialize(name)
    @name = name
    @artist = artist
    @genre = genre
    self.class.all << self
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
  save
end

end
