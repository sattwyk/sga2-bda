<%@ page contentType="text/html;charset=UTF-8" %> <%@ taglib
uri="jakarta.tags.core" prefix="c" %>
<html>
  <head>
    <title>Authors</title>
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
      input[type='text'],
      input[type='email'] {
        padding: 5px;
        margin-right: 10px;
      }
      button {
        padding: 6px 12px;
      }
    </style>

    <!-- jQuery CDN -->
    <script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>

    <script>
      $(document).ready(function () {
        // Hide success/error messages after 3 seconds
        setTimeout(function () {
          $('.success, .error').fadeOut('slow');
        }, 3000);

        // Simple client-side validation for author form
        $("form[action$='/authors']").on('submit', function (e) {
          const name = $("input[name='name']").val().trim();
          const email = $("input[name='email']").val().trim();

          if (name === '' || email === '') {
            alert('Name and Email are required.');
            e.preventDefault(); // prevent form submission
          }
        });
      });
    </script>
  </head>
  <body>
    <h2>Authors</h2>

    <c:if test="${not empty successMessage}">
      <p class="success">${successMessage}</p>
    </c:if>
    <c:if test="${not empty errorMessage}">
      <p class="error">${errorMessage}</p>
    </c:if>

    <h3>Add Author</h3>
    <form action="${pageContext.request.contextPath}/authors" method="post">
      Name: <input type="text" name="name" required /> Email:
      <input type="email" name="email" required /> Country:
      <input type="text" name="country" />
      <button type="submit">Save</button>
    </form>

    <h3>Author List</h3>
    <table>
      <tr>
        <th>ID</th>
        <th>Name</th>
        <th>Email</th>
        <th>Country</th>
        <th>Actions</th>
      </tr>
      <c:forEach items="${authors}" var="a">
        <tr>
          <td>${a.id}</td>
          <td>${a.name}</td>
          <td>${a.email}</td>
          <td>${a.country}</td>
          <td>
            <a href="${pageContext.request.contextPath}/authors/edit/${a.id}"
              >Edit</a
            >
          </td>
        </tr>
      </c:forEach>
    </table>

    <p>
      <a href="${pageContext.request.contextPath}/books">Go to Books</a>
    </p>
  </body>
</html>
