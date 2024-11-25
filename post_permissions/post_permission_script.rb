require 'json'
require 'net/http'
require 'uri'

# Variables to be edited as needed
local_host_name = 'http://localhost:8080' # Replace with your actual domain
dev_host_name = 'https://user-auth.dev.tabist.co.jp' # Replace with your actual domain
stg_host_name = 'https://user-auth.stg.tabist.co.jp' # Replace with your actual domain
prod_host_name = 'https://user-auth.tabist.co.jp' # Replace with your actual domain
host_name = stg_host_name

# Replace with your actual bearer token
bearer_token = 'eyJraWQiOiJjb2tDZjVEbUYzWTdYUUJIWVB2NFd4QTEybUlrY1FIUTR6djRcLzdGYlViRT0iLCJhbGciOiJSUzI1NiJ9.eyJzdWIiOiIwN2QzOGNiYi05ZTA4LTQ4M2EtOWI1Yi1jM2Q3MWQyNWJmMjYiLCJjb2duaXRvOmdyb3VwcyI6WyJBRE1JTiJdLCJpc3MiOiJodHRwczpcL1wvY29nbml0by1pZHAuYXAtbm9ydGhlYXN0LTEuYW1hem9uYXdzLmNvbVwvYXAtbm9ydGhlYXN0LTFfVWtScUtiWVQ2IiwiY2xpZW50X2lkIjoiMzRhcGRkbm9uNTk5c21idjR0ZDdjbmxnZTYiLCJvcmlnaW5fanRpIjoiMTJlM2Y4ZGUtYzExZC00ZDVjLTg0MTYtNDViODRhN2VhMGU5IiwiZXZlbnRfaWQiOiJiMjAzZjZjZC0yZWNjLTQyMTUtYTFmYS1lMmQwNjIzNDJhNTEiLCJ0b2tlbl91c2UiOiJhY2Nlc3MiLCJzY29wZSI6ImF3cy5jb2duaXRvLnNpZ25pbi51c2VyLmFkbWluIiwiYXV0aF90aW1lIjoxNzMwODc3Mzk0LCJleHAiOjE3MzA4ODQ1OTgsImN1c3RvbTpoYXNfYWxsX2hvdGVsX2FjY2VzcyI6InRydWUiLCJpYXQiOjE3MzA4ODA5OTgsImp0aSI6ImRmZTM0Yjc4LTgxZTktNGZkZS04NTA0LTA2ODNhMTk3MzQxYSIsInVzZXJuYW1lIjoiMDdkMzhjYmItOWUwOC00ODNhLTliNWItYzNkNzFkMjViZjI2In0.xQyBJu6cmJstUvWliBpudUSsiWaW69ouf8BxQDm9JC3pKrGVRS5czDsiMV4bhfp72P5oyzCZoeQQxgm59UJwkAbADKiLAeaGvl7sNEsfLDwHCXMgHNqpVYeX5g40P4hE5xE2n7jEXuKVsr08KThlcy_4tjiZ0Rno0x3mWyHUzSv1bpZBG2ZjwOiOebMvLxlKf1P00LYTFs6-RNjKgwQmF2H2MCMTEAAK-hVJZqsrGVHaGmYqlMHXd4kwGVVCxnDZr3rcVfTU7TKzRj7HA61QN82QhuYjI5lyRzW7xtzIFW_MPkWQvm3Rf7l2r4biOnvuhnpoYhsy5NDMhFbjnqZV9Q'

# Change the file name as needed
# file_name = 'input_UMS.json' 
file_name = 'input_RM.json' 
# file_name = 'input_DC.json'

# Read the JSON objects from input.json file
file = File.read(file_name)
permissions = JSON.parse(file)

permissions.each do |permission|
  uri = URI("#{host_name}/api/v0.1/permissions")
  http = Net::HTTP.new(uri.host, uri.port)
  http.use_ssl = true if uri.scheme == 'https'

  request = Net::HTTP::Post.new(uri)
  request['Content-Type'] = 'application/json'
  request['Authorization'] = "Bearer #{bearer_token}"
  request.body = permission.to_json

  puts "Request #{request.method} #{request.path}: #{request.body}"
  response = http.request(request)
  puts "Response #{response.code} #{response.message}: #{response.body}"
end
