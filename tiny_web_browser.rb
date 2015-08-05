require 'socket'
require 'json'

host = 'localhost'
port = 2000

puts "Please select GET or POST"
input = gets.chomp.upcase

if input == "GET"
	#This is the HTTP request we send to fetch a file
  request = "GET /index.html HTTP/1.0\r\n\r\n"

  elsif input == "POST"
  	puts "Enter your name:"
  	name = gets.chomp
  	puts "Enter your email:"
  	email = gets.chomp

	hash_to_send = {:viking => {:name => name, :email => email} }
	hash_to_json = hash_to_send.to_json  	

	request = "POST /thanks.html HTTP/1.0\r\nContent-Length: #{hash_to_json.size}\r\n\r\n#{hash_to_json}"
end 

#Connect to server
socket = TCPSocket.open(host, port)
#Send request
socket.print(request)
#Read complete response
response = socket.read
#Split response at first blank line into headers and body
headers,body = response.split("\r\n\r\n", 2)
#And display in
print body
socket.close