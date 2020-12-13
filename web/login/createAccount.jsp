<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page contentType="text/html;charset=UTF-8" import="java.sql.Connection, java.sql.Statement, java.sql.ResultSet, db.ApplicationDB, java.sql.PreparedStatement" %>
<%@ page import="db.Encrypt" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
    <head>
        <title>Login</title>
    </head>

    <body>
        <% try {
            //Get the database connection
            ApplicationDB db = new ApplicationDB();
            Connection con = db.getConnection();

            //get first,last,email from form and prepare it
            String first_name = request.getParameter("f_name").trim().toLowerCase();
            String last_name = request.getParameter("l_name").trim().toLowerCase();
            String email = request.getParameter("email_add").trim().toLowerCase();

            //Get the username from the form and prepare it
            String username = request.getParameter("username");
            username = username.trim().toLowerCase();
            String password = request.getParameter("password");
            String cpassword = request.getParameter("c_password");

            //check for existing user
            String checkStr = "SELECT * FROM bookingsystem.customer_data WHERE username = ?;";
            PreparedStatement ps = con.prepareStatement(checkStr);
            ps.setString(1, username);
            ResultSet result = ps.executeQuery();

            if(!password.equals(cpassword)) {
                session.setAttribute("throughline", "Passwords do not match");
                response.sendRedirect("createAccountPage.jsp");
            } else if (result.next()){
                session.setAttribute("throughline", "Account already exists");
                response.sendRedirect("createAccountPage.jsp");
            } else {
                String str = "INSERT INTO bookingsystem.customer_data " +
                        "VALUES ('" + username + "', '" + password + "', '"+ email + "', '"+ first_name +"','"+ last_name +" ');";
                Statement s = con.createStatement();
                s.executeUpdate(str);
                session.setAttribute("throughline", "Account Creation Successful");
                response.sendRedirect("../index.jsp");
                db.closeConnection(con);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        %>
    </body>
</html>