#require_relative '../lib'

class MusicLibraryController
  attr_accessor :path, :mp3_importer
  
  @imported_songs = []
  @listed_songs = []
  def initialize(path ="./db/mp3s")
  #def initialize(path)
    @path = path
    
    @mp3_importer = MusicImporter.new(path) 
    @imported_songs = @mp3_importer.import #store an array of songs
  end
  
  
  def call
    puts "Welcome to your music library!"
    puts "To list all of your songs, enter 'list songs'."
    puts "To list all of the artists in your library, enter 'list artists'."
    puts "To list all of the genres in your library, enter 'list genres'."
    puts  "To list all of the songs by a particular artist, enter 'list artist'."
    puts "To list all of the songs of a particular genre, enter 'list genre'."
    puts "To play a song, enter 'play song'."
    puts "To quit, type 'exit'."
    puts "What would you like to do?"
    user_input = gets.strip.downcase
    
    while user_input != 'exit' do
      
      case user_input 
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
        else
          puts "Invalid choice"
       end #case
    puts "What would you like to do?"
    user_input = gets.strip.downcase
    end #while
    
  end#call

  def list_songs
    sorted_songs = Song.all.sort_by {|song| song.name}
    sorted_songs.each_with_index do |this_song, index|
      puts "#{index+1}. #{this_song.artist.name} - #{this_song.name} - #{this_song.genre.name}"
    end #do
    @listed_songs = sorted_songs
  end #list_songs
  
  def list_artists
    sorted_artists = Artist.all.map {|artist| artist.name}.uniq.sort
    sorted_artists.each_with_index do |this_artist, index|
      puts "#{index+1}. #{this_artist}"
    end #do
  end #list_artists
  
  def list_genres
    sorted_genres = Genre.all.map {|genre| genre.name}.uniq.sort
    sorted_genres.each_with_index do |this_genre, index|
      puts "#{index+1}. #{this_genre}"
    end #do
  end #list_genre
  
  def list_songs_by_artist
    puts "Please enter the name of an artist:"
    user_input = gets.strip
    if chosen_artist = Artist.find_by_name(user_input)
      sorted_songlist = chosen_artist.songs.sort_by{ |song| song.name}
      #binding.pry
      sorted_songlist.each_with_index do |this_song, index|
        puts "#{index+1}. #{this_song.name} - #{this_song.genre.name}"
      end #do
    end#if
   end #list_songs_by_artist
   
  def list_songs_by_genre
    puts "Please enter the name of a genre:"
    user_input = gets.strip
    if chosen_genre = Genre.find_by_name(user_input)
      sorted_songlist = chosen_genre.songs.sort_by{ |song| song.name}
      #binding.pry
      sorted_songlist.each_with_index do |this_song, index|
        puts "#{index+1}. #{this_song.artist.name} - #{this_song.name}"
      end #do
    end#if
   end #list_songs_by_artist
   
   def play_song
    song_list = []
    sorted_songs = Song.all.sort_by {|song| song.name}
    sorted_songs.each_with_index do |song, index|
      song_list[index] = [song.name, song.artist.name]
    end #do
    puts "Which song number would you like to play?"
    user_input = gets.strip.to_i
    if user_input.between?(1,sorted_songs.size)
     puts "Playing #{song_list[user_input-1][0]} by #{song_list[user_input-1][1]}"
    end
  end#play_song
  
end #MusicLibraryController