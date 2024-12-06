// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "@hotwired/turbo-rails"
import "controllers"
import "@popperjs/core"
import "bootstrap"

document.addEventListener("DOMContentLoaded", function() {
  const fileInput = document.querySelector('input[type="file"][name="pokemon[photo]"]');
  const photoPreview = document.getElementById("photo-preview");

  if (fileInput && photoPreview) {
    fileInput.addEventListener("change", function(event) {
      const file = event.target.files[0];
      if (file) {
        const reader = new FileReader();
        reader.onload = function(e) {
          photoPreview.src = e.target.result;  // Update the preview image
        };
        reader.readAsDataURL(file);
      }
    });
  }
});
