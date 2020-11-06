<%--
  Created by IntelliJ IDEA.
  User: Blues
  Date: 11/6/2020
  Time: 2:35 AM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" import="java.sql.Connection, java.sql.Statement, java.sql.ResultSet, db.ApplicationDB, java.sql.PreparedStatement" %>

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
        //Statement stmt = con.createStatement();
        //Get the selected radio button from the index.jsp
        int id = Integer.parseInt(request.getParameter("username"));
        //Make a SELECT query from the table specified by the 'command' parameter at the index.jsp
        String str = "SELECT * FROM testtable WHERE id = ?";

        PreparedStatement ps = con.prepareStatement(str);

        ps.setInt(1, id);
        //Run the query against the database.
        ResultSet result = ps.executeQuery();
    } catch (Exception e) {
        e.printStackTrace();
    }
    %>
    </body>
</html>
