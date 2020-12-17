<%--
  Created by IntelliJ IDEA.
  User: nicole
  Date: 12/4/20
  Time: 12:57 PM
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
    <title>Sales Report</title>
</head>
<body>

<ul id="navbar" class="nav">
    <li class="navbar-entry"><a href="adminSuccess.jsp">Admin Home</a></li>
    <li class="navbar-entry"><a href="bestCustomer.jsp">Best Customer</a></li>
    <li class="navbar-entry"><a href="activeLines.jsp">Active Lines</a></li>
    <li class="navbar-entry"><a href="listOfReservations.jsp">Reservations</a></li>
    <li class="navbar-entry"><a href="revenue.jsp">Revenue</a></li>
    <li class="navbar-entry"><a id="home-text" class="active" href="SReport.jsp">Sales Report</a></li>
    <li class="navbar-entry"><a href="customerRepEdit.jsp">Customer Rep Editing</a></li>
    <li class="navbar-entry right-padding"><a id="logout" href="../../login/logout.jsp">Logout</a></li>
</ul>
<html>

<head>
    <title>Sales Report</title>
</head>

<body>

<strong> Sales Report</strong>
<p> Here is the sales report per month: </p>

<%

    try {

        // sales report per month
        ApplicationDB db = new ApplicationDB();
        Connection con = db.getConnection();

        String str = "SELECT * FROM passenger";
        PreparedStatement ps = con.prepareStatement(str);
        ResultSet res = ps.executeQuery();
%>

<%
    String newPass =
            "SELECT month(reservationDate) m, sum(fare) f "+
            "FROM reservation_data rd "+
            "GROUP BY m ";




    con.prepareStatement(newPass);
    ps = con.prepareStatement(newPass);
    ResultSet result = ps.executeQuery();

%>

<table border="2" align="center">
    <thead>
    <tr>
        <th>Month</th>
        <th>Fare</th>
    </tr>
    </thead>
    <tbody>
    <%
        while(result.next()){
    %>
    <tr>
        <td><%=result.getString("m")%></td>
        <td><%=result.getFloat("f")%></td>
    </tr>
    <%
        }
    %>
    </tbody>
</table>

<%
    }
    catch (Exception e) {
        e.printStackTrace();
    }
%>

</body>

</html>

