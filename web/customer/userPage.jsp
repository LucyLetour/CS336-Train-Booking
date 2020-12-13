<%@ page import="db.ApplicationDB" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
    <head>
        <link rel="stylesheet" href="../resources/navbar.css">
        <link rel="stylesheet" href="../resources/base.css">
        <title>My Home</title>
    </head>

    <body>

        <ul id="navbar" class="nav">
            <li class="navbar-entry"><a id="home-text" class="active" href="userPage.jsp">Schedule</a></li>
            <li class="navbar-entry"><a href="reservations.jsp">My Reservations</a></li>
            <li class="navbar-entry"><a href="questions.jsp">Questions</a></li>
            <li class="navbar-entry right-padding"><a id="logout" href="../login/logout.jsp">Logout</a></li>
        </ul>
        <br>
        <%
            out.print("Welcome, " + session.getAttribute("user"));
        %>
        <br>
        <form action="userPage.jsp" method="GET">
            <label for="origin">Origin Station:</label>
            <input type="text" id="origin">
            <label for="dest">Destination Station:</label>
            <input type="text" id="dest">
            <label for="dtime">Departure Time:</label>
            <input type="datetime-local" id="dtime">
            <input type="submit" value="Search">
        </form>

        <!-- Generate table with all valid train schedules -->

        <% try {
            // Get the database connection
            ApplicationDB db = new ApplicationDB();
            Connection con = db.getConnection();

            // Get and prepare username
            String username = request.getParameter("username");
            username = username.trim().toLowerCase();

            // Get password attempt
            String passwordAttempt = request.getParameter("password");


            String str = "SELECT ? FROM bookingsystem.reservation_data";
            PreparedStatement ps = con.prepareStatement(str);
            ps.setString(1, username);
            ResultSet result = ps.executeQuery();

            if(!result.next()) { // No result matches username (Empty result set)
            session.setAttribute("throughline", "Invalid username");
            response.sendRedirect("../index.jsp");
            } else {
            String password = result.getString("pass");

            if(passwordAttempt.equals(password)) {
            session.setAttribute("throughline", "Login Successful. Welcome " + username + "!");
            session.setAttribute("user", username);
            response.sendRedirect("../customer/userPage.jsp");
            } else {
            session.setAttribute("throughline", "Invalid password");
            response.sendRedirect("../index.jsp");
            }

            db.closeConnection(con);
            }
            } catch (Exception e) {
            e.printStackTrace();
            } %>
    </body>
</html>
