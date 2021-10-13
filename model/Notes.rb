require_relative '../db/db'

class Notes
  include Dynamoid::Document

  table name: :RubyServerlessNotes, key: :id, read_capacity: 1, write_capacity: 1

  field :content, :string
  field :createdAt, :string
  field :updatedAt, :string
end
