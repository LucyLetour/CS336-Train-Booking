<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Customer Representative Account</title>
</head>
<body>
<h1 style="font-family: 'Comic Sans MS',serif; font-size: 4em">Customer Service Representative Dashboard</h1>

<form method="post" action="empReservationView.jsp">
    <input type="submit" value="View Reservations">
</form>
<form method="post" action="empQuestionView.jsp">
    <input type="submit" value="Questions and Answers">
</form>

<form method="post" action="empScheduleView.jsp">
    <input type="submit" value="Schedule">
</form>

<form method="post" action="logout.jsp">
    <input type="submit" value="Logout">
</form>
</body>
</html>
