<%@ page contentType="text/html;charset=UTF-8" %> <%@ taglib
uri="jakarta.tags.core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <meta name="view-transition" content="same-origin" />
    <title>Books — Library Management</title>

    <!-- Modular Styles -->
    <link
      rel="stylesheet"
      href="${pageContext.request.contextPath}/styles/app.css"
    />
  </head>
  <body>
    <div class="container">
      <div class="header">
        <h1>Books</h1>
        <div class="nav-links">
          <a
            href="${pageContext.request.contextPath}/books/with-authors"
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
              <path d="M3 8h10M8 3v10" />
            </svg>
            View with Authors
          </a>
          <a
            href="${pageContext.request.contextPath}/authors"
            class="btn btn-secondary"
            >Authors</a
          >
        </div>
      </div>

      <c:if test="${not empty validationErrors}">
        <div class="alert error">
          <ul style="margin: 0; padding-left: 18px;">
            <c:forEach items="${validationErrors}" var="ve">
              <li>${ve.defaultMessage}</li>
            </c:forEach>
          </ul>
        </div>
      </c:if>
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
        <h2 class="card-title">Add New Book</h2>
        <form action="${pageContext.request.contextPath}/books" method="post">
          <div class="form-grid">
            <div class="form-group">
              <label class="form-label" for="title">Title *</label>
              <input
                type="text"
                id="title"
                name="title"
                class="form-input"
                placeholder="Enter book title"
                required
              />
            </div>
            <div class="form-group">
              <label class="form-label" for="isbn">ISBN *</label>
              <input
                type="text"
                id="isbn"
                name="isbn"
                class="form-input"
                placeholder="978-0-123456-78-9"
                required
                pattern="^[A-Za-z0-9\\-]+$"
              />
            </div>
            <div class="form-group">
              <label class="form-label" for="price">Price</label>
              <input
                type="number"
                id="price"
                step="0.01"
                name="price"
                class="form-input"
                placeholder="0.00"
                min="0"
              />
            </div>
            <div class="form-group">
              <label class="form-label" for="authorId">Author *</label>
              <select
                id="authorId"
                name="authorId"
                class="form-select"
                required
              >
                <option value="">Select an author</option>
                <c:forEach items="${authors}" var="a">
                  <option value="${a.id}">${a.name}</option>
                </c:forEach>
              </select>
            </div>
          </div>
          <button type="submit" class="btn btn-primary">Add Book</button>
        </form>
      </div>

      <div class="card">
        <h2 class="card-title">All Books</h2>

        <div class="search-wrapper">
          <svg
            class="search-icon"
            width="20"
            height="20"
            viewBox="0 0 20 20"
            fill="none"
            stroke="currentColor"
            stroke-width="2"
          >
            <circle cx="8.5" cy="8.5" r="5.5" />
            <path d="M12.5 12.5l4 4" />
          </svg>
          <input
            type="text"
            id="searchBox"
            class="search-input"
            placeholder="Search books by title, author, ISBN..."
          />
        </div>

        <div class="table-wrapper">
          <table class="table" id="booksTable">
            <thead>
              <tr>
                <th>ID</th>
                <th>Title</th>
                <th>ISBN</th>
                <th>Price</th>
                <th>Author</th>
                <th>Actions</th>
              </tr>
            </thead>
            <tbody>
              <c:forEach items="${books}" var="b">
                <tr>
                  <td>${b.id}</td>
                  <td><strong>${b.title}</strong></td>
                  <td>${b.isbn}</td>
                  <td>
                    <c:if test="${not empty b.price}">$${b.price}</c:if>
                  </td>
                  <td>${b.author.name}</td>
                  <td>
                    <a
                      href="${pageContext.request.contextPath}/books/edit/${b.id}"
                      class="table-link"
                      >Edit</a
                    >
                  </td>
                </tr>
              </c:forEach>
            </tbody>
          </table>
          <c:if test="${empty books}">
            <div class="empty-state">
              <div class="empty-state-icon">📚</div>
              <p>No books found. Add your first book above.</p>
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
        // Form validation for books
        const bookForm = document.querySelector("form[action*='/books']");
        if (bookForm) {
          bookForm.setAttribute('data-validate', 'true');
        }

        // Client-side filter for books table
        const searchBox = document.getElementById('searchBox');
        const tbodyRows = document.querySelectorAll('#booksTable tbody tr');
        if (searchBox) {
          searchBox.addEventListener('input', function (e) {
            const value = e.target.value.trim().toLowerCase();
            tbodyRows.forEach((row) => {
              const text = row.innerText.toLowerCase();
              row.style.display = text.includes(value) ? '' : 'none';
            });
          });
        }
      });
    </script>
  </body>
</html>
