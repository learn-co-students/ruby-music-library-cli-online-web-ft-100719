class Song

    attr_accessor :name, :genre
    attr_reader :artist
    @@all=[]

    def initialize(name, artist=nil, genre=nil)
        @name=name
        self.artist=artist if artist
        self.genre=genre if genre
    end
   
    def self.all
        @@all
    end

    def self.destroy_all
        @@all=[]
    end

    def save
        @@all << self
    end

    def self.create(name)
        song=Song.new(name)
        song.save
        song
    end

    def artist=(artist)
        @artist=artist
        artist.add_song(self) unless artist.songs.include?(self)
    end

    def genre=(genre)
        @genre=genre
        genre.songs << self unless genre.songs.include?(self)
    end

    def self.find_by_name(name)
        @@all.detect{|song| song.name==name}
    end

    def self.find_or_create_by_name(name)
        if find_by_name(name)
            song= find_by_name(name)
        else
            song= create(name)
        end
        song
    end

    def self.new_from_filename(file_name)
        song_info=file_name.split(" - ")
        song_name=song_info[1]
        artist_name=song_info[0]
        song_genre=song_info[2].delete_suffix(".mp3")
        
        artist= Artist.find_or_create_by_name(artist_name) #unless Artist.all.include?(song.artist)
        genre= Genre.find_or_create_by_name(song_genre) #unless Genre.all.include?(song.genre)
        song=Song.new(song_name, artist, genre )
        song
    end

    def self.create_from_filename(file_name)
        song= Song.new_from_filename(file_name)
        song.save
        song
    end


end