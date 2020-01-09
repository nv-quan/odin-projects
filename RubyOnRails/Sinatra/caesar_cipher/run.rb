require 'sinatra'
require 'sinatra/reloader' unless development?
require './caesar_cipher.rb'

get '/' do 
  shift_number = params['shift_number'] 
  input_string = params['input_string'] 
  unless shift_number.nil? || input_string.nil?
    output_string = caesar_cipher(input_string, shift_number.to_i)
    message = "Here is the output: #{output_string}"
  end
  erb :index, locals: {message: message}
end
