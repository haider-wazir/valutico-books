module Mutations
  class CreateBook < BaseMutation
    # arguments passed to the `resolve` method
    # argument :input, ::Types::Input::BookType, required: true
    argument :title, String, required: true
    argument :author, String, required: true
    argument :publication_date, GraphQL::Types::ISO8601Date, required: true
    type Types::BookType

    def resolve(title:, author:, publication_date:)
      current_user.books.create!(title:, author:, publication_date:)
    rescue ActiveRecord::RecordInvalid => e
      GraphQL::ExecutionError.new("Invalid attributes for #{e.record.class}:"\
        " #{e.record.errors.full_messages.join(', ')}")
    end
  end
end
