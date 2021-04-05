require 'json'
require 'securerandom'
require 'bcrypt'
require_relative '../../model/User.rb'

def signup(event:, context:)
    body = JSON.parse(event['body'])
    if defined? body
        email = body['email']
        password = body['password']

        puts "email = #{email}"
        puts "password = #{password}"

        user = User.new()
        user.id = SecureRandom.uuid
        user.email = email
        user.password = BCrypt::Password.create(password)
        user.createdAt = Time.now.strftime("%Y-%m-%d %H:%M:%S")
        user.updatedAt = Time.now.strftime("%Y-%m-%d %H:%M:%S")
        user.save

        {
            statusCode: 200,
            body: {
                message: 'signup',
            }.to_json
        }
    else
        {
            statusCode: 400,
            body: {
                message: 'signup error, no request body',
            }.to_json
        }
    end
end