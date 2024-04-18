<template>
    <div class="top-bar">
      <div class="logo-container">
        <img src="@/assets/logo.png" alt="Logo" class="logo">
        <span class="company-name">Smart City Platform</span>
      </div>
      <div class="user-menu">
        <img src="@/assets/logo.png" alt="User" @click="toggleDropdown" class="user-icon">
        <div v-if="showDropdown" class="dropdown-menu">
          <ul>
            <li @click="viewProfile">Profile</li>
            <li @click="openSettings">Settings</li>
            <li @click="logout">Logout</li>
          </ul>
        </div>
      </div>
    </div>
  </template>
  
  <script>
  export default {
    data() {
      return {
        showDropdown: false,
      };
    },
    methods: {
      toggleDropdown() {
        this.showDropdown = !this.showDropdown;
      },
      viewProfile() {
        // Placeholder for profile viewing logic
      },
      openSettings() {
        // Placeholder for settings logic
      },
      logout() {
        // Placeholder for logout logic
        // Example: this.$router.push('/login');
      }
    }
  }
  </script>
  
  <style scoped>
  .top-bar {
    display: flex;
    justify-content: space-between;
    align-items: center;
    padding: 10px 30px;
    background-color: #ffffff;
    box-shadow: 0 2px 4px rgba(0,0,0,0.1);
  }
  
  .logo-container {
    display: flex;
    align-items: center;
  }
  
  .logo {
    width: 40px;
    height: 40px;
    margin-right: 10px;
  }
  
  .company-name {
    font-size: 20px;
    color: #333;
  }
  
  .user-menu {
    position: relative;
  }
  
  .user-icon {
    width: 35px;
    height: 35px;
    cursor: pointer;
  }
  
  .dropdown-menu {
    position: absolute;
    right: 0;
    top: 48px;
    background-color: #fff;
    border: 1px solid #ddd;
    border-radius: 4px;
    box-shadow: 0 2px 8px rgba(0,0,0,0.1);
    z-index: 100;
  }
  
  .dropdown-menu ul {
    list-style: none;
    margin: 0;
    padding: 5px 0;
  }
  
  .dropdown-menu li {
    padding: 8px 20px;
    cursor: pointer;
    color: #333;
    text-align: left;
  }
  
  .dropdown-menu li:hover {
    background-color: #f6f6f6;
  }
  </style>
  