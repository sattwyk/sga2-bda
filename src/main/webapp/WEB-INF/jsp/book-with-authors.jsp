<%@ page contentType="text/html;charset=UTF-8" %> <%@ taglib
uri="jakarta.tags.core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <meta name="view-transition" content="same-origin" />
    <title>Books with Authors — Library Management</title>

    <!-- Modular Styles -->
    <link
      rel="stylesheet"
      href="${pageContext.request.contextPath}/styles/app.css"
    />
  </head>
  <body>
    <div class="container">
      <div class="header">
        <a href="${pageContext.request.contextPath}/books" class="back-link">
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
          Back to Books
        </a>
        <h1>Books with Authors</h1>
        <p>
          Showing all books joined with their authors using an inner join query.
        </p>
        <div class="info-badge">
          <svg width="16" height="16" viewBox="0 0 16 16" fill="currentColor">
            <path
              d="M8 15A7 7 0 1 1 8 1a7 7 0 0 1 0 14zm0 1A8 8 0 1 0 8 0a8 8 0 0 0 0 16z"
            />
            <path
              d="m8.93 6.588-2.29.287-.082.38.45.083c.294.07.352.176.288.469l-.738 3.468c-.194.897.105 1.319.808 1.319.545 0 1.178-.252 1.465-.598l.088-.416c-.2.176-.492.246-.686.246-.275 0-.375-.193-.304-.533L8.93 6.588zM9 4.5a1 1 0 1 1-2 0 1 1 0 0 1 2 0z"
            />
          </svg>
          SQL INNER JOIN
        </div>
      </div>

      <div class="card">
        <div class="table-wrapper">
          <table class="table">
            <thead>
              <tr>
                <th>Book Title</th>
                <th>Author Name</th>
              </tr>
            </thead>
            <tbody>
              <c:forEach items="${booksWithAuthors}" var="ba">
                <tr>
                  <td><strong>${ba.title}</strong></td>
                  <td>
                    <span class="author-badge">
                      <svg
                        width="14"
                        height="14"
                        viewBox="0 0 16 16"
                        fill="currentColor"
                      >
                        <path d="M11 6a3 3 0 1 1-6 0 3 3 0 0 1 6 0z" />
                        <path
                          d="M2 0a2 2 0 0 0-2 2v12a2 2 0 0 0 2 2h12a2 2 0 0 0 2-2V2a2 2 0 0 0-2-2H2zm12 1a1 1 0 0 1 1 1v12a1 1 0 0 1-1 1v-1c0-1-1-4-6-4s-6 3-6 4v1a1 1 0 0 1-1-1V2a1 1 0 0 1 1-1h12z"
                        />
                      </svg>
                      ${ba.authorName}
                    </span>
                  </td>
                </tr>
              </c:forEach>
            </tbody>
          </table>
          <c:if test="${empty booksWithAuthors}">
            <div class="empty-state">
              <div class="empty-state-icon">📖</div>
              <p>No books with authors found.</p>
            </div>
          </c:if>
        </div>
      </div>
    </div>

    <!-- Modular Scripts -->
    <script src="${pageContext.request.contextPath}/scripts/transitions.js"></script>
    <script src="${pageContext.request.contextPath}/scripts/app.js"></script>
  </body>
</html>
