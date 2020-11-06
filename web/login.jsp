<%--
  Created by IntelliJ IDEA.
  User: Blues
  Date: 11/6/2020
  Time: 2:35 AM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" import="" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.Statement" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="db.ApplicationDB" %>
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

        //Create a SQL statement
        Statement stmt = con.createStatement();
        //Get the selected radio button from the index.jsp
        String entity = request.getParameter("command");
        //Make a SELECT query from the table specified by the 'command' parameter at the index.jsp
        String str = "SELECT * FROM " + entity;
        //Run the query against the database.
        ResultSet result = stmt.executeQuery(str);
    } catch (Exception e) {
        e.printStackTrace();
    }
    %>
    </body>
</html>
