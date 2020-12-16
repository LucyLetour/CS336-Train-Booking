<%--
  Created by IntelliJ IDEA.
  User: root
  Date: 12/16/20
  Time: 12:02 AM
  To change this template use File | Settings | File Templates.
--%>
<%@ page import="db.ApplicationDB" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="javax.xml.transform.Result"%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<html>
<head>
    <title>Customer Rep Delete</title>
</head>
<body>
    <%

    try {

        // returns the 5 most active lines, im guessing by reservations per month
        ApplicationDB db = new ApplicationDB();
        Connection con = db.getConnection();

        String str= "DELETE FROM employee_data WHERE ssn=?";
        PreparedStatement pc = con.prepareStatement(str);
        pc.setString(1, request.getParameter("ssn"));
        pc.executeUpdate();
        db.closeConnection(con);

        request.sendRedirect("customerRepEdit.jsp");




    }
    catch (Exception e) {
        e.printStackTrace();
    }


    %>





</body>
</html>
