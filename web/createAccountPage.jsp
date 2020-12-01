<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
        <title>Login</title>
    </head>

    <body>
        <br>
        <form method="post" action="createAccount.jsp">
            <table>
                <tr>
                    <td>First Name: </td><td><input type="text" name="f_name"></td>
                </tr>
                <tr>
                    <td>Last Name: </td><td><input type="text" name="l_name"></td>
                </tr>
                <tr>
                    <td>Email: </td><td><input type="text" name="email_add"></td>
                </tr>
                <tr>
                    <td>Username: </td><td><input type="text" name="username"></td>
                </tr>
                <tr>
                    <td>Password: </td><td><input type="text" name="password"></td>
                </tr>
                <tr>
                    <td>Confirm Password: </td><td><input type="text" name="c_password"></td>
                </tr>

            </table>
            <input type="submit" value="Create account">
        </form>
        <form method="post" action="index.jsp">
            <input type="submit" value="Home">
        </form>
    </body>
</html>