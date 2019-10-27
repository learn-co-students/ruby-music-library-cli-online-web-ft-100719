
require 'pry'
class MusicLibraryController

    attr_accessor :path

  def initialize(path = "./db/mp3s")
    @path = path
    importer = MusicImporter.new(path)
    importer.import
  end

  def call
    user_input = ""
    while user_input != "exit"
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
      case user_input
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
  end

  def play_song
    puts "Which song number would you like to play?"
    song_list = Song.all.sort {|a, b| a.name <=> b.name}
    user_input = gets.strip.to_i
      if (1..Song.all.length).include?(user_input)
        song = song_list[user_input - 1]
        puts "Playing #{song.name} by #{song.artist.name}"
      end
    end


  def list_songs_by_genre
    puts "Please enter the name of a genre:"
    user_input = gets.strip
    if genre = Genre.find_by_name(user_input)
      genre.songs.sort {|a,b| a.name <=> b.name}.each.with_index(1) do |genre, index|
        puts "#{index}. #{genre.artist.name} - #{genre.name}"
      end
    end
  end

  def list_songs_by_artist
    puts "Please enter the name of an artist:"
    user_input = gets.strip
    if artist = Artist.find_by_name(user_input)
      artist.songs.sort {|a,b| a.name <=> b.name}.each.with_index(1) do |song, index|
        puts "#{index}. #{song.name} - #{song.genre.name}"
      end
    end
  end

  def list_genres
    genres = Genre.all.sort {|a, b| a.name <=> b.name}
    genres.each.with_index(1) do |genre, index|
      puts "#{index}. #{genre.name}"
    end
  end

  def list_artists
    songs_sort = Artist.all.sort_by do |artist|
      artist.name
    end
    artist_songs = songs_sort.uniq
    artist_songs.each.with_index(1) do |artist, index|
      puts "#{index}. #{artist.name}"
    end
  end

  def list_songs
    songs = Song.all.sort {|a, b| a.name <=> b.name}
    songs.each.with_index(1) do |song, index|
      puts "#{index}. #{song.artist.name} - #{song.name} - #{song.genre.name}"
    end
  end
  
end
