require 'album_repository'

RSpec.describe AlbumRepository do

    def reset_albums_table
        seed_sql = File.read('spec/seeds_albums.sql')
        connection = PG.connect({ host: '127.0.0.1', dbname: 'music_library_test' })
        connection.exec(seed_sql)
    end

    before(:each) do
        reset_albums_table
    end


    it "tests the results from the database" do
        repo = AlbumRepository.new
  
        albums = repo.all
        expect(albums.length).to eq 2
        expect(albums.first.title).to eq 'Doolittle'
        expect(albums.first.release_year).to eq '1989'
        expect(albums.first.artist_id).to eq '1'
    end

    it 'gets a single album - Doolittle' do
        repo = AlbumRepository.new
        album = repo.find(1)
        expect(album.artist_id).to eq "1"
        expect(album.title).to eq 'Doolittle'
        expect(album.release_year).to eq '1989'
    end

    it 'gets a single album - Waterloo' do
        repo = AlbumRepository.new
        album = repo.find(2)
        expect(album.artist_id).to eq '2'
        expect(album.title).to eq 'Waterloo'
        expect(album.release_year).to eq '1974'
    end
end
