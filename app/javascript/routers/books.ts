import { createRouter, createWebHistory } from 'vue-router';
import routes from '@/routes/books';

const router = createRouter({
  history: createWebHistory('/books/'),
  routes,
});

export default router;
