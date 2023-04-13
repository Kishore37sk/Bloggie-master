# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

=begin 10.times do|c|
  puts "creating post #{c+1}"
  Post.create!(topic_id: '5', user_id: '1', name: Faker::Lorem.unique.sentence[0...20], body: Faker::Lorem.sentence )
end
=end