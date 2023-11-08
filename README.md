# Backend Challenge: Build an application

<!-- List of all topics -->

## Table of Contents

- [An example Rails 7 app](#an-example-rails-7-app)
  - [Running app](#running-app)
    - [1. Install dependencies](#2-install-dependencies)
    - [2. Setup database](#4-setup-database)
    - [3. Run the app](#5-run-the-app)
  - [Auth](#auth)
    - [`/signup`](#signup)
    - [`/login`](#login)
    - [`/logout`](#logout)
  - [GraphQL](#auth)
    - [Mutations](#mutations)
    - [Queries](#queries)
    - [InputTypes](#input-types)
    - [OutputTypes](#output-types)


## Running app

### 1. Clone the repo

```bash
git clone git-url
cd valutico_books
```

### 2. Install dependencies

```bash
bundle install # install ruby gems
yarn install # install node packages
```

```bash
bundle exec rails db:setup
```

### 3. Run the app

```bash
bin/dev
```

## Auth

- [Devise](https://github.com/heartcombo/devise) and [Devise::JWT](https://github.com/waiting-for-dev/devise-jwt)

Predefined auth routes:

### `/signup`

**Request**:

```
curl -XPOST -H "Content-Type: application/json" -d '{ "user": { "email": "test@example.com", "password": "12345678", "password_confirmation": "12345678" } }' http://localhost:3000/signup
```

**Response**: Returns the details of the created user

```
{"data":{"id":"4","type":"user","attributes":{"email":"test@example.com","sign_in_count":1,"created_at":"2022-04-18T17:49:06.798Z"}}}
```

### `/login`

**Request**:

```bash
curl -XPOST -i -H "Content-Type: application/json" -d '{ "user": { "email": "test@example.com", "password": "12345678" } }' http://localhost:3000/login
```

**Response**: includes `Authorization` in header and details of the loggedin user

```bash
HTTP/1.1 200 OK
X-Frame-Options: SAMEORIGIN
X-XSS-Protection: 0
X-Content-Type-Options: nosniff
X-Download-Options: noopen
....
Content-Type: application/vnd.api+json; charset=utf-8
Authorization: Bearer eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOiI0Iiwic2NwIjoidXNlciIsImF1ZCI6bnVsbCwiaWF0IjoxNjUwMzA0MjU3LCJleHAiOjE2NTAzOTA2NTcsImp0aSI6IjM4ZmI4ZGIyLWVlMjgtNDg2Yy05YjE5LTA2NWVmYmQ0ZGE4MCJ9.p8766vPrhiGpPyV2FdShw1ljBx2Os3D1oE_rPjjAYrY
...

{"data":{"id":"4","type":"user","attributes":{"email":"test@example.com","sign_in_count":2,"created_at":"2022-04-18T17:49:06.798Z"}}}
```

### `/logout`

**Request**: includes `Authorization` and its JWT token in the header of `DELETE` request

```bash
curl -XDELETE -H "Authorization: Bearer eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOiI0Iiwic2NwIjoidXNlciIsImF1ZCI6bnVsbCwiaWF0IjoxNjUwMzA0MjU3LCJleHAiOjE2NTAzOTA2NTcsImp0aSI6IjM4ZmI4ZGIyLWVlMjgtNDg2Yy05YjE5LTA2NWVmYmQ0ZGE4MCJ9.p8766vPrhiGpPyV2FdShw1ljBx2Os3D1oE_rPjjAYrY" -H "Content-Type: application/json" http://localhost:3000/logout
```

**Response**: nothing

### Mutations

**Create book**:

```
mutation {
  createBook(
    input: {
      title: "Test1"
      author: "Test"
      publicationDate: "2020-07-10"
    }

  ) {
    id
  }
}
```

**Update book**

```
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
```
### Queries

**Fetch current_user's books**

```
query {
  fetchBooks {
    id
    title
    author
    publicationDate
  }
}
```

**Response**: Returns list of books

```
{
  "data": {
    "fetchBooks": [
        {
            "id": "65",
            "title": "12",
            "author": "123",
            "publicationDate": "2020-07-10",
            "__typename": "Book"
        },
        ...
    ]
  }
}
```

**Search books by title or author**

```
query ($filter: BookFilter) {
  fetchBooks(filter: { titleContains: 'Test', OR: { authorContains: 'Test' } }) {
    id
    title
    author
    publicationDate
  }
}
```

**Fetch a book by its ID**

```
query{
  fetchBook(id: $id) {
    id
    title
    author
    publicationDate
  }
}
```

### Input types

```
argument :title, String, required: true
argument :author, String, required: true
argument :publication_date, GraphQL::Types::ISO8601Date, required: true
```

### Output types

```
field :id, ID, null: false
field :title, String, null: false
field :author, String, null: false
field :publication_date, GraphQL::Types::ISO8601Date, null: false
```
