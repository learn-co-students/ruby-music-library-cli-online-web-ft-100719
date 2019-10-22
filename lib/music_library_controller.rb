class MusicLibraryController
  def initialize(path = './db/mp3s')
    importer = MusicImporter.new(path)

    importer.import
  end

  def call
    user_input = ""
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

      user_input = gets.strip

      test_input(user_input)
    end
  end

  def format_song(song)
    if song.is_a? Song
      "#{song.artist.name} - #{song.name} - #{song.genre.name}"
    end
  end

  def sort_music_objects(array)
    array.sort { |object_a, object_b| object_a.name <=> object_b.name }
  end

  def list_songs
    sorted_songs = sort_music_objects(Song.all)
    sorted_songs.each_with_index { |song, i| puts "#{i + 1}. #{format_song(song)}" }
  end

  def list_artists
    sorted_artists = sort_music_objects(Artist.all)
    sorted_artists.each_with_index { |artist, i| puts "#{i + 1}. #{artist.name}" }
  end

  def list_genres
    sorted_genres = sort_music_objects(Genre.all)
    sorted_genres.each_with_index { |genre, i| puts "#{i + 1}. #{genre.name}" }
  end

  def list_songs_by_artist
    puts "Please enter the name of an artist:"

    user_input = gets.strip

    requested_artist = Artist.find_by_name(user_input)

    if requested_artist.is_a? Artist
      sorted_songs = sort_music_objects(requested_artist.songs)
      sorted_songs.each_with_index do |song, i|
        puts "#{i + 1}. #{song.name} - #{song.genre.name}"
      end
    end
  end

  def list_songs_by_genre
    puts 'Please enter the name of a genre:'

    user_input = gets.strip

    requested_genre = Genre.find_by_name(user_input)

    if requested_genre.is_a? Genre
      sorted_songs = sort_music_objects(requested_genre.songs)
      sorted_songs.each_with_index do |song, i|
        puts "#{i + 1}. #{song.artist.name} - #{song.name}"
      end
    end
  end

  def valid_song_choice?(song_number_choice, song_array_size)
    (song_number_choice.is_a? Integer) && song_number_choice.positive? &&
      (song_number_choice <= song_array_size)
  end

  def play_song
    puts 'Which song number would you like to play?'

    user_input = gets.strip.to_i

    sorted_songs = sort_music_objects(Song.all)

    if valid_song_choice?(user_input, sorted_songs.size)
      chosen_song = sorted_songs[user_input - 1]

      puts "Playing #{chosen_song.name} by #{chosen_song.artist.name}"
    end
  end

  def test_input(user_input)
    case user_input.strip.downcase
    when 'list songs'
      list_songs
    when 'list artists'
      list_artists
    when 'list genres'
      list_genres
    when 'list artist'
      list_songs_by_artist
    when 'list genre'
      list_songs_by_genre
    when 'play song'
      play_song
    end
  end
end
