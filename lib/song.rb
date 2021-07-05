class Song
  attr_accessor :name, :artist, :genre
  @@all = []

  def initialize(name, artist = nil, genre = nil)
    @name = name
    self.artist=(artist)
    self.genre=(genre)
    save
  end

  def self.all
    @@all
  end

  def self.destroy_all
    all.clear
  end

  def save
    @@all << self
  end

  def self.create(name)
    self.new(name)
  end

  def artist=(artist)
    @artist = artist
    artist.add_song(self) if self.artist
  end

  def genre=(genre)
    @genre = genre
    genre.add_song(self) if self.genre
  end

  def self.find_by_name(name)
    @@all.find {|song| song.name == name}
  end

  def self.find_or_create_by_name(name)
    if self.find_by_name(name) == nil
      self.create(name)
    else
      self.find_by_name(name)
    end
  end

  def self.new_from_filename(filename)
    split_file = filename.split(" - ")
    split_file[2].delete_suffix!(".mp3")
    song = self.new(split_file[1])
    artist = Artist.find_or_create_by_name(split_file[0])
    song.artist = artist
    genre = Genre.find_or_create_by_name(split_file[2])
    song.genre = genre
    song
  end

  def self.create_from_filename(filename)
    song = self.new_from_filename(filename)
    song.save
  end
end
