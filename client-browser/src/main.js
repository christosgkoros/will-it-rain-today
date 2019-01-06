import Vue from 'vue'
import App from './App.vue'
import VueResource from 'vue-resource'
import VueMaterial from 'vue-material'
import 'vue-material/dist/vue-material.min.css'
import 'vue-material/dist/theme/default.css'

Vue.config.productionTip = false
Vue.use(VueResource);
Vue.use(VueMaterial);

Vue.prototype.$serverHost = 'http://localhost:8000';

new Vue({
  render: h => h(App),
}).$mount('#app')
