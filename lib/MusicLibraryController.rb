class MusicLibraryController
  
  attr_accessor :path
  
  def initialize(path = "./db/mp3s")
    @path = path
    MusicImporter.new(path).import
  end
  
  def call
    
    puts "Welcome to your music library!"
    puts "To list all of your songs, enter 'list songs'."
    puts "To list all of the artists in your library, enter 'list artists'."
    puts "To list all of the genres in your library, enter 'list genres'."
    puts "To list all of the songs by a particular artist, enter 'list artist'."
    puts "To list all of the songs of a particular genre, enter 'list genre'."
    puts "To play a song, enter 'play song'."
    puts "To quit, type 'exit'."
    puts "What would you like to do?"
    
    input = gets
    until input == "exit"
    
      case input
        when "list songs"
          list_songs
        when "list artists"
          list_artists
        when "list genres"
          list_genres
        when "list artist"
          list_songs_by_artist
        when "list genre"
          list_songs_by_genre
        when "play song"
          play_song
        when "exit"
          puts "Goodbye"
        else
          puts "Invalid Command"
        end
      
      end
      
    # unless input == "exit"
    #   call
    # end
    
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
    index = 1
    
    sorted_songs.each do |song|
      
      puts "#{index}. #{song.artist.name} - #{song.name} - #{song.genre.name}"
      index += 1
      
    end
  end
  
  def list_artists
    index = 1
    
    sorted_artists.each do |artist|
      
      puts "#{index}. #{artist.name}"
      index += 1
      
    end
  end
  
  def list_genres
    index = 1
    sorted_genres.each do |genre|
      
      puts "#{index}. #{genre.name}"
      index += 1
      
    end
  end
  
  def list_songs_by_artist
    puts "Please enter the name of an artist:"
    input = gets
    searched_artist = Artist.all.find { |artist| artist.name == input.to_s }
    if searched_artist
      index = 1
      sorted_songs = searched_artist.songs.sort_by { |song| song.name }
      sorted_songs.each do |song|
        puts "#{index}. #{song.name} - #{song.genre.name}"
        index += 1
      end
    end
  end
  
  def list_songs_by_genre
    puts "Please enter the name of a genre:"
    input = gets
    searched_genre = Genre.all.find { |genre| genre.name == input.to_s }
    if searched_genre
      index = 1
      sorted_songs = searched_genre.songs.sort_by { |song| song.name }
      sorted_songs.each do |song|
        puts "#{index}. #{song.artist.name} - #{song.name}"
        index += 1
      end
    end
  end
  
  def play_song
    puts "Which song number would you like to play?"
    input = gets
    song = sorted_songs[input.to_i - 1]
    if input.to_i > 0 && input.to_i <= sorted_songs.length
      puts "Playing #{song.name} by #{song.artist.name}"
    end
  end
  
end

