<%@ page import="db.ApplicationDB" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Process</title>
</head>
<body>

<%
    try{
        //check if exists

        ApplicationDB db = new ApplicationDB();
        Connection con = db.getConnection();

        String v = "SELECT * FROM bookingsystem.employee_data WHERE SSN = ?";
        PreparedStatement ps = con.prepareStatement(v);
        ps.setString(1,request.getParameter("ssn"));
        ResultSet res = ps.executeQuery();

        if (res.next()){
            //cannot create account
            session.setAttribute("user_status", "Account Creation Failed - User SSN already exists");
        }
        else if (request.getParameter("ssn").length() > 11){
            session.setAttribute("user_status","Account Creation Failed - Invalid SSN Length");
        }
        else{
            //create account
            String ins = "INSERT INTO bookingsystem.employee_data VALUES (?,?,?,?,?,0)";
            PreparedStatement ps_insert = con.prepareStatement(ins);
            ps_insert.setString(1,request.getParameter("user"));
            ps_insert.setString(2,request.getParameter("pass"));
            ps_insert.setString(3,request.getParameter("ssn"));
            ps_insert.setString(4,request.getParameter("fname"));
            ps_insert.setString(5,request.getParameter("lname"));
            ps_insert.executeUpdate();
            session.setAttribute("user_status", "Account Creation Success");
        }



    db.closeConnection(con);
    response.sendRedirect("customerRepEdit.jsp");
    }
    catch (Exception e){
        e.printStackTrace();
    }
%>










</body>
</html>
