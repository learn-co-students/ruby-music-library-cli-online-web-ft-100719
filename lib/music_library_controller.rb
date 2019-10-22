class MusicLibraryController
  def initialize(path = "./db/mp3s")
    importer = MusicImporter.new(path)
    importer.import
  end
  
  def call 
    user_input = nil 
    until user_input == "exit"
      puts "Welcome to your music library!"
      puts "To list all of your songs, enter 'list songs'."
      puts "To list all of the artists in your library, enter 'list artists'."
      puts "To list all of the genres in your library, enter 'list genres'."
      puts "To list all of the songs by a particular artist, enter 'list artist'."
      puts "To list all of the songs of a particular genre, enter 'list genre'."
      puts "To play a song, enter 'play song'."
      puts "To quit, type 'exit'."
      puts "What would you like to do?"
      user_input = gets.chomp
      if user_input == "list songs"
        list_songs
      elsif user_input == "list artists"
        list_artists
      elsif user_input == "list genres"
        list_genres
      elsif user_input == "list artist"
        list_songs_by_artist
      elsif user_input == "list genre"
        list_songs_by_genre 
      elsif user_input == "play song"
        play_song
      end
    end
  end
  
  def list_songs
    sorted = Song.all.sort{|song1, song2| song1.name <=> song2.name}
    sorted.each_with_index{|song, index| puts "#{index + 1}. #{song.artist.name} - #{song.name} - #{song.genre.name}"}
  end
  
  def list_artists
    sorted = Artist.all.sort{|artist1, artist2| artist1.name <=> artist2.name}
    sorted.each_with_index{|artist, index| puts "#{index + 1}. #{artist.name}"}
  end
  
  def list_genres
    sorted = Genre.all.sort{|genre1, genre2| genre1.name <=> genre2.name}
    sorted.each_with_index{|genre, index| puts "#{index + 1}. #{genre.name}"}
  end
  
  def list_songs_by_artist
    puts "Please enter the name of an artist:"
    user_input = gets.chomp
    artist = Artist.find_by_name(user_input)
    if artist 
      songs = artist.songs.sort{|song1, song2| song1.name <=> song2.name}
      songs.each_with_index{|song, index| puts "#{index + 1}. #{song.name} - #{song.genre.name}"}
    end
  end 
  
  def list_songs_by_genre
    puts "Please enter the name of a genre:"
    user_input = gets.chomp
    genre = Genre.find_by_name(user_input)
    if genre 
      songs = genre.songs.sort{|song1, song2| song1.name <=> song2.name}
      songs.each_with_index{|song, index| puts "#{index + 1}. #{song.artist.name} - #{song.name}"}
    end
  end 
  
  def play_song
    puts "Which song number would you like to play?"
    user_input = gets.chomp
    if user_input.to_i > 0 && user_input.to_i < Song.all.count
      sorted = Song.all.sort{|song1, song2| song1.name <=> song2.name}
      puts "Playing #{sorted[user_input.to_i - 1].name} by #{sorted[user_input.to_i - 1].artist.name}"
    end
  end 
end 