<template>
  <div class="toolbar">
    <div class="right">
      <span class="toolbar clearable_input">
        Filter: <InputText v-model="filterTerm" />
        <i
          v-if="filterTerm"
          @click="removeFilterTerm()"
          class="pi pi-times clear_button"
        />
      </span>
    </div>
  </div>
</template>

<script setup>
import { ref, nextTick } from 'vue';
import Dropdown from 'primevue/dropdown'; // Import Dropdown correctly

const filterTerm = ref('');

function removeFilterTerm() {
  filterTerm.value = '';
}
</script>

<style scoped>
span.toolbar {
  align-items: center;
  display: flex;
  padding-right: 5px;
}

span.toolbar input {
  padding-right: 5px;
  padding-left: 7px;
  margin-left: 5px;
  height: 30px;
  width: 200px;
}

.clearable_input {
  position: relative;
}

.clear_button {
  position: absolute;
  right: 0;
  padding: 0 10px;
  font-style: normal;
  user-select: none;
  cursor: pointer;
}

div.toolbar {
  align-items: center;
  display: flex;
  font-weight: normal;
  /* padding-top: 12px; */
}

div.toolbar .right {
  align-items: center;
  display: flex;
  min-width: auto;
}
</style>
