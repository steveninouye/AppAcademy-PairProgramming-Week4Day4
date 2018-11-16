# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Album.destroy_all
Band.destroy_all
User.destroy_all

10.times do |user|
  User.create!(email: Faker::Internet.email, session_token: SecureRandom::urlsafe_base64(16), password_digest: BCrypt::Password.create('password'))
end

10.times do |band|
  band = Band.create!(name: Faker::Music.band)

  rand(5).times do |album|
    albumn = Album.create!(band_id: band.id, title: Faker::Music.album, year: rand(1900..2018), live: [false,false,true,false].sample)

    rand(5..15).times do |track|
      Track.create!(album_id: albumn.id, title: Faker::Movie.quote, ord: (track+1), lyrics: Faker::Lorem.paragraphs(3).join("\n"), bonus_track: [false,false,true,false].sample)
    end
  end
end
