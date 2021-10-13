require 'dotenv'
Dotenv.load

require 'json'
require 'logger'
require 'jwt'
require 'bcrypt'
require 'securerandom'
require_relative '../../model/User'

def login(event:, context:)
  logger = Logger.new($stdout)

  body = JSON.parse(event['body'])
  if defined? body
    email = body['email']
    password = body['password']

    logger.info("email = #{email}")
    logger.info("password = #{password}")

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

  # user = User.where(email: email).first
  # if user
  # logger.info("user.password = #{user.password}")
  # logger.info("BCrypt::Password.new(user.password) = #{BCrypt::Password.new(user.password)}")

  #     if password == BCrypt::Password.new(user.password)
  #         payload = { id: SecureRandom.uuid, email: email }
  #         jwt_secret = ENV['JWT_SECRET']
  #         token = JWT.encode payload, jwt_secret, 'HS256'

  #         {
  #             statusCode: 200,
  #             body: {
  #                 message: 'login',
  #                 token: token
  #             }.to_json
  #         }
  #     else
  #         {
  #             statusCode: 400,
  #             body: {
  #                 message: 'login error, wrong password',
  #             }.to_json
  #         }
  #     end
  # else
  #     {
  #         statusCode: 400,
  #         body: {
  #             message: 'login error, no this user',
  #         }.to_json
  #     }
  # end
  else
    {
      statusCode: 400,
      body: {
        message: 'login error, no request body'
      }.to_json
    }
  end
end
