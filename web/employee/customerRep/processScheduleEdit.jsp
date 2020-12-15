<%@ page import="db.ApplicationDB" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.ResultSet" %>
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
        int intermediate_num = Integer.parseInt(request.getParameter("intermediate"));
        String[] intermeds = new String[100];
        for (int i = 0; i < intermediate_num;i++){
            intermeds[i] = request.getParameter("mid"+Integer.toString(i));
        }
        String origin = request.getParameter("origin");
        String dest = request.getParameter("dest");
        String line = request.getParameter("line");
        String arrival = request.getParameter("arrive");
        String departure = request.getParameter("depart");
        String fare = request.getParameter("fare");

        //modify stops_at first




        //modify train_schedule



        response.sendRedirect("empScheduleView.jsp");

    }
    catch (Exception e){
        e.printStackTrace();
    }




%>

</body>
</html>
