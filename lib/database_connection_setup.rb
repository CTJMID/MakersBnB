require_relative './conn'

if ENV['RACK_ENV'] == 'test'
  Conn.setup('makersbnb_test')
else 
  Conn.setup('makersbnb')
end