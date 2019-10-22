require_relative './concerns/findable.rb'
class Genre
  extend Concerns::Findable
  attr_accessor :name
  attr_reader :songs
  @@all = []

  def initialize(name)
    @name = name
    @songs = []
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
    new_genre = Genre.new(name)
    new_genre.save
    new_genre
  end

  def add_song(song)
    @songs << song unless songs.include?(song)
    song.genre = self if song.genre.nil?
  end

  def artists
    @songs.map(&:artist).uniq
  end
end
