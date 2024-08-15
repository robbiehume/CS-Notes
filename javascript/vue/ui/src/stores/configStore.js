import { createPinia, defineStore } from 'pinia';
import axios from 'axios';

export const useConfigStore = defineStore('configStore', {
    state: () => {
        return {
            testVal: '',
        };
    },
    actions: {
        async fetchConfig() {
            try {
                // The file is stored in S3 bucket
                const response = await axios.get('config.json');
                this.config = await response.data;

                this.testVal = this.config.testVal;
            } catch (error) {
                console.log(error);
                this.error = error;
            }
        }
    }
});

const store = createPinia();

export default store;
