# require_relative './concerns/findable.rb'
# require_relative './song.rb'
# require_relative './genre.rb'

require 'pry'

class Artist


  attr_accessor :name
  attr_reader :songs


  @@all=[]

  def initialize(name)
    @name=name
    @songs=[]
  end

  def self.all
    @@all
  end

  def self.destroy_all
    self.all.clear
  end

  def save
    @@all<<self
  end

  def self.create(name)
    artist=Artist.new(name)
    artist.save
    artist
  end

  def songs
    @songs
  end

  def add_song(song)# passing in #<Song:0x000056014bd6f0b8 @name="Bahama", @artist=nil>
    song.artist = self unless song.artist
    @songs << song unless @songs.include?(song)
  end

  def genres
    songs.collect{|song| song.genre}.uniq
  end

end
# binding.pry
