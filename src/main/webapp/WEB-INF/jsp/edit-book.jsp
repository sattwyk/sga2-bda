<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
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
            <form:form action="${pageContext.request.contextPath}/books/update" method="post" modelAttribute="bookForm">
                <form:hidden path="id"/>
                <div class="form-grid">
                    <div class="form-group">
                        <label class="form-label" for="title">
                            Title <span class="required">*</span>
                        </label>
                        <form:input 
                            path="title"
                            id="title" 
                            cssClass="form-input" 
                            placeholder="Enter book title"
                        />
                        <form:errors path="title" cssClass="form-error"/>
                    </div>

                    <div class="form-group">
                        <label class="form-label" for="isbn">ISBN <span class="required">*</span></label>
                        <form:input 
                            path="isbn"
                            id="isbn" 
                            cssClass="form-input" 
                            placeholder="978-0-123456-78-9"
                        />
                        <form:errors path="isbn" cssClass="form-error"/>
                    </div>

                    <div class="form-group">
                        <label class="form-label" for="price">Price</label>
                        <form:input 
                            path="price"
                            id="price" 
                            type="number"
                            step="0.01" 
                            cssClass="form-input" 
                            placeholder="0.00"
                            min="0"
                        />
                        <form:errors path="price" cssClass="form-error"/>
                    </div>

                    <div class="form-group">
                        <label class="form-label" for="authorId">
                            Author <span class="required">*</span>
                        </label>
                        <form:select path="author.id" id="authorId" cssClass="form-select">
                            <form:option value="" label="Select an author"/>
                            <form:options items="${authors}" itemValue="id" itemLabel="name"/>
                        </form:select>
                        <form:errors path="author.id" cssClass="form-error"/>
                    </div>
                </div>

                <div class="form-actions">
                    <button type="submit" class="btn btn-primary">Save Changes</button>
                    <a href="${pageContext.request.contextPath}/books" class="btn btn-secondary">Cancel</a>
                </div>
            </form:form>
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
