<%@ page import="db.ApplicationDB" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.ResultSet" %>
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

    String str = "SELECT * FROM bookingsystem.stops_at WHERE tid = ?";
    PreparedStatement ps = con.prepareStatement(str);
    ps.setString(1,tid);
    ResultSet res = ps.executeQuery();

    while (res.next()){
        if (res.getInt("is_origin") == 1){
            depart = res.getString("departure_time");
        }
        if (res.getInt("is_dest") == 1){
            arrival = res.getString("arrival_time");
        }

    }
    db.closeConnection(con);
}
catch (Exception e){
    e.printStackTrace();
}



%>
<form method="post" action="processScheduleEdit.jsp">
    <br>
    <label for="origin">Origin Station</label>
    <input type="text" id="origin" name="origin" value="<%=origin%>">
    <br>
    <label for="dest">Destination Station</label>
    <input type="text" id="dest" name="dest" value="<%=dest%>">
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
    <input type="submit" value="Update">
</form>

<form method="post" action="empScheduleView.jsp">
    <input type="submit" value="Cancel">
</form>


</body>
</html>
