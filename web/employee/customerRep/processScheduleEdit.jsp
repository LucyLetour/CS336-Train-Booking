<%@ page import="db.ApplicationDB" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <link rel="stylesheet" href="../../resources/navbar.css">
    <link rel="stylesheet" href="../../resources/base.css">
    <title>Answer a Question</title>
</head>
<body>
<%
    // we need to modify stops_at, then train_schedule to preserve foreign key constraints

    //does nothing for now
    response.sendRedirect("empScheduleView.jsp");
%>

</body>
</html>
