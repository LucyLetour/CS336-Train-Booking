<%--
  Created by IntelliJ IDEA.
  User: root
  Date: 12/15/20
  Time: 8:55 PM
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
    <title>List of Reservations by Customer</title>
</head>
<body>

<ul id="navbar" class="nav">
    <li class="navbar-entry"><a href="adminSuccess.jsp">Admin Home</a></li>
    <li class="navbar-entry"><a href="bestCustomer.jsp">Best Customer</a></li>
    <li class="navbar-entry"><a href="activeLines.jsp">Active Lines</a></li>
    <li class="navbar-entry"><a href="listOfReservations.jsp">Reservations</a></li>
    <li class="navbar-entry"><a id="home-text" class="active" href="reserveCust.jsp">Reservations Per Customer</a></li>
    <li class="navbar-entry"><a href="revenue.jsp">Revenue</a></li>
    <li class="navbar-entry"><a href="SReport.jsp">Sales Report</a></li>
    <li class="navbar-entry"><a href="customerRepEdit.jsp">Customer Rep Editing</a></li>
    <li class="navbar-entry right-padding"><a id="logout" href="../../login/logout.jsp">Logout</a></li>
</ul>
<html>
<head>
    <title>Reservations by Customer</title>
</head>
<body>
<%

    try {
        // reserves by customer
        ApplicationDB db = new ApplicationDB();
        Connection con = db.getConnection();

        String str = "SELECT * FROM passenger";
        PreparedStatement ps = con.prepareStatement(str);
        ResultSet res = ps.executeQuery();
%>


<%
    //reserves on customer
    String newPass =
            "SELECT pc.firstname, pc.lastname, pc.rid "+
            "FROM(SELECT p.username, p.rid, cd.firstname, cd.lastname "+
            "FROM passenger p "+
            "INNER JOIN customer_data cd "+
            "ON p.username = cd.username "+
            "GROUP BY p.rid) pc ";



    con.prepareStatement(newPass);
    ps = con.prepareStatement(newPass);
    ResultSet result = ps.executeQuery();

%>

<table border="2" align="center">
    <thead>
    <tr>
        <th>Customer First Name</th>
        <th>Customer Last Name</th>
        <th>Reservation Number</th>
    </tr>
    </thead>
    <tbody>
    <%
        while(result.next()){
    %>
    <tr>
        <td><%=result.getString("firstname")%></td>
        <td><%=result.getString("lastname")%></td>
        <td><%=result.getInt("rid")%></td>
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
