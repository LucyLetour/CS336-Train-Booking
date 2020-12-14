<%@ page import="db.ApplicationDB" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <link rel="stylesheet" href="../../resources/navbar.css">
    <link rel="stylesheet" href="../../resources/base.css">
    <title>Schedule</title>
</head>
<body>

    <ul id="navbar" class="nav">
        <li class="navbar-entry"><a id="home-text" class="active" href="customerRepSuccess.jsp">Customer Rep Home</a></li>
        <li class="navbar-entry"><a href="empScheduleView.jsp">Schedules</a></li>
        <li class="navbar-entry"><a href="empReservationView.jsp">Reservations</a></li>
        <li class="navbar-entry"><a href="empQuestionView.jsp">Q & A</a></li>
        <li class="navbar-entry right-padding"><a id="logout" href="../../login/logout.jsp">Logout</a></li>
    </ul>

    <%
        try {
            ApplicationDB db = new ApplicationDB();
            Connection con = db.getConnection();

            //CURRENTLY USING A TEST TABLE, SWITCH TO BOOKINGSYSTEM.TRAIN_SCHEDULE BEFORE SUBMITTING
            String str = "SELECT * FROM richTesting.train_schedule";
            PreparedStatement ps = con.prepareStatement(str);
            ResultSet res = ps.executeQuery();

            %>
            <p> All Scheduled Trips</p>
            <table border="2" align="center">
                <thead>
                    <tr>
                        <th>Train Line</th>
                        <th> Travel Time</th>
                    </tr>
                </thead>
                <tbody>
            <%

            while (res.next()){
                %>
                <tr>
                    <td><%=res.getString("train_line")%></td>
                    <td><%=res.getString("travel_time")%></td>
                    <td>
                        <form method="post">
                            <input type="submit" value="Edit">
                            <input type="submit" value="Delete">
                        </form>
                    </td>
                </tr>
                <%
            }
            %>    </tbody>
            </table>
            <%
        }
        catch (Exception e){
            e.printStackTrace();
        }
    %>








</body>
</html>
