<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<html>
<head>
    <title>Edit Book</title>
    <style>
        body { font-family: Arial, sans-serif; margin: 20px; }
        input[type=text], input[type=number], select {
            padding: 5px; margin: 5px 0;
        }
        button { padding: 6px 12px; margin-top: 10px; }
    </style>

    <!-- jQuery (optional here, but if you want validation you can add it) -->
    <script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
    <script>
        $(document).ready(function () {
            $("form[action$='/books/update']").on("submit", function (e) {
                const title = $("input[name='title']").val().trim();
                const authorId = $("select[name='authorId']").val();

                if (title === "" || !authorId) {
                    alert("Title and Author are required.");
                    e.preventDefault();
                }
            });
        });
    </script>
</head>
<body>
<h2>Edit Book</h2>

<form action="${pageContext.request.contextPath}/books/update" method="post">
    <input type="hidden" name="id" value="${bookForm.id}" />
    Title: <input type="text" name="title" value="${bookForm.title}" required /><br/>
    ISBN: <input type="text" name="isbn" value="${bookForm.isbn}" /><br/>
    Price: <input type="number" step="0.01" name="price" value="${bookForm.price}" /><br/>
    Author:
    <select name="authorId" required>
        <c:forEach items="${authors}" var="a">
            <option value="${a.id}"
                <c:if test="${a.id == bookForm.author.id}">selected</c:if>>
                ${a.name}
            </option>
        </c:forEach>
    </select><br/>
    <button type="submit">Update</button>
</form>

<a href="${pageContext.request.contextPath}/books">Back to list</a>
</body>
</html>
