<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="view-transition" content="same-origin" />
    <title>Edit Book — Library Management</title>
    
    <!-- Modular Styles -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/styles/app.css" />
    
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
            <a href="${pageContext.request.contextPath}/books" class="back-link">
                <svg width="16" height="16" viewBox="0 0 16 16" fill="none" stroke="currentColor" stroke-width="2">
                    <path d="M10 12L6 8l4-4"/>
                </svg>
                Back to Books
            </a>
            <h1>Edit Book</h1>
            <p>Update the details of this book.</p>
        </div>

        <div class="card">
            <form action="${pageContext.request.contextPath}/books/update" method="post">
                <input type="hidden" name="id" value="${bookForm.id}" />
                
                <div class="form-grid">
                    <div class="form-group">
                        <label class="form-label" for="title">
                            Title <span class="required">*</span>
                        </label>
                        <input 
                            type="text" 
                            id="title" 
                            name="title" 
                            value="${bookForm.title}" 
                            class="form-input" 
                            placeholder="Enter book title"
                            required 
                        />
                    </div>

                    <div class="form-group">
                        <label class="form-label" for="isbn">ISBN <span class="required">*</span></label>
                        <input 
                            type="text" 
                            id="isbn" 
                            name="isbn" 
                            value="${bookForm.isbn}" 
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
                            value="${bookForm.price}" 
                            class="form-input" 
                            placeholder="0.00"
                            min="0"
                        />
                    </div>

                    <div class="form-group">
                        <label class="form-label" for="authorId">
                            Author <span class="required">*</span>
                        </label>
                        <select id="authorId" name="authorId" class="form-select" required>
                            <c:forEach items="${authors}" var="a">
                                <option value="${a.id}"
                                    <c:if test="${a.id == bookForm.author.id}">selected</c:if>>
                                    ${a.name}
                                </option>
                            </c:forEach>
                        </select>
                    </div>
                </div>

                <div class="form-actions">
                    <button type="submit" class="btn btn-primary">Save Changes</button>
                    <a href="${pageContext.request.contextPath}/books" class="btn btn-secondary">Cancel</a>
                </div>
            </form>
        </div>
    </div>

    <!-- Modular Scripts -->
    <script src="${pageContext.request.contextPath}/scripts/transitions.js"></script>
    <script src="${pageContext.request.contextPath}/scripts/app.js"></script>
    
    <!-- Page-specific script -->
    <script>
      document.addEventListener('DOMContentLoaded', function() {
        const form = document.querySelector("form[action*='/books/update']");
        if (form) {
          form.setAttribute('data-validate', 'true');
        }
      });
    </script>
</body>
</html>
