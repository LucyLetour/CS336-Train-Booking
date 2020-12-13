<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
        <title>Login</title>
    </head>

    <body>
        <h1>Welcome to</h1><h1 style="font-family: 'Comic Sans MS',serif; font-size: 4em">T R A I N</h1>
        <br>

        <%
            if(session.getAttribute("throughline") != null) {
                out.print(session.getAttribute("throughline"));
            }
        %>

        <form method="post" action="login/login.jsp">
            <table>
                <tr>
                    <td>Username: </td><td><input type="text" name="username"></td>
                </tr>
                <tr>
                    <td>Password: </td><td><input type="password" name="password"></td>
                </tr>
            </table>
            <input type="submit" value="Login">
        </form>
        <form method="post" action="login/createAccountPage.jsp">
            <input type="submit" value="Create Account">
        </form>
        <form method="post" action="employee/employeeIndex.jsp">
            <input type="submit" value="Employee Login Portal">
        </form>
    </body>
</html>