import { setupEntryPoint } from './setupEntryPoint';
import App from '@/layouts/books/MainLayout.vue';
import router from '@/routers/books';
import '@/assets/css/style.scss';
// import '@/assets/css/panel.scss';

setupEntryPoint(App, router);
