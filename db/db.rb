require 'dotenv'
Dotenv.load

require 'dynamoid'

Dynamoid.configure do |config|
  config.access_key = ENV['MY_AWS_ACCESS_KEY']
  config.secret_key = ENV['MY_AWS_SECRET_ACCESS_KEY']
  config.region = 'ap-southeast-1'
end
