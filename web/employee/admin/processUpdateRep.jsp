<%@ page import="db.ApplicationDB" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Process</title>
</head>
<body>
<%
    try{
        ApplicationDB db = new ApplicationDB();
        Connection con = db.getConnection();

        String tid = request.getParameter("tid");


        String del = "UPDATE bookingsystem.employee_data SET username= ?, pass=?, firstname=?, lastname=?, authority=0 WHERE ssn = ?";
        PreparedStatement ps = con.prepareStatement(del);
        ps.setString(1,request.getParameter("user"));
        ps.setString(2,request.getParameter("pass"));
        ps.setString(3,request.getParameter("fname"));
        ps.setString(4,request.getParameter("lname"));
        ps.setString(5,request.getParameter("ssn"));
        ps.executeUpdate();

        db.closeConnection(con);
        response.sendRedirect("customerRepEdit.jsp");
    }
    catch (Exception e){
        e.printStackTrace();
    }

%>








</body>
</html>
