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
    <title>Revenue by Transit Line</title>
</head>
<body>
<%

    try {
        // revenue by customer
        ApplicationDB db = new ApplicationDB();
        Connection con = db.getConnection();

        String str = "SELECT * FROM train_schedule";
        PreparedStatement ps = con.prepareStatement(str);
        ResultSet res = ps.executeQuery();
%>


<%
    //sum revenue by transit line
    String newPass =
            "SELECT ts.train_line, sum(ts.fare) sumFare "+
                "FROM train_schedule ts "+
                "GROUP BY ts.train_line ";


    con.prepareStatement(newPass);
    ps = con.prepareStatement(newPass);
    ResultSet result = ps.executeQuery();

%>

<table border="2" align="center">
    <thead>
    <tr>
        <th>Transit Line</th>
        <th>Total Revenue</th>
    </tr>
    </thead>
    <tbody>
    <%
        while(result.next()){
    %>
    <tr>
        <td><%=result.getString("train_line")%></td>
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
