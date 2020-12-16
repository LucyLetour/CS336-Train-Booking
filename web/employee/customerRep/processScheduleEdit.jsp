<%@ page import="db.ApplicationDB" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="sun.security.krb5.internal.crypto.RsaMd5CksumType" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <link rel="stylesheet" href="../../resources/navbar.css">
    <link rel="stylesheet" href="../../resources/base.css">
    <title>Process Schedule</title>
</head>
<body>
<%
    // we need to modify stops_at, then train_schedule to preserve foreign key constraints
    // for now this just displays the data for debugging
    try {
        //get new intermediate stops
        int intermediate_num = Integer.parseInt(request.getParameter("intermediate"));
        String[] intermeds = new String[100];
        for (int i = 0; i < intermediate_num;i++){
            intermeds[i] = request.getParameter("mid"+Integer.toString(i));
        }

        //get old intermediate stops
        String[] old_intermeds = new String[100];
        for (int i = 0; i < intermediate_num; i++) {
            old_intermeds[i] = request.getParameter("old"+Integer.toString(i));
        }

        String origin = request.getParameter("origin");
        String dest = request.getParameter("dest");
        String line = request.getParameter("line");
        String arrival = request.getParameter("arrive");
        String departure = request.getParameter("depart");
        String fare = request.getParameter("fare");
        String tid = request.getParameter("tid");

        //get SID for origin, dest, and any intermediate stops
        int origin_sid = 0;
        int dest_sid = 0;
        int[] intermed_sid = new int[100];
        int[] old_intermed_sid = new int[100];

        ApplicationDB db = new ApplicationDB();
        Connection con = db.getConnection();


        //get sid for new origin
        String orig_query = "SELECT sid FROM bookingsystem.station_data WHERE stationName = ?";
        PreparedStatement ps_orig = con.prepareStatement(orig_query);
        ps_orig.setString(1,origin);
        ResultSet orig_result = ps_orig.executeQuery();
        if (orig_result.next()){
            origin_sid = orig_result.getInt("sid");
        }

        //get sid for new dest
        String dest_query = "SELECT sid FROM bookingsystem.station_data WHERE stationName = ?";
        PreparedStatement ps_dest = con.prepareStatement(dest_query);
        ps_dest.setString(1,dest);
        ResultSet dest_result = ps_dest.executeQuery();
        if (dest_result.next()){
            dest_sid = dest_result.getInt("sid");
        }

        //get sid for new intermediates
        for (int i=0;i<intermediate_num;i++){

            if (intermeds[i].equals("")){
                intermed_sid[i] = -1;
            }
            else {
                String mid_query = "SELECT sid FROM bookingsystem.station_data WHERE stationName = ?";
                PreparedStatement ps_mid = con.prepareStatement(mid_query);
                ps_mid.setString(1,intermeds[i]);
                ResultSet mid_result = ps_mid.executeQuery();
                if (mid_result.next()){
                    intermed_sid[i] = mid_result.getInt("sid");
                }
            }
        }

        //get sid for old intermediates
        for (int i=0;i<intermediate_num;i++){
            String mid_query = "SELECT sid FROM bookingsystem.station_data WHERE stationName = ?";
            PreparedStatement ps_mid = con.prepareStatement(mid_query);
            ps_mid.setString(1,old_intermeds[i]);
            ResultSet mid_result = ps_mid.executeQuery();
            if (mid_result.next()){
                old_intermed_sid[i] = mid_result.getInt("sid");
            }
        }


        //modify stops_at first

        //UPDATE bookingSystem.stops_at
        //SET sid = station, is_origin = 0, is_dest = 0,  departure_time = dt
        //WHERE tid = tid;

        //modify entry for origin station
        String update_orig = "UPDATE bookingsystem.stops_at SET sid = ?, is_origin=1, is_dest=0, departure_time = ? WHERE tid = ? AND is_origin = 1";
        PreparedStatement ps_stops_orig = con.prepareStatement(update_orig);
        ps_stops_orig.setString(1,Integer.toString(origin_sid));
        ps_stops_orig.setString(2,departure);
        ps_stops_orig.setString(3,tid);
        int res_stops_orig = ps_stops_orig.executeUpdate();


        //modify entry for destination station
        String update_dest = "UPDATE bookingsystem.stops_at SET sid=?, is_origin = 0, is_dest = 1, arrival_time = ? WHERE tid = ? AND is_dest = 1";
        PreparedStatement ps_stops_dest = con.prepareStatement(update_dest);
        ps_stops_dest.setString(1,Integer.toString(dest_sid));
        ps_stops_dest.setString(2,arrival);
        ps_stops_dest.setString(3,tid);
        int res_stops_dest = ps_stops_dest.executeUpdate();


        //modify enrtry(s) for intermediate stations
        for (int i = 0; i < intermediate_num;i++){

            if (intermed_sid[i] == -1){
                String del_med = "DELETE FROM bookingsystem.stops_at WHERE tid= ? AND sid = ?";
                PreparedStatement ps_del = con.prepareStatement(del_med);
                ps_del.setString(1,tid);
                ps_del.setString(2,Integer.toString(old_intermed_sid[i]));
                int res_del = ps_del.executeUpdate();
            }
            else {
                String update_med = "UPDATE  bookingsystem.stops_at SET sid=?, is_origin = 0, is_dest = 0 WHERE tid = ? AND sid= ? ";
                PreparedStatement ps_stops_med = con.prepareStatement(update_med);
                ps_stops_med.setString(1,Integer.toString(intermed_sid[i]));
                ps_stops_med.setString(2,tid);
                ps_stops_med.setString(3,Integer.toString(old_intermed_sid[i]));
                int res_stops_med = ps_stops_med.executeUpdate();
            }
        }



        //modify train_schedule
        // NEED TO FIX TRAVEL TIME

        //UPDATE bookingSystem.train_schedule
        //SET train_line = line, fare = fare
        //WHERE tid = tid;

        String update_sch = "UPDATE bookingsystem.train_schedule SET train_line = ?, fare = ? WHERE tid = ?";
        PreparedStatement ps_sch = con.prepareStatement(update_sch);
        ps_sch.setString(1,line);
        ps_sch.setString(2,fare);
        ps_sch.setString(3,tid);
        int res_update_sch = ps_sch.executeUpdate();



        db.closeConnection(con);
        response.sendRedirect("empScheduleView.jsp");

    }
    catch (Exception e){
        e.printStackTrace();
    }




%>

</body>
</html>
