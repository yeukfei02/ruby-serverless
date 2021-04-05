require 'json'
require_relative '../../model/Notes.rb'

def updateNoteById(event:, context:)
    if event['pathParameters']
        id = event['pathParameters']['id']
        if id
            body = JSON.parse(event['body'])
            if defined? body
                content = body['content']

                puts "content = #{content}"

                begin
                    Notes.update(id, content: content)

                    {
                        statusCode: 200,
                        body: {
                            message: 'updateNoteById',
                        }.to_json
                    }
                rescue => exception
                    puts "error = #{exception}"
    
                    {
                        statusCode: 400,
                        body: {
                            message: 'updateNoteById error, no this id',
                        }.to_json
                    }
                end
            end
        else
            {
                statusCode: 400,
                body: {
                    message: 'updateNoteById error, please provide id',
                }.to_json
            }
        end
    end
end