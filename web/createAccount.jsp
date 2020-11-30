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
                String cpassword = request.getParameter("c_password");

                //check for existing user
                String checkStr = "SELECT * FROM login.loginsnormal WHERE username = ?;";
                PreparedStatement ps = con.prepareStatement(checkStr);
                ps.setString(1, username);
                ResultSet result = ps.executeQuery();

                if(!password.equals(cpassword)) { %>
                    <p style="color: red">Passwords do not match</p>
                    <jsp:include page="createAccountPage.jsp"/> <%
                }
                else if (result.next()){ %>
                    <p style="color: red">Account already exists</p>
                    <jsp:include page="createAccountPage.jsp"/> <%
                }
                else {

                    String str = "INSERT INTO login.loginsnormal " +
                                 "VALUES ('" + username + "', '" + password + "');";

                    Statement s = con.createStatement();
                    s.executeUpdate(str);
                    out.print("Account Creation Successful"); %>
                    <jsp:include page="index.jsp"/> <%

                    db.closeConnection(con);
                }
            } catch (Exception e) {
                e.printStackTrace();
            }
        %>
    </body>
</html>
