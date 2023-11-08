module Mutations
  class DeleteBook < BaseMutation
    
    argument :id, ID, required: true
    type Types::BookType
    
    def resolve(id:)
      book = current_user.books.find_by_id(id)
      book.delete
      book
    rescue ActiveRecord::RecordInvalid => e
      GraphQL::ExecutionError.new("Invalid attributes for #{e.record.class}:"\
        " #{e.record.errors.full_messages.join(', ')}")
    end
  end
end
