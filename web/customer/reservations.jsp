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

        <h1> My Reservations </h1>

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
                    "WHERE ? = sa.tid and stations.sid = sa.sid and sa.arrival_time >= STR_TO_DATE(?, '%Y-%m-%d %H:%i') and sa.departure_time <= STR_TO_DATE(?, '%Y-%m-%d %H:%i')";

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
                if(r.getTimestamp("resDate").before(new java.util.Date())) {
                    pending = false;
                }

                int tid = r.getInt("tid");

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
                String arrTime = temp.getString("arrival_time");

                ps = con.prepareStatement(stationsBetween);
                ps.setInt(1, r.getInt("tid"));
                ps.setString(2, String.valueOf(r.getTimestamp("resDate")));
                ps.setString(3, arrTime);
                temp = ps.executeQuery();

                StringBuilder intermediates = new StringBuilder(oname);
                intermediates.append(" -> ");

                while(temp.next()) {
                    intermediates.append(temp.getString("name")).append(" -> ");
                }

                String allStations = intermediates.append(dname).toString();

                %>
                <button type="button" class="collapsible" >Train <%=tid%> <%=oname%> -> <%=dname%> on <%=r.getTimestamp("resDate").toLocalDateTime().toLocalDate()%></button>
                <div class="content flex-div" style>
                    <%
                        if (pending) { %>
                    <div class="cancel-div">
                        <form action="deleteReservation.jsp" method="post"><input type="hidden" name="rid" value="<%=r.getInt("rid")%>"><input type="submit" value="Cancel Reservation"></form>
                    </div>
                    <% }
                    %>

                    <div class="data-div">
                        <p><%=allStations%></p>
                        <p><%=r.getTimestamp("resDate")%> to <%=arrTime%>, $<%=r.getFloat("fare")%></p>
                    </div>


                </div>
            <% }

        } catch (Exception e) {
            e.printStackTrace();
        }
        %>

        <br>
        <br>
        <br>
        <br>

        <script>
            $( 'button' ).on('click', function () {
                $(this).toggleClass("c_active");
                let content = $(this).next();
                if (content.attr('style')){
                    content.attr('style', null);
                } else {
                    content.attr('style', 'max-height: 144px;');
                }
            });
        </script>

    </body>
</html>
