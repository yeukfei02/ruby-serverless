require 'json'
require 'logger'
require_relative '../../model/Notes'

def getNoteById(event:, context:)
    logger = Logger.new($stdout)

    if event['pathParameters']
        id = event['pathParameters']['id']
        if id
            begin
                note = Notes.find(id)

                {
                    statusCode: 200,
                    body: {
                        message: 'getNoteById',
                        note: note
                    }.to_json
                }
            rescue => exception
                logger.info("error = #{exception}")

                {
                    statusCode: 400,
                    body: {
                        message: 'getNoteById error, no this id',
                    }.to_json
                }
            end
        else
            {
                statusCode: 400,
                body: {
                    message: 'getNoteById error, please provide id',
                }.to_json
            }
        end
    end
end