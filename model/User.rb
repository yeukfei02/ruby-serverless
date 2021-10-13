require_relative '../db/db'

class User
  include Dynamoid::Document

  table name: :RubyServerlessUser, key: :id, read_capacity: 1, write_capacity: 1

  field :email, :string
  field :password, :string
  field :createdAt, :string
  field :updatedAt, :string
end
