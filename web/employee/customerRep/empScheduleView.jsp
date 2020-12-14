<%@ page import="db.ApplicationDB" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <link rel="stylesheet" href="../../resources/navbar.css">
    <link rel="stylesheet" href="../../resources/base.css">
    <title>Schedule</title>
</head>
<body>

    <ul id="navbar" class="nav">
        <li class="navbar-entry"><a id="home-text" class="active" href="customerRepSuccess.jsp">Customer Rep Home</a></li>
        <li class="navbar-entry"><a href="empReservationView.jsp">Reservations</a></li>
        <li class="navbar-entry"><a href="empQuestionView.jsp">Q & A</a></li>
        <li class="navbar-entry right-padding"><a id="logout" href="../../login/logout.jsp">Logout</a></li>
    </ul>

    <form method="post" action="customerRepSuccess.jsp">
        <input type="submit" value="Back">
    </form>

    <form method="post" action="../../login/logout.jsp">
        <input type="submit" value="Logout">
    </form>
</body>
</html>
