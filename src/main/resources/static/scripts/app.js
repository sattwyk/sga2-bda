// Shared UI utilities for alerts, forms, and search

// Auto-dismiss alerts after 3 seconds
document.addEventListener('DOMContentLoaded', function () {
  document.querySelectorAll('.alert').forEach(function (el) {
    setTimeout(() => {
      el.style.opacity = '0';
      setTimeout(() => el.remove(), 400);
    }, 3000);
  });

  // Form validation feedback (reset border on input)
  document.querySelectorAll('.form-input, .form-select').forEach(function (el) {
    el.addEventListener('input', function () {
      el.style.borderColor = '';
    });
    el.addEventListener('change', function () {
      el.style.borderColor = '';
    });
  });

  // Search input: focus/clear icon
  const search = document.querySelector('.search-input');
  if (search) {
    search.addEventListener('focus', function () {
      search.select();
    });
    // Optional: add clear button logic if needed
  }
});
