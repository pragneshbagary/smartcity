<template>
    <div class="app-navbar">
      <ul class="navbar-menu">
        <li @click="selectOption('traffic')">Traffic</li>
        <li @click="selectOption('cctv')">CCTVs</li>
        <li @click="selectOption('drones')">Manage CCTVs</li>
      </ul>
    </div>
  </template>
  
  <script>
  export default {
    methods: {
      selectOption(option) {
        // Emit an event with the selected option which can be handled by the parent component
        this.$emit('option-selected', option);
      }
    }
  }
  </script>
  
  <style scoped>
  .app-navbar {
    width: 250px;
    /* height: 100vh; */
    background-color: #2c3e50; /* Dark slate blue background */
    color: white;
    display: flex;
    flex-direction: column;
    align-items: center;
    padding-top: 20px;
    box-shadow: 2px 0 5px rgba(0, 0, 0, 0.1);
  }
  
  .navbar-menu {
    list-style: none;
    width: 100%;
    padding: 0;
  }
  
  .navbar-menu li {
    padding: 15px 20px;
    cursor: pointer;
    text-align: center;
    border-bottom: 1px solid #34495e; /* Slightly lighter blue for separation */
    transition: background-color 0.3s, color 0.3s;
  }
  
  .navbar-menu li:hover {
    background-color: #34495e; /* Lighter blue when hovered */
    color: #ecf0f1; /* Light grey color for text on hover */
  }
  </style>
  