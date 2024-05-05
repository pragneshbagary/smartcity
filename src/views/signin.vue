<template>
    <div class="full-width">
        <div class="container">
            <h2>Sign In</h2>
            <form @submit.prevent="handleSubmit">
                <div class="form-group">
                    <label for="userType">User Type</label>
                    <select id="userType" v-model="userType" class="form-control">
                        <option value="public">Public</option>
                        <option value="governmentAdmin">Government Admin</option>
                    </select>
                </div>

                <div class="form-group">
                    <label for="username">Username</label>
                    <input id="username" v-model="username" type="text" class="form-control" />
                </div>

                <div class="form-group">
                    <label for="password">Password</label>
                    <input id="password" v-model="password" type="password" class="form-control" />
                </div>

                <div v-if="userType === 'governmentAdmin'" class="form-group">
                    <label for="adminId">ID</label>
                    <input id="adminId" v-model="adminId" type="text" class="form-control" />
                </div>

                <button type="submit" class="btn btn-primary" @click="navigateToHomepage">Login</button>
            </form>
            <p>New user? <a href="/signup">Sign up here</a></p>
        </div>
    </div>
</template>
  
<script>
export default {
    name: 'SignIn',
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
            // Here, implement your sign-in logic, e.g., validate input, make API call, etc.
            // console.log({
            //     userType: this.userType,
            //     username: this.username,
            //     password: this.password,
            //     adminId: this.userType === 'governmentAdmin' ? this.adminId : undefined,
            // });
            // Redirect or show a message based on the response
        },
        navigateToHomepage() {
      // Assuming you have the UserType ID stored in a variable called `userTypeId`
         this.$router.push({ name: 'homepage', params: { userType: this.userType } });
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
    transition: color 0.15s ease-in-out, background-color 0.15s ease-in-out, border-color 0.15s ease-in-out, box-shadow 0.15s ease-in-out;
}
</style>
  