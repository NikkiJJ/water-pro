# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#!/usr/bin/env ruby

# Load Rails application environment
require_relative '../config/environment'

require 'httparty'
require 'json'
require 'bathing_site'


BathingSite.destroy_all
User.destroy_all

user = User.create!(
  email: "user1@gmail.com",
  password: "123456",
  first_name: "John",
  last_name: "Smith",
  nickname: "jonny"
)

admin = User.create!(
  email: "admin@admin.com",
  password: "123456",
  first_name: "Admin",
  last_name: "User",
  nickname: "Admin",
  admin: true
)

api_endpoint = 'http://environment.data.gov.uk/doc/bathing-water.json?_pageSize=200&_view=all&_pageSize=200'

response = HTTParty.get(api_endpoint)

data = JSON.parse(response.body)

data['result']['items'].each do |item|
  site_name = item['label'].first['_value']
  county_name = item['district'].first['label'].first['_value']
  eubwid = item['eubwidNotation']

  BathingSite.create!(
    site_name: site_name,
    region: county_name,
    eubwid: eubwid,
    water_quality: "good",
    user: user
  )
end
