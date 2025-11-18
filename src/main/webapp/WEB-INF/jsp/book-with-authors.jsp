<%@ page contentType="text/html;charset=UTF-8" %> <%@ taglib
uri="jakarta.tags.core" prefix="c" %>
<html>
  <head>
    <title>Books with Authors</title>
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
    </style>
  </head>
  <body>
    <h2>Books with Authors (INNER JOIN)</h2>

    <table>
      <tr>
        <th>Title</th>
        <th>Author</th>
      </tr>
      <c:forEach items="${booksWithAuthors}" var="ba">
        <tr>
          <td>${ba.title}</td>
          <td>${ba.authorName}</td>
        </tr>
      </c:forEach>
    </table>

    <a href="${pageContext.request.contextPath}/books">Back to Books</a>
  </body>
</html>
