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
    <title>Customer Rep Account</title>
</head>
<body>

<strong> Control Customer Rep Accounts </strong>

<p> Here you can: add, delete, and edit Customer Representative Accounts</p>

<%
    /*
    try {


        ApplicationDB db = new ApplicationDB();
        Connection con = db.getConnection();

    }
    catch (Exception e) {
        e.printStackTrace();
    }

     */
%>

</body>
</html>