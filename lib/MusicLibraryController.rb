class MusicLibraryController
  
  attr_accessor :path
  
  def initialize(path = "./db/mp3s")
    @path = path
    MusicImporter.new(path).import
  end
  
  def call
    
    input = ""
    
    puts "Welcome to your music library!"
    puts "To list all of your songs, enter 'list songs'."
    puts "To list all of the artists in your library, enter 'list artists'."
    puts "To list all of the genres in your library, enter 'list genres'."
    puts "To list all of the songs by a particular artist, enter 'list artist'."
    puts "To list all of the songs of a particular genre, enter 'list genre'."
    puts "To play a song, enter 'play song'."
    puts "To quit, type 'exit'."
    while input != "exit"
      puts "What would you like to do?"
      
      input = gets.chomp
        case input
          when "list songs"
            puts self.list_songs
          when "list artists"
            puts self.list_artists
          when "list genres"
            puts self.list_genres
          when "list artist"
            puts self.list_songs_by_artist
          when "list genre"
            puts self.list_songs_by_genre
          when "play song"
            puts self.play_song
        end
      end
  end
  
  def sorted_songs
    Song.all.sort_by {|song| song.name}
  end
  
  def sorted_artists
    Artist.all.sort_by {|artist| artist.name}
  end
  
  def sorted_genres
    Genre.all.sort_by {|genre| genre.name}
  end
  
  def list_songs
    index = 0
    sorted_songs.map do |song|
      index += 1
      puts "#{index}. #{song.artist.name} - #{song.name} - #{song.genre.name}"
    end
  end
  
  def list_artists
    index = 0
    sorted_artists.map do |artist|
      index += 1
      puts "#{index}. #{artist.name}"
    end
  end
  
  def list_genres
    index = 0
    sorted_genres.map do |genre|
      index += 1
      puts "#{index}. #{genre.name}"
    end
  end
  
  def list_songs_by_artist
    puts "Please enter the name of an artist:"
    input = gets.chomp
    searched_artist = Artist.all.find { |artist| artist.name == input.to_s }
    if searched_artist
      index = 0
      sorted_songs = searched_artist.songs.sort_by { |song| song.name }
      sorted_songs.map do |song|
        index += 1
        puts "#{index}. #{song.name} - #{song.genre.name}"
      end
    end
  end
  
  def list_songs_by_genre
    puts "Please enter the name of a genre:"
    input = gets.chomp
    searched_genre = Genre.all.find { |genre| genre.name == input.to_s }
    if searched_genre
      index = 0
      sorted_songs = searched_genre.songs.sort_by { |song| song.name }
      sorted_songs.map do |song|
        index += 1
        puts "#{index}. #{song.artist.name} - #{song.name}"
      end
    end
  end
  
  def play_song
    puts "Which song number would you like to play?"
    input = gets.chomp
    song = sorted_songs[input.to_i - 1]
    if input.to_i > 0 && input.to_i <= sorted_songs.length
      puts "Playing #{song.name} by #{song.artist.name}"
    end
  end
  
end

