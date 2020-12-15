
<%@ page import="db.ApplicationDB" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <link rel="stylesheet" href="../../resources/navbar.css">
    <link rel="stylesheet" href="../../resources/base.css">
    <title>Answer Question</title>
</head>
<body>

<ul id="navbar" class="nav">
    <li class="navbar-entry"><a id="home-text" class="active" href="adminSuccess.jsp">Admin Home</a></li>
    <li class="navbar-entry"><a href="bestCustomer.jsp">Best Customer</a></li>
    <li class="navbar-entry"><a href="activeLines.jsp">Active Lines</a></li>
    <li class="navbar-entry"><a href="listOfReservations.jsp">Reservations</a></li>
    <li class="navbar-entry"><a href="revenue.jsp">Revenue</a></li>
    <li class="navbar-entry"><a href="SReport.jsp">Sales Report</a></li>
    <li class="navbar-entry"><a href="customerRepEdit.jsp">Customer Rep Editing</a></li>
    <li class="navbar-entry right-padding"><a id="logout" href="../../login/logout.jsp">Logout</a></li>
</ul>
<html>
<head>
    <title>Admin Account</title>
</head>
<body>

<strong> Admin Home Page </strong>

<p> Welcome Admin Employee to the Admin Home Page.</p>
<p> Here you can: Find active lines, edit add and delete customer rep accounts, find the best customer, get a list of reservations, get the revenue, and get a sales report.</p>


</body>
</html>
