module Types
  module Input
    class BookType < Types::BaseInputObject
      argument :title, String, required: true
      argument :author, String, required: true
      argument :publication_date, GraphQL::Types::ISO8601Date, required: true
    end
  end
end