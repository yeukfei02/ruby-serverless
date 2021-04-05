require 'dotenv'
Dotenv.load

require 'json'
require 'jwt'

def authorize(event:, context:)
    token = event['authorizationToken'].gsub('Bearer ', '')
    jwt_secret = ENV['JWT_SECRET']

    puts "token = #{token}"

    principalId = 'user'
    effect = 'Deny'
    policy_document = {}

    begin
        decoded = JWT.decode token, jwt_secret, true, { algorithm: 'HS256' }
        puts "decoded = #{decoded}"
        if decoded
            principalId = decoded['id']
            effect = 'Allow'
            policy_document = generate_policy_document(principalId, effect)
        end
    rescue => exception
        puts "error = #{exception}"
    end

    return policy_document
end

def generate_policy_document(principalId, effect)
    policy_document = {}

    puts "principalId = #{principalId}"
    puts "effect = #{effect}"

    if principalId && effect
        policy_document = {
            principalId: principalId,
            policyDocument: {
                Version: '2012-10-17',
                Statement: [
                    {
                        Action: 'execute-api:Invoke',
                        Effect: effect,
                        Resource: '*',
                    },
                ],
            },
        }
    end

    return policy_document
end