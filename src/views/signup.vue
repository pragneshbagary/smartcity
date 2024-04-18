<template>
    <div class="full-width">
    <div class="container">
      <h2>Sign Up</h2>
      <form @submit.prevent="handleSubmit">
        <div class="form-group">
          <label for="userType">User Type:</label>
          <select id="userType" v-model="userType" class="form-control">
            <option value="public">Public</option>
            <option value="governmentAdmin">Government Admin</option>
          </select>
        </div>
  
        <div class="form-group">
          <label for="username">Username:</label>
          <input id="username" type="text" v-model="username" class="form-control" required>
        </div>
  
        <div class="form-group">
          <label for="password">Password:</label>
          <input id="password" type="password" v-model="password" class="form-control" required>
        </div>
  
        <div v-if="userType === 'governmentAdmin'" class="form-group">
          <label for="adminId">ID:</label>
          <input id="adminId" type="text" v-model="adminId" class="form-control">
        </div>
  
        <button type="submit" class="btn btn-primary">Sign Up</button>
      </form>
      <p>Already a user? <a href="/">Sign in here</a></p>

    </div>
</div>
  </template>
  
  <script>
  export default {
    name: 'SignUp',
    data() {
      return {
        userType: 'public',
        username: '',
        password: '',
        adminId: '',
      };
    },
    methods: {
      handleSubmit() {
        // Placeholder for sign-up logic, e.g., validation and API call for registration
        console.log('Form Submitted', this.username, this.password, this.userType, this.adminId);
        // Implement your sign-up logic here
      },
    },
  };
  </script>
  
  <style scoped>
  .full-width {
    width: 100vw;
    height: 100vh;
    background: url("@/assets/homepage.webp");
    position: fixed;
    top: 0;
    left: 0;
}
  .container {
    max-width: 400px;
    margin: auto;
    padding: 20px;
    background: rgba(255, 255, 255, 0.8);
    border-radius: 10px;
    box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
    margin-top: 50px;
  }
  .form-group {
    margin-bottom: 1rem;

  }
  .form-control {
    display: block;
    width: 100%;
    /* padding: 0.375rem 0.75rem; */
    font-size: 1rem;
    line-height: 1.5;
    color: #495057;
    background-color: #fff;
    background-clip: padding-box;
    border: 1px solid #ced4da;
    border-radius: 0.25rem;
    transition: border-color 0.15s ease-in-out, box-shadow 0.15s ease-in-out;
    width: 100%;
    height: 35px;
  }
  .btn-primary {
    color: #fff;
    background-color: #007bff;
    border-color: #007bff;
    cursor: pointer;
  }
  .btn {
    display: inline-block;
    font-weight: 400;
    text-align: center;
    white-space: nowrap;
    vertical-align: middle;
    user-select: none;
    border: 1px solid transparent;
    padding: 0.375rem 0.75rem;
    font-size: 1rem;
    line-height: 1.5;
    border-radius: 0.25rem;
    transition: color 0.15s ease-in-out, background-color 0.15s ease-in-out, border-color 0.15s ease-in-out, boxShadow 0.15s ease-in-out;
  }
  </style>
  