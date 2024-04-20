<!-- 
<template>
    <div class="main-area">
      Placeholder for the interactive map 
      <div class="map-placeholder">
        Interactive Map Goes Here
        Replace this placeholder with the actual map component or integration
      </div>
    </div>
  </template>
  
  <script>
  export default {
    props: ['activeTab'],
    mounted() {
      // Placeholder: Initialize map and set up API if necessary
      // this.initializeMap();
    },
    methods: {
      initializeMap() {
        // Placeholder for map initialization logic
        // Example: Load Google Maps API or any other map service API
      }
    }
  }
  </script>
  
  <style scoped>
  .main-area {
    flex-grow: 1; /* Take up remaining space */
    padding: 20px;
    background-color: #ecf0f1; /* Light gray background for contrast */
    display: flex;
    justify-content: center;
    align-items: center;
  }
  
  .map-placeholder {
    width: 80%;
    height: 80%;
    background-color: #bdc3c7; /* Medium gray placeholder area */
    color: #2c3e50; /* Dark text color for visibility */
    display: flex;
    justify-content: center;
    align-items: center;
    font-size: 24px;
    border-radius: 8px; /* Soft rounded corners for a modern look */
    box-shadow: 0 4px 8px rgba(0,0,0,0.1); /* Subtle shadow for depth */
  }
  </style>
 -->

 <template>
    <div class="main-area">
      <!-- Dynamic Component based on selected tab -->
      <component :is="currentComponent" v-bind="$attrs"></component>
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
    }
  }
  </script>
  
  <style>
  .main-area {
    flex-grow: 1;
    padding: 20px;
  }
  </style>
  