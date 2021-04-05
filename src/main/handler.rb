require 'json'

def main(event:, context:)
    {
        statusCode: 200,
        body: {
            message: 'ruby-serverless',
        }.to_json
    }
end