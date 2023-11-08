module Queries
  class BaseQuery < GraphQL::Schema::Resolver
    include GraphQL::FragmentCache::ObjectHelpers
   
    def current_user
      context[:current_user]
    end
  end
end