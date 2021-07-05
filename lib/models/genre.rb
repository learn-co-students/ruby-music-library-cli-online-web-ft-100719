class Genre
    attr_accessor :name, :songs
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
      Genre.all << self
      self
    end
    
    def self.destroy_all
      self.all.clear
    end
    
    def self.create(name)
      self.new(name).save
    end
    
    def artists
      self.songs.collect{|song| song.artist}.uniq
    end
  end