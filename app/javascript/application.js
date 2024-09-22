// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "@hotwired/turbo-rails"
import "controllers"

document.addEventListener("DOMContentLoaded", function() {
    const headers = document.querySelectorAll('th.sortable');

    headers.forEach(header => {
      header.addEventListener('click', function() {
        headers.forEach(h => h.classList.remove('sort-asc', 'sort-desc'));
        
        if (this.classList.contains('sort-asc')) {
          this.classList.remove('sort-asc');
          this.classList.add('sort-desc');
        } else {
          this.classList.remove('sort-desc');
          this.classList.add('sort-asc');
        }
      });
    });
  });
