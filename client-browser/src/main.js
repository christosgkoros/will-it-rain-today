import Vue from 'vue'
import App from './App.vue'
import VueResource from 'vue-resource'
import VueMaterial from 'vue-material'
import 'vue-material/dist/vue-material.min.css'
import 'vue-material/dist/theme/default.css'

Vue.config.productionTip = false
Vue.use(VueResource);
Vue.use(VueMaterial);


//define a specific host for the REST API
//Vue.prototype.$serverHost = "http://localhost:8000";

if (!Vue.prototype.$serverHost) {
  Vue.prototype.$serverHost="";
}

new Vue({
  render: h => h(App),
}).$mount('#app')
