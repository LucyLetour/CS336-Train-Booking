<%@ page import="db.ApplicationDB" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <link rel="stylesheet" href="../../resources/navbar.css">
    <link rel="stylesheet" href="../../resources/base.css">
    <title>Update Rep</title>
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

<form method="post" action="processUpdateRep.jsp">
    <input type="hidden" name="ssn" value="<%=request.getParameter("ssn")%>">
    <label for="fname">First Name: </label>
    <input type="text" id="fname" name="fname" value="<%=request.getParameter("fname")%>">
    <br>
    <label for="lname">Last Name: </label>
    <input type="text" id="lname" name="lname" value="<%=request.getParameter("lname")%>">
    <br>
    <label for="user">Username: </label>
    <input type="text" id="user" name="user" value="<%=request.getParameter("user")%>">
    <br>
    <label for="pass">Password: </label>
    <input type="text" id="pass" name="pass" value="<%=request.getParameter("pass")%>">
    <br>
    <label for="auth">Authority level: </label>
    <input type="text" id="auth" name="auth" value="<%=request.getParameter("auth")%>">
    <br>
    <input type="submit" value="Update">
</form>
<br>
<form method="post" action="customerRepEdit.jsp">
    <input type="submit" value="Cancel">
</form>



<%

%>







</body>
</html>
