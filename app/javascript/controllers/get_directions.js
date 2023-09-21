document.addEventListener('DOMContentLoaded', function () {
  const getDirectionsButton = document.getElementById('getDirectionsButton');

  getDirectionsButton.addEventListener('click', function () {

      if ("geolocation" in navigator) {

          navigator.geolocation.getCurrentPosition(function (position) {
              const userLocation = {
                  lat: position.coords.latitude,
                  lng: position.coords.longitude
              };


              const bathingSiteLocation = {
                  lat: 51.5074,
                  lng: -0.1278
              };


              const directionsURL = `https://www.google.com/maps/dir/?api=1&origin=${userLocation.lat},${userLocation.lng}&destination=${bathingSiteLocation.lat},${bathingSiteLocation.lng}`;


              window.open(directionsURL, '_blank');
          });
      } else {

          alert("Geolocation is not supported by your browser.");
      }
  });
});
