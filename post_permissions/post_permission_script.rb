require 'json'
require 'net/http'
require 'uri'

# Variables to be edited as needed
local_host_name = 'http://localhost:8080' # Replace with your actual domain
dev_host_name = 'https://user-auth.dev.tabist.co.jp' # Replace with your actual domain
stg_host_name = 'https://user-auth.stg.tabist.co.jp' # Replace with your actual domain
prod_host_name = 'https://your_domain.com' # Replace with your actual domain
host_name = local_host_name

# Replace with your actual bearer token
bearer_token = 'eyJraWQiOiJkMlNVa0xTVnhUSENpOU1hdHF4UFRpWDdvNlBRQnhRMUpFQm1KZHc4ODlFPSIsImFsZyI6IlJTMjU2In0.eyJzdWIiOiIxOWQ3MzhjYS05MWQzLTRiODYtOWE0Yy03Yjg4NTI5MGIwM2EiLCJjb2duaXRvOmdyb3VwcyI6WyJBRE1JTiJdLCJlbWFpbF92ZXJpZmllZCI6dHJ1ZSwiY29nbml0bzpwcmVmZXJyZWRfcm9sZSI6ImFybjphd3M6aWFtOjo2NzY4MTU3Mjg2MTk6cm9sZVwvVXNlcl9NYW5hZ2VtZW50X1JvbGUiLCJpc3MiOiJodHRwczpcL1wvY29nbml0by1pZHAuYXAtbm9ydGhlYXN0LTEuYW1hem9uYXdzLmNvbVwvYXAtbm9ydGhlYXN0LTFfZ2Z1WUJjZkNQIiwiY29nbml0bzp1c2VybmFtZSI6IjE5ZDczOGNhLTkxZDMtNGI4Ni05YTRjLTdiODg1MjkwYjAzYSIsImN1c3RvbTpqb2JfdGl0bGUiOiJBZG1pbiIsIm9yaWdpbl9qdGkiOiIzYjZkNDAwMi1kNTExLTQwOWEtOWZlNC1kNzNiZTVjMzVjNzEiLCJjb2duaXRvOnJvbGVzIjpbImFybjphd3M6aWFtOjo2NzY4MTU3Mjg2MTk6cm9sZVwvVXNlcl9NYW5hZ2VtZW50X1JvbGUiXSwiYXVkIjoiNTAwaDI4dWtubjQ2OXFnb25nZ2ZhZzBsOGsiLCJldmVudF9pZCI6ImY4ZGE2YjdkLWJkYTUtNGQxYi1hZjQzLWM5ZTUyMTBiM2YxYSIsInRva2VuX3VzZSI6ImlkIiwiYXV0aF90aW1lIjoxNzI0MjE5ODQxLCJleHAiOjE3MjUyNDk0ODMsImN1c3RvbTpoYXNfYWxsX2hvdGVsX2FjY2VzcyI6InRydWUiLCJpYXQiOjE3MjUyNDU4ODMsImp0aSI6ImJkYWMxMGZmLTVmODQtNDk5Yy1iY2YwLWM0NDFjZTRkNDQwOSIsImVtYWlsIjoiY2hldGFuLmdob2Rhc2FyYUB0YWJpc3QuY29tIn0.OE5YKRKpIOqXC9gdjRXnUHdcQYVDkY7eaiIyZr_fgweTrm2t-IxZHJt3LlB3QRAOOvHB-MJXEMy8d5pXa9IAsgaDgOc5si6yNHe5MNqn0Sy0Rr3wfdZX5jurDCLiEMtbyWmNq4lbavaZkGv36HYR6sDtp9I3SfbmqeX7aUsznb6w1h7uEIkxgb6jP3XOh5nkxPo1aPZhRLO2DzSSEQe7unU-LAUJ3PI35McLK1BCo1nUIxR9ybB0BjZMi-ni8tyX7-tB8vRD7mgQbi-FTUkUOriagzsY9NeXhL4mhhj9kELDZhifku40ffBBkviRerSMjZGkulvuB0LadJ2mM5cu4Q' 

# Change the file name as needed
file_name = 'input_UMS.json' 
# file_name = 'input_RM.json' 
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
