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


            String str = "SELECT * FROM bookingsystem.train_schedule";
            PreparedStatement ps = con.prepareStatement(str);
            ResultSet res = ps.executeQuery();

            %>
            <p> All Scheduled Trips</p>
            <table border="2" align="center">
                <thead>
                    <tr>
                        <th>Train Line </th>
                        <th> Origin </th>
                        <th> Destination </th>
                        <th> Travel Time </th>
                    </tr>
                </thead>
                <tbody>
            <%

            while (res.next()){
                String line = res.getString("train_line");
                String travel_time = res.getString("travel_time");
                String tid = res.getString("tid");

                String str_orig = "SELECT s.stationName FROM bookingsystem.station_data s, bookingsystem.train_schedule t, bookingsystem.stops_at st WHERE t.tid = st.tid AND s.sid = st.sid AND st.is_origin=1 AND st.tid=?";
                PreparedStatement ps_orig = con.prepareStatement(str_orig);
                ps_orig.setString(1,tid);
                ResultSet res_orig = ps_orig.executeQuery();

                String dest = "default";
                String origin = "default";

                if (res_orig.next()){
                    //get name of origin station
                    origin = res_orig.getString("stationName");
                }

                String str_dest = "SELECT s.stationName FROM bookingsystem.station_data s, bookingsystem.train_schedule t, bookingsystem.stops_at st WHERE t.tid = st.tid AND s.sid = st.sid AND st.is_dest=1 AND st.tid=?";
                PreparedStatement ps_dest = con.prepareStatement(str_dest);
                ps_dest.setString(1,tid);
                ResultSet res_dest = ps_dest.executeQuery();

                if (res_dest.next()){
                    dest = res_dest.getString("stationName");
                }

                %>
                <tr>
                    <td><%=line%></td>
                    <td><%=origin%></td>
                    <td><%=dest%></td>
                    <td><%=travel_time%></td>
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
