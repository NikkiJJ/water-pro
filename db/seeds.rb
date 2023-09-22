# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
#!/usr/bin/env ruby

# Load Rails application environment

require_relative '../config/environment'

require 'nokogiri'
require 'open-uri'
require 'httparty'
require 'json'
require 'csv'

BathingSite.destroy_all
User.destroy_all

user = User.create!(
  email: "user1@gmail.com",
  password: "123456",
  first_name:"John",
  last_name:"Smith",
  nickname: "jonny"
)

csv_path = Rails.root.join('app', 'data', 'site.csv')

CSV.foreach(csv_path, headers: true) do |row|
  eubwid = row['EUBWID']

   base_url = 'https://environment.data.gov.uk/id/bathing-water/'
   api_url = "#{base_url}#{eubwid}.json".freeze

  response = HTTParty.get(api_url)
  data = response.parsed_response
  quality = data['result']['primaryTopic']
  water_quality = quality['latestComplianceAssessment']['complianceClassification']['name']['_value']
  site_name = data['result']['primaryTopic']['name']['_value']


  BathingSite.create!(
    site_name: site_name,
    water_quality: water_quality,
    user: user,

  )
  p "Created #{site_name} bathing site!"
end
