<template>
  <nav class="navbar">
    <h2 class="navbar-logo">
      <img
        src="https://valutico.com/wp-content/uploads/2022/11/Valutico-Logo.svg"
        alt="profile_picture"
      />
    </h2>
    <ul class="navbar-nav">
      <li v-for="item in menuItems" :key="item.routeName" class="nav-item">
        <router-link
          :to="{
            name: item.routeName,
          }"
        >
          {{ item.title }}
        </router-link>
      </li>
      <li class="nav-item">
        <a href="/panel/"></a>
      </li>
    </ul>
  </nav>
</template>

<script setup lang="ts">
const menuItems = [
  { title: 'Sign in', routeName: 'login' },
  { title: 'Sign up', routeName: 'signup' },
];
</script>
