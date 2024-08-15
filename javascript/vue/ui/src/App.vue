<template>
  <div>
        <MainView />
        </div>
  </template>
  
  <script setup>
    import MainView from '@/components/MainView.vue';
    import { useConfigStore } from '@/stores';
    import { onMounted, ref } from 'vue';

    const mountingComplete = ref(false);

    onMounted(async () => {
        const configStore = useConfigStore();
        await configStore.fetchConfig();

        mountingComplete.value = true;
        document.getElementById('wrapper').style.minHeight = window.innerHeight - 85 + 'px';
    });

  </script>
  
  <style>
  </style>
  
