# frozen_string_literal: true

module Types
  class BookType < Types::BaseObject
    field :id, ID, null: false
    field :title, String, null: false
    field :author, String, null: false
    field :publication_date, GraphQL::Types::ISO8601Date, null: false
  end
end
