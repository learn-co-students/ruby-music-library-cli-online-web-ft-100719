require_relative './concerns/findable.rb'
class Artist
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
    new_artist = Artist.new(name)
    new_artist.save
    new_artist
  end

  def add_song(song)
    @songs << song unless songs.include?(song)
    song.artist = self if song.artist.nil?
  end

  def genres
    @songs.map(&:genre).uniq
  end
end
