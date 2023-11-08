module Mutations
  class UpdateBook < BaseMutation
    # arguments passed to the `resolve` method
    # argument :input, Types::Input::BookType, required: true

    argument :id, ID, required: true
    argument :title, String, required: true
    argument :author, String, required: true
    argument :publication_date, GraphQL::Types::ISO8601Date, required: true

    type Types::BookType, null: true

    def resolve(id:, title:, author:, publication_date:)
      book = current_user.books.find_by_id(id)
      book.update!(title:, author:, publication_date:)
      book
    rescue ActiveRecord::RecordInvalid => e
      GraphQL::ExecutionError.new("Invalid attributes for #{e.record.class}:"\
        " #{e.record.errors.full_messages.join(', ')}")
    end
  end
end
