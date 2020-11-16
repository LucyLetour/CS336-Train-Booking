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

        // Get salt and password hash from database using username
        String str = "SELECT salt, passwordhash FROM login.logins WHERE username = ?";
        PreparedStatement ps = con.prepareStatement(str);
        ps.setString(1, username);
        ResultSet result = ps.executeQuery();

        if(!result.next()) { // No result matches username (Empty result set)
            //out.print("Invalid Username, Please try again");  %>
            <p style="color: red">Invalid Password, Please try again</p>
            <jsp:include page="index.jsp"/> <%
        } else {
            int salt = result.getInt("salt");
            String passwordHash = result.getString("passwordhash");

            if(Encrypt.checkPassword(passwordAttempt, salt, passwordHash)) {
                out.print("Login Successful. Welcome " + username + "!");
                session.setAttribute("user", username); %>
                <jsp:include page="success.jsp"/> <%
            } else {
                //out.print("Invalid Password, Please try again"); %>
                <p style="color: red">Invalid Password, Please try again</p>
                <jsp:include page="index.jsp"/> <%
            }

            db.closeConnection(con);

        }
    } catch (Exception e) {
        e.printStackTrace();
    } %>
    </body>
</html>
