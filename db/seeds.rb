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

api_endpoint = 'http://environment.data.gov.uk/doc/bathing-water.json?_pageSize=700&_view=all&_pageSize=700'

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
