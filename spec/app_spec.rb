require './app'
require 'album_repository'
require 'artist_repository'

RSpec.describe AlbumRepository do

    def reset_albums_table
        seed_sql = File.read('spec/seeds_albums.sql')
        connection = PG.connect({ host: '127.0.0.1', dbname: 'music_library_test' })
        connection.exec(seed_sql)
    end

    before(:each) do
        reset_albums_table
    end
end

RSpec.describe ArtistRepository do

    def reset_albums_table
        seed_sql = File.read('spec/seeds_artists.sql')
        connection = PG.connect({ host: '127.0.0.1', dbname: 'music_library_test' })
        connection.exec(seed_sql)
    end

    before(:each) do
        reset_artists_table
    end
end

RSpec.describe Application do
    it "tests the input when inputting 1" do
        io = double :io
        
        expect(io).to receive(:puts).with("Welcome to the music library manager!\n\n")
        expect(io).to receive(:puts).with("What would you like to do?\n")
        expect(io).to receive(:puts).with("1 - List all albums\n2 - List all artists")
        expect(io).to receive(:gets).and_return("1")
        

        application = Application.new('music_library_test',io,AlbumRepository.new, ArtistRepository.new)
        database_name = DatabaseConnection.connect('music_library_test')
        album_repository = AlbumRepository.new
        artist = ArtistRepository.new
        application.run
    end
end