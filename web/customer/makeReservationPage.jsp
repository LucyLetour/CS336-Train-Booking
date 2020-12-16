<%@ page import="db.ApplicationDB" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page contentType="text/html;charset=UTF-8"%>
<html>
    <head>
        <link rel="stylesheet" href="../resources/navbar.css">
        <link rel="stylesheet" href="../resources/base.css">
        <title>Make Reservation</title>
    </head>

    <body>
        <script>
            let submittingForm = false;
            const setSubmittingForm = function () {
                submittingForm = true;
            };

            window.onbeforeunload = function() {
                if (submittingForm) {
                    return undefined;
                }

                return "Warning: leaving this page now will cancel the reservation process. Your progress is NOT saved";
            };
        </script>

        <ul id="navbar" class="nav">
            <li class="navbar-entry"><a id="home-text" href="userPage.jsp">Schedule</a></li>
            <li class="navbar-entry"><a href="reservations.jsp">My Reservations</a></li>
            <li class="navbar-entry"><a href="questions.jsp">Questions</a></li>
            <li class="navbar-entry right-padding"><a id="logout" href="../login/logout.jsp">Logout</a></li>
        </ul>
        <% try {
            // Get the database connection
            ApplicationDB db = new ApplicationDB();
            Connection con = db.getConnection();

            float onewayFare = Float.parseFloat(request.getParameter("fare"));
            String origin = request.getParameter("origin");
            String dest = request.getParameter("dest");
            String dtime = request.getParameter("dtime");
            int tid = Integer.parseInt(request.getParameter("tid"));


            String stationsBetween =
                    "SELECT stations.stationName name " +
                    "FROM stops_at sa, station_data stations " +
                    "WHERE ? = sa.tid and stations.sid = sa.sid and sa.arrival_time >= STR_TO_DATE(?, '%Y-%m-%d %H:%i') and sa.departure_time <= STR_TO_DATE(?, '%Y-%m-%d %H:%i')";

            PreparedStatement sb = con.prepareStatement(stationsBetween);
            sb.setInt(1, Integer.parseInt(request.getParameter("tid")));
            sb.setObject(2, request.getParameter("departure_time"));
            sb.setObject(3, request.getParameter("arrival_time"));
            ResultSet stations = sb.executeQuery();

            StringBuilder intermediates = new StringBuilder(origin);
            intermediates.append(" -> ");

            while(stations.next()) {
                intermediates.append(stations.getString("name")).append(" -> ");
            }

            String allStations = intermediates.append(dest).toString();
        %>

        <h2> Your trip: </h2>
        <h3> <%=allStations%> </h3>

        <form action="createReservation.jsp" method="post" onsubmit="setSubmittingForm()" oninput="vFare.value=`$` + ((!roundtrip.checked || roundtrip.indeterminate ? 1 : 2)*<%=onewayFare%>*Math.min((!disabled.checked || disabled.indeterminate ? 1 : 0.5), Math.min((!minor.checked || minor.indeterminate ? 1 : 0.75), (!senior.checked || senior.indeterminate ? 1 : 0.65))).toFixed(2))">
            <table>
                <tr>
                    <td><label for="roundtrip">Roundtrip: </label><input type="checkbox" name="roundtrip" id="roundtrip" value="2"></td>
                    <td><output name="vFare" for="roundtrip fare">$<%=onewayFare%></output></td>
                </tr>
                <tr>
                    <td><label> Please select all that apply: </label></td>
                </tr>
                <tr>
                   <td><label for="disabled"> - Disabled: </label><input type="checkbox" name="disabled" id="disabled" value="unchecked"></td>
                </tr>
                <tr>
                    <td><label for="senior"> - Senior (age 60+): </label><input type="checkbox" name="senior" id="senior" value="unchecked"></td>
                </tr>
                <tr>
                    <td><label for="minor"> - Minor (under 18): </label><input type="checkbox" name="minor" id="minor" value="unchecked"></td>
                </tr>
            </table>
            <input type="hidden" name="origin" value="<%=origin%>">
            <input type="hidden" name="tid" value="<%=tid%>">
            <input type="hidden" name="dest" value="<%=dest%>">
            <input type="hidden" name="dtime" value="<%=dtime%>">
            <input type="hidden" name="departure_time" value="<%=request.getParameter("departure_time")%>">
            <input type="hidden" name="fare" value="<%=onewayFare%>">
            <input type="submit" value="Make Reservation">
        </form>
        <form action="userPage.jsp" method="get">
            <input type="hidden" name="origin" value="<%=origin%>">
            <input type="hidden" name="tid" value="<%=tid%>">
            <input type="hidden" name="dest" value="<%=dest%>">
            <input type="hidden" name="dtime" value="<%=dtime%>">
            <input type="submit" value="Cancel">
        </form>

        <%
        } catch (Exception e) {
            e.printStackTrace();
        }
        %>
    </body>
</html>
