<script>
import { useQuery, useMutation } from '@vue/apollo-composable';
import { useRoute } from 'vue-router';
import { watch } from 'vue';
import { computed } from 'vue';
import gql from 'graphql-tag';

export default {
  setup() {
    const { mutate: updateBook, onDone } = useMutation(
      gql`
        mutation UpdateBook(
          $id: ID!
          $title: String!
          $author: String!
          $publicationDate: ISO8601Date!
        ) {
          updateBook(
            input: { id: $id, title: $title, author: $author, publicationDate: $publicationDate }
          ) {
            id
          }
        }
      `,
      () => ({
        variables: {
          title: '',
          author: '',
          publicationDate: '',
        },
      }),
    );
    onDone((res) => {
      window.location.href = '/books';
    });

    const route = useRoute();
    const bookId = route.params.id;

    const { result } = useQuery(
      gql`
        query FetchBook($id: ID!) {
          fetchBook(id: $id) {
            id
            title
            author
            publicationDate
          }
        }
      `,
      () => ({
        id: bookId,
      }),
    );
    console.log(result);
    let bookTitle = computed(() => result.value?.fetchBook?.title);
    let bookAuthor = computed(() => result.value?.fetchBook?.author);
    let bookPublicationDate = computed(() => result.value?.fetchBook?.publicationDate);
    return {
      updateBook,
      bookTitle,
      bookPublicationDate,
      bookAuthor,
      bookId,
    };
  },
  methods: {
    formSubmit() {
      this.updateBook({
        id: this.bookId,
        title: this.title,
        author: this.author,
        publicationDate: this.publicationDate,
      });
    },
    handleSubmit(e) {
      e.preventDefault();
    },
    updateDate() {},
  },
  data() {
    return {
      title: '',
      author: '',
      publicationDate: '',
    };
  },
  watch: {
    bookAuthor(value, oldValue) {
      this.author = value;
    },
    bookTitle(value, oldValue) {
      this.title = value;
    },
    bookPublicationDate(value, oldValue) {
      this.publicationDate = value;
    },
  },
};
</script>

<template>
  <section class="section">
    <div class="container">
      <div class="form">
        <div class="form-box pt-25">
          <div class="form-bg py-30 px-50">
            <div class="flex">
              <router-link :to="{ path: '/' }" class="my-auto">
                <svg
                  class="w-10"
                  aria-hidden="true"
                  xmlns="http://www.w3.org/2000/svg"
                  fill="none"
                  viewBox="0 0 8 14"
                >
                  <path
                    stroke="currentColor"
                    stroke-linecap="round"
                    stroke-linejoin="round"
                    stroke-width="2"
                    d="M7 1 1.3 6.326a.91.91 0 0 0 0 1.348L7 13"
                  />
                </svg>
              </router-link>
              <h2 class="text-center">Edit</h2>
            </div>
            <form @submit.prevent="handleSubmit">
              <div class="field">
                <label class="label">Title</label>
                <p class="control">
                  <input class="input" v-model="title" placeholder="Book title" required="true" />
                </p>
              </div>
              <div class="field">
                <label class="label">Author</label>
                <p class="control">
                  <input class="input" v-model="author" placeholder="Book author" required="true" />
                </p>
              </div>

              <div class="field">
                <label class="label">PublicationDate</label>
                <p class="control">
                  <input
                    required="true"
                    class="input"
                    v-model="publicationDate"
                    placeholder="Book publication Date"
                  />
                </p>
              </div>

              <p class="control mt-2">
                <button class="btn" @click="formSubmit">Update Book</button>
              </p>
            </form>
          </div>
        </div>
      </div>
    </div>
  </section>
</template>
