<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <meta name="view-transition" content="same-origin" />
    <title>Authors — Library Management</title>

    <!-- Modular Styles -->
    <link
      rel="stylesheet"
      href="${pageContext.request.contextPath}/styles/app.css"
    />
  </head>
  <body>
    <div class="container">
      <div class="header">
        <h1>Authors</h1>
        <a
          href="${pageContext.request.contextPath}/books"
          class="btn btn-secondary"
        >
          <svg
            width="16"
            height="16"
            viewBox="0 0 16 16"
            fill="none"
            stroke="currentColor"
            stroke-width="2"
          >
            <path d="M2 4h12M2 8h12M2 12h12" />
          </svg>
          View Books
        </a>
      </div>

      <c:if test="${not empty successMessage}">
        <div class="alert success">
          <svg width="20" height="20" viewBox="0 0 20 20" fill="currentColor">
            <path
              d="M10 18a8 8 0 100-16 8 8 0 000 16zm3.707-9.293a1 1 0 00-1.414-1.414L9 10.586 7.707 9.293a1 1 0 00-1.414 1.414l2 2a1 1 0 001.414 0l4-4z"
            />
          </svg>
          ${successMessage}
        </div>
      </c:if>
      <c:if test="${not empty errorMessage}">
        <div class="alert error">
          <svg width="20" height="20" viewBox="0 0 20 20" fill="currentColor">
            <path
              d="M10 18a8 8 0 100-16 8 8 0 000 16zM8.707 7.293a1 1 0 00-1.414 1.414L8.586 10l-1.293 1.293a1 1 0 101.414 1.414L10 11.414l1.293 1.293a1 1 0 001.414-1.414L11.414 10l1.293-1.293a1 1 0 00-1.414-1.414L10 8.586 8.707 7.293z"
            />
          </svg>
          ${errorMessage}
        </div>
      </c:if>

      <div class="card">
        <h2 class="card-title">Add New Author</h2>
        <form:form
          action="${pageContext.request.contextPath}/authors"
          method="post"
          modelAttribute="authorForm"
        >
          <form:hidden path="id" />
          <div class="form-grid">
            <div class="form-group">
              <label class="form-label" for="name">Name *</label>
              <form:input
                path="name"
                id="name"
                cssClass="form-input"
                placeholder="Enter author name"
              />
              <form:errors path="name" cssClass="form-error" />
            </div>
            <div class="form-group">
              <label class="form-label" for="email">Email *</label>
              <form:input
                path="email"
                id="email"
                type="email"
                cssClass="form-input"
                placeholder="author@example.com"
              />
              <form:errors path="email" cssClass="form-error" />
            </div>
            <div class="form-group">
              <label class="form-label" for="country">Country</label>
              <form:input
                path="country"
                id="country"
                cssClass="form-input"
                placeholder="Enter country"
              />
              <form:errors path="country" cssClass="form-error" />
            </div>
          </div>
          <button type="submit" class="btn btn-primary">Add Author</button>
        </form:form>
      </div>

      <div class="card">
        <h2 class="card-title">All Authors</h2>
        <div class="table-wrapper">
          <table class="table">
            <thead>
              <tr>
                <th>ID</th>
                <th>Name</th>
                <th>Email</th>
                <th>Country</th>
                <th>Actions</th>
              </tr>
            </thead>
            <tbody>
              <c:forEach items="${authors}" var="a">
                <tr>
                  <td>${a.id}</td>
                  <td><strong>${a.name}</strong></td>
                  <td>${a.email}</td>
                  <td>
                    <c:if test="${not empty a.country}">
                      <span class="badge">${a.country}</span>
                    </c:if>
                  </td>
                  <td>
                    <a
                      href="${pageContext.request.contextPath}/authors/edit/${a.id}"
                      class="table-link"
                      >Edit</a
                    >
                  </td>
                </tr>
              </c:forEach>
            </tbody>
          </table>
          <c:if test="${empty authors}">
            <div class="empty-state">
              <div class="empty-state-icon">✍️</div>
              <p>No authors found. Add your first author above.</p>
            </div>
          </c:if>
        </div>
      </div>
    </div>

    <!-- Modular Scripts -->
    <script src="${pageContext.request.contextPath}/scripts/transitions.js"></script>
    <script src="${pageContext.request.contextPath}/scripts/app.js"></script>

    <!-- Page-specific script -->
    <script>
      document.addEventListener('DOMContentLoaded', function () {
        // Form validation for authors
        const authorForm = document.querySelector("form[action*='/authors']");
        const emailInput = document.querySelector('#email');

        // Trim whitespace on blur and improve validation
        if (emailInput) {
          emailInput.addEventListener('blur', function () {
            this.value = this.value.trim();
          });

          // Clear custom validity on input
          emailInput.addEventListener('input', function () {
            this.setCustomValidity('');
          });

          // Show custom validation message
          emailInput.addEventListener('invalid', function (e) {
            if (this.validity.typeMismatch) {
              this.setCustomValidity(
                'Please enter a valid email address (e.g., name@example.com)'
              );
            } else if (this.validity.valueMissing) {
              this.setCustomValidity('Email is required');
            } else if (this.validity.patternMismatch) {
              this.setCustomValidity(
                'Please enter a valid email address (e.g., name@example.com)'
              );
            }
          });
        }

        if (authorForm) {
          authorForm.setAttribute('data-validate', 'true');
        }
      });
    </script>
  </body>
</html>
