# frozen_string_literal: true

module Types
  class QueryType < Types::BaseObject
    field :fetch_books, resolver: Queries::FetchBooks
    field :fetch_book, resolver: Queries::FetchBook
  end
end
