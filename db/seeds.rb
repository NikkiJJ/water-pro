# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
BathingSite.destroy_all

10.times do
  bathing_site = BathingSite.new(
    pollution_level: [1, 2, 3].sample,
    site_name: ['sea palling', 'brighton', 'blackpool', 'walton', 'southend', 'brightlingsea', 'jaywick', 'clacton', 'margate', 'bromley'].sample,
    tide: [1, 2, 3].sample,
    region: ['norfolk', 'london', 'essex', 'blackpool', 'kent', 'cornwall', 'devon'].sample
  )

  bathing_site.save!

    puts "#{bathing_site.site_name} is made"
end
