const Index = () => import('@/pages/books/IndexPage.vue');
const New = () => import('@/pages/books/NewBook.vue');
const Edit = () => import('@/pages/books/EditBook.vue');

const routes = [
  {
    path: '/',
    name: 'index',
    components: {
      default: Index,
    },
  },
  {
    path: '/new',
    name: 'New',
    components: {
      default: New,
    },
  },
  {
    path: '/:id',
    name: 'Edit',
    components: {
      default: Edit,
    },
  },
];

export default routes;
