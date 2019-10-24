class Genre
  attr_reader :name, :genre
  attr_accessor :song

  @@all = []

  def initialize(name)
    @name = name
    self.class.all << self
  end

  def self.all
    @@all
  end

  def name= (name)  #custom setter
    @name = name
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
