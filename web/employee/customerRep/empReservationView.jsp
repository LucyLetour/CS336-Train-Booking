<%@ page import="db.ApplicationDB" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <link rel="stylesheet" href="../../resources/navbar.css">
    <link rel="stylesheet" href="../../resources/base.css">
    <title>Reservations</title>
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

            String str = "SELECT * FROM bookingsystem.passenger";
            PreparedStatement ps = con.prepareStatement(str);

            ResultSet result = ps.executeQuery();


            %>
            <p> All Reservations </p>
            <table border="2" align="center">
                <thead>
                    <tr>
                        <th> Customer </th>
                        <th> Transit Line </th>
                        <th> Date </th>
                    </tr>
                </thead>
                <tbody>
                <%
                    while(result.next()){

                        //get tid of customers reservation
                        String rid = Float.toString(result.getFloat("rid"));
                        String str_cust = "SELECT tid FROM bookingsystem.trip WHERE rid = ?";
                        PreparedStatement ps_cust = con.prepareStatement(str_cust);
                        ps_cust.setString(1,rid);
                        ResultSet res_cust = ps_cust.executeQuery();
                        String line_no = "";
                        if (res_cust.next()){
                            line_no = res_cust.getString("tid");

                        }
                        //get name of train line
                        String str_transit = "SELECT train_line FROM bookingsystem.train_schedule WHERE tid = ?";
                        PreparedStatement ps_transit = con.prepareStatement(str_transit);
                        ps_transit.setString(1,line_no);
                        ResultSet res_transit = ps_transit.executeQuery();
                        String train_line = "";
                        if (res_transit.next()){
                            train_line = res_transit.getString("train_line");
                        }
                        //get date of trip
                        String str_date = "SELECT reservationDate FROM bookingsystem.reservation_data WHERE rid = ?";
                        PreparedStatement ps_date = con.prepareStatement(str_date);
                        ps_date.setString(1,rid);
                        ResultSet res_date = ps_date.executeQuery();
                        String date = "";
                        if (res_date.next()) {
                            date = res_date.getString("reservationDate");
                        }

                        %>
                        <tr>
                            <td><%=result.getString("username")%></td>
                            <td> <%=train_line%> </td>
                            <td> <%=date%></td>
                        </tr>
                        <%
                    }
                %>

                </tbody>
            </table>
            <%



        }
        catch (Exception e) {
            e.printStackTrace();
        }


    %>





</body>
</html>
