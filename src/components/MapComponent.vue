<template>
	<div class="map-component">
		<div id="map"></div>
	</div>
</template>

<script>
import { Loader } from "@googlemaps/js-api-loader";
import cameraImage from "../assets/cctv-camera.png";
import IOTImage from "../assets/iot.png";
import api from "@/services/api.service.js";
import Hls from "hls.js";

export default {
	name: "MapsComponent",
	props: {
		traffic: {
			type: Boolean,
			default: false,
		},
		showCameras: {
			type: Boolean,
			default: false,
		},
		showIOT: {
			type: Boolean,
			default: false,
		},
		activeTab: {
			type: String,
		},
	},
	setup() {
		return {
			userType: "public",
			username: "",
			password: "",
			adminId: "",
			map: "",
			trafficLayer: "",
			cameraLayer: "",
			markerIconPath: cameraImage,
			markers: [],
			mapClickListener: null,
			cameraLocations: [
				{
					address: "215 Emily St, MountainView, CA",
					description: "Single family house with modern design",
					price: "$ 3,889,000",
					type: "home",
					bed: 5,
					bath: 4.5,
					size: 300,
					position: {
						lat: 37.362863347890716,
						lng: -121.97802139023555,
					},
				},
			],
			IOTLocations: "",
		};
	},
	mounted() {
		this.loadMap();
		this.getMarkers();
		this.getIOTMarkers();
	},
	methods: {
		getMarkers() {
			api({
				url: `/cameras`,
				method: "get",
			})
				.then((response) => {
					const responseData = response.data;
					// console.log(responseData);
					this.cameraLocations = responseData;
				})
				.catch((e) => console.log(e));
		},

		getIOTMarkers() {
			api({
				url: `/iot`,
				method: "get",
			})
				.then((response) => {
					const responseData = response.data;
					this.IOTLocations = responseData.map((x) => {
						return {
							iot_id: x.IOT_ID,
							coords: {
								lat: x.LATITUDE,
								lng: x.LONGITUDE,
							},
							details: x,
						};
					});

					// console.log(this.IOTLocations);
				})
				.catch((e) => console.log(e));
		},

		loadMap() {
			const loader = new Loader({
				apiKey: process.env.VUE_APP_MAPS_API_URL,
				version: "weekly",
				// ...additionalOptions,
			});

			loader.load().then(async () => {
				const { Map } = await google.maps.importLibrary("maps");
				const { AdvancedMarkerElement } = await google.maps.importLibrary(
					"marker"
				);
				this.map = new Map(document.getElementById("map"), {
					center: { lat: 37.43238031167444, lng: -122.16795397128632 },
					zoom: 11,
					mapId: "c81ce28bc5bf928c",
				});
			});
		},

		addMapEvent() {
			this.mapClickListener = this.onMapClick.bind(this);
			this.map.addListener("click", this.mapClickListener);
		},

		onMapClick(event) {
			const lat = event.latLng.lat();
			const lng = event.latLng.lng();
			const coord = {
				lat,
				lng,
			};
			this.$emit("chosenCoords", coord);
		},

		removeMapClickListener() {
			if (this.mapClickListener) {
				google.maps.event.clearListeners(this.map, "click");
				this.mapClickListener = null;
			}
		},

		showTraffic(show) {
			if (this.map) {
				if (show) {
					// If the traffic layer is not already set, add it
					if (!this.trafficLayer) {
						this.trafficLayer = new google.maps.TrafficLayer();
						this.trafficLayer.setMap(this.map);
					}
				} else {
					// If the traffic layer is set, remove it
					if (this.trafficLayer) {
						this.trafficLayer.setMap(null);
						this.trafficLayer = null; // Reset the trafficLayer reference
					}
				}
			} else {
				console.error("Map is not loaded yet.");
			}
		},

		toggleHighlight(markerView, property) {
			if (markerView.content.classList.contains("highlight")) {
				markerView.content.classList.remove("highlight");
				markerView.zIndex = null;
			} else {
				markerView.content.classList.add("highlight");
				markerView.zIndex = 1;
			}
		},

		buildContent(property, type) {
			const content = document.createElement("div");
			content.classList.add("property");
			if (type == "camera") {
				
				const videoId = `video-${property.camera_id}`;
				content.innerHTML = `
					<div class="marker-container">
						<img src="${cameraImage}" alt="Camera Icon" class="marker-icon" />
					</div>
					<div class="details">
						<div class="close-icon">X</div>
						<video id="${videoId}" controls></video>
					</div>
				`;
			} else {
				content.innerHTML = `
					<div class="marker-container">
						<img src="${IOTImage}" alt="Camera Icon" class="marker-icon" />
					</div>
					<div class="details">
						<div class="close-icon">X</div>
						<div class="info-container">
							<div>ID: ${property.details.IOT_ID}</div>
							<div>STATUS: ${property.details.STATUS}</div>
							<div>DISTRICT: ${property.details.DISTRICT}</div>
						</div>
					</div>
				`;
			}

			return content;
		},

		addMarkers(val, data, type) {
			if (this.map && val) {
				for (const property of data) {
					// console.log(property.coords)
					const AdvancedMarkerElement =
						new google.maps.marker.AdvancedMarkerElement({
							map: this.map,
							content: this.buildContent(property, type),
							position: {
								lat: parseFloat(property.coords.lat),
								lng: parseFloat(property.coords.lng),
							},
							title: property.camera_id,
						});

					AdvancedMarkerElement.addListener("click", () => {
						this.toggleHighlight(AdvancedMarkerElement, property);
						if (type === "camera") {
							const videoId = `video-${property.camera_id}`;
							const video = document.getElementById(videoId);
							if (Hls.isSupported()) {
								const hls = new Hls();
								hls.loadSource(property.video_url);
								hls.attachMedia(video);
							} else if (video.canPlayType("application/vnd.apple.mpegurl")) {
								video.src = property.video_url;
							}
						}
					});

					this.markers.push(AdvancedMarkerElement);
				}
			}
		},

		removeMarkers(val) {
			if (this.markers.length > 0) {
				this.markers.forEach((marker) => {
					const video = marker.content.querySelector("video");
					if (video) {
						video.pause();
						video.src = "";
						video.load();
					}
					marker.setMap(null);
				});
				this.markers = [];

				if (val === "camera") {
					if (this.showIOT) {
						this.addMarkers(true, this.IOTLocations);
					}
				} else {
					if (this.showCameras) {
						this.addMarkers(true, this.cameraLocations);
					}
				}
			}
		},
	},
	watch: {
		traffic(newVal) {
			this.showTraffic(newVal);
		},
		showCameras(newVal) {
			if (newVal) {
				this.addMarkers(newVal, this.cameraLocations, "camera");
			} else {
				this.removeMarkers("camera");
			}
		},
		showIOT(newVal) {
			if (newVal) {
				// console.log('showIOT')
				this.addMarkers(newVal, this.IOTLocations, "iot");
			} else {
				this.removeMarkers("iot");
			}
		},
		activeTab(newVal) {
			// console.log(newVal, 'iot');
			if (newVal == "cctv" || newVal == "iot") {
				this.addMapEvent();
			} else {
				this.removeMapClickListener();
			}
		},
	},
};
</script>

<style>
.map-component {
	display: flex;
	flex-direction: column;
	height: 100%;
	/* Adjust based on your layout requirements */
}

#map {
	height: 100%;
}

.search-bar-container {
	padding: 10px;
	background: #ffffff;
	box-shadow: 0 2px 6px rgba(0, 0, 0, 0.1);
}

.search-bar {
	width: 100%;
	height: 40px;
	padding: 8px 10px;
	font-size: 16px;
	border: 1px solid #ccc;
	border-radius: 4px;
	box-shadow: inset 0 1px 3px rgba(0, 0, 0, 0.05);
}

.map-placeholder {
	flex-grow: 1;
	background-color: #e0e0e0;
	display: flex;
	align-items: center;
	justify-content: center;
	color: #333;
	font-size: 24px;
	text-align: center;
}

.marker-container {
	display: flex;
	align-items: center;
	justify-content: center;
	width: 40px;
	height: 40px;
	background-color: white;
	border-radius: 50%;
	box-shadow: 0 2px 6px rgba(0, 0, 0, 0.3);
}

.marker-container-iot {
	display: flex;
	align-items: center;
	justify-content: center;
	width: 40px;
	height: 40px;
	background-color: white;
	border-radius: 50%;
	box-shadow: 0 2px 6px rgba(0, 0, 0, 0.3);
}

.marker-icon-iot {
	width: 24px;
	height: 24px;
}
.marker-icon {
	width: 24px;
	height: 24px;
}

.close-icon {
	font-size: 16px;
	display: flex;
	align-items: center;
	justify-content: center;
	background: white;
	background-color: white;
	width: 20px;
	height: 20px;
	border-radius: 50%;
	box-shadow: 0 2px 6px rgba(0, 0, 0, 0.3);
}

.property.highlight .marker-container{
  display: none;
}
.property .details {
  display: none;
  flex-direction: column;
  flex: 1;
}

.property.highlight {
  background-color: #FFFFFF;
  border-radius: 8px;
  box-shadow: 10px 10px 5px rgba(0, 0, 0, 0.2);
  padding: 8px 15px;
  width: auto;
}

.property.highlight::after {
  border-top: 9px solid #FFFFFF;
}

.property.highlight .details {
  display: flex;
}

.info-container {
	text-align: left;
	font-size: 12px;
	font-weight: 700;
}
</style>
