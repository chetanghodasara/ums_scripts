require 'json'
require 'net/http'
require 'uri'

# Variables to be edited as needed
local_domain_name = 'localhost:8080' # Replace with your actual domain
dev_domain_name = 'your_domain.com' # Replace with your actual domain
stg_domain_name = 'your_domain.com' # Replace with your actual domain
prod_domain_name = 'your_domain.com' # Replace with your actual domain
domain_name = local_domain_name

bearer_token = 'eyJraWQiOiJpbjVBUk5vUDBadjhnXC9TSk1PUHBPdzNPVnhpdm03czR0UXZ5c0lUVGRIVT0iLCJhbGciOiJSUzI1NiJ9.eyJzdWIiOiIxOWQ3MzhjYS05MWQzLTRiODYtOWE0Yy03Yjg4NTI5MGIwM2EiLCJjb2duaXRvOmdyb3VwcyI6WyJBRE1JTiJdLCJpc3MiOiJodHRwczpcL1wvY29nbml0by1pZHAuYXAtbm9ydGhlYXN0LTEuYW1hem9uYXdzLmNvbVwvYXAtbm9ydGhlYXN0LTFfZ2Z1WUJjZkNQIiwiY2xpZW50X2lkIjoiNTAwaDI4dWtubjQ2OXFnb25nZ2ZhZzBsOGsiLCJvcmlnaW5fanRpIjoiNzRkNmU4ZTctNTAwMi00YmNjLTlhZWEtNDNmNzk1NzgxM2I5IiwiZXZlbnRfaWQiOiJiMjIyOTkyZC1lM2Y1LTQ1N2ItOTRkNC04NTUyZjVhM2EyNTIiLCJ0b2tlbl91c2UiOiJhY2Nlc3MiLCJzY29wZSI6ImF3cy5jb2duaXRvLnNpZ25pbi51c2VyLmFkbWluIiwiYXV0aF90aW1lIjoxNzE2NDU5MzY0LCJleHAiOjE3MTY4NzEyNDQsImlhdCI6MTcxNjg2NzY0NCwianRpIjoiMDAwZDc3ZDktOTVlNC00MTA0LWE5NjUtMDdkYzExM2QzODA0IiwidXNlcm5hbWUiOiIxOWQ3MzhjYS05MWQzLTRiODYtOWE0Yy03Yjg4NTI5MGIwM2EifQ.m75pTPvkmTgQ_w9qfAQcivS30QxUVwtl3uZuuByuvAneGkUkAyXr5BqYrPZ68qyFLyzGU_-GmSkl9Y3qxJnHtz6Bi3o5E8wnV6qBeGBuOc9zr6BCjM96TgJRZcN7Ldk6s9j6AttDINVuAY6R4I4ZUJkYH9YdRRuw3Mxs5XAjcWCviBxvvUF2sQ2rM_ePg7Q9cAPfshLV2X1Q1F_pEUiNNc-SeNVYErSt-tJtzt6x5GCnEe1gPGxhdgWRk1Vv0p1z3nFv2EgwA1j6bbjg0PhnoCI-yBDSKfNRdXcZBk1R-6yySYM_FRj1scGB2aUpRm-47VDfkqIYHVpmGMqxAfjYuA' # Replace with your actual bearer token

# Read the JSON objects from input.json file
file = File.read('input.json')
permissions = JSON.parse(file)

permissions.each do |permission|
  uri = URI("http://#{domain_name}/api/v0.1/permissions")
  http = Net::HTTP.new(uri.host, uri.port)
  http.use_ssl = true if uri.scheme == 'https'

  request = Net::HTTP::Post.new(uri)
  request['Content-Type'] = 'application/json'
  request['Authorization'] = "Bearer #{bearer_token}"
  request.body = permission.to_json

  puts "Request #{request.method} #{request.path}: #{request.body.to_json}"
  response = http.request(request)
  puts "Response #{response.code} #{response.message}: #{response.body}"
end
