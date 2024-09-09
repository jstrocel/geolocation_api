# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
#
User.create([{
              name: 'John Doe',
              email: 'john@gmail.com',
              password: 'topsecret',
              password_confirmation: 'topsecret'
            }])
User.last.create_token
Geolocation.create([{
                     ip_address: '142.251.214.142',
                     url: 'google.com',
                     latitude: 37.7749,
                     longitude: -122.4194
                   },

                    {
                      ip_address: '23.227.38.33',
                      url: 'shopify.com',
                      latitude: 45.4189,
                      longitude: -75.6965
                    },
                    {
                      ip_address: '157.240.22.35',
                      url: 'facebook.com',
                      latitude: 37.3394,
                      longitude: -121.8950
                    }])
