# require_relative './concerns/findable.rb'
# require_relative './song.rb'
# require_relative './artist.rb'

require 'pry'

class Genre

  attr_accessor :name

  @@all=[]

  def initialize(name)
    @name=name
    @@all<<self
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
    genre=Genre.new(name)
    genre.save
    genre
  end

  def songs
    @songs
  end

  def artists
    songs.collect{|song| song.artist }.uniq
  end



end
# binding.pry
