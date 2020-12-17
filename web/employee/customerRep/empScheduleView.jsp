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
    <li class="navbar-entry"><a id="home-text" href="customerRepSuccess.jsp">Customer Rep Home</a></li>
    <li class="navbar-entry"><a class="active" href="empScheduleView.jsp">Schedules</a></li>
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
<h3> All Scheduled Trips</h3>
<table border="2" align="center">
    <thead>
    <tr>
        <th>Train Line </th>
        <th> Origin </th>
        <th> Destination </th>
        <th> Travel Time </th>
        <th> Fare </th>
    </tr>
    </thead>
    <tbody>
    <%

        while (res.next()){
            String line = res.getString("train_line");
            String travel_time = res.getString("travel_time");
            String tid = res.getString("tid");
            String fare = res.getString("fare");

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
        <td><%=fare%></td>
        <td>
            <form method="post" action="editScheduleView.jsp">
                <input type="hidden" name="origin" value="<%=origin%>">
                <input type="hidden" name="dest" value="<%=dest%>">
                <input type="hidden" name="line" value="<%=line%>">
                <input type="hidden" name="tid" value="<%=tid%>">
                <input type="hidden" name="fare" value="<%=fare%>">
                <input type="hidden" name="travel_time" value="<%=travel_time%>">
                <input type="submit" value="Edit">
            </form>
        </td>
        <td>
            <form method="post" action="processScheduleDelete.jsp">
                <input type="hidden" name="tid" value="<%=tid%>">
                <input type="submit" value="Delete">
            </form>
        </td>
    </tr>
    <%
        }
    %>    </tbody>
</table>
<%

%>
<br>
<br>
<h3> Search For Schedules</h3>
<form method="post" action="searchResults.jsp">
    <label for="origin">Origin Station: </label>
    <select id="origin" name="origin">
        <%
            String get_st = "SELECT stationName FROM bookingsystem.station_data";
            PreparedStatement ps_st = con.prepareStatement(get_st);
            ResultSet stationResults = ps_st.executeQuery();
            while(stationResults.next()){
        %><option value="<%=stationResults.getString("stationName")%>"><%=stationResults.getString("stationName")%></option> <%
        }
    %>
    </select>
    <br>
    <label for="dest">Destination Station: </label>
    <select id="dest" name="dest">
        <%
            stationResults = ps_st.executeQuery();
            while(stationResults.next()){
        %><option value="<%=stationResults.getString("stationName")%>"><%=stationResults.getString("stationName")%></option> <%
        }
    %>
    </select>
    <br>
    <input type="submit" value="Search">
</form>
<%


    }
    catch (Exception e){
        e.printStackTrace();
    }
%>








</body>
</html>