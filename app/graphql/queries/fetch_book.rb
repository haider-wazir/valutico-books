module Queries
  class FetchBook < Queries::BaseQuery
    type Types::BookType, null: false
    argument :id, ID, required: true

    def resolve(id:)
      cache_fragment { current_user.books.find_by_id(id) }
    rescue ActiveRecord::RecordNotFound => _e
      GraphQL::ExecutionError.new('Book does not exist.')
    rescue ActiveRecord::RecordInvalid => e
      GraphQL::ExecutionError.new("Invalid attributes for #{e.record.class}:"\
        " #{e.record.errors.full_messages.join(', ')}")
    end
  end
end