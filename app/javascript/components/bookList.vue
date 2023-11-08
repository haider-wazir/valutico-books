<template>
  <div>
    <div>
      <link-item
        v-for="(link, index) in orderedLinks"
        :key="link.id"
        :link="link"
        :index="index"
        :pageNumber="pageNumber"
      >
      </link-item>
    </div>
    <div v-if="isNewPage">
      <button v-show="!isFirstPage" @click="previousPage()">Previous</button>
      <button v-show="morePages" @click="nextPage()">Next</button>
    </div>
  </div>
</template>
