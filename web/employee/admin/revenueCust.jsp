<%--
  Created by IntelliJ IDEA.
  User: root
  Date: 12/15/20
  Time: 8:23 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page import="db.ApplicationDB" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Revenue by Customer</title>
</head>
<body>

<%

    try {
        // revenue by customer
        ApplicationDB db = new ApplicationDB();
        Connection con = db.getConnection();

        String str = "SELECT * FROM passenger";
        PreparedStatement ps = con.prepareStatement(str);
        ResultSet res = ps.executeQuery();
%>


<%
    //sum revenue by customer
    String newPass =
            "SELECT cd.firstname, cd.lastname, sumF.sumFare "+
                    "FROM (SELECT p.username, sum(res.fare) sumFare "+
                    "FROM passenger p "+
                    "INNER JOIN reservation_data res "+
                    "ON p.rid = res.rid "+
                    "GROUP BY p.username) sumF "+
                    "INNER JOIN customer_data cd "+
                    "ON cd.username = sumF.username ";



    con.prepareStatement(newPass);
    ps = con.prepareStatement(newPass);
    ResultSet result = ps.executeQuery();

%>

<table border="2" align="center">
    <thead>
        <tr>
            <th>First Name</th>
            <th>Last Name</th>
            <th>Total Fare</th>
        </tr>
    </thead>
    <tbody>
        <%
            while(result.next()){
                %>
                    <tr>
                        <td><%=result.getString("firstname")%></td>
                        <td><%=result.getString("lastname")%></td>
                        <td><%=result.getInt("sumFare")%></td>
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
