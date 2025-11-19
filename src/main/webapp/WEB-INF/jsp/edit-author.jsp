<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <meta name="view-transition" content="same-origin" />
    <title>Edit Author — Library Management</title>

    <!-- Modular Styles -->
    <link
      rel="stylesheet"
      href="${pageContext.request.contextPath}/styles/app.css"
    />

    <style>
      /* Page-specific styles */
      .container {
        max-width: 800px;
      }
    </style>
  </head>
  <body>
    <div class="container">
      <div class="header">
        <a href="${pageContext.request.contextPath}/authors" class="back-link">
          <svg
            width="16"
            height="16"
            viewBox="0 0 16 16"
            fill="none"
            stroke="currentColor"
            stroke-width="2"
          >
            <path d="M10 12L6 8l4-4" />
          </svg>
          Back to Authors
        </a>
        <h1>Edit Author</h1>
        <p>Update the details of this author.</p>
      </div>

      <div class="card">
        <form
          action="${pageContext.request.contextPath}/authors/update"
          method="post"
        >
          <input type="hidden" name="id" value="${authorForm.id}" />

          <div class="form-grid">
            <div class="form-group">
              <label class="form-label" for="name">
                Name <span class="required">*</span>
              </label>
              <input
                type="text"
                id="name"
                name="name"
                value="${authorForm.name}"
                class="form-input"
                placeholder="Enter author name"
                required
              />
            </div>

            <div class="form-group">
              <label class="form-label" for="email">
                Email <span class="required">*</span>
              </label>
              <input
                type="email"
                id="email"
                name="email"
                value="${authorForm.email}"
                class="form-input"
                placeholder="author@example.com"
                pattern="[a-zA-Z0-9._%+\-]+@[a-zA-Z0-9.\-]+\.[a-zA-Z]{2,}"
                title="Please enter a valid email address"
                required
              />
            </div>

            <div class="form-group">
              <label class="form-label" for="country">Country</label>
              <input
                type="text"
                id="country"
                name="country"
                value="${authorForm.country}"
                class="form-input"
                placeholder="Enter country"
              />
            </div>
          </div>

          <div class="form-actions">
            <button type="submit" class="btn btn-primary">Save Changes</button>
            <a
              href="${pageContext.request.contextPath}/authors"
              class="btn btn-secondary"
              >Cancel</a
            >
          </div>
        </form>
      </div>
    </div>

    <!-- Modular Scripts -->
    <script src="${pageContext.request.contextPath}/scripts/transitions.js"></script>
    <script src="${pageContext.request.contextPath}/scripts/app.js"></script>

    <!-- Page-specific script -->
    <script>
      document.addEventListener('DOMContentLoaded', function () {
        const form = document.querySelector("form[action*='/authors/update']");
        if (form) {
          form.setAttribute('data-validate', 'true');
        }
      });
    </script>
  </body>
</html>
