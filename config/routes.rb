Rails.application.routes.draw do
  if Rails.env.development?
    mount GraphiQL::Rails::Engine, at: "/graphiql", graphql_path: "/graphql"
  end
  post "/graphql", to: "graphql#execute"
  mount Sidekiq::Web => '/sidekiq'
  root to: 'application#website'

  devise_for :users, defaults: { format: :json }, skip: :all
  devise_scope :user do
    # If you change these urls and helpers, you must change these files too:
    # - config/initializers/devise.rb#JWT Devise
    # - spec/support/authentication_helper.rb
    post '/users/login' => 'sessions#create', as: :user_session
    delete '/users/logout' => 'sessions#destroy', as: :destroy_user_session
    post '/users/signup' => 'registrations#create', as: :user_registration
  end

  get '/books(/*path)', to: 'application#books', as: :panel
  get '/(*path)', to: 'application#website', as: :website
end
