// Put code in ui/src/stores/index.js

import { createPinia, defineStore } from 'pinia'
import axios from "axios";

export const sampleStore = defineStore('SampleStore', {
    state: () => {
        return {
            selectedSources: [],
            results: []
        }
        
    }
});

const store = createPinia();

export default store;
