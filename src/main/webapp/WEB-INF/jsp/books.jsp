<%@ page contentType="text/html;charset=UTF-8" %> <%@ taglib
uri="jakarta.tags.core" prefix="c" %>
<html>
  <head>
    <title>Books</title>
    <style>
      body {
        font-family: Arial, sans-serif;
        margin: 20px;
      }
      table {
        border-collapse: collapse;
        width: 100%;
        margin-top: 20px;
      }
      th,
      td {
        border: 1px solid #ddd;
        padding: 8px;
      }
      th {
        background-color: #f2f2f2;
      }
      .success {
        color: green;
      }
      .error {
        color: red;
      }
      #searchBox {
        margin-top: 10px;
        padding: 5px;
        width: 250px;
      }
      input[type='text'],
      input[type='number'],
      select {
        padding: 5px;
        margin-right: 10px;
        margin-top: 5px;
      }
      button {
        padding: 6px 12px;
      }
    </style>

    <!-- jQuery -->
    <script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>

    <script>
      $(document).ready(function () {
        // Hide messages after 3 seconds
        setTimeout(function () {
          $('.success, .error').fadeOut('slow');
        }, 3000);

        // Filter books by table text (title / author / isbn)
        $('#searchBox').on('keyup', function () {
          const value = $(this).val().toLowerCase();
          $('#booksTable tbody tr').filter(function () {
            $(this).toggle($(this).text().toLowerCase().indexOf(value) > -1);
          });
        });

        // Simple validation for book form
        $("form[action$='/books']").on('submit', function (e) {
          const title = $("input[name='title']").val().trim();
          const authorId = $("select[name='authorId']").val();

          if (title === '' || !authorId) {
            alert('Title and Author are required.');
            e.preventDefault();
          }
        });
      });
    </script>
  </head>
  <body>
    <h2>Books</h2>

    <c:if test="${not empty successMessage}">
      <p class="success">${successMessage}</p>
    </c:if>
    <c:if test="${not empty errorMessage}">
      <p class="error">${errorMessage}</p>
    </c:if>

    <h3>Add Book</h3>
    <form action="${pageContext.request.contextPath}/books" method="post">
      Title: <input type="text" name="title" required /> ISBN:
      <input type="text" name="isbn" /> Price:
      <input type="number" step="0.01" name="price" />
      Author:
      <select name="authorId" required>
        <option value="">Select</option>
        <c:forEach items="${authors}" var="a">
          <option value="${a.id}">${a.name}</option>
        </c:forEach>
      </select>
      <button type="submit">Save</button>
    </form>

    <h3>Book List</h3>

    Search:
    <input type="text" id="searchBox" placeholder="Search by any field..." />

    <table id="booksTable">
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
            <td>${b.title}</td>
            <td>${b.isbn}</td>
            <td>${b.price}</td>
            <td>${b.author.name}</td>
            <td>
              <a href="${pageContext.request.contextPath}/books/edit/${b.id}"
                >Edit</a
              >
            </td>
          </tr>
        </c:forEach>
      </tbody>
    </table>

    <p>
      <a href="${pageContext.request.contextPath}/books/with-authors"
        >View Books with Authors (JOIN)</a
      ><br />
      <a href="${pageContext.request.contextPath}/authors">Back to Authors</a>
    </p>
  </body>
</html>
