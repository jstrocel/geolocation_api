# README

How to run this application

Step 1
Create an env file with the following variables:
SECRET_KEY_BASE =<rails secret key goes here>
GEOLOCATION_API_KEY =<ipstack api key goes here>

Step 2
With Docker and docker-compose installed, use the following command

docker-compose up --build

Step 3
Login with the following curl command

curl --location --request POST '0.0.0.0:3000/auth/sign_in?email=john%40gmail.com&password=topsecret' \
--header 'Content-Type: application/json' \
--header 'Accept: application/json'

Step 4

Copy the access token, client, and expiry headers from the retun on the user session reqest

Step 5

Use the following commands to interact with the system:

Index

curl --location '0.0.0.0:3000' \
--header 'client: <client token goes here>' \
--header 'access-token: <access token goes here>' \
--header 'expiry: <expiry interval goes here>' \
--header 'token-type: Bearer' \
--header 'uid: john@gmail.com' \
--header 'Cookie: <session cookie goes here>'

Create

curl --location '0.0.0.0:3000/api/v1/geolocations' \
--header 'client: <client token goes here>' \
--header 'access-token: <access token goes here>' \
--header 'expiry: <expiry interval goes here>' \
--header 'token-type: Bearer' \
--header 'uid: john@gmail.com' \
--header 'Cookie: <session cookie goes here>'
--header 'Content-Type: application/json' \
--data '{
"ip_address": "172.217.12.110",
"url": "https://google.com"
}'
