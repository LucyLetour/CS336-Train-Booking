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
    <title>List of Reservations by Transit Line</title>
</head>
<body>

<ul id="navbar" class="nav">
    <li class="navbar-entry"><a href="adminSuccess.jsp">Admin Home</a></li>
    <li class="navbar-entry"><a href="bestCustomer.jsp">Best Customer</a></li>
    <li class="navbar-entry"><a href="listOfReservations.jsp">Reservations</a></li>
    <li class="navbar-entry"><a href="activeLines.jsp">Active Lines</a></li>
    <li class="navbar-entry"><a id="home-text" class="active" href="reserveTrains.jsp">Reservations Per Transit Line</a></li>
    <li class="navbar-entry"><a href="revenue.jsp">Revenue</a></li>
    <li class="navbar-entry"><a href="SReport.jsp">Sales Report</a></li>
    <li class="navbar-entry"><a href="customerRepEdit.jsp">Customer Rep Editing</a></li>
    <li class="navbar-entry right-padding"><a id="logout" href="../../login/logout.jsp">Logout</a></li>
</ul>
<html>
<head>
    <title>Revenue by Transit Line</title>
</head>
<body>
<%

    try {
        // reserves by customer
        ApplicationDB db = new ApplicationDB();
        Connection con = db.getConnection();

        String str = "SELECT * FROM train_schedule";
        PreparedStatement ps = con.prepareStatement(str);
        ResultSet res = ps.executeQuery();
%>


<%
    //reserves on train line
    String newPass =
            "SELECT ts.tid, ts.train_line, rtrip.rid " +
                    "FROM (SELECT t.tid, r.rid " +
                    "        FROM reservation_data r " +
                    "        INNER JOIN trip t " +
                    "        ON r.rid = t.rid " +
                    "        GROUP BY r.rid) rtrip " +
                    "INNER JOIN train_schedule ts " +
                    "ON ts.tid = rtrip.tid ";



    con.prepareStatement(newPass);
    ps = con.prepareStatement(newPass);
    ResultSet result = ps.executeQuery();

%>

<table border="2" align="center">
    <thead>
    <tr>
        <th>Transit Line</th>
        <th>Reservation Number</th>
    </tr>
    </thead>
    <tbody>
    <%
        while(result.next()){
    %>
    <tr>
        <td><%=result.getString("train_line")%></td>
        <td><%=result.getInt("rtrip.rid")%></td>
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
