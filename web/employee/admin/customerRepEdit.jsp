<%@ page import="db.ApplicationDB" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="javax.xml.transform.Result" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <link rel="stylesheet" href="../../resources/navbar.css">
    <link rel="stylesheet" href="../../resources/base.css">
    <title>Customer Rep</title>
</head>
<body>

<ul id="navbar" class="nav">
    <li class="navbar-entry"><a id="home-text" class="active" href="customerRepEdit.jsp">Customer Rep Editing</a></li>
    <li class="navbar-entry"><a href="bestCustomer.jsp">Best Customer</a></li>
    <li class="navbar-entry"><a href="activeLines.jsp">Active Lines</a></li>
    <li class="navbar-entry"><a href="listOfReservations.jsp">Reservations</a></li>
    <li class="navbar-entry"><a href="revenue.jsp">Revenue</a></li>
    <li class="navbar-entry"><a href="SReport.jsp">Sales Report</a></li>
    <li class="navbar-entry"><a href="adminSuccess.jsp">Admin Home</a></li>
    <li class="navbar-entry right-padding"><a id="logout" href="../../login/logout.jsp">Logout</a></li>
</ul>

<strong> Control Customer Rep Accounts </strong>

<p> Here you can: add, delete, and edit Customer Representative Accounts</p>

<%
    try {


        ApplicationDB db = new ApplicationDB();
        Connection con = db.getConnection();
    %>
        <table border="2" align="center">
        <thead>
        <tr>
            <th>Username</th>
        </tr>
        </thead>
        <tbody>

        <%
          String str= "SELECT * FROM employee_data";
          PreparedStatement ps= con.prepareStatement(str);
          ResultSet res= ps.executeQuery();

          while(res.next()){
              %>
                <tr>
                    <td><%= res.getString("username")%></td>
                <td>
                <form method="post" action= "repUpdateForm.jsp">
                <input type="hidden" name="ssn" value="<%= res.getString("ssn")%>">
                <input type="hidden" name="fname" value="<%=res.getString("firstname")%>">
                <input type="hidden" name="lname" value="<%=res.getString("lastname")%>">
                <input type="hidden" name="user" value="<%=res.getString("username")%>">
                <input type="hidden" name="pass" value="<%=res.getString("pass")%>">
                <input type="hidden" name="auth" value="<%=res.getString("authority")%>">
                <input type="submit" value="Edit">
                </form>
                </td>

                <td>
                <form method="post" action= "crDel.jsp">
                <input type="hidden" name="ssn" value="<%= res.getString("ssn")%>">
                <input type="submit" value="Delete">
                </form>
                </td>
                </tr>
        <%

          }

        %>
        </tbody>
        </table>


<%
    }
    catch (Exception e) {
        e.printStackTrace();
    }


%>

</body>
</html>