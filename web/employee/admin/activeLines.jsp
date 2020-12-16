<%--
  Created by IntelliJ IDEA.
  User: nicole
  Date: 12/4/20
  Time: 12:59 PM
  To change this template use File | Settings | File Templates.
--%>

<%@ page import="db.ApplicationDB" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="java.util.Date" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <link rel="stylesheet" href="../../resources/navbar.css">
    <link rel="stylesheet" href="../../resources/base.css">
    <title>Active Lines</title>
</head>
<body>

<ul id="navbar" class="nav">
    <li class="navbar-entry"><a id="home-text" class="active" href="activeLines.jsp">Active Lines</a></li>
    <li class="navbar-entry"><a href="bestCustomer.jsp">Best Customer</a></li>
    <li class="navbar-entry"><a href="adminSuccess.jsp">Admin Home</a></li>
    <li class="navbar-entry"><a href="listOfReservations.jsp">Reservations</a></li>
    <li class="navbar-entry"><a href="revenue.jsp">Revenue</a></li>
    <li class="navbar-entry"><a href="SReport.jsp">Sales Report</a></li>
    <li class="navbar-entry"><a href="customerRepEdit.jsp">Customer Rep Editing</a></li>
    <li class="navbar-entry right-padding"><a id="logout" href="../../login/logout.jsp">Logout</a></li>
</ul>





<strong> Active Lines</strong>
<p> These are the most 5 active lines: </p>



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
            "SELECT ts.tid, ts.train_line trainline, rtrip.rid, COUNT(ts.train_line) bitch "+
            "FROM (SELECT t.tid, r.rid, r.reservationDate "+
            "FROM reservation_data r "+
            "INNER JOIN trip t "+
            "ON r.rid = t.rid "+
            "WHERE month(r.reservationDate) = ? "+
            "GROUP BY r.rid) rtrip "+
    "INNER JOIN train_schedule ts "+
    "ON ts.tid = rtrip.tid "+
    "GROUP BY ts.train_line "+
    "ORDER BY bitch desc "+
    "LIMIT 5 ";



    con.prepareStatement(newPass);
    ps = con.prepareStatement(newPass);
    ps.setInt(1 , new Date().getMonth()+1);
    ResultSet result = ps.executeQuery();

%>



<table border="2" align="center">
    <thead>
    <tr>
        <th>Transit Line</th>
        <th>Number of Reservations</th>
    </tr>
    </thead>
    <tbody>
    <%
        while(result.next()){
    %>
    <tr>
        <td><%=result.getString("trainline")%></td>
        <td><%=result.getInt("bitch")%></td>
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