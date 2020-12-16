<%@ page import="db.ApplicationDB" %>
<%@ page import="java.sql.*" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page contentType="text/html;charset=UTF-8"%>

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
        <% try {
            // Get the database connection
            ApplicationDB db = new ApplicationDB();
            Connection con = db.getConnection();
            %>


            <form method="GET">
                <label for="origin">Origin Station:</label>
                <select name="origin" id="origin">
                    <option value="%"></option>
                    <%
                        String str = "SELECT stationName FROM station_data";
                        PreparedStatement ps = con.prepareStatement(str);
                        ResultSet stationResults = ps.executeQuery();

                        String lastSelected;
                        while(stationResults.next()) {
                            lastSelected = stationResults.getString("stationName").equals(request.getParameter("origin")) ? "selected" : ""; %>
                            <option <%=lastSelected%> value="<%=stationResults.getString("stationName")%>"><%=stationResults.getString("stationName")%></option>
                        <% }
                    %>
                </select>
                <label for="dest">Destination Station:</label>
                <select name="dest" id="dest">
                    <option value="%"></option>
                    <%
                        stationResults = ps.executeQuery();

                        while(stationResults.next()) {
                            lastSelected = stationResults.getString("stationName").equals(request.getParameter("dest")) ? "selected" : ""; %>
                            <option <%=lastSelected%> value="<%=stationResults.getString("stationName")%>"><%=stationResults.getString("stationName")%></option>
                        <% }
                    %>
                </select>
                <label for="dtime">Departure Time:</label>
                <input type="datetime-local" name="dtime" id="dtime" value="<%=request.getParameter("dtime")%>">
                <label for="sortby">Sort by: </label>
                <select name="sortby" id="sortby" value="<%=request.getParameter("sortby")%>">
                    <option selected value="departure_time">Departure Time</option>
                    <option value="arrival_time">Arrival Time</option>
                    <option value="fare">Fare</option>
                </select>
                <input type="submit" value="Search">
            </form>
        <br>
        <br>

        <!-- Generate table with all valid train schedules -->

        <%
            // Get info from GET
            String origin = request.getParameter("origin");
            String dest = request.getParameter("dest");
            String dtime = request.getParameter("dtime").replace("T", " ").replace("%3A", ":"); //YYYY-MM-DDThh%3Amm -> YYYY-MM-DD hh:mm
            String sortby = request.getParameter("sortby");

            String allTrains =
                    "SELECT ts.tid, ts.train_line, ts.fare, sa.arrival_time, sa.departure_time, sd.stationName, sd.sid " +
                    "FROM train_schedule ts " +
                        "INNER JOIN stops_at sa " +
                        "ON ts.tid = sa.tid " +
                        "INNER JOIN station_data sd " +
                        "ON sa.sid = sd.sid";

            String deptSchedule =
                    "SELECT * " +
                    "FROM (" + allTrains + ") al " +
                    "WHERE al.stationName LIKE ? and " +
                          "al.departure_time > STR_TO_DATE(?, '%Y-%m-%d %H:%i')";

            String arrSchedule =
                    "SELECT * " +
                    "FROM (" + allTrains + ") al " +
                    "WHERE al.stationName LIKE ?";


            String routes =
                    "SELECT ds.tid, ds.train_line tl, ds.fare fare, ds.stationName dsn, ds.departure_time departure_time, ar.stationName asn, ar.arrival_time arrival_time " +
                    "FROM (" + deptSchedule + ") ds " +
                    "INNER JOIN (" + arrSchedule + ") ar " +
                    "ON ds.tid = ar.tid " +
                    "WHERE ds.departure_time < ar.arrival_time and " +
                          "ds.sid <> ar.sid ";

            String bigTable =
                    "SELECT bt.tid tid, bt.tl tl, bt.fare * (((" +
                            "SELECT COUNT(*) num " +
                            "FROM stops_at sa " +
                            "WHERE bt.tid = sa.tid and sa.arrival_time >= STR_TO_DATE(bt.departure_time, '%Y-%m-%d %H:%i') and sa.departure_time <= STR_TO_DATE(bt.arrival_time, '%Y-%m-%d %H:%i')"+
                    ") + 2.0) / (" +
                            "SELECT COUNT(*) num " +
                            "FROM stops_at sa " +
                            "WHERE bt.tid = sa.tid "+
                    ")) as fare, bt.dsn dsn, bt.departure_time departure_time, bt.asn asn, bt.arrival_time arrival_time " +
                    "FROM ("+ routes +") bt";


            ps = con.prepareStatement(bigTable + " ORDER BY " + sortby);
            ps.setString(1, origin);
            ps.setString(2, dtime);
            ps.setString(3, dest);
            ResultSet result = ps.executeQuery();

        %>
        <table border="2" align="center">
            <thead>
                <tr>
                    <th> Train Line </th>
                    <th> Origin </th>
                    <th> Departure Time </th>
                    <th> Destination </th>
                    <th> Arrival Time </th>
                    <th> Fare </th>
                </tr>
            </thead>
            <tbody>
            <%
            // Generate table from query
            while(result.next()) {
                %>
                <tr>
                    <td><%=result.getString("tl")%></td>
                    <td><%=result.getString("dsn")%></td>
                    <td><%=result.getString("departure_time")%></td>
                    <td><%=result.getString("asn")%></td>
                    <td><%=result.getString("arrival_time")%></td>
                    <td>$<%=result.getString("fare")%></td>
                    <td>
                        <form action="makeReservationPage.jsp" method="post">
                            <input type="hidden" name="tid" value="<%=result.getInt("tid")%>">
                            <input type="hidden" name="departure_time" value="<%=result.getString("departure_time")%>">
                            <input type="hidden" name="arrival_time" value="<%=result.getString("arrival_time")%>">
                            <input type="hidden" name="origin" value="<%=result.getString("dsn")%>">
                            <input type="hidden" name="dest" value="<%=result.getString("asn")%>">
                            <input type="hidden" name="fare" value="<%=result.getFloat("fare")%>">
                            <input type="hidden" name="dtime" value="<%=request.getParameter("dtime")%>">
                            <input type="submit" value="Make Reservation">
                        </form>
                    </td>
                </tr>
                <%
            }
            %>
        </table>
        <%
        } catch (Exception e) {
            e.printStackTrace();
        } %>
    </body>
</html>
