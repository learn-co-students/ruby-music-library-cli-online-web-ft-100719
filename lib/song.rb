# require_relative './concerns/findable.rb'
# require_relative './artist.rb'
# require_relative './genre.rb'


require 'pry'

class Song

  attr_accessor :name, :artist

  @@all=[]

  def initialize(name, artist=nil, genre=nil)
    @name=name
    self.artist=artist unless artist==nil#artist= instead of simply assigning to an @artist instance variable to ensure that associations are created upon initializati
    self.genre=genre unless genre==nil

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
    song=Song.new(name)
    song.save
    song
  end

  def artist
    @artist
  end

  def artist=(artist)#-> passing in an Artist object that looks like #<Artist:0x000055ceeca68248 @name="Bobby", @songs=[]>
  @artist=artist
    # @artist.songs << self
  @artist.add_song(self)
  end

  def genre
    @genre
  end

  def genre=(genre)
    @genre=genre
    @genre.songs << self unless @genre.songs.include?(self)
    # @songs << song unless @songs.include?(song)
  end

  def self.find_by_name(name)
    self.all.find{|song| song.name==name}
  end

  def self.find_or_create_by_name(name)
    self.find_by_name(name)? self.find_by_name(name) : self.create(name)
  end

end
# binding.pry|| self.find_by_name(name)!=self
