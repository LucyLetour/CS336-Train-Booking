<%@ page import="db.ApplicationDB" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.ArrayList" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <link rel="stylesheet" href="../../resources/navbar.css">
    <link rel="stylesheet" href="../../resources/base.css">
    <title>Answer Question</title>
</head>
<body>

<ul id="navbar" class="nav">
    <li class="navbar-entry"><a id="home-text" class="active" href="customerRepSuccess.jsp">Customer Rep Home</a></li>
    <li class="navbar-entry"><a href="empScheduleView.jsp">Schedules</a></li>
    <li class="navbar-entry"><a href="empReservationView.jsp">Reservations</a></li>
    <li class="navbar-entry"><a href="empQuestionView.jsp">Q & A</a></li>
    <li class="navbar-entry right-padding"><a id="logout" href="../../login/logout.jsp">Logout</a></li>
</ul>

<% // we need to modify stops_at, then train_schedule to preserve foreign key constraints
//get additional data from trip and stops_at

String origin = request.getParameter("origin");
String dest = request.getParameter("dest");
String line = request.getParameter("line");
String fare = request.getParameter("fare");
String tid = request.getParameter("tid");


String arrival = "";
String depart = "";

try {
    ApplicationDB db = new ApplicationDB();
    Connection con = db.getConnection();

    //gets intermediate stops in time order
    String str = "SELECT * FROM bookingsystem.stops_at WHERE tid = ? ORDER BY arrival_time ASC";
    PreparedStatement ps = con.prepareStatement(str);
    ps.setString(1,tid);
    ResultSet res = ps.executeQuery();

    int intermediate = 0;

    String[] intermeds = new String[100];
    while (res.next()){
        if (res.getInt("is_origin") == 1){
            depart = res.getString("departure_time");
        }
        else if (res.getInt("is_dest") == 1){
            arrival = res.getString("arrival_time");
        }
        else {
            //intermediate stops


            String str_intermed = "SELECT stationName FROM bookingsystem.station_data WHERE sid = ?";
            PreparedStatement ps_intermed = con.prepareStatement(str_intermed);
            ps_intermed.setString(1,res.getString("sid"));
            ResultSet res_intermed = ps_intermed.executeQuery();
            if (res_intermed.next()){
                intermeds[intermediate] = (res_intermed.getString("stationName"));
            }
            intermediate += 1;
        }

    }

    %>
    <form method="post" action="processScheduleEdit.jsp">
        <br>
        <label for="origin">Origin Station:</label>
        <select name="origin" id="origin">
            <option value="%"></option>
            <%
                String get_st = "SELECT stationName FROM bookingsystem.station_data";
                PreparedStatement ps_st = con.prepareStatement(get_st);
                ResultSet stationResults = ps_st.executeQuery();

                String lastSelected;
                while(stationResults.next()) {
                    lastSelected = stationResults.getString("stationName").equals(origin) ? "selected" : ""; %>
            <option <%=lastSelected%> value="<%=stationResults.getString("stationName")%>"><%=stationResults.getString("stationName")%></option>
            <% }
            %>
        </select>
        <br>
        <%
            //generate drop downs for any intermediate stops along the way
            for (int i = 0; i < intermediate; i++){
        %>
        <label for="mid<%=i%>"> Intermediate Stop <%=i%></label>
        <select name="mid<%=i%>" id="mid<%=i%>">
            <option value="%"></option>
            <%
                stationResults = ps_st.executeQuery();
                while (stationResults.next()){
                    lastSelected = stationResults.getString("stationName").equals(intermeds[i]) ? "selected" : "";
            %>
            <option <%=lastSelected%> value="<%=stationResults.getString("stationName")%>"><%=stationResults.getString("stationName")%></option>
            <%
                }
            %>
        </select>
        <%
            }
        %>

        <br>

        <label for="dest">Destination Station:</label>
        <select name="dest" id="dest">
            <option value="%"></option>
            <%
                stationResults = ps_st.executeQuery();

                while(stationResults.next()) {
                    lastSelected = stationResults.getString("stationName").equals(dest) ? "selected" : ""; %>
            <option <%=lastSelected%> value="<%=stationResults.getString("stationName")%>"><%=stationResults.getString("stationName")%></option>
            <% }
            %>
        </select>
        <br>
        <label for="line">Train Line</label>
        <input type="text" id="line" name="line" value="<%=line%>">
        <br>
        <label for="arrive">Arrival Time</label>
        <input type="text" id="arrive" name="arrive" value="<%=arrival%>">
        <br>
        <label for="depart">Departure Time</label>
        <input type="text" id="depart" name="depart" value="<%=depart%>">
        <br>
        <label for="fare">Fare</label>
        <input type="text" id="fare"  name="fare" value="<%=fare%>">
        <br>
        <input type="hidden" name="intermediate" value="<%=intermediate%>">
        <input type="hidden" name="tid" value="<%=tid%>">
        <%
            for(int i=0; i < intermediate; i++){
             %><input type="hidden" name="old<%=i%>" value="<%=intermeds[i]%>"> <%
            }

        %>

        <input type="submit" value="Update">
    </form>

    <form method="post" action="empScheduleView.jsp">
        <input type="submit" value="Cancel">
    </form>
    <%


    db.closeConnection(con);
}
catch (Exception e){
    e.printStackTrace();
}


%>

</body>
</html>
