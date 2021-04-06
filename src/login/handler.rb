require 'dotenv'
Dotenv.load

require 'json'
require 'jwt'
require 'bcrypt'
require 'securerandom'
require_relative '../../model/User.rb'

def login(event:, context:)
    body = JSON.parse(event['body'])
    if defined? body
        email = body['email']
        password = body['password']

        puts "email = #{email}"
        puts "password = #{password}"

        user = User.where(email: email).first
        if user
            puts "user.password = #{user.password}"
            puts "BCrypt::Password.new(user.password) = #{BCrypt::Password.new(user.password)}"

            # if password == BCrypt::Password.new(user.password)
            payload = { id: SecureRandom.uuid, email: email }
            jwt_secret = ENV['JWT_SECRET']
            token = JWT.encode payload, jwt_secret, 'HS256'

            {
                statusCode: 200,
                body: {
                    message: 'login',
                    token: token
                }.to_json
            }
            # else
            #     {
            #         statusCode: 400,
            #         body: {
            #             message: 'login error, wrong password',
            #         }.to_json
            #     }
            # end
        else
            {
                statusCode: 400,
                body: {
                    message: 'login error, no this user',
                }.to_json
            }
        end
    else
        {
            statusCode: 400,
            body: {
                message: 'login error, no request body',
            }.to_json
        }
    end
end