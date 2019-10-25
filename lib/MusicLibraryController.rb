class MusicLibraryController

  def initialize(path = "./db/mp3s")
    newImporter = MusicImporter.new(path)
    Song.all << newImporter.import
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

     user_input = gets.chomp.downcase

    case user_input
      when "list songs"
        self.list_songs
      when "list artists"
        self.list_artists
      when "list genres"
        self.list_genres
      # when "list artist"
      #   self.list_songs_by_artist
      # when "list genre"
      #   self.list_songs_by_genre
      # when "play song"
      #   self.play_song
      when "exit"
        'exit'
    else
      call
    end
 end

  def list_songs
    songs = Song.all.sort_by do |song|
     song.name
    end
    binding.pry
    songs.each.with_index(1) do |s, i|
     puts "#{i}. #{s.artist.name} - #{s.name} - #{s.genre.name}}"
    end
 end

 def list_artists
   artist = Artist.all.sort_by { |artist| artist.name}
   artist.each.with_index(1) do |artist, index|
     puts "#{index}. #{artist.name}"
   end
 end

 def list_genres
   genre = Genre.all.sort_by {|genre| genre.name}
   genre.each.with_index(1) do |genre, index|
     puts "#{index}. #{genre.name}"
   end
 end






end
