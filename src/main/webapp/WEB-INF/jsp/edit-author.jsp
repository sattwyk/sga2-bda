<%@ page contentType="text/html;charset=UTF-8" %>
<html>
  <head>
    <title>Edit Author</title>
    <style>
      body {
        font-family: Arial, sans-serif;
        margin: 20px;
      }
      input[type='text'],
      input[type='email'] {
        padding: 5px;
        margin: 5px 0;
      }
      button {
        padding: 6px 12px;
        margin-top: 10px;
      }
    </style>
  </head>
  <body>
    <h2>Edit Author</h2>

    <form
      action="${pageContext.request.contextPath}/authors/update"
      method="post"
    >
      <input type="hidden" name="id" value="${authorForm.id}" />
      Name:
      <input
        type="text"
        name="name"
        value="${authorForm.name}"
        required
      /><br />
      Email:
      <input
        type="email"
        name="email"
        value="${authorForm.email}"
        required
      /><br />
      Country:
      <input type="text" name="country" value="${authorForm.country}" /><br />
      <button type="submit">Update</button>
    </form>

    <a href="${pageContext.request.contextPath}/authors">Back to list</a>
  </body>
</html>
