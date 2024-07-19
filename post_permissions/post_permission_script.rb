require 'json'
require 'net/http'
require 'uri'

# Variables to be edited as needed
local_domain_name = 'localhost:8080' # Replace with your actual domain
dev_domain_name = 'user-auth.dev.tabist.co.jp' # Replace with your actual domain
stg_domain_name = 'your_domain.com' # Replace with your actual domain
prod_domain_name = 'your_domain.com' # Replace with your actual domain
domain_name = dev_domain_name

bearer_token = 'eyJraWQiOiJpbjVBUk5vUDBadjhnXC9TSk1PUHBPdzNPVnhpdm03czR0UXZ5c0lUVGRIVT0iLCJhbGciOiJSUzI1NiJ9.eyJzdWIiOiIxOWQ3MzhjYS05MWQzLTRiODYtOWE0Yy03Yjg4NTI5MGIwM2EiLCJjb2duaXRvOmdyb3VwcyI6WyJBRE1JTiJdLCJpc3MiOiJodHRwczpcL1wvY29nbml0by1pZHAuYXAtbm9ydGhlYXN0LTEuYW1hem9uYXdzLmNvbVwvYXAtbm9ydGhlYXN0LTFfZ2Z1WUJjZkNQIiwiY2xpZW50X2lkIjoiNTAwaDI4dWtubjQ2OXFnb25nZ2ZhZzBsOGsiLCJvcmlnaW5fanRpIjoiOTg1NjE5YTAtZGVlOS00YTc2LWI0NTUtZDBmOTk5ZDdkMmJjIiwiZXZlbnRfaWQiOiIxMGMxZTM3Zi1lMDJiLTQzY2EtOGZmOS04NDk4NDRkMDE2YzMiLCJ0b2tlbl91c2UiOiJhY2Nlc3MiLCJzY29wZSI6ImF3cy5jb2duaXRvLnNpZ25pbi51c2VyLmFkbWluIiwiYXV0aF90aW1lIjoxNzE5Mjk4NjgxLCJleHAiOjE3MjEzNzU1NDMsImlhdCI6MTcyMTM3MTk0MywianRpIjoiNTE5NjE0MDEtN2U4Yy00ZDJlLWFjOTAtMTkwMjM5Njg2NWQxIiwidXNlcm5hbWUiOiIxOWQ3MzhjYS05MWQzLTRiODYtOWE0Yy03Yjg4NTI5MGIwM2EifQ.AdB-tA0dQeXjtxbnM22gx7R1pLfi0erY3Da61DyiovnNTqI9BsrsOwTC02-oV0_5OWpgUwE8yofoY7WpfliVyztQW8k-5O6Wj9kLhhwraeNT-s6A7h8c2ts7zaPdzi5SklRQOYte1M-apXHHm-LLrogmXOdgOmEEgFLydy6Cm9Mt_Pjc4wmNGHn8UfPoMsBPOkq2bX9VYT5RdAoE-CaC6lXMNF9L3EI9MVgzkLKafbt3NM8euKj5uM_S_FWqZi4n5Kg5kXM_BNulcuIqxSAEh4zMhiFjtBQG6BZ1bT6RAkR8J1DrfGWwvnQyQ-fIIuBlKfYXhy_kI7itCvkOVjk3fQ' # Replace with your actual bearer token

# Read the JSON objects from input.json file
file = File.read('input.json')
permissions = JSON.parse(file)

permissions.each do |permission|
  uri = URI("https://#{domain_name}/api/v0.1/permissions")
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
