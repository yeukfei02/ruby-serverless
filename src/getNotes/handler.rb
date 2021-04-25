require 'json'
require_relative '../../model/Notes'

def getNotes(event:, context:)
    notes = Notes.all

    {
        statusCode: 200,
        body: {
            message: 'getNotes',
            notes: notes
        }.to_json
    }
end