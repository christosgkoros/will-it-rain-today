import Vue from 'vue'
import App from './App.vue'
import VueResource from 'vue-resource'
import VueMaterial from 'vue-material'
import 'vue-material/dist/vue-material.min.css'
import 'vue-material/dist/theme/default.css'

Vue.config.productionTip = false
Vue.use(VueResource);
Vue.use(VueMaterial);

Vue.prototype.$serverHost = 'http://willitrain-env-1.eba-hvjyxccy.eu-central-1.elasticbeanstalk.com';

new Vue({
  render: h => h(App),
}).$mount('#app')
