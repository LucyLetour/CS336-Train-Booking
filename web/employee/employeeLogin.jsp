<%@ page contentType="text/html;charset=UTF-8" import="java.sql.Connection, java.sql.ResultSet, db.ApplicationDB, java.sql.PreparedStatement" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
    <head>
        <title>Employee Login</title>
    </head>
    <body>
        <%
        try {
            // Get the database connection
            ApplicationDB db = new ApplicationDB();
            Connection con = db.getConnection();
            // Get and prepare username
            String username = request.getParameter("username");
            username = username.trim().toLowerCase();
            // Get password attempt
            String passwordAttempt = request.getParameter("password");
            //authority level of 0 for customer service rep, authority level of 1 for admin
            int auth;
            String str = "SELECT pass,authority FROM bookingsystem.employee_data WHERE username = ?";
            PreparedStatement ps = con.prepareStatement(str);
            ps.setString(1, username);
            ResultSet result = ps.executeQuery();
            if(!result.next()) { // No result matches username (Empty result set)
                session.setAttribute("throughline", "Invalid Username, Please try again");
                response.sendRedirect("employeeIndex.jsp");
            } else {
                String password = result.getString("pass");
                if(passwordAttempt.equals(password)) {
                    auth = result.getInt("authority");
                    if (auth == 0) {
                        session.setAttribute("throughline", "Login Successful. Welcome " + username + " !");
                        auth = result.getInt("authority");
                        session.setAttribute("user", username);
                        session.setAttribute("auth",auth);
                        response.sendRedirect("customerRep/customerRepSuccess.jsp");
                    } else if (auth == 1){
                        session.setAttribute("throughline", "Login Successful. Welcome " + username + " !");
                        auth = result.getInt("authority");
                        session.setAttribute("user", username);
                        session.setAttribute("auth",auth);
                        response.sendRedirect("admin/adminSuccess.jsp");
                    } else {
                        session.setAttribute("throughline", "Invalid Authorization, Please try again");
                        response.sendRedirect("employeeIndex.jsp");
                    }
                } else {
                    session.setAttribute("throughline", "Invalid Password, Please try again");
                    response.sendRedirect("employeeIndex.jsp");
                }
                db.closeConnection(con);
            }
        } catch (Exception e) {
            e.printStackTrace();
        } %>
    </body>
</html>