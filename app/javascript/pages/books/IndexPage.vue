<script>
import { useQuery, useMutation } from '@vue/apollo-composable';
import { useRoute } from 'vue-router';
import { watch } from 'vue';
import { computed } from 'vue';
import gql from 'graphql-tag';
import { apolloClient } from '../../entrypoints/client.js';

export default {
  setup() {
    const { mutate: deleteBook, onDone } = useMutation(
      gql`
        mutation DeleteBook($id: ID!) {
          deleteBook(input: { id: $id }) {
            id
          }
        }
      `,
      () => ({
        variables: {
          id: '',
        },
        update(cache, book) {
          console.log(cache);
          const normalizedId = cache.evict({
            id: cache.identify({ id: book.data.deleteBook.id, __typename: 'Book' }),
          });
          cache.gc();
          console.log('normalizedId: ', normalizedId);
          window.location.href = '/books';
        },
      }),
    );
    return {
      deleteBook,
    };
  },
  methods: {
    onDeleteClicked(id) {
      this.deleteBook({ id: id });
    },
    fetchBooks(filter = {}) {
      apolloClient
        .query({
          query: gql`
            query ($filter: BookFilter) {
              fetchBooks(filter: $filter) {
                id
                title
                author
                publicationDate
              }
            }
          `,
          variables: {
            filter: filter,
          },
        })
        .then((res) => {
          console.log(res);
          this.books = res.data.fetchBooks;
          return res;
        })
        .catch((err) => {
          return err;
        });
      // this.currentBooks = computed(() => result.value?.fetchBooks);
    },
    searchSubmit() {
      this.fetchBooks({ titleContains: this.searchTerm, OR: { authorContains: this.searchTerm } });
    },
  },
  data() {
    return {
      books: [],
      searchTerm: '',
    };
  },
  mounted() {
    this.fetchBooks();
  },
};
</script>
<template>
  <div class="container">
    <div class="form">
      <div class="form-box pt-25">
        <div class="form-bg py-30 px-50 mw-none">
          <div class="flex justify-content-between">
            <h2 class="text-center">Books</h2>
            <div class="field">
              <input
                class="input search"
                v-model="searchTerm"
                placeholder="Search by title or author"
              />
              <button class="btn-outline" @click="searchSubmit">Search</button>
            </div>
            <router-link :to="{ path: '/new' }" class=""
              ><button class="btn">Add</button></router-link
            >
          </div>

          <table class="navbar-nav">
            <thead>
              <tr>
                <th>ID</th>
                <th>Title</th>
                <th>Author</th>
                <th>PublicationDate</th>
                <th></th>
              </tr>
            </thead>
            <tbody>
              <tr v-for="book in books" :key="book.id" class="nav-item">
                <td>{{ book.id }}</td>
                <td>{{ book.title }}</td>
                <td>{{ book.author }}</td>
                <td>{{ book.publicationDate }}</td>
                <td>
                  <router-link :to="{ path: '/' + book.id }" class="my-auto">
                    <svg
                      xmlns="http://www.w3.org/2000/svg"
                      fill="none"
                      viewBox="0 0 24 24"
                      stroke-width="1.5"
                      stroke="currentColor"
                      class="book-icon"
                    >
                      <path
                        stroke-linecap="round"
                        stroke-linejoin="round"
                        d="M16.862 4.487l1.687-1.688a1.875 1.875 0 112.652 2.652L10.582 16.07a4.5 4.5 0 01-1.897 1.13L6 18l.8-2.685a4.5 4.5 0 011.13-1.897l8.932-8.931zm0 0L19.5 7.125M18 14v4.75A2.25 2.25 0 0115.75 21H5.25A2.25 2.25 0 013 18.75V8.25A2.25 2.25 0 015.25 6H10"
                      />
                    </svg>
                  </router-link>

                  <a href="javascript:;" @click="onDeleteClicked(book.id)">
                    <svg
                      xmlns="http://www.w3.org/2000/svg"
                      fill="none"
                      viewBox="0 0 24 24"
                      stroke-width="1.5"
                      stroke="currentColor"
                      class="book-icon"
                    >
                      <path
                        stroke-linecap="round"
                        stroke-linejoin="round"
                        d="M14.74 9l-.346 9m-4.788 0L9.26 9m9.968-3.21c.342.052.682.107 1.022.166m-1.022-.165L18.16 19.673a2.25 2.25 0 01-2.244 2.077H8.084a2.25 2.25 0 01-2.244-2.077L4.772 5.79m14.456 0a48.108 48.108 0 00-3.478-.397m-12 .562c.34-.059.68-.114 1.022-.165m0 0a48.11 48.11 0 013.478-.397m7.5 0v-.916c0-1.18-.91-2.164-2.09-2.201a51.964 51.964 0 00-3.32 0c-1.18.037-2.09 1.022-2.09 2.201v.916m7.5 0a48.667 48.667 0 00-7.5 0"
                      />
                    </svg>
                  </a>
                </td>
              </tr>
            </tbody>
          </table>
        </div>
      </div>
    </div>
  </div>
</template>
