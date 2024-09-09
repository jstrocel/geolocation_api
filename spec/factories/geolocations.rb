require 'faker'

FactoryBot.define do
  factory :geolocation do
    ip_address { Faker::Internet.ip_v4_address }
    url { Faker::Internet.domain_name }
    latitude { 1.5 }
    longitude { 1.5 }
  end
end
