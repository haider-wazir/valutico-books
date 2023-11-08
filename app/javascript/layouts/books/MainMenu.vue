<template>
  <nav class="navbar">
    <div class="nav-container">
      <h2 class="navbar-logo">
        <img
          src="https://valutico.com/wp-content/uploads/2022/11/Valutico-Logo.svg"
          alt="profile_picture"
        />
      </h2>
    </div>
    <ul class="navbar-nav">
      <li class="nav-item">Profile</li>
      <li class="nav-item" @click="logout">Logout</li>
    </ul>
  </nav>
</template>

<script setup lang="ts">
import { useAuthStore } from '@/stores/auth.store';
const authStore = useAuthStore();

const logout = () => {
  authStore.logout();
};
</script>
