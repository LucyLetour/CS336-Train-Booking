<%@ page import="db.ApplicationDB" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <link rel="stylesheet" href="../../resources/navbar.css">
    <link rel="stylesheet" href="../../resources/base.css">
    <title>Answer Question</title>
</head>
    <body>

    <ul id="navbar" class="nav">
        <li class="navbar-entry"><a id="home-text" href="customerRepSuccess.jsp">Customer Rep Home</a></li>
        <li class="navbar-entry"><a href="empScheduleView.jsp">Schedules</a></li>
        <li class="navbar-entry"><a href="empReservationView.jsp">Reservations</a></li>
        <li class="navbar-entry"><a class="active" href="empQuestionView.jsp">Q & A</a></li>
        <li class="navbar-entry right-padding"><a id="logout" href="../../login/logout.jsp">Logout</a></li>
    </ul>

    <h2><%=request.getParameter("question")%></h2>

    <form method="post" action="processAnswer.jsp">
        <input type="hidden" name="question" value="<%=request.getParameter("question")%>">
        <input type="hidden" name="cust_user" value="<%=request.getParameter("cust_user")%>">
        <input type="hidden" name="qid" value="<%=request.getParameter("qid")%>">
        <input type="text" name="answer_text">
        <input type="submit" value="Answer">
    </form>

    <form method="post" action="empQuestionView.jsp">
        <input type="submit" value="Cancel">
    </form>


</body>
</html>
