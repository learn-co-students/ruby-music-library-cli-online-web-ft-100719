class Artist
    attr_accessor :name
    attr_reader :songs
    @@all = []

    extend Concerns::Findable
    
    def initialize(name)
      @name = name
      @songs = []
    end
    
    def self.all
      @@all
    end
    
    def save
      Artist.all << self
      self
    end
    
    def self.destroy_all
      self.all.clear
    end
    
    def self.create(name)
      self.new(name).save
    end
    
    def add_song(song)
      @songs << song unless @songs.include?(song)
      song.artist = self if song.artist == nil
    end
    
    def genres
      self.songs.collect{|song| song.genre}.uniq
    end
    
  end