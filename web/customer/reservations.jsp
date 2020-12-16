<%@ page import="db.ApplicationDB" %>
<%@ page import="java.sql.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
    <head>
        <link rel="stylesheet" href="../resources/navbar.css">
        <link rel="stylesheet" href="../resources/base.css">
        <link rel="stylesheet" href="../resources/collapsible.css">
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
        <title>My Reservations</title>
    </head>
    <body>
        <ul id="navbar" class="nav">
            <li class="navbar-entry"><a id="home-text" href="userPage.jsp">Schedule</a></li>
            <li class="navbar-entry"><a class="active" href="reservations.jsp">My Reservations</a></li>
            <li class="navbar-entry"><a href="questions.jsp">Questions</a></li>
            <li class="navbar-entry right-padding"><a id="logout" href="../login/logout.jsp">Logout</a></li>
        </ul>

        <script>
            function collapsibleOnClick(elem) {
                let content = $(elem).next();
                content.toggleClass("active");
            }
        </script>

        <% try {
            // Get the database connection
            ApplicationDB db = new ApplicationDB();
            Connection con = db.getConnection();
            PreparedStatement ps;
            ResultSet r;

            String getStationName =
                    "SELECT stationName " +
                    "FROM station_data " +
                    "WHERE sid = ?";

            String getArrTime =
                    "SELECT arrival_time " +
                    "FROM stops_at " +
                    "WHERE tid = ? and sid = ?";

            String stationsBetween =
                    "SELECT stations.stationName name " +
                    "FROM stops_at sa, station_data stations " +
                    "WHERE ? = sa.tid and stations.sid = sa.sid and sa.arrival_time >= ? and sa.departure_time <= ?";

            String userReservations =
                    "SELECT o.sid osid, d.sid dsid, rd.reservationDate resDate, t.tid tid, rd.fare fare, rd.rid rid " +
                    "FROM reservation_data rd " +
                    "INNER JOIN origin o " +
                    "ON rd.rid = o.rid " +
                    "INNER JOIN destination d " +
                    "ON d.rid = o.rid " +
                    "INNER JOIN passenger p " +
                    "ON d.rid = p.rid " +
                    "INNER JOIN trip t " +
                    "on rd.rid = t.rid " +
                    "WHERE p.username LIKE ? " +
                    "ORDER BY rd.reservationDate DESC";

            ps = con.prepareStatement(userReservations);
            ps.setString(1, (String) session.getAttribute("user"));
            r = ps.executeQuery();

            boolean pending = true;

            // pog
            while (r.next()) {
                if(r.getTimestamp("resDate").before(new java.util.Date())) pending = false;

                ps = con.prepareStatement(getStationName);
                ps.setInt(1, r.getInt("osid"));
                ResultSet temp = ps.executeQuery();
                temp.next();
                String oname = temp.getString("stationName");

                ps = con.prepareStatement(getStationName);
                ps.setInt(1, r.getInt("dsid"));
                temp = ps.executeQuery();
                temp.next();
                String dname = temp.getString("stationName");

                ps = con.prepareStatement(getArrTime);
                ps.setInt(1, r.getInt("tid"));
                ps.setInt(2, r.getInt("dsid"));
                temp = ps.executeQuery();
                temp.next();
                Timestamp arrTime = temp.getTimestamp("arrival_time");

                ps = con.prepareStatement(stationsBetween);
                ps.setInt(1, r.getInt("tid"));
                ps.setTimestamp(2, r.getTimestamp("resDate"));
                ps.setTimestamp(3, arrTime);
                temp = ps.executeQuery();

                StringBuilder intermediates = new StringBuilder(oname);
                intermediates.append(" -> ");

                while(temp.next()) {
                    intermediates.append(temp.getString("name")).append(" -> ");
                }

                String allStations = intermediates.append(dname).toString();

                %>
                <button type="button" class="collapsible" onclick="collapsibleOnClick(this.id)">Reservation <%=oname%> -> <%=dname%> on <%=r.getTimestamp("resDate")%></button>
                <div class="content, active">
                    <p><%=allStations%>, $<%=r.getFloat("fare")%></p>
                    <p><%=r.getTimestamp("resDate")%> to <%=arrTime%></p>
                    <%
                        if (pending) {
                    %>
                    <form action="deleteReservation.jsp" method="post"><input type="hidden" name="rid" value="<%=r.getInt("rid")%>"><input type="submit" value="cancel"></form>
                    <%
                        }
                    %>
                </div>
            <% }

        } catch (Exception e) {
            e.printStackTrace();
        }
        %>

    </body>
</html>
