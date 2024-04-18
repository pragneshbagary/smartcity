<template>
    <div class="right-panel">
      <div class="toggle">
        <label class="switch">
          <input type="checkbox" id="traffic" v-model="traffic">
          <span class="slider round"></span>
        </label>
        <span class="label-text">Traffic</span>
      </div>
      <div class="toggle">
        <label class="switch">
          <input type="checkbox" id="cctv" v-model="cctv">
          <span class="slider round"></span>
        </label>
        <span class="label-text">CCTVs</span>
      </div>
      <div class="toggle">
        <label class="switch">
          <input type="checkbox" id="drones" v-model="drones">
          <span class="slider round"></span>
        </label>
        <span class="label-text">Drones</span>
      </div>
    </div>
  </template>
  
  <script>
  export default {
    data() {
      return {
        traffic: false,
        cctv: false,
        drones: false
      }
    },
    watch: {
      traffic(newVal) {
        this.$emit('toggle-traffic', newVal);
        // console.log(newVal)
      },
      cctv(newVal) {
        this.$emit('toggle-cctv', newVal);
      },
      drones(newVal) {
        this.$emit('toggle-drones', newVal);
      }
    }
  }
  </script>
  
  <style scoped>
  .right-panel {
    display: flex;
    flex-direction: column;
    padding: 20px;
    border-left: 1px solid #ddd;
    background-color: #f8f9fa;
    /* height: 100vh; */
  }
  
  .toggle {
    margin-bottom: 10px;
  }
  
  .label-text {
    margin-left: 10px;
    font-size: 16px;
    color: #333;
  }
  
  .switch {
    position: relative;
    display: inline-block;
    width: 60px;
    height: 34px;
  }
  
  .switch input { 
    opacity: 0;
    width: 0;
    height: 0;
  }
  
  .slider {
    position: absolute;
    cursor: pointer;
    top: 0;
    left: 0;
    right: 0;
    bottom: 0;
    background-color: #ccc;
    transition: .4s;
    border-radius: 34px;
  }
  
  .slider:before {
    position: absolute;
    content: "";
    height: 26px;
    width: 26px;
    left: 4px;
    bottom: 4px;
    background-color: white;
    transition: .4s;
    border-radius: 50%;
  }
  
  input:checked + .slider {
    background-color: #2196F3;
  }
  
  input:focus + .slider {
    box-shadow: 0 0 1px #2196F3;
  }
  
  input:checked + .slider:before {
    transform: translateX(26px);
  }
  </style>
  