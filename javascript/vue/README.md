## Code examples


### Emit up to parent
* Create a searchBox component and then add that component to each of your views.  The component with “emit” an event to signal that a search needs to be performed and the parent will listen for the event and then actually perform the search
* In the searchBox component you would have something like:

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

### Preventing form submission
* If you are using a `<form…>` element but are submitting the content via JavaScript and want to keep the page from automatically reload/changing the URL when you hit enter or click submit, then you need to do the following:
* Add  onsubmit="event.preventDefault();" to your <form…> tag and return false; from your JavaScript method; i.e.:
```Vue
<form id="myForm" onsubmit="event.preventDefault();">
…. your input fields here …
              <button type="submit" onclick="mySubmitFunction()">Submit</button>
</form>

<script>
              function mySubmitFunction() {
                             …ajax / axios submission of data…

                             return false;
              }
</script>
```
