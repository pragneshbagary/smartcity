<template>
  <div class="main-area">
    <!-- Dynamic Component based on selected tab -->
    <component @chosenCoords="emitCoords" :active-tab="activeTab" :is="currentComponent" v-bind="$attrs"></component>
  </div>
</template>

<script>
import MapComponent from './MapComponent.vue'
import AnalyticsComponent from './AnalyticsComponent.vue'
import HelpComponent from './HelpComponent.vue'

export default {
  props: ['activeTab'], // Passed from the parent component based on navbar selection
  components: {
    MapComponent,
    AnalyticsComponent,
    HelpComponent
  },
  computed: {
    currentComponent() {
      switch (this.activeTab) {
        case 'traffic':
          return 'MapComponent';
        case 'cctv':
          return 'MapComponent';
        case 'drones':
          return 'MapComponent';
        default:
          return null;
      }
    }
  },
  methods: {
    emitCoords(val) {
      this.$emit('emitChosenCoords', val);
    }
  }
}
</script>

<style>
.main-area {
  flex-grow: 1;
  padding: 20px;
}
</style>