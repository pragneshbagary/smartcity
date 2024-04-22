<template>
  <div class="map-component">
    <div id="map"></div>
  </div>
</template>

<script>
import { Loader } from "@googlemaps/js-api-loader"
import cameraImage from '../assets/cctv-camera.png';
import api from "@/services/api.service.js";

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
    activeTab: {
      type: String
    }
  },
  setup() {
    return {
      userType: 'public',
      username: '',
      password: '',
      adminId: '',
      map: '',
      trafficLayer: '',
      cameraLayer: '',
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
    };
  },
  mounted() {
    this.loadMap();
    this.getMarkers();
  },
  methods: {

    getMarkers() {
      api({
				url: `/cameras`,
				method: "get"
			})
				.then(response => {
					const responseData = response.data;
          console.log(responseData);
          this.cameraLocations = responseData
				})
				.catch(e => console.log(e));
    },

    loadMap() {
      const loader = new Loader({
        apiKey: process.env.VUE_APP_MAPS_API_URL,
        version: "weekly",
        // ...additionalOptions,
      });

      loader.load().then(async () => {
        const { Map } = await google.maps.importLibrary("maps");
        const { AdvancedMarkerElement } = await google.maps.importLibrary("marker");
        this.map = new Map(document.getElementById("map"), {
          center: { lat: 37.43238031167444, lng: -122.16795397128632 },
          zoom: 11,
          mapId: 'c81ce28bc5bf928c'
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
        lng
      }
      this.$emit('chosenCoords', coord);
    },

    removeMapClickListener() {
      if (this.mapClickListener) {
        google.maps.event.clearListeners(this.map, 'click');
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

    buildContent(property) {
      const content = document.createElement("div");

      content.classList.add("property");
      content.innerHTML = `
      <div class="marker-container">
        <img src="${cameraImage}" alt="Camera Icon" class="marker-icon" />
      </div>
      `;

      return content
    },

    addMarkers() {
      if (this.map && this.showCameras) {
        for (const property of this.cameraLocations) {
          console.log(property.coords)
          const AdvancedMarkerElement = new google.maps.marker.AdvancedMarkerElement({
            map: this.map,
            content: this.buildContent(property),
            position: {
              lat: parseFloat(property.coords.lat),
              lng: parseFloat(property.coords.lng)
            },
            title: property.camera_id
          });

          AdvancedMarkerElement.addListener("click", () => {
            this.toggleHighlight(AdvancedMarkerElement, property);
          });

          this.markers.push(AdvancedMarkerElement);
        }
      }
    },

    removeMarkers() {
      if (this.markers.length > 0) {
        this.markers.forEach((marker) => {
          marker.setMap(null);
        });
        this.markers = [];
      }
    },

  },
  watch: {
    traffic(newVal) {
      this.showTraffic(newVal);
    },
    showCameras(newVal) {
      if (newVal) {
        this.addMarkers();
      } else {
        this.removeMarkers();
      }
    },
    activeTab(newVal) {
      if(newVal == 'cctv') {
        this.addMapEvent();
      } else {
        this.removeMapClickListener()
      }
    }
  }

}
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

.marker-icon {
  width: 24px;
  height: 24px;
}
</style>
