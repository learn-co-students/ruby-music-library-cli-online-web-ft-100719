class MusicLibraryController

    VALID_INPUT = ['list songs', 'list artists', 'list genres', 'list artist', 'list genre', 'play song', 'exit', 'help']

    def initialize(path = './db/mp3s')
        MusicImporter.new(path).import
    end

    def call
        self.welcome
        self.help
        self.ask_for_input
    end

    def welcome
        puts "Welcome to your music library!"
    end

    def help
        puts "To list all of your songs, enter 'list songs'."
        puts "To list all of the artists in your library, enter 'list artists'."
        puts "To list all of the genres in your library, enter 'list genres'."
        puts "To list all of the songs by a particular artist, enter 'list artist'."
        puts "To list all of the songs of a particular genre, enter 'list genre'."
        puts "To play a song, enter 'play song'."
        puts "To quit, type 'exit'."
    end

    def ask_for_input
        puts "What would you like to do?"
        self.send_input
    end

    def send_input
        input = gets.chomp
        self.input_valid?(input) ? self.evaluate_input(input) : self.invalid_input
    end

    def input_valid?(input)
        VALID_INPUT.include?(input)
    end

    def invalid_input
        puts "Sorry, your input was invalid. Please try again."
        self.ask_for_input
    end

    def evaluate_input(input)
        case input
        when 'list songs'
            self.list_songs
            self.ask_for_input
        when 'list artists'
            self.list_artists
            self.ask_for_input
        when 'list genres'
            self.list_genres
            self.ask_for_input
        when 'list artist'
            self.list_songs_by_artist
            self.ask_for_input
        when 'list genre'
            self.list_songs_by_genre
            self.ask_for_input
        when 'play song'
            self.play_song
            self.ask_for_input
        when 'exit'
            self.exit
        when 'help'
            self.help
            self.ask_for_input
        end
    end

    def list_songs
        songs = Song.all.sort{|a, b| a.name <=> b.name}
        songs.each.with_index(1){|song, index| puts "#{index}. #{song.artist.name} - #{song.name} - #{song.genre.name}"}
    end

    def list_artists
        artists = Artist.all.sort{|a, b| a.name <=> b.name}
        artists.each.with_index(1){|artist, index| puts "#{index}. #{artist.name}"}
    end

    def list_genres
        genres = Genre.all.sort{|a, b| a.name <=> b.name}
        genres.each.with_index(1){|genre, index| puts "#{index}. #{genre.name}"}
    end

    def list_songs_by_artist
        puts "Please enter the name of an artist:"
        input = gets.chomp
        songs = Artist.find_or_create_by_name(input).songs.sort{|a,b | a.name <=> b.name}
        songs.each.with_index(1){|song, index| puts "#{index}. #{song.name} - #{song.genre.name}"}
    end

    def list_songs_by_genre
        puts "Please enter the name of a genre:"
        input = gets.chomp
        songs = Genre.find_or_create_by_name(input).songs.sort{|a,b | a.name <=> b.name}
        songs.each.with_index(1){|song, index| puts "#{index}. #{song.artist.name} - #{song.name}"}
    end

    def play_song
        puts "Which song number would you like to play?"
        input = gets.chomp
        songs = Song.all.sort{|a, b| a.name <=> b.name}
        song = songs[input.to_i - 1] if (1..songs.size).include?(input.to_i - 1) 
        puts "Playing #{song.name} by #{song.artist.name}" unless song == nil
    end

    def exit
    end

end
