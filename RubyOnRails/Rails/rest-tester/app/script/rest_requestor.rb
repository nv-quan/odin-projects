require 'rest-client'
url = "127.0.0.1:3000/users"

puts RestClient.get(url)
puts RestClient.get(url + '/1')
