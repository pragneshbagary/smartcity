<template>
  <div id="app">
    <TopBar />
    <div class="main-content">
        <appNavbar @option-selected="changeTab"/>
        <MainArea :activeTab="activeTab"/>
        <RightPanel />
    </div>
  </div>
</template>

<script>
import TopBar from '../components/TopBar'
import appNavbar from '../components/appNavbar'
import MainArea from '../components/MainArea'
import RightPanel from '../components/RightPanel'

export default {
  name: 'App',
  components: {
    TopBar,
    appNavbar,
    MainArea,
    RightPanel
  },
  data() {
    return {
      activeTab: 'traffic' // Default tab
    }
  },
  methods: {
    changeTab(tab) {
      this.activeTab = tab;
    }
  }
}
</script>

<style>
.main-content {
  display: flex;
}
</style>
