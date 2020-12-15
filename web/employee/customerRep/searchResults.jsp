<%@ page import="db.ApplicationDB" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.ArrayList" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <link rel="stylesheet" href="../../resources/navbar.css">
    <link rel="stylesheet" href="../../resources/base.css">
    <title>Search Results</title>
</head>
<body>

<ul id="navbar" class="nav">
    <li class="navbar-entry"><a id="home-text" class="active" href="customerRepSuccess.jsp">Customer Rep Home</a></li>
    <li class="navbar-entry"><a href="empScheduleView.jsp">Schedules</a></li>
    <li class="navbar-entry"><a href="empReservationView.jsp">Reservations</a></li>
    <li class="navbar-entry"><a href="empQuestionView.jsp">Q & A</a></li>
    <li class="navbar-entry right-padding"><a id="logout" href="../../login/logout.jsp">Logout</a></li>
</ul>

<h1>R E S U L T S</h1>

</body>
</html>
