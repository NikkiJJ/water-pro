import { Controller } from "@hotwired/stimulus";

// Connects to data-controller="map"
export default class extends Controller {
  static values = { apiKey: String, markers: Array };

  connect() {
    mapboxgl.accessToken = this.apiKeyValue;
    this.map = new mapboxgl.Map({
      container: this.element,
      style: "mapbox://styles/mapbox/streets-v12",
    });
    this.#addMarkersToMap();
    this.#fitMapToMarkers();
  }

  #addMarkersToMap() {
    this.markersValue.forEach((marker, index) => {
      const popupContentWithStyles = `
        <div style='background-color: #fff; border: 1px solid #ccc; border-radius: 10px; padding: 10px; width: 200px;'>
          <div style="width: 100%; text-align: center;">
            <a href='${marker.popupLink}' style='text-decoration: none; color: #000000; font-weight: bold;'>${marker.popupContent}</a>
          </div>
        </div>
      `;

      const popup = new mapboxgl.Popup().setHTML(popupContentWithStyles);
      new mapboxgl.Marker()
        .setLngLat([marker.lng, marker.lat])
        .setPopup(popup)
        .addTo(this.map);
    });
  }

  #fitMapToMarkers() {
    const bounds = new mapboxgl.LngLatBounds();
    this.markersValue.forEach((marker) => {
      bounds.extend([marker.lng, marker.lat]);
    });
    this.map.fitBounds(bounds, {});
  }
}
