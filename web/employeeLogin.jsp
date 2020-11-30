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
        int auth = 0;

        String str = "SELECT pass,authority FROM login.loginsemployee WHERE username = ?";
        PreparedStatement ps = con.prepareStatement(str);
        ps.setString(1, username);
        ResultSet result = ps.executeQuery();

        if(!result.next()) { // No result matches username (Empty result set) %>
            <p style="color: red">Invalid Username, Please try again</p>
            <jsp:include page="employeeIndex.jsp"/> <%
        } else {
            String password = result.getString("pass");

            if(passwordAttempt.equals(password)) {
                auth = result.getInt("authority");
                if (auth == 0){
                    auth = result.getInt("authority");
                    out.print("Login Successful. Welcome " + username + " !");
                    session.setAttribute("user", username);
                    session.setAttribute("auth",auth);%>
                    <jsp:include page="customerRepSuccess.jsp"/> <%
                }
                else if (auth == 1){
                    auth = result.getInt("authority");
                    out.print("Login Successful. Welcome " + username + " !");
                    session.setAttribute("user", username);
                    session.setAttribute("auth",auth);%>
                    <jsp:include page="adminSuccess.jsp"/> <%
                }
                else {%>
                    <p style="color: #ff0000">Invalid Authorization, Please try again</p>
                    <jsp:include page="employeeIndex.jsp"/> <%
                }

            } else { %>
                <p style="color: #ff0000">Invalid Password, Please try again</p>
                <jsp:include page="employeeIndex.jsp"/> <%
            }

            db.closeConnection(con);
        }
    } catch (Exception e) {
        e.printStackTrace();
    } %>
    </body>
</html>
