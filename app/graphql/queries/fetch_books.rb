require 'search_object'
require 'search_object/plugin/graphql'
module Queries
  class FetchBooks < Queries::BaseQuery
    include SearchObject.module(:graphql)

    # scope is starting point for search
    scope { current_user.books.all.order(created_at: :desc) }

    type [Types::BookType], null: false

    # inline input type definition for the advanced filter
    class BookFilter < ::Types::BaseInputObject
      argument :OR, [self], required: false
      argument :title_contains, String, required: false
      argument :author_contains, String, required: false
    end

    option :filter, type: BookFilter, with: :apply_filter
    
    # apply_filter recursively loops through "OR" branches
    def apply_filter(scope, value)
      branches = normalize_filters(value).reduce { |a, b| a.or(b) }
      scope.merge branches
    end

    def normalize_filters(value, branches = [])
      scope = current_user.books.all.order(created_at: :desc)
      scope = scope.where('title LIKE ?', "%#{value[:title_contains]}%") if value[:title_contains]
      scope = scope.where('author LIKE ?', "%#{value[:author_contains]}%") if value[:author_contains]

      branches << scope

      value[:OR].reduce(branches) { |s, v| normalize_filters(v, s) } if value[:OR].present?

      branches
    end
  end
end
