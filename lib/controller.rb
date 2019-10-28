class MusicLibraryController

  def initialize(path = "./db/mp3s")
    new_import = MusicImporter.new(path)
    new_import.import
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
    user_input = nil
    while user_input != "exit" do
      user_input = gets.chomp
      test_user_input(user_input)
    end
  end

  def test_user_input(input)
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
    end
  end

  def list_songs
    sorted_songs = Song.all.sort_by { |song| song.name }
    counter = 1
    sorted_songs.each do |song|
      puts "#{counter}. #{song.artist.name} - #{song.name} - #{song.genre.name}"
      counter += 1
    end
  end

  def list_artists
    sorted_artists = Artist.all.sort_by { |artist| artist.name }
    counter = 1
    sorted_artists.each do |artist|
      puts "#{counter}. #{artist.name}"
      counter += 1
    end
  end

  def list_genres
    sorted_genres = Genre.all.sort_by { |genre| genre.name }
    counter = 1
    sorted_genres.each do |genre|
      puts "#{counter}. #{genre.name}"
      counter += 1
    end
  end

  def list_songs_by_artist
    puts "Please enter the name of an artist:"
    input = gets.chomp
    artist = Artist.find_by_name(input)
    if artist != nil
      artist_songs = artist.songs.sort_by { |song| song.name }
      counter = 1
      artist_songs.each do |song|
        puts "#{counter}. #{song.name} - #{song.genre.name}"
        counter += 1
      end
    end
  end

  def list_songs_by_genre
    puts "Please enter the name of a genre:"
    input = gets.chomp
    genre = Genre.find_by_name(input)
    if genre != nil
      songs = genre.songs.sort_by { |song| song.name }
      counter = 1
      songs.each do |song|
        puts "#{counter}. #{song.artist.name} - #{song.name}"
        counter += 1
      end
    end
  end

  def play_song
    puts "Which song number would you like to play?"
    input = gets.chomp.to_i
    if input.is_a? Numeric
      if input.between?(1, Song.all.size)
        sorted_songs = Song.all.sort_by { |song| song.name }
        song = sorted_songs[input-1]
        puts "Playing #{song.name} by #{song.artist.name}"
      end
    end
  end

end