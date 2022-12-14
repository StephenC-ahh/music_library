# file: app.rb

require_relative 'lib/database_connection'
require_relative 'lib/artist_repository'
require_relative 'lib/album_repository'

# We need to give the database name to the method `connect`.
DatabaseConnection.connect('music_library')

# # Perform a SQL query on the database and get the result set.
# sql = 'SELECT id, title FROM albums;'
# result = DatabaseConnection.exec_params(sql, [])

# # Print out each record from the result set .
# result.each do |record|
#   p record
# end

artist_repository = ArtistRepository.new
album_repository = AlbumRepository.new



# returns all from artists table in music_library db
artist_repository.all.each do |artist|
    p artist

end
# returns all from albums table in music library db
album_repository.all.each do |album|
  p album
end
# returns a single artist from the music library
artist = artist_repository.find(1)
puts "The first artist is: #{artist.name}"
puts "The genre of the artist: #{artist.name} is #{artist.genre}"
# returns a single album from the music library
album = album_repository.find(1)
puts album.title 

# creates a new record in artists table
# artist = Artist.new
# artist.name = 'Van Halen'
# artist.genre = 'Heavy Metal'
# artist_repository.create(artist) #INSERT into artists


# DELETES
# artist_repository.delete(11) # DELETE FROM artists WHERE id =


# # update
# artist = repo.find(1)
# artist.name = 'Whatever'

# artist_repository.update(artist) #UPDATE artists...WHERE id = 