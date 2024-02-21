import { createApp } from 'vue'
import App from './App.vue'
import './registerServiceWorker'
import router from './router'
import PrimeVue from 'primevue/config';
import 'primevue/resources/themes/lara-light-green/theme.css'

import DataTable from 'primevue/datatable';
import Column from 'primevue/column';

const app = createApp(App)
app.use(router)
app.use(PrimeVue)
app.mount('#app')

app.component('DataTable', DataTable);
app.component('Column', Column);
