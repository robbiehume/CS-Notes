## Code examples


### Emit up to parent
* create a searchBox component and then add that component to each of your views.  The component with “emit” an event to signal that a search needs to be performed and the parent will listen for the event and then actually perform the search
*In the searchBox component you would have something like:

  ```Vue
  <template>
      <form class="form" id="form">
          <input type="text" placeholder="Search" aria-label="Search" autocomplete="on" v-model="searchString" @keydown.enter="search()">
          <button class="btn btn-outline-success my-2 my-sm-0" title="search" id="submit"><i data-v-23f56637="" class="fa fa-search"></i></button>
      </form>
  
  </template>
  
  <script setup>
      defineEmits(['search']);
      const searchString = ref('')
  
      function search() {
          emit('search', { searchString })
      }
  </script>
  ```


* In the View for each tab you would have something like:
  ```Vue
  <template>
      <searchBox @search="performSearch" />
  </template>
  <script setup>
      import searchBox from '@/components/searchBox.vue'
  
      function performSearch(searchTerm) {
  
      }
  </script>
  ```
