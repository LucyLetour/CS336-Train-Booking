<%--
  Created by IntelliJ IDEA.
  User: Blues
  Date: 11/6/2020
  Time: 2:35 AM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" import="java.sql.Connection, java.sql.Statement, java.sql.ResultSet, db.ApplicationDB, java.sql.PreparedStatement" %>
<%@ page import="db.Encrypt" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
    <head>
        <title>Login</title>
    </head>

    <body>
        <% try {
            // Get the database connection
            ApplicationDB db = new ApplicationDB();
            Connection con = db.getConnection();

            // Get and prepare username
            String username = request.getParameter("username");
            username = username.trim().toLowerCase();

            // Get password attempt
            String passwordAttempt = request.getParameter("password");


            String str = "SELECT pass FROM bookingsystem.customer_data WHERE username = ?";
            PreparedStatement ps = con.prepareStatement(str);
            ps.setString(1, username);
            ResultSet result = ps.executeQuery();

            if(!result.next()) { // No result matches username (Empty result set)
                session.setAttribute("throughline", "Invalid username");
                response.sendRedirect("../index.jsp");
            } else {
                String password = result.getString("pass");

                if(passwordAttempt.equals(password)) {
                    session.setAttribute("throughline", "Login Successful. Welcome " + username + "!");
                    session.setAttribute("user", username);
                    response.sendRedirect("userPage.jsp");
                } else {
                    session.setAttribute("throughline", "Invalid password");
                    response.sendRedirect("../index.jsp");
                }

                db.closeConnection(con);
            }
        } catch (Exception e) {
            e.printStackTrace();
        } %>
    </body>
</html>
