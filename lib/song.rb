class Song

  attr_accessor :name, :artist, :genre
  @@all = []

  def initialize(name, artist = nil, genre = nil)
    @name = name
    self.artist = artist if artist
    self.genre = genre if genre
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
  c = self.new(name)
  c.save
  c
end

def artist=(artist)
    if @artist == nil
      @artist = artist
    else
      @artist = @artist
    end
    if self.artist != nil
      @artist.add_song(self)
    end
    @artist
  end

  def artist
    @artist
  end

  def genre=(genre)
      if @genre == nil
        @genre = genre
      else
        @genre = @genre
      end
      if self.genre != nil
        @genre.add_song(self)
      end
      @genre
    end

    def genre
      @genre
    end


end
