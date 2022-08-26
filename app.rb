require_relative 'lib/database_connection'
require_relative 'lib/artist_repository'
require_relative 'lib/album_repository'

class Application
# The Application class initializer
# takes four arguments:
#  * The database name to call `DatabaseConnection.connect`
#  * the Kernel object as `io` (so we can mock the IO in our tests)
#  * the AlbumRepository object (or a double of it)
#  * the ArtistRepository object (or a double of it)
    def initialize(database_name, io, album_repository, artist_repository)
        DatabaseConnection.connect(database_name)
        @io = io
        @album_repository = album_repository
        @artist_repository = artist_repository
    end

    def run
        @io.puts "Welcome to the music library manager!\n\n"
        @io.puts "What would you like to do?\n"
        @io.puts "1 - List all albums\n2 - List all artists"
        result = @io.gets.chomp
        
    end
end