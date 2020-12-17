<%--
  Created by IntelliJ IDEA.
  User: nicole
  Date: 12/4/20
  Time: 1:00 PM
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
    <title>Best Customer</title>
</head>
<body>

<ul id="navbar" class="nav">
    <li class="navbar-entry"><a href="adminSuccess.jsp">Admin Home</a></li>
    <li class="navbar-entry"><a id="home-text" class="active" href="bestCustomer.jsp">Best Customer</a></li>
    <li class="navbar-entry"><a href="activeLines.jsp">Active Lines</a></li>
    <li class="navbar-entry"><a href="listOfReservations.jsp">Reservations</a></li>
    <li class="navbar-entry"><a href="revenue.jsp">Revenue</a></li>
    <li class="navbar-entry"><a href="SReport.jsp">Sales Report</a></li>
    <li class="navbar-entry"><a href="customerRepEdit.jsp">Customer Rep Editing</a></li>
    <li class="navbar-entry right-padding"><a id="logout" href="../../login/logout.jsp">Logout</a></li>
</ul>
<html>

<head>
    <title>Best Customer</title>
</head>

<body>

<strong> Best Customer</strong>
<p> This is the best customer: </p>

<%

    try {
        // returns customer with most reservations
        ApplicationDB db = new ApplicationDB();
        Connection con = db.getConnection();

        String str = "SELECT * FROM passenger";
        PreparedStatement ps = con.prepareStatement(str);
        ResultSet res = ps.executeQuery();
%>


<%
    //need to return customer with most revenue created

    String newPass =
            "SELECT cd.firstname, cd.lastname, sumF.sumFare "+
            "FROM (SELECT p.username, sum(res.fare) sumFare "+
            "FROM passenger p "+
            "INNER JOIN reservation_data res "+
            "ON p.rid = res.rid "+
            "GROUP BY p.username) sumF "+
            "INNER JOIN customer_data cd "+
            "ON cd.username = sumF.username "+
            "ORDER BY sumF.sumFare desc " +
            "LIMIT 1 ";


    //join pass res_d on rid, username and fare , sum fare gb username, max select

    con.prepareStatement(newPass);
    ps = con.prepareStatement(newPass);
    ResultSet result = ps.executeQuery();
    result.next();
    String firstname= result.getString("firstname");
    String lastname = result.getString("lastname");

%>


<p> <%= firstname + " " + lastname %></p>

<%
    }
    catch (Exception e) {
        e.printStackTrace();
    }
%>

</body>

</html>