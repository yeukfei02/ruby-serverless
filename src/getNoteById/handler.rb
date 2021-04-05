require 'json'
require_relative '../../model/Notes.rb'

def getNoteById(event:, context:)
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
                puts "error = #{exception}"

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