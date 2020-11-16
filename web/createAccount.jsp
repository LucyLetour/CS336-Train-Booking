<%@ page contentType="text/html;charset=UTF-8" language="java" %>
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
                //Get the database connection
                ApplicationDB db = new ApplicationDB();
                Connection con = db.getConnection();

                //Get the username from the form and prepare it
                String username = request.getParameter("username");
                username = username.trim().toLowerCase();

                String password = request.getParameter("password");

                // Create a new salt that will be tied to this account
                int salt = Encrypt.getNewSalt();

                // Create a new user using the username, salt, and password (Encrypted and salted)
                String str = "INSERT INTO login.logins " +
                             "VALUES ('" + username + "', '" + salt + "', '" + Encrypt.hashNewPassword(salt, password) + "');";

                Statement s = con.createStatement();
                s.executeUpdate(str); %>
                <jsp:include page="index.jsp"/> <%

                db.closeConnection(con);
            } catch (Exception e) {
                e.printStackTrace();
            }
        %>
    </body>
</html>
