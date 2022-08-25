require 'artist_repository'

RSpec.describe ArtistRepository do
	def reset_artists_table
		seed_sql = File.read('spec/seeds_artists.sql')
    connection = PG.connect({ host: '127.0.0.1', dbname: 'music_library_test' })
    connection.exec(seed_sql)
  end

  before(:each) do
		reset_artists_table
	end
	
	it 'returns a lits of artists' do
    repo = ArtistRepository.new

    artists = repo.all
    expect(artists.length).to eq 2
    expect(artists.first.id).to eq '1'
    expect(artists.first.name).to eq "Pixies"
  end

  it 'returns a Pixies as a single artist' do
		repo = ArtistRepository.new

    artist = repo.find(1)
    expect(artist.id).to eq '1'
    expect(artist.name).to eq "Pixies"
    expect(artist.genre).to eq "Rock"
	end

  it 'returns Abba as a single artist' do
    repo = ArtistRepository.new

    artist = repo.find(2)
    expect(artist.id).to eq '2'
    expect(artist.name).to eq "ABBA"
    expect(artist.genre).to eq "Pop"
	end
  
	it 'creates a new artist' do
		repo = ArtistRepository.new
		artist = Artist.new
		artist.name = 'Beatles'
		artist.genre = 'Pop'

		repo.create(artist) # => nil
		artists = repo.all
		expect(artists.last.name).to eq 'Beatles'
		expect(artists.last.genre).to eq 'Pop' 
	end

	it 'deletes an artist given an id' do
		repo = ArtistRepository.new

		id_to_delete = 1

		repo.delete(id_to_delete)

		artists = repo.all
		expect(artists.length).to eq 1
		expect(artists.first.id).to eq '2'
	end

	it 'deletes the two artists' do
		repo = ArtistRepository.new

		repo.delete(1)
		repo.delete(2)

		artists = repo.all
		expect(artists.length).to eq(0)
	end

	it 'updates an artist' do
		repo = ArtistRepository.new

    artist = repo.find(1)

		artist.name = 'Something else'
		artist.genre = 'Disco'
		repo.update(artist)
		updated_artist = repo.find(1)
		expect(updated_artist.name).to eq 'Something else'
		expect(updated_artist.genre).to eq 'Disco'
	end

	it 'updates an artists name only' do
		repo = ArtistRepository.new

    artist = repo.find(1)

		artist.name = 'Something else'
		
		repo.update(artist)
		updated_artist = repo.find(1)
		expect(updated_artist.name).to eq 'Something else'
		expect(updated_artist.genre).to eq 'Rock'
	end
end 