require 'dotenv'
Dotenv.load

require 'json'
require 'jwt'
require 'logger'

def authorize(event:, context:)
    logger = Logger.new($stdout)

    token = event['authorizationToken'].gsub('Bearer ', '')
    jwt_secret = ENV['JWT_SECRET']

    logger.info("token = #{token}")

    principalId = 'user'
    effect = 'Deny'
    policy_document = {}

    begin
        decoded = JWT.decode token, jwt_secret, true, { algorithm: 'HS256' }
        logger.info("decoded = #{decoded}")
        if decoded
            principalId = decoded[0]['id']
            effect = 'Allow'
            policy_document = generate_policy_document(principalId, effect)
        end
    rescue => exception
        logger.info("error = #{exception}")
    end

    return policy_document
end

def generate_policy_document(principalId, effect)
    policy_document = {}

    logger.info("principalId = #{principalId}")
    logger.info("effect = #{effect}")

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