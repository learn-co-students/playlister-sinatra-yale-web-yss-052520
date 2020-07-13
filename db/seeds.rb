# Add seed data here. Seed your database with `rake db:seed`

Artist.destroy_all
Genre.destroy_all
Song.destroy_all
SongGenre.destroy_all

a_1 = Artist.create(name: "Joe")
a_2 = Artist.create(name: "Brad")
a_3 = Artist.create(name: "Alex")

g_1 = Genre.create(name: "Rock")
g_2 = Genre.create(name: "Pop")
g_3 = Genre.create(name: "Rock")

s_1 = Song.create(name: "Bloop blop", artist_id: a_1.id)
s_2 = Song.create(name: "Abba baba", artist_id: a_2.id)
s_3 = Song.create(name: "Hey Joana", artist_id: a_3.id)

sg_1 = SongGenre.create(song_id: s_1.id, genre_id: g_1.id)
sg_2 = SongGenre.create(song_id: s_2.id, genre_id: g_2.id)
sg_3 = SongGenre.create(song_id: s_3.id, genre_id: g_3.id)
sg_1 = SongGenre.create(song_id: s_1.id, genre_id: g_2.id)