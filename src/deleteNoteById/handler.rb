require 'json'
require 'logger'
require_relative '../../model/Notes.rb'

def deleteNoteById(event:, context:)
    logger = Logger.new($stdout)
    
    if event['pathParameters']
        id = event['pathParameters']['id']
        if id
            begin
                Notes.where(id: id).delete_all

                {
                    statusCode: 200,
                    body: {
                        message: 'deleteNoteById',
                    }.to_json
                }
            rescue => exception
                logger.info("error = #{exception}")

                {
                    statusCode: 400,
                    body: {
                        message: 'deleteNoteById error, no this id',
                    }.to_json
                }
            end
        else
            {
                statusCode: 400,
                body: {
                    message: 'deleteNoteById error, please provide id',
                }.to_json
            }
        end
    end
end