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
        int intermediate = Integer.parseInt(request.getParameter("intermediate"));
        %>
        <p>Origin: <%=request.getParameter("origin")%></p>
        <%
        for (int i=0; i< intermediate; i++){
            %>
            <p>Intermediate Stop: <%=request.getParameter("mid"+Integer.toString(i))%></p>
            <%
        }
        %>
        <p>Destination: <%=request.getParameter("dest")%></p>
        <p>Line: <%=request.getParameter("line")%></p>
        <p>Departure: <%=request.getParameter("depart")%> </p>
        <p>Arrival: <%=request.getParameter("arrive")%></p>
        <p>Fare: <%=request.getParameter("fare")%></p>
        <p>intermediate stops: <%=intermediate%></p>
        <%
    }
    catch (Exception e){
        e.printStackTrace();
    }



    //response.sendRedirect("empScheduleView.jsp");
%>

</body>
</html>
