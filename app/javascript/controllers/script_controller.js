import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="script"
export default class extends Controller {
  connect() {
    const text = "Discover the water quality near you...";
const textElement = document.getElementById("text");

let index = 0;

function type() {
  if (index < text.length) {
    textElement.textContent += text.charAt(index);
    index++;
    setTimeout(type, 50); // Adjust the typing speed here (in milliseconds)
  }
}

type(); // Start typing when the page loads
  }
}
