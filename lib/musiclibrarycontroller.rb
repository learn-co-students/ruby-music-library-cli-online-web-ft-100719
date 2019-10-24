

class MusicLibraryController
  attr_accessor :path, :mp3_importer
  
  @imported_songs = []
  
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
      #   when 'list artists'
          
      #   when 'list genres'
          
      #   when 'list artist'
          
       end
    puts "What would you like to do?"
    user_input = gets.strip.downcase
    end #while
    
  end#call

  def list_songs
    #binding.pry
    @imported_songs.sort_by {|song| song.name}.each_with_index do |this_song, index|
      puts "#{index}+1. #{song.name} - #{song.artist} - #{song.genre}"
    end #do
    
  end #list_songs
  
    
end #MusicLibraryController