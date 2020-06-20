<template>
  <md-app>
    <md-app-toolbar class="md-primary">
      <span class="md-title">Will it rain</span>
    </md-app-toolbar>
    <md-app-content><WillitRain msg="Calculate the chance of rain for a given day"/></md-app-content>
  </md-app>
</template>

<script>
import WillitRain from './components/WillitRain.vue'

export default {
  name: 'app',
  components: {
      WillitRain
  }
}
</script>

<style>
#app {
  font-family: 'Avenir', Helvetica, Arial, sans-serif;
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
  text-align: center;
  color: #2c3e50;
  margin-top: 60px;
}
</style>
