<%@ page import="db.ApplicationDB" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <link rel="stylesheet" href="../../resources/navbar.css">
    <link rel="stylesheet" href="../../resources/base.css">
    <title>Delete</title>
</head>
<body>
<%
    try{

        ApplicationDB db = new ApplicationDB();
        Connection con = db.getConnection();

        String tid = request.getParameter("tid");

        //delete from trip
        // then from stops_at
        //then schedule

        String del_trips = "DELETE FROM bookingsystem.trip WHERE tid = ?";
        PreparedStatement ps_trip = con.prepareStatement(del_trips);
        ps_trip.setString(1,tid);
        int result_trips = ps_trip.executeUpdate();

        String del_stops = "DELETE FROM bookingsystem.stops_at WHERE tid = ? ";
        PreparedStatement ps_stop = con.prepareStatement(del_stops);
        ps_stop.setString(1,tid);
        int result = ps_stop.executeUpdate();



        String del = "DELETE FROM bookingsystem.train_schedule WHERE tid = ?";
        PreparedStatement ps = con.prepareStatement(del);
        ps.setString(1, tid);
        int result_delete = ps.executeUpdate();


        db.closeConnection(con);
        response.sendRedirect("empScheduleView.jsp");

    }
    catch (Exception e){
        e.printStackTrace();
    }


%>

</body>
</html>
