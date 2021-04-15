require 'json'
require 'logger'
require_relative '../../model/Notes.rb'

def createNotes(event:, context:)
    logger = Logger.new($stdout)
    
    body = JSON.parse(event['body'])
    if defined? body
        content = body['content']

        logger.info("content = #{content}")

        notes = Notes.new()
        notes.id = SecureRandom.uuid
        notes.content = content
        notes.createdAt = Time.now.strftime("%Y-%m-%d %H:%M:%S")
        notes.updatedAt = Time.now.strftime("%Y-%m-%d %H:%M:%S")
        notes.save

        {
            statusCode: 200,
            body: {
                message: 'createNotes',
            }.to_json
        }
    else
        {
            statusCode: 400,
            body: {
                message: 'createNotes error, no request body',
            }.to_json
        }
    end
end