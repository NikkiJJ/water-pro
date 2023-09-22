function initMap() {
}
document.addEventListener('DOMContentLoaded', function () {
  const getDirectionsButton = document.getElementById('getDirectionsButton');

  getDirectionsButton.addEventListener('click', function () {

      if ("geolocation" in navigator) {

          navigator.geolocation.getCurrentPosition(function (position) {
              const userLocation = {
                  lat: position.coords.latitude,
                  lng: position.coords.longitude
              };


              const bathingSiteName = getDirectionsButton.getAttribute('data-bathing-site-name');


              const directionsURL = `https://www.google.com/maps/dir/?api=1&origin=${userLocation.lat},${userLocation.lng}&destination=${bathingSiteName}`;

              window.open(directionsURL, '_blank');
          });
      } else {

          alert("Geolocation is not supported by your browser.");
      }
  });
});
