<template>
  <nav>
    <div class="profile">
      <img
        src="https://valutico.com/wp-content/uploads/2022/11/Valutico-Logo.svg"
        alt="profile_picture"
      />
      <h3>Valutico</h3>
    </div>
    <ul>
      <li class="active">
        <router-link
          :to="{
            name: 'index',
          }"
          class="item"
        >
          My Books
        </router-link>
      </li>
    </ul>
  </nav>
</template>

<script setup lang="ts"></script>
