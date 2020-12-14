<%@ page contentType="text/html;charset=UTF-8" %>
<html>
    <head>
        <link rel="stylesheet" href="../../resources/navbar.css">
        <link rel="stylesheet" href="../../resources/base.css">
        <title>Customer Representative Account</title>
    </head>

    <body>
        <ul id="navbar" class="nav">
            <li class="navbar-entry"><a id="home-text" class="active" href="customerRepSuccess.jsp">Customer Rep Home</a></li>
            <li class="navbar-entry"><a href="empReservationView.jsp">Reservations</a></li>
            <li class="navbar-entry"><a href="empQuestionView.jsp">Q & A</a></li>
            <li class="navbar-entry right-padding"><a id="logout" href="../../login/logout.jsp">Logout</a></li>
        </ul>

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

        <form method="post" action="../../login/logout.jsp">
            <input type="submit" value="Logout">
        </form>
    </body>
</html>
