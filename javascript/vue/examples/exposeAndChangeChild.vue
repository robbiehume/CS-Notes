// Parent

<template>
  <div>
    <ChildComponent ref="child" />
    <button @click="changeChildVariable">Change Child Variable</button>
    <p>Child Variable: {{ child?.childVariable }}</p>
    <button @click="invokeChildMethod">Invoke Child Method</button>
  </div>
</template>

<script setup>
import { ref } from 'vue';
import ChildComponent from './ChildComponent.vue';

const child = ref(null);

function changeChildVariable() {
  if (child.value) {
    child.value.childVariable = 'Changed value';
  }
}

function invokeChildMethod() {
  if (child.value) {
    child.value.childMethod();
  }
}
</script>


// Child Component

<template>
  <div>
    Child Component
  </div>
</template>

<script setup>
import { ref, defineExpose } from 'vue';

const childVariable = ref('Initial value');

function childMethod() {
  console.log('Child method invoked!');
}

// Expose the variable and method
defineExpose({
  childVariable,
  childMethod
});


</script>




