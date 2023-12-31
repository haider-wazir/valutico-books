import { Component, createApp } from 'vue';
import { Router } from 'vue-router';
import { VueQueryPlugin } from 'vue-query';
import { globalProperties } from './globalProperties';
import { pinia } from '@/stores';
import { setHTTPHeader } from '@/services/http.service';
import AuthService from '@/services/auth.service';

import { DefaultApolloClient } from '@vue/apollo-composable';
import { apolloClient } from './client.js';

const token = AuthService.getToken();

if (token) {
  setHTTPHeader({ Authorization: token });
}

export const setupEntryPoint = (rootComponent: Component, router: Router) => {
  const app = createApp(rootComponent);
  app.use(router);
  app.use(pinia);
  app.use(VueQueryPlugin);
  app.provide(DefaultApolloClient, apolloClient);
  app.config.globalProperties = { ...app.config.globalProperties, ...globalProperties };

  app.mount('#app');
};
