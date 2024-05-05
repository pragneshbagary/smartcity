<template>
	<div class="app-navbar">
		<ul class="navbar-menu">
			<li @click="selectOption('traffic')" :class="{ 'active': selectedOption === 'traffic' }">
				<!-- Traffic -->
				Home
			</li>
			<li v-if="userType=='governmentAdmin'" @click="selectOption('cctv')" :class="{ 'active': selectedOption === 'cctv' }">
				<!-- CCTVs -->
				Add CCTVs
			</li>
			<li v-if="userType=='governmentAdmin'" @click="selectOption('drones')" :class="{ 'active': selectedOption === 'drones' }">
				Manage CCTVs
			</li>
			<li v-if="userType=='governmentAdmin'" @click="selectOption('iot')" :class="{ 'active': selectedOption === 'iot' }">
				<!-- IOT -->
				Add IOT
			</li>
			<li v-if="userType=='governmentAdmin'" @click="selectOption('iot-station')" :class="{ 'active': selectedOption === 'iot-station' }">
				Manage IOT Station
			</li>
		</ul>
	</div>
</template>

<script>
export default {
	props: ['userType'],
	data() {
		return {
			selectedOption: 'traffic'
		};
	},
	methods: {
		selectOption(option) {
			this.selectedOption = option;
			// Emit an event with the selected option which can be handled by the parent component
			this.$emit('option-selected', option);
		},
	}
};
</script>

<style scoped>
.app-navbar {
	width: 250px;
	/* height: 100vh; */
	background-color: #2c3e50;
	/* Dark slate blue background */
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
	border-bottom: 1px solid #34495e;
	/* Slightly lighter blue for separation */
	transition: background-color 0.3s, color 0.3s;
}

.navbar-menu li:hover {
	background-color: #34495e;
	/* Lighter blue when hovered */
	color: #ecf0f1;
	/* Light grey color for text on hover */
}

.navbar-menu li.active {
  background-color: #34495e; /* Lighter blue for active tab */
  color: #ecf0f1; /* Light grey color for active tab text */
}
</style>