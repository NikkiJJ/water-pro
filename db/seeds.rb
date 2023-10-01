#!/usr/bin/env ruby
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
 admin = User.create(
   email: "admin@admin.com",
   password: "123456",
   first_name: "Admin",
   last_name: "User",
   nickname: "Admin",
   admin: true
 )

api_endpoint = 'http://environment.data.gov.uk/doc/bathing-water.json?_pageSize=1200&_view=all&_pageSize=1200'

response = HTTParty.get(api_endpoint)
data = JSON.parse(response.body)
data['result']['items'].each do |item|
  site_name = item['label'].first['_value']
  county_name = item['district'].first['label'].first['_value']
  eubwid = item['eubwidNotation']

  base_url = 'https://environment.data.gov.uk/id/bathing-water/'
  api_url = "#{base_url}#{eubwid}.json".freeze

  response = HTTParty.get(api_url)
  data2 = response.parsed_response
  quality = data2['result']['primaryTopic']
  if quality.present?
    compliance_assessment = quality['latestComplianceAssessment']
    if compliance_assessment.present?
      classification = compliance_assessment['complianceClassification']
      if classification.present?
        water_quality = classification['name']['_value']
      else
        water_quality = "Unknown"
      end
    end
  end

  web_res_image_url = "https://environment.data.gov.uk/media/image/bathing-water-profile/#{eubwid}_1-webres.jpg"
# about api
base_url = 'https://environment.data.gov.uk/doc/bathing-water-profile/'
api_url2 = "#{base_url}#{eubwid}.json".freeze

response2 = HTTParty.get(api_url2)
data2 = JSON.parse(response2.body)

if data2['result']['items'][0]['bathingWaterDescription'].present? && data2['result']['items'][0]['bathingWaterDescription']['_value'].present?
site_info = data2['result']['items'][0]['bathingWaterDescription']['_value']
else
site_info = "No bathing water description available."
end

  BathingSite.create!(
    site_name: site_name,
    region: county_name,
    eubwid: eubwid,
    water_quality: water_quality,
    site_info: site_info,
    web_res_image_url: web_res_image_url
  )
  p "Created #{site_name}, #{county_name} bathing site!"
end

base_url = 'https://admiraltyapi.azure-api.net/uktidalapi/api/V1/Stations'
tapi_key = ENV['TIDE_API']
response = HTTParty.get(base_url, headers: { 'Ocp-Apim-Subscription-Key' => tapi_key })

if response.code == 200
  stations_data = JSON.parse(response.body)
  if stations_data['features'].any?
    stations_data['features'].each do |station|
      station_name = station['properties']['Name']
      station_id = station['properties']['Id']
      station_info_url = "#{base_url}/#{station_id}"
      response = HTTParty.get(station_info_url, headers: { 'Ocp-Apim-Subscription-Key' => tapi_key })

      if response.code == 200
        station_details = JSON.parse(response.body)
        country = station_details['properties']['Country']
        continuous_heights_available = station_details['properties']['ContinuousHeightsAvailable']
        footnote = station_details['properties']['Footnote']
        TidalInformation.create!(
          station_id: station_id,
          station_name: station_name,
          country: country,
          continuous_heights_available: continuous_heights_available,
          footnote: footnote
        )

        puts "Seeded TidalInformation for station: #{station_name}"
      else
        puts "Failed to fetch details for station: #{station_name}"
      end
    end
  end
end

BathingSite.all.each do |bathing_site|
  latitude = bathing_site.latitude
  longitude = bathing_site.longitude
  closest_tidal_info = TidalInformation.near([latitude, longitude], 20).first

  if closest_tidal_info
    bathing_site.update(station_id: closest_tidal_info.station_id)

    puts "Updated station ID for BathingSite at (#{latitude}, #{longitude}) to #{closest_tidal_info.station_id}"
  else
    puts "No matching TidalInformation found for BathingSite: #{bathing_site.site_name}"
  end
end
