import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="get-directions"
export default class extends Controller {
  connect() {
    console.log("hello")
    const getDirectionsButton = document.getElementById('getDirectionsButton');

    getDirectionsButton.addEventListener('click', function () {
      if ("geolocation" in navigator) {
        navigator.geolocation.getCurrentPosition(function (position) {
          const userLocation = {
            lat: position.coords.latitude,
            lng: position.coords.longitude
          };

          const destinationLat = getDirectionsButton.getAttribute('data-destination-lat');
          const destinationLng = getDirectionsButton.getAttribute('data-destination-lng');

          const directionsURL = `https://www.google.com/maps/dir/?api=1&origin=${userLocation.lat},${userLocation.lng}&destination=${destinationLat},${destinationLng}`;

          window.open(directionsURL, '_blank');
        });
      } else {
        alert("Geolocation is not supported by your browser.");
      }
    });
  }
}
