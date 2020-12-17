<%--
  Created by IntelliJ IDEA.
  User: nicole
  Date: 12/4/20
  Time: 1:01 PM
  To change this template use File | Settings | File Templates.
--%>

<%@ page import="db.ApplicationDB" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <link rel="stylesheet" href="../../resources/navbar.css">
    <link rel="stylesheet" href="../../resources/base.css">
    <title>List of Reservations</title>
</head>
<body>

<ul id="navbar" class="nav">
    <li class="navbar-entry"><a href="adminSuccess.jsp">Admin Home</a></li>
    <li class="navbar-entry"><a href="bestCustomer.jsp">Best Customer</a></li>
    <li class="navbar-entry"><a href="activeLines.jsp">Active Lines</a></li>
    <li class="navbar-entry"><a id="home-text" class="active" href="listOfReservations.jsp">Reservations</a></li>
    <li class="navbar-entry"><a href="revenue.jsp">Revenue</a></li>
    <li class="navbar-entry"><a href="SReport.jsp">Sales Report</a></li>
    <li class="navbar-entry"><a href="customerRepEdit.jsp">Customer Rep Editing</a></li>
    <li class="navbar-entry right-padding"><a id="logout" href="../../login/logout.jsp">Logout</a></li>
</ul>
<html>

<head>
    <title>Reservations</title>
</head>

<body>

<strong> Reservations by Customer Name or Transit Line</strong>
<form method="post" action="reserveCust.jsp">
    <input type="submit" value="Reservations By Customer Name">
</form>
<form method="post" action="reserveTrains.jsp">
    <input type="submit" value="Reservations By Transit Line">
</form>

</body>

</html>
