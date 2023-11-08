# frozen_string_literal: true

require 'rails_helper'

describe GraphqlController, type: :request do
  let(:user) { create(:user) }
  let(:book) { Book.create title: 'test', author: 'test', publication_date: '2020-07-10', user_id: user.id }
  before do
    login(user)
  end
  
  context 'create book' do
    it 'should create book' do
      post '/graphql', params: { query: create_book_query }, headers: auth_header
      json = JSON.parse(response.body)
      data = json['data']['createBook']

      expect(data).to include('id' => be_present)
    end

    it 'should returns an error' do
      post '/graphql', params: { query: create_book_without_author_query }, headers: auth_header
      json = JSON.parse(response.body)
      error = json['errors'].first['message']
      expect(error).to eq("Argument 'author' on InputObject 'CreateBookInput' is required. Expected type String!")
    end
  end

  context 'update book' do
    it 'should update the book' do
      post '/graphql', params: { query: update_book_query(id: book.id) }, headers: auth_header
      json = JSON.parse(response.body)
      data = json['data']['updateBook']

      expect(data).to include('id' => be_present)
    end
  end

  context 'delete book' do
    it 'should delete the book' do
      post '/graphql', params: { query: delete_book_query(id: book.id) }, headers: auth_header
      json = JSON.parse(response.body)
      data = json['data']['deleteBook']

      expect(data).to include('id' => be_present)
    end
  end

  context 'show book' do
    it 'should show the book' do
      post '/graphql', params: { query: show_book_query(id: book.id) }, headers: auth_header
      json = JSON.parse(response.body)
      data = json['data']['fetchBook']

      expect(data).to include(
        'id'              => be_present,
        'title'           => be_present,
        'publicationDate' => be_present,
        'author'          => be_present
      )
    end
  end

  def create_book_query
    <<~GQL
      mutation {
        createBook(
          input: {
            title: "Test"
            publicationDate: "2020-07-10"
            author: "Test"
          }
          
        ) {
          id
        }
      }
    GQL
  end

  def create_book_without_author_query
    <<~GQL
      mutation {
        createBook(
          input: {
            title: "Test"
            publicationDate: "2020-07-10"
          }
          
        ) {
          id
        }
      }
    GQL
  end

  def update_book_query(id:)
    <<~GQL
      mutation {
        updateBook(
          input: {
            id: #{id}
            title: "Test1"
            author: "Test"
            publicationDate: "2020-07-10"
          }
          
        ) {
          id
        }
      }
    GQL
  end

  def delete_book_query(id:)
    <<~GQL
      mutation {
        deleteBook(
          input: {
            id: #{id}
          }
          
        ) {
          id
        }
      }
    GQL
  end

  def show_book_query(id:)
    <<~GQL
      query {
        fetchBook(
          id: #{id}
        ) {
          id
          title
          author
          publicationDate
        }
      }
    GQL
  end
end
